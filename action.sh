#!/system/bin/sh
# Action button script — manual ChatGPT → Google assistant switch
# Prints directly to Magisk "graveyard" output

# Define ui_print so Magisk Manager shows messages
ui_print() { echo "$1"; }

GPT_SERVICE="com.openai.chatgpt/com.openai.feature.assistant.impl.AssistantVoiceInteractionService"
GOOGLE_SERVICE="com.google.android.googlequicksearchbox/com.google.android.voiceinteraction.GsaVoiceInteractionService"

ui_print "*******************************"
ui_print " ChatGPT Assistant Toggle — Action "
ui_print "*******************************"

DEVICE_MODEL=$(getprop ro.product.model)
if [ "$DEVICE_MODEL" != "RMX5060" ]; then
    ui_print "❌ This action is only for RMX5060. Detected: $DEVICE_MODEL"
    exit 0
fi

if ! pm list packages | grep -q "com.openai.chatgpt"; then
    ui_print "❌ ChatGPT app not installed! Cannot perform toggle."
    exit 0
fi

ui_print "➡ Setting ChatGPT Voice Assistant..."
settings put secure voice_interaction_service "$GPT_SERVICE"
sleep 2

ui_print "➡ Restoring Google Assistant..."
settings put secure voice_interaction_service "$GOOGLE_SERVICE"

CURRENT=$(settings get secure voice_interaction_service)
ui_print "✅ Current active service: $CURRENT"
ui_print "✨ Manual assistant switch complete!"
