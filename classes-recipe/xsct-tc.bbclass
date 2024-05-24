#
# Copyright (C) 2016-2022, Xilinx, Inc.  All rights reserved.
# Copyright (C) 2022-2023, Advanced Micro Devices, Inc.  All rights reserved.
#
# SPDX-License-Identifier: MIT
#

XSCT_PATH_ADD = "${XILINX_SDK_TOOLCHAIN}/bin:"

# When building in a Linux target config, we need to use the provided XSCT
# compiler, don't bother to build compilers for this...
INHIBIT_DEFAULT_DEPS:linux = "1"
INHIBIT_DEFAULT_DEPS:linux-gnueabi = "1"

TC_XSCT_PATH = "\
${XILINX_SDK_TOOLCHAIN}/gnu/microblaze/lin/bin:\
${XILINX_SDK_TOOLCHAIN}/gnu/aarch32/lin/gcc-arm-none-eabi/bin:\
${XILINX_SDK_TOOLCHAIN}/gnu/armr5/lin/gcc-arm-none-eabi/bin:\
${XILINX_SDK_TOOLCHAIN}/gnu/aarch64/lin/aarch64-none/bin:"

XSCT_PATH_ADD:append:linux = "${TC_XSCT_PATH}"
XSCT_PATH_ADD:append:linux-gnueabi = "${TC_XSCT_PATH}"

PATH =. "${XSCT_PATH_ADD}"
TOOL_PATH = "${XILINX_SDK_TOOLCHAIN}/bin"
TOOL_VERSION_COMMAND = "hsi -version"
TOOL_VER_MAIN ??= "${XILINX_XSCT_VERSION}"
TOOL_NAME = "xsct"
