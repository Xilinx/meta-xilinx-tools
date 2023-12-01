#
# Copyright (C) 2016-2022, Xilinx, Inc.  All rights reserved.
# Copyright (C) 2023, Advanced Micro Devices, Inc.  All rights reserved.
#
# SPDX-License-Identifier: MIT
#

inherit xsctapp

FILESEXTRAPATHS:append := ":${XLNX_SCRIPTS_DIR}"
SRC_URI:append =" \
  file://fsboot.tcl \
  file://base-hsi.tcl \
"

XSCTH_BUILD_CONFIG = ""

XSCTH_SCRIPT = "${WORKDIR}/fsboot.tcl"
