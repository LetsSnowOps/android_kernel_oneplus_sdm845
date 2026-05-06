# ZombieNet fajita LOS23 kernel notes

Device: OnePlus 6T / fajita / A6013
Base branch: lineage-23.2-4.19
Working boot payload format: plain ARM64 Image

Important:
- This device/boot image did NOT boot with Image.gz-dtb.
- Use out/arch/arm64/boot/Image for repacking or AnyKernel3.
- Tested booting with LOS23 donor boot image.

ZombieNet config adds:
- CAN core
- CAN_RAW / CAN_BCM / CAN_GW
- VCAN / SLCAN / GS_USB
- USB serial adapters: FTDI, CP210x, PL2303, CH341
- BT RFCOMM TTY
- HIDRAW
- schedutil governor
