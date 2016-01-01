#!/bin/sh

# Update submodule:
git submodule update

# Move into dir:
cd openwrt

# Clean:
git clean -f
git checkout -f
make target/linux/clean

# Copy config:
cp ../config .config

# Copy root filesystem:
rsync -avz ../root/ ./files

# Apply patches:
for i in ../patches/*; do
	patch -p1 < "$i"
done

# Make:
make -j4

# Image is in:
#  bin/ramips/openwrt-15.05-ramips-rt305x-wl-351-squashfs-sysupgrade.bin
