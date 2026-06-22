### AnyKernel3 Ramdisk Mod Script
## Official AnyKernel3 framework by osm0sis
## ZombieNet fajita V4 device configuration

properties() { '
kernel.string=ZombieNet Fajita LOS23 V4
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=fajita
device.name2=OnePlus6T
device.name3=A6013
device.name4=A6010
device.name5=
supported.versions=16
supported.patchlevels=2026-06
supported.vendorpatchlevels=
'; }

BLOCK=/dev/block/bootdevice/by-name/boot;
IS_SLOT_DEVICE=1;
RAMDISK_COMPRESSION=auto;
PATCH_VBMETA_FLAG=auto;

. tools/ak3-core.sh;

ui_print " ";
ui_print "ZombieNet Fajita LOS23 V4";
ui_print "Device: OnePlus 6T / fajita";
ui_print "Preserving current ramdisk and stock kernel_dtb";
ui_print " ";

split_boot;
flash_boot;
