#!/bin/sh
# Minimal compatibility shim for older Android kernel trees.

case "$1" in
  binutils)
    echo 2.25.0
    ;;
  gcc)
    echo 4.9.0
    ;;
  llvm|clang)
    echo 10.0.0
    ;;
  *)
    echo 0.0.0
    ;;
esac
