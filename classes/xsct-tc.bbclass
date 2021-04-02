XILINX_SDK_TOOLCHAIN ??= "${XSCT_STAGING_DIR}/Vitis/${XILINX_VER_MAIN}"

XSCT_PATH_ADD = "${XILINX_SDK_TOOLCHAIN}/bin:"

# When building in a Linux target config, we need to use the provided XSCT
# compiler, don't bother to build compilers for this...
INHIBIT_DEFAULT_DEPS_linux = "1"
INHIBIT_DEFAULT_DEPS_linux-gnueabi = "1"

TC_XSCT_PATH = "\
${XILINX_SDK_TOOLCHAIN}/gnu/microblaze/lin/bin:\
${XILINX_SDK_TOOLCHAIN}/gnu/aarch32/lin/gcc-arm-none-eabi/bin:\
${XILINX_SDK_TOOLCHAIN}/gnu/armr5/lin/gcc-arm-none-eabi/bin:\
${XILINX_SDK_TOOLCHAIN}/gnu/aarch64/lin/aarch64-none/bin:"

XSCT_PATH_ADD_append_linux = "${TC_XSCT_PATH}"
XSCT_PATH_ADD_append_linux-gnueabi = "${TC_XSCT_PATH}"

PATH =. "${XSCT_PATH_ADD}"
TOOL_PATH = "${XILINX_SDK_TOOLCHAIN}/bin"
TOOL_VERSION_COMMAND = "hsi -version"
TOOL_VER_MAIN = "${XILINX_VER_MAIN}"
TOOL_NAME = "xsct"
