inherit xsct-tarball
XILINX_SDK_TOOLCHAIN ??= "${XSCT_STAGING_DIR}/Vitis/${XILINX_VER_MAIN}"

XSCT_PATH_ADD = "${XILINX_SDK_TOOLCHAIN}/bin:\
${XILINX_SDK_TOOLCHAIN}/gnu/microblaze/lin/bin:\
${XILINX_SDK_TOOLCHAIN}/gnu/aarch32/lin/gcc-arm-none-eabi/bin:\
${XILINX_SDK_TOOLCHAIN}/gnu/armr5/lin/gcc-arm-none-eabi/bin:\
${XILINX_SDK_TOOLCHAIN}/gnu/aarch64/lin/aarch64-none/bin:"
PATH =. "${XSCT_PATH_ADD}"
TOOL_PATH = "${XILINX_SDK_TOOLCHAIN}/bin"
TOOL_VERSION_COMMAND = "hsi -version"
TOOL_VER_MAIN = "${XILINX_VER_MAIN}"
TOOL_NAME = "xsct"
