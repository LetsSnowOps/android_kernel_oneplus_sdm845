#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
OUT="${OUT:-$ROOT/out-v5.2a}"
CLANG_DIR="${CLANG_DIR:-$ROOT/../clang-r596125}"

if [ ! -x "$CLANG_DIR/bin/clang" ]; then
    echo "ERROR: clang not found at:"
    echo "$CLANG_DIR/bin/clang"
    echo
    echo "Set CLANG_DIR=/path/to/clang-r596125"
    exit 1
fi

mkdir -p "$OUT"

export PATH="$CLANG_DIR/bin:$PATH"

make -C "$ROOT" \
    O="$OUT" \
    ARCH=arm64 \
    LLVM=1 LLVM_IAS=1 \
    CC="$CLANG_DIR/bin/clang" \
    LD="$CLANG_DIR/bin/ld.lld" \
    zombienet_fajita_v4_defconfig

# V5.2D single hardening change
"$ROOT/scripts/config" --file "$OUT/.config" --enable STRICT_KERNEL_RWX

# V5.2D: enforce W^X permissions on loadable modules
"$ROOT/scripts/config" --file "$OUT/.config" --enable STRICT_MODULE_RWX

make -C "$ROOT" \
    O="$OUT" \
    ARCH=arm64 \
    LLVM=1 LLVM_IAS=1 \
    CC="$CLANG_DIR/bin/clang" \
    LD="$CLANG_DIR/bin/ld.lld" \
    olddefconfig

grep -q '^CONFIG_STRICT_KERNEL_RWX=y' "$OUT/.config"

echo "=== ABI sanity ==="

grep -q '^CONFIG_MODULES=y' "$OUT/.config"
grep -q '^CONFIG_MODULE_UNLOAD=y' "$OUT/.config"
grep -q '^CONFIG_MODVERSIONS=y' "$OUT/.config"
grep -q '^CONFIG_MODULES_TREE_LOOKUP=y' "$OUT/.config"
grep -q '^# CONFIG_MODULE_SIG is not set' "$OUT/.config"

make -C "$ROOT" -j"$(nproc)" \
    O="$OUT" \
    ARCH=arm64 \
    LLVM=1 LLVM_IAS=1 \
    CC="$CLANG_DIR/bin/clang" \
    LD="$CLANG_DIR/bin/ld.lld" \
    AR="$CLANG_DIR/bin/llvm-ar" \
    NM="$CLANG_DIR/bin/llvm-nm" \
    OBJCOPY="$CLANG_DIR/bin/llvm-objcopy" \
    OBJDUMP="$CLANG_DIR/bin/llvm-objdump" \
    READELF="$CLANG_DIR/bin/llvm-readelf" \
    STRIP="$CLANG_DIR/bin/llvm-strip" \
    HOSTCC="$CLANG_DIR/bin/clang" \
    HOSTCXX="$CLANG_DIR/bin/clang++" \
    CLANG_TRIPLE=aarch64-linux-gnu- \
    CROSS_COMPILE=aarch64-linux-gnu- \
    Image.gz

IMAGE="$OUT/arch/arm64/boot/Image.gz"

gzip -t "$IMAGE"

echo
echo "ZombieNet V5.2A Image.gz: PASS"
ls -lh "$IMAGE"
sha256sum "$IMAGE"
