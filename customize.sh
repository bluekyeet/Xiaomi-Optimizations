#!/system/bin/sh

ui_print "Installing module..."

ui_print "Checking device support..."
DEVICE="$(getprop ro.product.device)"

if [ "$DEVICE" = "amethyst" ]; then
    ui_print "Supported device"
else
    ui_print "Unsupported device, please use with caution"
fi

