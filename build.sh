#!/bin/sh

# Update submodule:
git submodule update

# Move into dir:
cd openwrt

# Copy config:
cp ../config .config

# Make:
make -j4

# Image is in:
#  bin/ramips/openwrt-15.05-ramips-rt305x-wl-351-squashfs-sysupgrade.bin
