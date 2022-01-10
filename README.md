meta-xilinx-tools
=================

This layer provides support for using Xilinx tools on supported architectures
MicroBlaze, Zynq and ZynqMP.

Maintainers, Mailing list, Patches
==================================

Please send any patches, pull requests, comments or questions for this layer to
the [meta-xilinx mailing list](https://lists.yoctoproject.org/listinfo/meta-xilinx)
with ['meta-xilinx-tools'] in the subject:

	meta-xilinx@lists.yoctoproject.org

Maintainers:

	Jaewon Lee <jaewon.lee@xilinx.com>
        Sai Hari Chandana Kalluri <chandana.kalluri@xilinx.com>
        Mark Hatle <mark.hatle@xilinx.com>

Dependencies
============

This layer depends on: xsct

xsct-tarball class fetches the required xsct tool and installs it in the local
Yocto build directory, as xsct. All of the recipes which depend on xsct will
use it from this location.  Please see the Xilinx EULA license file for xsct
at the following location:

https://www.xilinx.com/support/documentation/sw_manuals/xilinx2021_2/end-user-license-agreement.pdf

Each release is dependent on the Xilinx XSCT release version. Please note that
xsct tools may not be backward compatible with embeddedsw repo. Meaning
2016.3 xsct tools might not work with older version on embeddedsw repo

Layer dependencies
=====================

URI: git://git.openembedded.org/bitbake

URI: git://git.openembedded.org/openembedded-core

URI: git://git.openembedded.org/meta-xilinx (meta-xilinx-bsp)

URI: git://git.openembedded.org/meta-xilinx (meta-xilinx-standalone)

Providing path to XSA
=====================

meta-xilinx-tools recipes depends on XSA to be provided.
As of the 2019.2 release, all design files were renamed from hdf to xsa.
But the variables and references to hdf will remain and renamed in the future release

HDF_BASE can be set to git:// or file://

HDF_PATH will be git repository or the path containing HDF

For example:

Set the following way to use XSA from local path

HDF_BASE = "file://"

HDF_PATH = "/< path-to-xsa >/system.xsa"

Adding dependencies to build BOOT.bin
=====================================

This layer can be used via dependencies while creating the required Boot.bin.

Basically the goal to build FSBL or PMU etc will depend on the use-case and
Boot.bin will indicate these dependencies.  Boot.bin is created using bootgen
tool from Xilinx. Please refer to help files of bootgen.

Executing bootgen -bif_help  will provide some detailed help on BIF attributes.

BIF file is required for generating boot.bin, BIF is partitioned into Common
BIF attributes and Partition BIF attributes. Attributes of BIF need to be
specified in local.conf while using xilinx-bootbin recipe for generating
boot.bin

Use IMAGE_INSTALL_append = " xilinx-bootbin" in local.conf

Examples for adding dependencies
================================

1) Example to include dependency for zc702-zynq7 board
--------------------------------------------------------

See https://github.com/Xilinx/meta-xilinx-tools/blob/master/recipes-bsp/bootbin/machine-xilinx-zynq.inc

BIF_PARTITION_ATTR= "fsbl u-boot"

BIF_PARTITION_ATTR[fsbl]="bootloader"

BIF_PARTITION_IMAGE[fsbl]="${DEPLOY_DIR_IMAGE}/fsbl-${MACHINE}.elf"

BIF_PARTITION_DEPENDS[fsbl]="virtual/fsbl:do_deploy"


BIF_PARTITION_IMAGE[u-boot]="${DEPLOY_DIR_IMAGE}/u-boot-${MACHINE}.elf"

BIF_PARTITION_DEPENDS[u-boot]="virtual/bootloader:do_deploy"


2) Example to include dependency for zcu102-zynqmp board
---------------------------------------------------------

See https://github.com/Xilinx/meta-xilinx-tools/blob/master/recipes-bsp/bootbin/machine-xilinx-zynqmp.inc

BIF_PARTITION_ATTR= "fsbl pmu atf u-boot"

BIF_PARTITION_ATTR[fsbl]="bootloader, destination_cpu=a53-0"

BIF_PARTITION_IMAGE[fsbl]="${DEPLOY_DIR_IMAGE}/fsbl-${MACHINE}.elf"

BIF_PARTITION_DEPENDS[fsbl]="virtual/fsbl:do_deploy"


BIF_PARTITION_ATTR[pmu]="destination_cpu=pmu"

BIF_PARTITION_IMAGE[pmu]="${DEPLOY_DIR_IMAGE}/pmu-firmware-${MACHINE}.elf"

BIF_PARTITION_DEPENDS[pmu] ?= "virtual/pmu-firmware:do_deploy"


BIF_PARTITION_ATTR[atf]="destination_cpu=a53-0,exception_level=el-3,trustzone"

BIF_PARTITION_IMAGE[atf]="${DEPLOY_DIR_IMAGE}/arm-trusted-firmware-${TUNE_PKGARCH}.elf"

BIF_PARTITION_DEPENDS[atf]="arm-trusted-firmware:do_deploy"


BIF_PARTITION_ATTR[u-boot]="destination_cpu=a53-0,exception_level=el-2"

BIF_PARTITION_IMAGE[u-boot]="${DEPLOY_DIR_IMAGE}/u-boot-${MACHINE}.elf"

BIF_PARTITION_DEPENDS[u-boot]="virtual/bootloader:do_deploy"

Additional configurations using YAML
====================================

This layer provides additional configurations through YAML

1) Example YAML based configuration for uart0 setting in PMU Firmware

YAML_SERIAL_CONSOLE_STDIN = "psu_uart_0"

YAML_SERIAL_CONSOLE_STDOUT = "psu_uart_0"

2) Example YAML based configuration for device tree generation

YAML_MAIN_MEMORY_CONFIG = "psu_ddr_0"

YAML_CONSOLE_DEVICE_CONFIG = "psu_uart_0"

3) YAML_DT_BOARD_FLAGS has board specific dtsi in DTG code base this can be enabled by using
See https://github.com/Xilinx/device-tree-xlnx/tree/master/device_tree/data/kernel_dtsi/2018.1/BOARD

YAML_DT_BOARD_FLAGS = "{BOARD zcu102-rev1.0}"

Note only Xilinx eval boards have the dtsi in DTG, for custom board one needs
to patch DTG to include the custom board dtsi and enable it using YAML
configuration


