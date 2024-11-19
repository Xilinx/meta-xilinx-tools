#
# Copyright (C) 2016-2022, Xilinx, Inc.  All rights reserved.
# Copyright (C) 2023, Advanced Micro Devices, Inc.  All rights reserved.
#
# SPDX-License-Identifier: MIT
#
TOOL_VER_MAIN ?= "${XILINX_XSCT_VERSION}"
TOOL_VER_MAIN[doc] = "XSCT version, usually the same as XILINX_XSCT_VERSION"

XILINX_SDK_TOOLCHAIN_BASE = "${@'${COMPONENTS_DIR}/${BUILD_ARCH}/xsct-native' if d.getVar('PN') == 'defaultpkgname' else '${RECIPE_SYSROOT_NATIVE}'}"
XILINX_SDK_TOOLCHAIN ??= "${XILINX_SDK_TOOLCHAIN_BASE}/Vitis/${TOOL_VER_MAIN}"

ESDK_LOCALCONF_ALLOW:append = " XILINX_SDK_TOOLCHAIN"

XSCT_URL[2022.1] = "https://petalinux.xilinx.com/sswreleases/rel-v2022/xsct-trim/xsct-2022-1.tar.xz"
XSCT_URL[2022.2] = "https://petalinux.xilinx.com/sswreleases/rel-v2022/xsct-trim/xsct-2022-2.tar.xz"
XSCT_URL[2023.1] = "https://petalinux.xilinx.com/sswreleases/rel-v2023/xsct-trim/xsct-2023-1_0425.tar.xz"
XSCT_URL[2023.2] = "https://petalinux.xilinx.com/sswreleases/rel-v2023/xsct-trim/xsct-2023-2_1002.tar.xz"
XSCT_URL[2024.1] = "https://petalinux.xilinx.com/sswreleases/rel-v2024/xsct-trim/xsct-2024-1_0515.tar.xz"
XSCT_URL[2024.2] = "https://petalinux.xilinx.com/sswreleases/rel-v2024.2/xsct-trim/xsct-2024-2_1104.tar.xz"
XSCT_URL ?= "${@d.getVarFlag('XSCT_URL', d.getVar('TOOL_VER_MAIN'))}"
XSCT_TARBALL ?= "xsct_${TOOL_VER_MAIN}.tar.xz"

XSCT_CHECKSUM[2022.1] = "e343a8b386398e292f636f314a057076e551a8173723b8ea0bc1bbd879c05259"
XSCT_CHECKSUM[2022.2] = "8a3272036ca61f017f357bf6ad9dfbdec6aebb39f43c3ca0cee7ec86ea4c066f"
XSCT_CHECKSUM[2023.1] = "b23f1bca2bf2205912797e90061708e228ec76809c5765f5955d12e4b31f82aa"
XSCT_CHECKSUM[2023.2] = "903c8853320e40ed0b23fdf735f88c5a14f945bf92b363f097b8290b523f4016"
XSCT_CHECKSUM[2024.1] = "b73be5f07312e48aa3ceb96d947a5c7b347caf2dd23c85c3db12893c319235d5"
XSCT_CHECKSUM[2024.2] = "7fc702dfd0d94cf2facbdd680b9fb4f873bdb43166ef19bb28acffdce1773c7b"
XSCT_CHECKSUM ?= "${@d.getVarFlag('XSCT_CHECKSUM', d.getVar('TOOL_VER_MAIN'))}"

VALIDATE_XSCT_CHECKSUM ?= '1'
VALIDATE_XSCT_CHECKSUM[doc] = "Ignore the checksum when set to 0"

USE_XSCT_TARBALL ?= '1'
USE_XSCT_TARBALL[doc] = "Flag to determine whether or not to use the xsct-tarball class. \
If enabled, the tarball from path EXTERNAL_XSCT_TARBALL is copied to downloads/xsct, and extracted \
to tmp/sysroots-xsct. XILINX_SDK_TOOLCHAIN is set accordingly to use xsct from this path."

EXTERNAL_XSCT_TARBALL ?= ""
EXTERNAL_XSCT_TARBALL[doc] = "Variable that defines where the xsct tarball is stored"
