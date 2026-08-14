# ZombieNet Fajita LOS23 V5.2D

Status: **BOOT TESTED**

## Base

V5.2D is derived directly from boot-tested V5.2C.

## Hardening

```
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_STRICT_MODULE_RWX=y
```

## Module ABI preserved

```
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SIG is not set
CONFIG_MODULES_TREE_LOOKUP=y
```

## Physical test

- Android 16 boot: PASS
- STRICT_KERNEL_RWX: PASS
- STRICT_MODULE_RWX: PASS
- Wi-Fi: PASS
- WLAN monitor-mode startup: PASS
- Module permission regression: NONE OBSERVED
- Kernel panic: NONE
- Known MEMCG lru_size underflow warning: SEEN, pre-existing

Running kernel:

```
4.19.325-cip131-st15-perf-g4bfddc719161
```

Image.gz SHA-256:

```
1ccd88b6fddfabfd5edc6b4b8cbce101834a09d3e5aed2d45ac4cde78e3c81c4
```

Packaging continues to preserve the known-working ramdisk and kernel DTB.
No module-signing enforcement, KPTI, SSBD, DTBO, or unrelated ABI changes are included.
