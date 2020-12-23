#!/usr/bin/env bash

boot_device=/dev/nvme0n1;
root_device=/dev/nvme0n1p2;

linux_params="i8042.nopnp=1 pci=nocrs i915.enable_dpcd_backlight=1 acpi_backlight=vendor loglevel=3";
# rd.udev.log-priority=3
# acpi_backlight=video acpi_backlight=vendor acpi_backlight=native
# acpi=off

uuid=$(sudo blkid -s UUID -o value "$root_device");

params=$(printf "%s " \
  "root=UUID=$uuid rw" \
  "initrd=\intel-ucode.img initrd=\initramfs-linux.img" \
  "$linux_params" \
);

echo -e "----------------------------";
echo "UUID: $uuid";
echo "PARAMS: $params";
echo -e "----------------------------\n";

sudo efibootmgr -d "$boot_device" -p 1 \
  -c -L "Artix Linux" \
  -l /vmlinuz-linux \
  -u "$params" \
  --verbose;
