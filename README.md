# OpenWRT build script for the Sitecom WL-351

This repository contains all necessary components to build a working [OpenWRT](https://openwrt.org) image for the Sitecom WL-351 home router, based on the latest OpenWRT 15.05 Chaos Calmer.
The plan was initially to customize the stock Chaos Calmer image, but because the stock image for this device was broken (no support for the RTL8366RB switch), I first had to find a way to make it work.
That took a lot of digging and experimenting, especially getting the external switch to work.
Hopefully this will save other people the effort.

This is not intended to be a generic image build; it's my home setup.
If you want to recycle it, you'll probably need to make some small changes.
My goal was minimalism: text files for configuration instead of LuCI, all config files baked into the image, no IPv6 support.
The base image alone uses almost all of the 4MB flash memory.

The `openwrt` directory is the OpenWRT root.
To fetch the OpenWRT tree:

```sh
git submodule init
git submodule update
```

The main OpenWRT config file is called `config`.
To edit it inside the OpenWRT configuration menu:

```sh
cd ./openwrt
cp ../config .config
make menuconfig
cp .config ../config
```

The `root` directory contains files and directories that will be baked into the image.
This is where our custom config files go.

The `patches` directory contains patches on top of OpenWRT.
Currently it contains one patch, which is an edited version of [this patch](https://dev.openwrt.org/ticket/17475) by [@ranma](https://github.com/ranma).
That patch disables the second, internal RT3052 switch, which turned out to be the missing piece in the puzzle.
This second switch was a red herring that had me running around in circles.
In the end we don't need it at all.

The `build.sh` script is a small shell script that actually builds the image.
The compiled sysupgrade image can be found at:

```
./openwrt/bin/ramips/openwrt-15.05-ramips-rt305x-wl-351-squashfs-sysupgrade.bin
```

To flash the image onto the router, you'll need a TFTP server and a serial cable adapter.
I use a Raspberry Pi for the TFTP server, and my serial cable is a cheap USB TTL serial converter from China.
With the serial cable attached, reboot the router and type `2` when the U-Boot version string appears.
Then follow the instructions to load the new image from the TFTP server.
The [OpenWRT wiki](https://wiki.openwrt.org/toh/sitecom/wl-351) explains this further.
