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

XSCT being installed in your path

URI: git://git.openembedded.org/bitbake

URI: git://git.openembedded.org/openembedded-core
layers: meta

Adding YAML configurations
==========================

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
