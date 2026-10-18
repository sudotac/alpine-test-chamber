#!/bin/sh
# SPDX-License-Identifier: CC0-1.0

arch="$(cat /etc/apk/arch)"
case "$arch" in
    x86_64)
        boot_arch=x64
        ;;
    aarch64)
        boot_arch=aa64
        ;;
    riscv64)
        boot_arch=riscv64
        ;;
esac
install -Dm755 /usr/share/edk2-shell/Shell.efi /boot/EFI/boot/boot"$boot_arch".efi

cat << EOS | setup-interfaces -i
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
EOS
rc-update --quiet add networking boot

sed -i '/^#ttyS0/a hvc0::respawn:/sbin/getty -L 115200 hvc0 vt100' /etc/inittab
