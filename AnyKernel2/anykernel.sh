# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Phantom Kernel by @Dencel007. Credits: TeamQuantum & TeamGhost
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=1
device.name1=santoni
device.name2=Xiaomi
device.name3=Redmi 4X
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;


## AnyKernel install
dump_boot;

# begin ramdisk changes

# fstab.qcom
if [ -f /fstab.qcom ]; then
insert_line fstab.qcom "data        f2fs" before "data        ext4" "/dev/block/bootdevice/by-name/userdata     /data        f2fs    nosuid,nodev,noatime,inline_xattr,data_flush      wait,check,encryptable=footer,formattable,length=-16384";
insert_line fstab.qcom "cache        f2fs" after "data        ext4" "/dev/block/bootdevice/by-name/cache     /cache        f2fs    nosuid,nodev,noatime,inline_xattr,flush_merge,data_flush wait,formattable,check";
fi;

# end ramdisk changes

write_boot;

## end install

