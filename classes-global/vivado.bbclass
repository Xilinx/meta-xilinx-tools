#
# Copyright (C) 2018-2022, Xilinx, Inc.  All rights reserved.
# Copyright (C) 2023, Advanced Micro Devices, Inc.  All rights reserved.
#
# SPDX-License-Identifier: MIT
#

inherit xilinx-tool-check

VIVADO_PATH_ADD = "${XILINX_VIVADO_DESIGN_SUIT}/bin:"
PATH =. "${VIVADO_PATH_ADD}"

TOOL_PATH = "${XILINX_VIVADO_DESIGN_SUIT}/bin"
TOOL_VERSION_COMMAND = "vivado -version"
TOOL_VER_MAIN ??= "${XILINX_XSCT_VERSION}"
TOOL_NAME = "vivado"
