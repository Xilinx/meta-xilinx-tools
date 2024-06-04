inherit xsctapp xsctyaml

# The makefile does not handle parallelization
PARALLEL_MAKE = "-j1"

B = "${S}/${XSCTH_PROJ}"

XSCTH_PROC_IP = "psv_psm"
XSCTH_PROC_IP:versal-net = "psx_psm"
XSCTH_APP  = "versal PSM Firmware"

# XSCT version provides it's own toolchain, so can build in any environment
COMPATIBLE_HOST:versal = "${HOST_SYS}"
COMPATIBLE_HOST:versal-net = "${HOST_SYS}"

# Clear this for a Linux build, using the XSCT toolchain
EXTRA_OEMAKE:linux = ""

# Workaround for hardcoded toolchain items
XSCT_PATH_ADD:append:elf = "\
${UNPACKDIR}/bin:"

MB_OBJCOPY = "mb-objcopy"

do_configure:prepend:elf() {
  mkdir -p ${UNPACKDIR}/bin
  echo "#! /bin/bash\n${CC} \$@" > ${UNPACKDIR}/bin/mb-gcc
  echo "#! /bin/bash\n${AS} \$@" > ${UNPACKDIR}/bin/mb-as
  echo "#! /bin/bash\n${AR} \$@" > ${UNPACKDIR}/bin/mb-ar
  echo "#! /bin/bash\n${AR} \$@" > ${UNPACKDIR}/bin/mb-gcc-ar
  echo "#! /bin/bash\n${OBJCOPY} \$@" > ${UNPACKDIR}/bin/mb-objcopy
  chmod 0755 ${UNPACKDIR}/bin/mb-gcc
  chmod 0755 ${UNPACKDIR}/bin/mb-as
  chmod 0755 ${UNPACKDIR}/bin/mb-ar
  chmod 0755 ${UNPACKDIR}/bin/mb-gcc-ar
  chmod 0755 ${UNPACKDIR}/bin/mb-objcopy
}

do_compile:append() {
  ${MB_OBJCOPY} -O binary ${B}/${XSCTH_PROJ}/executable.elf ${B}/${XSCTH_PROJ}/executable.bin
}

# xsctapp sets it's own do_install, replace it with the real one
do_install() {
    :
}

do_deploy() {
    install -Dm 0644 ${B}/${XSCTH_PROJ}/executable.elf ${DEPLOYDIR}/${PSM_FIRMWARE_BASE_NAME}.elf
    ln -sf ${PSM_FIRMWARE_BASE_NAME}.elf ${DEPLOYDIR}/${PSM_FIRMWARE_IMAGE_NAME}.elf
    install -m 0644 ${B}/${XSCTH_PROJ}/executable.bin ${DEPLOYDIR}/${PSM_FIRMWARE_BASE_NAME}.bin
    ln -sf ${PSM_FIRMWARE_BASE_NAME}.bin ${DEPLOYDIR}/${PSM_FIRMWARE_IMAGE_NAME}.bin
}

addtask deploy before do_build after do_install
