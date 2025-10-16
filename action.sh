#!/system/bin/sh
# Triggered by the "Action" button in Magisk Manager
# Manually switches Voice Assistant: ChatGPT → Google

GPT_SERVICE="com.openai.chatgpt/com.openai.feature.assistant.impl.AssistantVoiceInteractionService"
GOOGLE_SERVICE="com.google.android.googlequicksearchbox/com.google.android.voiceinteraction.GsaVoiceInteractionService"

ui_print "*******************************"
ui_print " ChatGPT Assistant Toggle — Action "
ui_print "*******************************"

# --- Optional device check ---
DEVICE_MODEL=$(getprop ro.product.model)
if [ "$DEVICE_MODEL" != "RMX5060" ]; then
  ui_print "This action is intended only for RMX5060. Detected: $DEVICE_MODEL"
  exit 0
fi

# --- Check ChatGPT presence ---
if ! pm list packages | grep -q "com.openai.chatgpt"; then
  ui_print "❌ ChatGPT app not installed! Cannot perform toggle."
  exit 0
fi

# --- Perform toggle ---
ui_print "➡ Setting ChatGPT Voice Assistant..."
settings put secure voice_interaction_service "$GPT_SERVICE"
sleep 2
ui_print "➡ Restoring Google Assistant..."
settings put secure voice_interaction_service "$GOOGLE_SERVICE"

CURRENT=$(settings get secure voice_interaction_service)
ui_print "✅ Current active service: $CURRENT"
ui_print "✨ Manual assistant switch complete!"
