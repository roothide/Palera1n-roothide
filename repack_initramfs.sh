#! /bin/sh
set -e
set -x

cd $(dirname "$0")/initramfs

chmod -R +r .
rm -f ../initramfs.xz
find . | cpio -oH newc | xz -C crc32 --x86 -vz9eT$(nproc --all) > ../initramfs.xz

cd ..
