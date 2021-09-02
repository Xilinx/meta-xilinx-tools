# Should not need any external patches
SRC_URI = "${EMBEDDEDSW_SRCURI}"

# We WANT to default to this version when available
DEFAULT_PREFERENCE = "100"

inherit xsctapp xsctyaml

B = "${S}/${XSCTH_PROJ}"
B_zynq = "${S}/${XSCTH_PROJ}"
B_zynqmp = "${S}/${XSCTH_PROJ}"

# Use BOARDVARIANT_ARCH, but if it's undefined fall back to SOC_VARIANT_ARCH
# instead of MACHINE_ARCH.  This is because the same machine may be used with
# different variants, and zynqmp-dr is known to be 'different'.
SOC_VARIANT_ARCH ??= "${MACHINE_ARCH}"
PACKAGE_ARCH_zynqmp-dr = "${@['${BOARDVARIANT_ARCH}', '${SOC_VARIANT_ARCH}'][d.getVar('BOARDVARIANT_ARCH')==d.getVar('MACHINE_ARCH')]}"

XSCTH_MISC_append_zynqmp-dr = " -lib libmetal"

XSCTH_COMPILER_DEBUG_FLAGS = " -DFSBL_DEBUG_INFO"

XSCTH_APP_zynq   = "Zynq FSBL"
XSCTH_APP_zynqmp = "Zynq MP FSBL"

# Building for zynq does work here
COMPATIBLE_MACHINE_zynq = ".*"

# XSCT version provides it's own toolchain, so can build in any environment
COMPATIBLE_HOST_zynq   = "${HOST_SYS}"
COMPATIBLE_HOST_zynqmp = "${HOST_SYS}"

# Clear this for a Linux build, using the XSCT toolchain
EXTRA_OEMAKE_linux = ""
EXTRA_OEMAKE_linux-gnueabi = ""

# Workaround for hardcoded toolchain items
XSCT_PATH_ADD_append_elf = "\
${WORKDIR}/bin:"

XSCT_PATH_ADD_append_eabi = "\
${WORKDIR}/bin:"

do_compile_prepend_elf_aarch64() {
  mkdir -p ${WORKDIR}/bin
  echo "#! /bin/bash\n${CC} \$@" > ${WORKDIR}/bin/aarch64-none-elf-gcc
  echo "#! /bin/bash\n${AS} \$@" > ${WORKDIR}/bin/aarch64-none-elf-as
  echo "#! /bin/bash\n${AR} \$@" > ${WORKDIR}/bin/aarch64-none-elf-ar
  chmod 0755 ${WORKDIR}/bin/aarch64-none-elf-gcc
  chmod 0755 ${WORKDIR}/bin/aarch64-none-elf-as
  chmod 0755 ${WORKDIR}/bin/aarch64-none-elf-ar
}

ARM_INSTRUCTION_SET_eabi_arm = "arm"
do_compile_prepend_eabi_arm() {
  mkdir -p ${WORKDIR}/bin
  echo "#! /bin/bash\n${CC} \$@" > ${WORKDIR}/bin/arm-none-eabi-gcc
  echo "#! /bin/bash\n${AS} \$@" > ${WORKDIR}/bin/arm-none-eabi-as
  echo "#! /bin/bash\n${AR} \$@" > ${WORKDIR}/bin/arm-none-eabi-ar
  chmod 0755 ${WORKDIR}/bin/arm-none-eabi-gcc
  chmod 0755 ${WORKDIR}/bin/arm-none-eabi-as
  chmod 0755 ${WORKDIR}/bin/arm-none-eabi-ar
}

# xsctapp sets it's own do_install, replace it with the real one
do_install() {
    :
}

do_deploy() {
    install -Dm 0644 ${B}/${XSCTH_PROJ}/executable.elf ${DEPLOYDIR}/${FSBL_BASE_NAME}.elf
    ln -sf ${FSBL_BASE_NAME}.elf ${DEPLOYDIR}/${FSBL_IMAGE_NAME}.elf
}
