# Build Instructions to create ZynqMP DFx Static firmware recipes

* [Introduction](#introduction)
* [How to create a firmware recipe app](#how-to-create-a-firmware-recipe-app)
* [Test Procedure on Target](#test-procedure-on-target)
  * [Loading DFx Static bitstream and dt overlay](#loading-dfx-static-bitstream-and-dt-overlay)
  * [Unloading DFx Static bitstream and dt overlay](#unloading-dfx-static-bitstream-and-dt-overlay)
* [References](#references)

## Introduction
This readme describes the build instructions to create firmware recipes using
dfx_dtg_zynqmp_static.bbclass for ZynqMP DFx Static configuration. This bitbake
class supports following use cases. This bitbake class support only vivado dfx
design.

> **Note:** Refer https://github.com/Xilinx/dfx-mgr/blob/master/README.md for
> shell.json and accel.json file content.

* **ZynqMP**:
  * Design: Vivado DFx design.
    * Input files to firmware recipes: .xsa (ZynqMP dfx static),
      .dtsi (optional: to add static pl custom dt nodes), shell.json (optional)
      and .xclbin (optional).
    * Usage Examples:
```
# ZynqMP DFx Static
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
3. Now create the recipes for ZynqMP DFx Static firmware app using recipetool.
```
$ recipetool create -o <meta-layer>/recipes-firmware/<firmware-app-name>/firmware-app-name.bb file:///<meta-layer>/recipes-firmware/<firmware-app-name>/files
```
4. Modify the recipe and inherit dfx_dtg_zynqmp_static bbclass as shown below.
```
SUMMARY = "ZynqMP DFx Static firmware app using dfx_dtg_zynqmp_static bbclass"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit dfx_dtg_zynqmp_static

SRC_URI = "\
    file://zcu102_dfx_static.xsa \
    file://shell.json \
    file://static-custom.dtsi \
    "

COMPATIBLE_MACHINE:zynqmp = "zynqmp"
```
5. Add firmware-recipe app to image and enable fpga-overlay machine features to
   local.conf as shown below.
> **Note:** fpga-manager-script provides fpgautil tool to load .bin and dtbo
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
* Once Linux boots on target, use fpgautil command to load .bin and
  corresponding dt overlay as shown below.
> **Note:** firmware can be loaded only with sudo or root permissions.
---

### Loading DFx Static bitstream and dt overlay

* ZynqMP (DFx Static)
```
TODO - Logs needs to be added.
```

---

### Unloading PL bitstream or pdi and dt overlay
* ZynqMP (DFx Static)
```
root@yocto-zcu102-dfx-2023:~# fpgautil -R
```

---

## References
* https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18841847/Solution+ZynqMP+PL+Programming
