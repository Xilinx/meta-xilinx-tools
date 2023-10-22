# Build Instructions to create Versal DFx Static firmware recipes

* [Introduction](#introduction)
* [How to create a firmware recipe app](#how-to-create-a-firmware-recipe-app)
* [Test Procedure on Target](#test-procedure-on-target)
  * [Loading DFx Static pdi and dt overlay](#loading-dfx-static-pdi-and-dt-overlay)
  * [Unloading DFx Static pdi and dt overlay](#unloading-dfx-static-pdi-and-dt-overlay)
* [References](#references)

## Introduction
This readme describes the build instructions to create firmware recipes using
dfx_dtg_versal_static.bbclass for Versal DFx Static configuration. This bitbake
class supports following use cases. This bitbake class support only vivado dfx
design.

> **Note:** Refer https://github.com/Xilinx/dfx-mgr/blob/master/README.md for
> shell.json and accel.json file content.

* **Versal**:
  * Design: Vivado DFx design.
    * Input files to firmware recipes: .xsa (Versal dfx static),
      .dtsi (optional: to add static pl custom dt nodes), shell.json (optional)
      and .xclbin (optional).
    * Usage Examples:
```
# Versal DFx Static
SRC_URI = " \
    file://<dfx_design_static_pl>.xsa \
    file://<dfx_design_static_pl_custom>.dtsi \
    file://shell.json \
    file://<dfx_design_static_pl>.xclbin \
    "
```
---

## How to create a firmware recipe app

1. Follow [Building Instructions](https://github.com/Xilinx/meta-xilinx/blob/master/README.building.md) upto step 4.
2. Create recipes-firmware directory in meta layer and copy the .xsa, .dtsi,
   .json and .xclbin file to these directories.
```
$ mkdir -p <meta-layer>/recipes-fimrware/<recipes-firmware-app>/files
$ cp -r <path-to-files>/*.{xsa, dtsi, shell.json and .xclbin} <meta-layer>/recipes-fimrware/<firmware-app-name>/files
```
3. Now create the recipes for Versal DFx Static firmware app using recipetool.
```
$ recipetool create -o <meta-layer>/recipes-fimrware/<firmware-app-name>/firmware-app-name.bb file:///<meta-layer>/recipes-fimrware/<firmware-app-name>/files 
```
4. Modify the recipe and inherit dfx_dtg_versal_static bbclass as shown below.
```
SUMMARY = "Versal DFx Static firmware app using dfx_dtg_versal_static bbclass"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit dfx_dtg_versal_static

SRC_URI = "\
    file://vck190_pl_demo_static.xsa \
    file://shell.json \
    file://static-custom.dtsi \
    "

COMPATIBLE_MACHINE:versal = "versal"
```
5. Add firmware-recipe app to image and enable fpga-overlay machine features to
   local.conf as shown below.
> **Note:** fpga-manager-script provides fpgautil tool to load .pdi and dtbo
> at runtime linux.
```
MACHINE_FEATURES += "fpga-overlay"
IMAGE_INSTALL:append = " \
  firmware-app-name \
  fpga-manager-script \
  "
```
6. Follow [Building Instructions](https://github.com/Xilinx/meta-xilinx/blob/master/README.building.md) and continue from step 5.
7. Once images are built firmware app files will be installed on target_rootfs.
```
# <target_rootfs>/lib/firmware/xilinx/firmware-app-name
```
---

## Test Procedure on Target
* Once Linux boots on target, use fpgautil command to load .pdi and
  corresponding dt overlay as shown below.
> **Note:** firmware can be loaded only with sudo or root permissions.
---

### Loading DFx Static pdi and dt overlay

* Versal (DFx Static)
```
yocto-vck190-dfx-2023:~$ sudo su
root@yocto-vck190-dfx-2023:~#
root@yocto-vck190-dfx-2023:~# fpgautil -o /lib/firmware/xilinx/vck190-dfx-static/vck190-dfx-static.dtbo
[  257.555571] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga/external-fpga-config
[  257.565879] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga/pid
[  257.574670] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga/uid
[  257.583599] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/fpga_PR0
[  257.593434] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/fpga_PR1
[  257.603268] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/fpga_PR2
[  257.613100] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/static_region_axi_bram_ctrl_0
[  257.624762] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/static_region_dfx_decoupler_rp1
[  257.636589] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/static_region_dfx_decoupler_rp2
[  257.648415] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/static_region_dfx_decoupler_rp3
[  257.663234] of-fpga-region fpga:fpga-PR0: FPGA Region probed
[  257.669135] of-fpga-region fpga:fpga-PR1: FPGA Region probed
[  257.675022] of-fpga-region fpga:fpga-PR2: FPGA Region probed
root@yocto-vck190-dfx-2023:~#
```
---

### Unloading DFx Static pdi and dt overlay

* Versal (DFx Static)
```
root@yocto-vck190-dfx-2023:~# fpgautil -R -n Full
```
---

## References
* https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/1188397412/Solution+Versal+PL+Programming
