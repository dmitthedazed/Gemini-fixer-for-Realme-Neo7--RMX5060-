# Gemini fixer for Realme Neo7 (RMX5060)

So, ive had this problem when i use ShortX + Rule + VISTrigger, Gemini won't work until i switch digital assistant default to any other app and then back to google app, so this module does that switching on boot in the background so i won't go everytime to Gemini -> Settings -> Digital assistants from Google -> Android default digital assistant


- Requires root (Magisk), Realme Neo7 (RMX5060), and the ChatGPT app installed.
- Installer enforces device and app checks.

## What it does

At each boot, [service.sh](service.sh) waits for the system to come up, sets:
- ChatGPT Voice Assistant: `com.openai.chatgpt/com.openai.feature.assistant.impl.AssistantVoiceInteractionService`
- Then restores Google Assistant: `com.google.android.googlequicksearchbox/com.google.android.voiceinteraction.GsaVoiceInteractionService`

Timing (defaults):
- Initial boot wait: 15s
- ChatGPT hold: 3s

Files:
- [customize.sh](customize.sh): Validates device model (RMX5060) and ChatGPT presence during install.
- [service.sh](service.sh): Performs the assistant toggle at boot.
- [post-fs-data.sh](post-fs-data.sh): Reserved (currently empty).
- [module.prop](module.prop): Module metadata.

## Requirements

- Magisk installed (Zygisk/Modules support).
- Device: Realme Neo7 (RMX5060) only.
- ChatGPT app: package `com.openai.chatgpt` must be installed.
- Google app installed (for Assistant restore).

Notes:
- If device ≠ RMX5060, install aborts.
- If ChatGPT isn’t installed, install aborts with a clear message from [customize.sh](customize.sh).
- Tested on Realme UI 6 RMX5060_15.0.0.1133(CN01) build

## Verification

After a successful boot:
- Verify current assistant:
  - In a root shell: `settings get secure voice_interaction_service`
  - Expected: Google service after the toggle.
- Verify ChatGPT presence: `pm list packages | grep com.openai.chatgpt`

## Troubleshooting

- Install aborted: “ChatGPT app not installed” → install ChatGPT and retry.
- Install aborted: “incompatible device” → this module targets RMX5060 only.
- Still not fixed after reboot:
  - Increase the delays in [service.sh](service.sh) (e.g., boot wait to 30s, hold to 5s), then reboot.

## Uninstall

Magisk: Modules → Remove “Gemini fixer for RMX5060” → Reboot.

## FAQ

- Will this set ChatGPT as the permanent default? No. It restores Google Assistant after the brief toggle.
- Can I use it with any other digital assistant? Replace Google restore line in [service.sh](service.sh) (not recommended unless you know what you’re doing).
