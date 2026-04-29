#!/bin/sh
# SPDX-License-Identifier: CC0-1.0

cat << EOS | setup-interfaces -i
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
EOS
rc-update --quiet add networking boot
