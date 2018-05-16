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

Manjukumar Harthikote Matha

Dependencies
============

This layer depends on:

* **You'll need `xlsclients` and `Xvfb` to satisfy the XSCT dependence on it.
You may install these by `apt-get install -y xvfb x11-utils` or the like.

XSCT being installed somewhere the yocto build can access. You must define
this path by specifying the XILINX_SDK_TOOLCHAIN variable globally, typically
in your local.conf (or site.conf).

The supported tool version is indicated in XILINX_VER_MAIN which defaults to
the current release that is checked out.

It would be wise then to define XILINX_SDK_TOOLCHAIN like so:
XILINX_SDK_TOOLCHAIN = "/full/path/to/xilinx/SDK/${XILINX_VER_MAIN}"

Each release is dependent on the Xilinx XSCT release version. Please note that
xsct tools may not be backward compatible with embeddedsw repo. Meaning
2016.3 xsct tools might not work with older version on embeddedsw repo

URI: git://git.openembedded.org/bitbake

URI: git://git.openembedded.org/openembedded-core


Providing path to HDF
=====================

meta-xilinx-tools recipes depends on HDF to be provided.

HDF_BASE can be set to git:// or file://

HDF_PATH will be git repository or the path containing HDF

Adding Dependencies to build BOOT.bin
=====================================

This layer can be used via dependencies while creating the required Boot.bin.

Basically the goal to build FSBL or PMU etc will depend on the use-case and
Boot.bin will indicate these dependencies.  Boot.bin is created using bootgen
tool from Xilinx. Please refer to help files of bootgen.

Executing bootgen -bif_help  will provide some detailed help on BIF attributes.

BIF file is required for generating Boot.bin, BIF is partitioned into Common
BIF attributes and Partition BIF attributes. Attributes of BIF need to be
specified in local.conf while using xilinx-bootbin.bbclass for generating
Boot.bin

Examples for adding dependencies
================================

1) Example to include dependency for zc702-zynq7 board

IMAGE_CLASSES += " xilinx-bootbin"

BIF_PARTITION_ATTR= "fsbl u-boot"

BIF_PARTITION_IMAGE[fsbl]="${DEPLOY_DIR_IMAGE}/fsbl-${MACHINE}.elf"
BIF_PARTITION_DEPENDS[fsbl]="virtual/fsbl:do_deploy"

BIF_PARTITION_IMAGE[u-boot]="${DEPLOY_DIR_IMAGE}/u-boot-${MACHINE}.elf"


2) Example to include dependency for zcu102-zynqmp board

IMAGE_CLASSES += " xilinx-bootbin"

BIF_COMMON_ATTR= "fsbl_config"
BIF_COMMON_ATTR[fsbl_config]="a53_x64"

BIF_PARTITION_ATTR= "fsbl pmu atf u-boot"

BIF_PARTITION_ATTR[fsbl]="bootloader"
BIF_PARTITION_IMAGE[fsbl]="${DEPLOY_DIR_IMAGE}/fsbl-${MACHINE}.elf"
BIF_PARTITION_DEPENDS[fsbl]="virtual/fsbl:do_deploy"

BIF_PARTITION_ATTR[pmu]="destination_cpu=pmu"
BIF_PARTITION_IMAGE[pmu]="${DEPLOY_DIR_IMAGE}/pmu-${MACHINE}.elf"
BIF_PARTITION_DEPENDS[pmu]="virtual/pmufw:do_deploy"

BIF_PARTITION_ATTR[atf]="destination_cpu=a53-0,exception_level=el-3,trustzone"
BIF_PARTITION_IMAGE[atf]="${DEPLOY_DIR_IMAGE}/arm-trusted-firmware-${TUNE_PKGARCH}.elf"

BIF_PARTITION_ATTR[u-boot]="destination_cpu=a53-0,exception_level=el-2"
BIF_PARTITION_IMAGE[u-boot]="${DEPLOY_DIR_IMAGE}/u-boot-${MACHINE}.elf"

Additional configurations using YAML
====================================

This layer provides additional configurations through YAML

1) Example YAML based configuration for uart0 setting in PMU Firmware

YAML_FILE_PATH = "${WORKDIR}/pmufw.yaml"
YAML_BSP_CONFIG="stdin stdout"
YAML_BSP_CONFIG[stdin]="set,psu_uart_0"
YAML_BSP_CONFIG[stdout]="set,psu_uart_0"
XSCTH_MISC = "-yamlconf ${YAML_FILE_PATH}"

2) Example YAML based configuration for device tree generation

YAML_FILE_PATH = "${WORKDIR}/dtgen.yaml"
YAML_BSP_CONFIG="main_memory console_device pcw_dts"
YAML_BSP_CONFIG[main_memory]="set,psu_ddr_0"
YAML_BSP_CONFIG[console_device]="set,psu_uart_0"
YAML_BSP_CONFIG[pcw_dts]="set,pcw.dtsi"
XSCTH_MISC = "-yamlconf ${YAML_FILE_PATH}"
