# ZombieNet Fajita LOS23 V5.2E

Status: **BOOT TESTED**

## Base

V5.2E is derived directly from boot-tested V5.2D.

## Hardening

```
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
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
- INIT_ON_ALLOC_DEFAULT_ON: PASS
- INIT_ON_FREE_DEFAULT_ON: PASS
- Kernel panic: NONE
- New allocator warning: NONE OBSERVED
- MEMCG underflow warning: NOT SEEN IN TEST CAPTURE
- Memory pressure: NONE OBSERVED

Running kernel:

```
4.19.325-cip131-st15-perf-g4bfddc719161-dirty
```

Image.gz SHA-256:

```
cb448ba8b3480b585ed87bd6a481c8dc5d9b2068ec4fca8c720e1c6e45fece3c
```

Known-working ramdisk and kernel DTB remain preserved.
Module-signing enforcement, KPTI, SSBD and unrelated ABI settings remain unchanged.
