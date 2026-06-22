# ZombieNet Fajita LOS23 V4

Boot-tested custom kernel for the **OnePlus 6T (`fajita`)**, built for the matching LineageOS 23.2 / Android 16 June 2026 base.

## Release assets

- `ZombieNet-fajita-LOS23-V4-AnyKernel3.zip`
  - Clean fajita-only AnyKernel3 installer.
  - Contains `Image.gz`, not a prebuilt `boot.img`.
  - Preserves the currently installed ramdisk and separate stock `kernel_dtb`.
  - Contains no NetHunter installer, branding, scripts, or payloads.

- `ZombieNet-fajita-LOS23-V4-boot.img`
  - Exact prebuilt image that was boot-tested on the matching ROM base.
  - Preserves the tested base image's ramdisk and stock `kernel_dtb`.
  - Replaces the active slot's complete boot image, including its ramdisk state.

- `SHA256SUMS`
  - SHA-256 checksums for both release binaries.

## Compatibility

- Device: OnePlus 6T
- Codename: `fajita`
- Models: A6010 / A6013
- Tested ROM base: LineageOS 23.2, Android 16, June 2026
- A/B boot slots supported

Do not flash this release on `enchilada`, OnePlus 7/7 Pro, another ROM base, or another security-patch base.

## Changes in V4

### Added kernel features

- Bluetooth RFCOMM
- RFCOMM TTY binding
- Bluetooth BNEP and HIDP
- CAN core, CAN RAW, CAN BCM, and CAN Gateway
- VCAN
- SLCAN
- GS_USB CAN adapters
- USB serial CH341
- USB serial CP210x
- USB serial FTDI
- USB serial PL2303
- cfg80211 compatibility features
- nl80211 test mode

### Build and runtime fixes

- Rebased on the current LineageOS 23.2 fajita kernel source.
- Preserved the current ROM's LTO, boot-header, ramdisk, and device-tree expectations.
- Fixed `O=out` camera include paths.
- Fixed OnePlus `project_info` sysfs callback types for Clang CFI.
- Fixed the Venus VIDC response callback type for Clang CFI.
- Preserved strict CFI instead of disabling it globally.
- Packaged the kernel as bare `Image.gz` while preserving the stock separate `kernel_dtb`.

## Recommended installation: AnyKernel3 ZIP

The AnyKernel ZIP preserves the boot image already installed on the phone, including its ramdisk/root state and stock `kernel_dtb`.

1. Keep a copy of the exact working ROM `boot.img`.
2. Reboot to Lineage Recovery.
3. Select **Apply update**.
4. Select **Apply from ADB**.
5. On the computer:

```bash
adb sideload ZombieNet-fajita-LOS23-V4-AnyKernel3.zip
```

6. Reboot system.

The AnyKernel package is structurally verified from the same V4 `Image.gz`. The prebuilt boot image is the artifact that was directly boot-tested.

## Direct boot-image installation

This method replaces the complete boot image on one slot.

```bash
adb reboot bootloader
fastboot getvar current-slot
```

For slot `a`:

```bash
fastboot flash boot_a ZombieNet-fajita-LOS23-V4-boot.img
fastboot reboot
```

For slot `b`:

```bash
fastboot flash boot_b ZombieNet-fajita-LOS23-V4-boot.img
fastboot reboot
```

Do not flash `vbmeta`, `dtbo`, `vendor_boot`, or wipe data. Temporary `fastboot boot` was not used because it was not reliable on the tested device.

## Rollback

Flash the exact working ROM boot image back to the same slot.

```bash
fastboot flash boot_a stock-boot.img
fastboot reboot
```

Use `boot_b` instead only when slot `b` was flashed.

## Basic verification

```bash
adb shell uname -a
adb shell 'zcat /proc/config.gz 2>/dev/null | grep -E "CONFIG_BT_RFCOMM=|CONFIG_BT_RFCOMM_TTY=|CONFIG_CAN_VCAN=|CONFIG_CAN_SLCAN=|CONFIG_CAN_GS_USB=|CONFIG_USB_SERIAL_CH341="'
```

VCAN smoke test:

```bash
adb shell su -c 'ip link add dev vcan0 type vcan'
adb shell su -c 'ip link set vcan0 up'
adb shell su -c 'ip -details link show vcan0'
```

## Source

- Repository: `LetsSnowOps/android_kernel_oneplus_sdm845`
- Branch: `zombienet-fajita-los23-v4`
- Release tag: `zombienet-fajita-los23-v4`
- Git author: LetsSnowOps `<forsnow@proton.me>`

## Notes

The AnyKernel ZIP is the safer general release because it preserves each user's current ramdisk. The prebuilt boot image is intended only for the exact matching ROM base.

## Prebuilt ramdisk audit

The prebuilt boot image contains an unmodified stock-style ramdisk according to magiskboot.
