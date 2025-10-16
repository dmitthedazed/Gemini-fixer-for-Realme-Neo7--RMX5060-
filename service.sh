#!/system/bin/sh
# Runs at every boot — switches assistant and updates module.prop with status

MODULE_DIR="/data/adb/modules/gemini_fixer_module"
MODULE_PROP="$MODULE_DIR/module.prop"

GPT_SERVICE="com.openai.chatgpt/com.openai.feature.assistant.impl.AssistantVoiceInteractionService"
GOOGLE_SERVICE="com.google.android.googlequicksearchbox/com.google.android.voiceinteraction.GsaVoiceInteractionService"

sleep 15   # wait for system services

STATUS="❌ Unknown error"
RESULT=""

# --- Check ChatGPT app ---
if ! pm list packages | grep -q "com.openai.chatgpt"; then
    STATUS="❌ ChatGPT not installed"
    RESULT="Skipped toggle"
else
    settings put secure voice_interaction_service "$GPT_SERVICE"
    sleep 3
    settings put secure voice_interaction_service "$GOOGLE_SERVICE"
    CURRENT=$(settings get secure voice_interaction_service)
    if [ "$CURRENT" = "$GOOGLE_SERVICE" ]; then
        STATUS="✅ Success"
        RESULT="Google Assistant restored"
    else
        STATUS="⚠ Partial success"
        RESULT="Unexpected active service: $CURRENT"
    fi
fi

TIME_NOW=$(date +"%Y-%m-%d %H:%M:%S")

# --- Update module.prop description ---
sed -i '/^description=/d' "$MODULE_PROP"
echo "description=${STATUS} — ${RESULT} (Last run: ${TIME_NOW})" >> "$MODULE_PROP"
