#!/system/bin/sh
# Magisk service script — runs at every boot
# Switches voice_interaction_service to ChatGPT, then back to Google

GPT_SERVICE="com.openai.chatgpt/com.openai.feature.assistant.impl.AssistantVoiceInteractionService"
GOOGLE_SERVICE="com.google.android.googlequicksearchbox/com.google.android.voiceinteraction.GsaVoiceInteractionService"

# Wait for system to fully boot (so 'settings' service is available)
sleep 15

# Set ChatGPT Voice Assistant
settings put secure voice_interaction_service "$GPT_SERVICE"
sleep 3

# Restore Google Assistant
settings put secure voice_interaction_service "$GOOGLE_SERVICE"
