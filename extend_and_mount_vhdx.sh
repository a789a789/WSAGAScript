#!/bin/bashhttps://github.com/WSA-Community/WSAGAScript/tree/WSA-Community:main

. ./VARIABLES.sh

if [[ ! /proc/self/mounts -ef /etc/mtab ]]; then
	printf "/etc/mtab doesn't exist or is invalid\n"
	printf 'creating valid /etc/mtab\n'
	ln -sf /proc/self/mounts /etc/mtab
fi

echo "chk product."
e2fsck -f $ImagesRoot/product.vhdx

echo "Resizing product.vhdx"
resize2fs $ImagesRoot/product.vhdx 1024M

echo "chk system.vhdx"
e2fsck -f $ImagesRoot/system.vhdx

echo "Resizing system.vhdx"
resize2fs $ImagesRoot/system.vhdx 1280M

echo "chk system_ext.vhdx"
e2fsck -f $ImagesRoot/system_ext.vhdx

echo "Resizing system_ext.vhdx"
resize2fs $ImagesRoot/system_ext.vhdx 150M

echo "chk vendor.vhdx"
e2fsck -f $ImagesRoot/vendor.vhdx

echo "Resizing vendor.vhdx"
resize2fs $ImagesRoot/vendor.vhdx 400M

echo "Creating mount point for product"
mkdir -p $MountPointProduct

echo "Creating mount point for system_ext" 
mkdir -p $MountPointSystemExt

echo "Creating mount point for system"
mkdir -p $MountPointSystem

echo "Creating mount point for vendor"
mkdir -p $MountPointVendor

echo "Mounting product"
mount $ImagesRoot/product.vhdx $MountPointProduct

echo "Mounting system_ext"
mount $ImagesRoot/system_ext.vhdx $MountPointSystemExt

echo "Mounting system"
mount $ImagesRoot/system.vhdx $MountPointSystem

echo "Mounting vendor"
mount $ImagesRoot/vendor.vhdx $MountPointVendor

echo "!! Images mounted !!"
