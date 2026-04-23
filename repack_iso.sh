#! /bin/sh
set -e
set -x

cd $(dirname "$0")/

rm -f ./palen1x-new.iso

# cp ./palen1x.iso ./palen1x-new.iso
# xorriso -dev ./palen1x-new.iso  -boot_image any keep -update ./initramfs.xz  /boot/initramfs.xz -end

[ -e ./rootfs ] && sudo rm -rf ./rootfs
mkdir ./rootfs && xorriso -indev ./palen1x.iso -osirrox on -extract / ./rootfs/
sudo cp ./initramfs.xz ./rootfs/boot/initramfs.xz

#xorriso -indev ./palen1x.iso -report_el_torito as_mkisofs
xorriso -as mkisofs \
  -o ./palen1x-new.iso \
  -V 'ISOIMAGE' \
  --grub2-mbr --interval:local_fs:0s-15s:zero_mbrpt,zero_gpt,zero_apm:./palen1x.iso \
  --protective-msdos-label \
  -partition_cyl_align off \
  -partition_offset 0 \
  -partition_hd_cyl 64 \
  -partition_sec_hd 32 \
  -apm-block-size 2048 \
  -hfsplus \
  -efi-boot-part --efi-boot-image \
  -c '/boot.catalog' \
  -b '/boot/grub/i386-pc/eltorito.img' \
  -no-emul-boot \
  -boot-load-size 4 \
  -boot-info-table \
  --grub2-boot-info \
  -eltorito-alt-boot \
  -e '/efi.img' \
  -no-emul-boot \
  -boot-load-size 5760 \
  ./rootfs/

xorriso -indev ./palen1x.iso -report_el_torito plain
xorriso -indev ./palen1x-new.iso -report_el_torito plain
