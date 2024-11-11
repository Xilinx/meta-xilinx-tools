# We use dtgen (xsct) to process a base configuration, and then patch the
# output, if necessary, to generate a qemu specific configuration.
#
# The patched configurations are not intended to represent any real boards
# but instead enable Yocto Project testimage.
#
# Note, patching things in this way is NOT considered a good practice.
# it is not recommended to follow this approach unless absolutely necessary.

SRC_URI:append:qemu-microblazeel = " file://qemu-microblazeel.nopatch"

do_patch_config:qemu-microblazeel() {
    cd ${B}
    cat ${WORKDIR}/qemu-microblazeel.nopatch | patch -p1
}



SRC_URI:append:qemu-zynq7 = " file://qemu-zynq7.nopatch"

do_patch_config:qemu-zynq7() {
    cd ${B}
    cat ${WORKDIR}/qemu-zynq7.nopatch | patch -p1
}



SRC_URI:append:qemu-zynqmp = " file://qemu-zynqmp.nopatch"

do_patch_config:qemu-zynqmp() {
    cd ${B}
    cat ${WORKDIR}/qemu-zynqmp.nopatch | patch -p1
}



SRC_URI:append:qemu-versal = " file://qemu-versal.nopatch"

do_patch_config:qemu-versal() {
    cd ${B}
    cat ${WORKDIR}/qemu-versal.nopatch | patch -p1
}


SRC_URI:append:qemu-versal = " file://qemu-versal-net.nopatch"

do_patch_config:qemu-versal() {
    cd ${B}
    cat ${WORKDIR}/qemu-versal-net.nopatch | patch -p1
}


# Empty no-op default
do_patch_config() {
    :
}

addtask patch_config after do_configure before do_compile
