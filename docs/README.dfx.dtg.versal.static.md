# Build Instructions to create Versal DFx Static firmware recipes

- [Build Instructions to create Versal DFx Static firmware recipes](#build-instructions-to-create-versal-dfx-static-firmware-recipes)
  - [Introduction](#introduction)
  - [How to create a firmware recipe app](#how-to-create-a-firmware-recipe-app)
  - [Test Procedure on Target](#test-procedure-on-target)
    - [Loading DFx Static pdi and dt overlay](#loading-dfx-static-pdi-and-dt-overlay)
    - [Unloading DFx Static pdi and dt overlay](#unloading-dfx-static-pdi-and-dt-overlay)
  - [References](#references)

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
$ mkdir -p <meta-layer>/recipes-firmware/<recipes-firmware-app>/files
$ cp -r <path-to-files>/*.{xsa, dtsi, shell.json and .xclbin} <meta-layer>/recipes-firmware/<firmware-app-name>/files
```
3. Now create the recipes for Versal or Versal-Net DFx Static firmware app using recipetool.
```
$ recipetool create -o <meta-layer>/recipes-firmware/<firmware-app-name>/firmware-app-name.bb file:///<meta-layer>/recipes-firmware/<firmware-app-name>/files
```
4. Modify the recipe and inherit dfx_dtg_versal_static bbclass as shown below.

* Versal
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

COMPATIBLE_MACHINE:versal = ".*"
```

* Versal-Net
```
SUMMARY = "Versal-Net DFx Static firmware app using dfx_dtg_versal_static bbclass"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit dfx_dtg_versal_static

SRC_URI = "\
    file://versal_net_dfx_static.xsa \
    file://shell.json \
    file://static-custom.dtsi \
    "

COMPATIBLE_MACHINE:versal-net = ".*"
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
yocto-vck190-versal:/$ sudo su
yocto-vck190-versal:/# fpgautil -b /lib/firmware/xilinx/vck190-dfx-static/vck190-dfx-static.pdi -o /lib/firmware/xilinx/vck190-dfx-static/vck190-dfx-static.dtbo
[  110.575263] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga/external-fpga-config
[  110.585557] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga/pid
[  110.594365] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga/uid
[  110.603307] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/fpga_PR0
[  110.613152] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/fpga_PR1
[  110.623007] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/fpga_PR2
[  110.632849] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/static_region_axi_bram_ctrl_0
[  110.644516] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/static_region_dfx_decoupler_rp1
[  110.656351] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/static_region_dfx_decoupler_rp2
[  110.668188] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/static_region_dfx_decoupler_rp3
[  110.682762] of-fpga-region fpga:fpga-PR0: FPGA Region probed
[  110.689956] of-fpga-region fpga:fpga-PR1: FPGA Region probed
[  110.695890] of-fpga-region fpga:fpga-PR2: FPGA Region probed
Time taken to load BIN is 133.000000 Milli Seconds
BIN FILE loaded through FPGA manager successfully
yocto-vck190-versal:/#
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
