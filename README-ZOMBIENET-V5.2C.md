# ZombieNet Fajita LOS23 V5.2C

Status: **BOOT TESTED**

## Base

V5.2C is derived from the boot-tested V5.2A ABI-restore baseline.

## Single new change

```
CONFIG_STRICT_KERNEL_RWX=y
```

V5.2C intentionally does **not** enable STRICT_MODULE_RWX yet.

## Preserved module ABI

```
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SIG is not set
CONFIG_MODULES_TREE_LOOKUP=y
```

## Preserved packaging

- standalone Image.gz
- known-working ramdisk preserved
- known-working DTB/kernel_dtb preserved
- no DTBO replacement
- no forced module signatures

## Physical test

- Android 16 boot: PASS
- launcher/system startup: PASS
- CONFIG_STRICT_KERNEL_RWX: PASS
- kernel panic: none observed
- Oops/BUG regression: none observed
- Synaptics safety changes preserved
- FastRPC functionality preserved
- Wi-Fi functional

Running kernel:

```

```

Image.gz SHA-256:

```
42bbcab6631c49f5c7280df23512669d336df7b085eeec090c94f67523d98b9f
```

V5.2B MEMCG diagnostic changes are intentionally excluded.
