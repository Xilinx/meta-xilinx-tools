# qemu-microblazeel
FILESEXTRAPATHS:prepend:qemu-microblazeel := "${THISDIR}/linux-xlnx:"
SRC_URI:append:qemu-microblazeel = " file://qemu-microblazeel.cfg"
