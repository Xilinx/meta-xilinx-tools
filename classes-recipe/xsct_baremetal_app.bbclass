#
# Copyright (C) 2023, Advanced Micro Devices, Inc.  All rights reserved.
#
# SPDX-License-Identifier: MIT
#
# This bbclass provides build infrastructure for Baremetal Application for both
# APU and RPU.

inherit xsctapp xsctyaml deploy

DEPENDS = "esw-bsp"

# For ZynqMP DR device Baremetal app depends on libmetal.
DEPENDS:append:zynqmp-dr = " libmetal"

# recipes that inherit from this class need to use an appropriate machine
# override for COMPATIBLE_MACHINE to build successfully; don't allow building
# for microblaze MACHINE
COMPATIBLE_MACHINE ?= "^$"
COMPATIBLE_MACHINE:microblaze = "^$"

# Use "standalone" template for Baremetal application.
BAREMETAL_SUPPORTED_OS_NAME ?= "standalone"
BAREMETAL_DEPENDS_LIBRARIES ?= "xiltimer"
XSCTH_MISC:append = " -osname ${BAREMETAL_SUPPORTED_OS_NAME} -lib ${BAREMETAL_DEPENDS_LIBRARIES}"

# Set default target processor and user can override this from recipe.
XSCTH_PROC_IP:versal ?= "psv_cortexr5"
XSCTH_PROC_IP:zynqmp ?= "psu_cortexr5"
XSCTH_PROC:zynq ?= "ps7_cortexa9_1"

# Configurable params for Baremetal BSP such as UART, Clocking etc.
# TODO - Define params.

# The makefile does not handle parallelization
PARALLEL_MAKE = "-j1"

XSCTH_APP_COMPILER_FLAGS:append:zynqmp = " -mfloat-abi=hard "
XSCTH_APP_COMPILER_FLAGS:append:versal = " -mfloat-abi=hard "

# Disable arch QA check errors.
INSANE_SKIP:${PN} = "arch"

# Disable buildpaths QA check warnings.
INSANE_SKIP:${PN} += "buildpaths"

do_install() {
    install -d ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/
    if [ -f ${B}/${XSCTH_PROJ}/${XSCTH_EXECUTABLE} ]; then
        install -Dm 0644 ${B}/${XSCTH_PROJ}/${XSCTH_EXECUTABLE} ${D}${nonarch_base_libdir}/firmware/xilinx/${PN}/${PN}.elf
    fi
}

FILES:${PN} += "${nonarch_base_libdir}/firmware/xilinx/${PN}"
