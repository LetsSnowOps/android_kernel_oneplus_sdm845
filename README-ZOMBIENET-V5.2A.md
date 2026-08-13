# ZombieNet fajita LOS23 V5.2A ABI Restore

Status: **BOOT TESTED**

Target:
- OnePlus 6T / fajita
- Android / LineageOS 23
- Kernel 4.19.325
- Standalone `Image.gz` layout

V5.2A restores the known-working V4 module ABI while retaining the
source-level FastRPC and Synaptics memory-safety fixes.

Required module configuration:

    CONFIG_MODULES=y
    CONFIG_MODULE_UNLOAD=y
    CONFIG_MODVERSIONS=y
    # CONFIG_MODULE_SIG is not set
    CONFIG_MODULES_TREE_LOOKUP=y

Packaging rules:
- Build `Image.gz` only.
- Preserve the known-working ramdisk.
- Preserve the known-working DTB/kernel_dtb.
- Do not rebuild or replace DTBO as part of this candidate.
- Do not force module signatures.

Physical test result:
- Android 16 boot: PASS
- Touch / Synaptics initialization: PASS
- /dev/rmi/rmidev*: removed
- /proc/touchpanel/radd: removed
- Wi-Fi: PASS
- FastRPC: functional
- Kernel panic: none observed

The later V5.2B `WARN_RATELIMIT()` memcg diagnostic is intentionally
NOT part of V5.2A.
