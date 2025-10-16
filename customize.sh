#!/system/bin/sh
ui_print "*******************************"
ui_print "     Gemini fixer for Realme Neo7 (RMX5060)  "
ui_print "         by dmitthedazed       "
ui_print "*******************************"

# --- Device check ---
DEVICE_MODEL=$(getprop ro.product.model)
ui_print "Detected device model: $DEVICE_MODEL"

if [ "$DEVICE_MODEL" != "RMX5060" ]; then
    ui_print "❌ This module is intended only for Realme Neo7 (RMX5060)!"
    ui_print "Your device is '$DEVICE_MODEL'. Aborting installation."
    abort "❌ Installation aborted: incompatible device."
fi

ui_print "✅ Device verified: Realme Neo7 (RMX5060)"
ui_print "Checking for ChatGPT app..."

# --- ChatGPT presence check ---
if pm list packages | grep -q "com.openai.chatgpt"; then
    ui_print "✅ ChatGPT package found (com.openai.chatgpt)"
else
    ui_print "❌ ChatGPT app not installed!"
    ui_print "Please install ChatGPT from Play Store or APK and retry."
    abort "❌ Installation aborted: ChatGPT app not detected."
fi

ui_print "✅ All checks passed. Continuing installation..."

# --- Auto-update version info ---
MODULE_PATH="$MODPATH/module.prop"
if [ -f "$MODULE_PATH" ]; then
    ui_print "🔄 Updating version info in module.prop..."
    NEW_VERSION=$(date +%Y.%m.%d)
    NEW_VERSIONCODE=$(date +%s)
    sed -i '/^version=/d' "$MODULE_PATH"
    sed -i '/^versionCode=/d' "$MODULE_PATH"
    echo "version=$NEW_VERSION" >> "$MODULE_PATH"
    echo "versionCode=$NEW_VERSIONCODE" >> "$MODULE_PATH"
    ui_print "✅ Version updated to $NEW_VERSION ($NEW_VERSIONCODE)"
else
    ui_print "⚠ module.prop not found — skipping version update."
fi

ui_print "🎉 Installation script finished successfully!"
