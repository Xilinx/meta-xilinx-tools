# Build Instructions to create ZynqMP DFx Partial firmware recipes

* [Introduction](#introduction)
* [How to create a DFx RP firmware recipe app](#how-to-create-a-dfx-rp-firmware-recipe-app)
* [Test Procedure on Target](#test-procedure-on-target)
  * [Loading DFx RP PL bitstream and dt overlay](#loading-dfx-rp-pl-bitstream-and-dt-overlay)
  * [Testing RP PL functionality](#testing-rp-pl-functionality)
  * [Unloading DFx RP PL bitstream and dt overlay](#unloading-dfx-rp-pl-bitstream-and-dt-overlay)
* [References](#references)

## Introduction
This readme describes the build instructions to create firmware recipes using
dfx_dtg_zynqmp_partial.bbclass for ZynqMP DFx Reconfigurable Partition(RP)
configuration. This bitbake class support only vivado dfx design.

> **Note:** Refer https://github.com/Xilinx/dfx-mgr/blob/master/README.md for
> shell.json and accel.json file content.

* **ZynqMP**:
  * Design: Vivado DFx design.
    * Input files to firmware recipes: .xsa, .dtsi(optional: to add pl-partial-custom
      dt nodes), accel.json (optional) and .xclbin (optional).
    * Usage Examples:
```
# ZynqMP DFx RP
SRC_URI = " \
    file://<dfx_design_rp_pl>.xsa \
    file://<dfx_design_rp_pl_custom>.dtsi \
    file://accel.json \
    file://<dfx_design_rp_pl>.xclbin \
    "
```
---

## How to create a DFx RP firmware recipe app

1. Follow [ZynqMP DFx Static firmware recipe instructions](README.dfx.dtg.zynqmp.static.md)
   upto step 5 to create ZynqMP DFx static firmware recipe.
2. Create RP recipes-firmware directory in meta layer and copy the .xsa, .dtsi,
   .json and .xclbin file to these directories.
```
$ mkdir -p <meta-layer>/recipes-firmware/<recipes-firmware-app>/files
$ cp -r <path-to-files>/*.{xsa, dtsi, accel.json and .xclbin} <meta-layer>/recipes-firmware/<firmware-app-name>/files
```
3. Now create the recipes for Versal DFx RP firmware app using recipetool.
```
$ recipetool create -o <meta-layer>/recipes-firmware/<firmware-app-name>/firmware-app-name.bb file:///<meta-layer>/recipes-firmware/<firmware-app-name>/files
```
4. Modify the recipe and inherit dfx_dtg_zynqmp_partial bbclass as shown below.
> **Note:** DFx RP recipes depends on DFx Static xsa, hence `STATIC_PN` should
> reference to DFx Static recipe name. Optionally user can set `RP_NAME` this is
> useful when you have multiple RP regions in DFx designs.

```
SUMMARY = "ZynqMP DFX partial firmware app using dfx_dtg_zynqmp_partial bbclass"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit dfx_dtg_zynqmp_partial

SRC_URI = " \
    file://zcu102_dfx_rp0_pb.xsa \
    file://accel.json \
    file://pl-partial-custom.dtsi \
    "

COMPATIBLE_MACHINE ?= "^$"
COMPATIBLE_MACHINE:zynqmp = "zynqmp"

STATIC_PN = "zcu102-dfx-static"
RP_NAME = "rp0"
```
5. Add RP firmware-recipe app to image to local.conf as shown below.
```
IMAGE_INSTALL:append = " \
  firmware-app-name \
  "
```
6. Follow [ZynqMP DFx static firmware recipe instructions](README.dfx.dtg.zynqmp.static.md) and continue from step 5.
7. Once images are built firmware app files will be installed on target_rootfs.
```
# <target_rootfs>/lib/firmware/xilinx/<static-recipe>/firmware-app-name
```
---

## Test Procedure on Target
* Once Linux boots on target, use fpgautil command to load RP .bin and corresponding
  dt overlay as shown below.
> **Note:**
> 1. firmware can be loaded only with sudo or root permissions.
> 2. Prior to load DFx RP PL bitstream, Make sure DFx static firmware is
>    loaded following [Loading DFx Static bitstream and dt overlay](README.dfx.dtg.zynqmp.static.md).
---

### Loading DFx RP PL bitstream and dt overlay
* ZynqMP
```
TODO - Logs needs to be added.
```
---

### Testing RP PL functionality

* This examples uses RP PL GPIO DIP switches to capture interrupts.
* Verify RP PL GPIO DIP switches are registered.
* Move the DIP Switches ON/OFF and verify the interrupt counts.
```
TODO - Logs needs to be added.
```
---

### Unloading DFx RP PL bitstream or pdi and dt overlay
* ZynqMP DFx RP
```
TODO - Logs needs to be added.
```
---

## References
* https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18841847/Solution+ZynqMP+PL+Programming
