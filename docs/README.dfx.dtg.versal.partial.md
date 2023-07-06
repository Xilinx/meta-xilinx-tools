# Build Instructions to create Versal DFx Partial firmware recipes

* [Introduction](#introduction)
* [How to create a DFx RP firmware recipe app](#how-to-create-a-dfx-rp-firmware-recipe-app)
* [Test Procedure on Target](#test-procedure-on-target)
  * [Loading DFx RP PL pdi and dt overlay](#loading-dfx-rp-pl-pdi-and-dt-overlay)
  * [Testing RP PL functionality](#testing-rp-pl-functionality)
  * [Unloading DFx RP PL pdi and dt overlay](#unloading-dfx-rp-pl-pdi-and-dt-overlay)
* [References](#references)

## Introduction
This readme describes the build instructions to create firmware recipes using
dfx_dtg_versal_partial.bbclass for Versal DFx Reconfigurable Partition(RP)
configuration. This bitbake class support only vivado dfx design.

> **Note:** Refer https://github.com/Xilinx/dfx-mgr/blob/master/README.md for
> shell.json and accel.json file content.

* **Versal**:
  * Design: Vivado DFx design.
    * Input files to firmware recipes: .xsa, .dtsi(optional: to add pl-partial-custom
      dt nodes), accel.json (optional) and .xclbin (optional).
    * Usage Examples:
```
# Versal DFx RP
SRC_URI = " \
    file://<dfx_design_rp_pl>.xsa \
    file://<dfx_design_rp_pl_custom>.dtsi \
    file://accel.json \
    file://<dfx_design_rp_pl>.xclbin \
    "
```
---

## How to create a DFx RP firmware recipe app

1. Follow [Versal DFx Static firmware recipe instructions](README.dfx.dtg.versal.static.md)
   upto step 5 to create Versal DFx static firmware recipe.
2. Create RP recipes-firmware directory in meta layer and copy the .xsa, .dtsi,
   .json and .xclbin file to these directories.
```
$ mkdir -p <meta-layer>/recipes-fimrware/<recipes-firmware-app>/files
$ cp -r <path-to-files>/*.{xsa, dtsi, accel.json and .xclbin} <meta-layer>/recipes-fimrware/<firmware-app-name>/files
```
3. Now create the recipes for Versal DFx RP firmware app using recipetool.
```
$ recipetool create -o <meta-layer>/recipes-fimrware/<firmware-app-name>/firmware-app-name.bb file:///<meta-layer>/recipes-fimrware/<firmware-app-name>/files 
```
4. Modify the recipe and inherit dfx_dtg_versal_partial bbclass as shown below.
> **Note:** DFx RP recipes depends on DFx Static xsa, hence `STATIC_PN` should
> reference to DFx Static recipe name. Optionally user can set `RP_NAME` this is
> useful when you have multiple RP regions in DFx designs.

```
SUMMARY = "Versal DFX partial firmware app using dfx_dtg_versal_partial bbclass"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit dfx_dtg_versal_partial

SRC_URI = " \
    file://vck190_pl_demo_rp1rm1_dipsw.xsa \
    file://accel.json \
    file://pl-partial-custom.dtsi \
    "

COMPATIBLE_MACHINE ?= "^$"
COMPATIBLE_MACHINE:versal = "versal"

STATIC_PN = "vck190-dfx-static"
RP_NAME = "rp1"
```
5. Add RP firmware-recipe app to image to local.conf as shown below.
```
IMAGE_INSTALL:append = " \
  firmware-app-name \
  "
```
6. Follow [Versal DFx static firmware recipe instructions](README.dfx.dtg.versal.static.md) and continue from step 5.
7. Once images are built firmware app files will be installed on target_rootfs.
```
# <target_rootfs>/lib/firmware/xilinx/<static-recipe>/firmware-app-name
```
---

## Test Procedure on Target
* Once Linux boots on target, use fpgautil command to load RP .pdi and
  corresponding dt overlay as shown below.
> **Note:**
> 1. firmware can be loaded only with sudo or root permissions.
> 2. Prior to load DFx RP PL pdi, Make sure DFx static firmware is
>    loaded following [Loading DFx Static pdi and dt overlay](README.dfx.dtg.versal.static.md).
---

### Loading DFx RP PL pdi and dt overlay
* Versal DFx RP
```
yocto-vck190-dfx-2023:~$ sudo su
root@yocto-vck190-dfx-2023:~# tree /lib/firmware/xilinx
/lib/firmware/xilinx
`-- vck190-dfx-static
    |-- rp1
    |   `-- vck190-dfx-rp1rm1-dipsw
    |       |-- accel.json
    |       |-- vck190-dfx-rp1rm1-dipsw.dtbo
    |       `-- vck190-dfx-rp1rm1-dipsw.pdi
    |-- rp2
    |   `-- vck190-dfx-rp2rm1-pb
    |       |-- accel.json
    |       |-- vck190-dfx-rp2rm1-pb.dtbo
    |       `-- vck190-dfx-rp2rm1-pb.pdi
    |-- rp3
    |   `-- vck190-dfx-rp3rm1-led
    |       |-- accel.json
    |       |-- vck190-dfx-rp3rm1-led.dtbo
    |       `-- vck190-dfx-rp3rm1-led.pdi
    |-- shell.json
    |-- vck190-dfx-static.dtbo
    `-- vck190-dfx-static.pdi

7 directories, 12 files
root@yocto-vck190-dfx-2023:~#
root@yocto-vck190-dfx-2023:~# cat /proc/interrupts
           CPU0       CPU1
 11:      17699      37013     GICv3  30 Level     arch_timer
 14:          0          0     GICv3  62 Level     zynqmp_ipi
 15:          0          0     GICv3  23 Level     arm-pmu
 16:          0          0     GICv3  15 Edge      xlnx_event_mgmt
 17:          0          0     GICv3 176 Level     sysmon-irq
 19:        486          0     GICv3  50 Level     uart-pl011
 21:          0          0     GICv3  92 Level     zynqmp-dma
 22:          0          0     GICv3  93 Level     zynqmp-dma
 23:          0          0     GICv3  94 Level     zynqmp-dma
 24:          0          0     GICv3  95 Level     zynqmp-dma
 25:          0          0     GICv3  96 Level     zynqmp-dma
 26:          0          0     GICv3  97 Level     zynqmp-dma
 27:          0          0     GICv3  98 Level     zynqmp-dma
 28:          0          0     GICv3  99 Level     zynqmp-dma
 29:          3          0     GICv3 157 Level     f1030000.spi
 31:          0          0     GICv3  88 Level     eth0, eth0
 32:          0          0     GICv3  90 Level     eth1, eth1
 33:          0          0     GICv3  54 Level     xhci-hcd:usb1
 34:          0          0     GICv3 174 Level     f12a0000.rtc
 35:          0          0     GICv3 175 Level     f12a0000.rtc
 36:          0          0     GICv3  47 Level     cdns-i2c
 37:          0          0     GICv3 155 Level     cdns-i2c
 38:       1089          0     GICv3 160 Level     mmc0
IPI0:        76         73       Rescheduling interrupts
IPI1:      1372       1955       Function call interrupts
IPI2:         0          0       CPU stop interrupts
IPI3:         0          0       CPU stop (for crash dump) interrupts
IPI4:         0          0       Timer broadcast interrupts
IPI5:         0          0       IRQ work interrupts
IPI6:         0          0       CPU wake-up interrupts
Err:          0
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
root@yocto-vck190-dfx-2023:~# fpgautil -b /lib/firmware/xilinx/vck190-dfx-static/rp1/vck190-dfx-rp1rm1-dipsw/vck190-dfx-rp1rm1-dipsw.pdi -o /lib/firmware/xilinx/vck190-dfx-static/rp1/vck190-dfx-rp1rm1-dipsw/vck190-dfx-rp1rm1-dipsw.dtbo -f Partial -n PR0
[  273.511455] fpga_manager fpga0: writing vck190-dfx-rp1rm1-dipsw.pdi to Xilinx Versal FPGA Manager
[284052.461]Loading PDI from DDR
[284052.566]Monolithic/Master Device
[284055.847]3.365 ms: PDI initialization time
[284059.809]+++Loading Image#: 0x0, Name: pl_cfi, Id: 0x18700002
[284065.432]---Loading Partition#: 0x0, Id: 0x103
[284069.829] 0.033 ms for Partition#: 0x0, Size: 1312 Bytes
[284074.973]---Loading Partition#: 0x1, Id: 0x105
[284079.344] 0.007 ms for Partition#: 0x1, Size: 160 Bytes
[284084.430]---Loading Partition#: 0x2, Id: 0x205
[284088.844] 0.049 ms for Partition#: 0x2, Size: 960 Bytes
[284093.887]---Loading Partition#: 0x3, Id: 0x203
[284098.280] 0.030 ms for Partition#: 0x3, Size: 688 Bytes
[284103.342]---Loading Partition#: 0x4, Id: 0x303
[284108.863] 1.156 ms for Partition#: 0x4, Size: 209440 Bytes
[284113.052]---Loading Partition#: 0x5, Id: 0x305
[284117.712] 0.296 ms for Partition#: 0x5, Size: 3536 Bytes
[284122.594]---Loading Partition#: 0x6, Id: 0x403
[284126.991] 0.034 ms for Partition#: 0x6, Size: 8096 Bytes
[284132.136]---Loading Partition#: 0x7, Id: 0x405
[284136.507] 0.007 ms for Partition#: 0x7, Size: 160 Bytes
[284141.636]Subsystem PDI Load: Done
[  273.615503] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga/firmware-name
[  273.627382] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga/fpga-bridges
[  273.636953] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga/partial-fpga-config
[  273.647241] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/rp1_axi_gpio_0
[  273.660826] gpio gpiochip1: (a4010000.gpio): not an immutable chip, please consider fixing it!
[  273.670490] input: pl-gpio-keys as /devices/platform/pl-gpio-keys/input/input0
Time taken to load BIN is 171.000000 Milli Seconds
BIN FILE loaded through FPGA manager successfully
root@yocto-vck190-dfx-2023:~#
```
---

### Testing RP PL functionality

* This examples uses RP PL GPIO DIP switches to capture interrupts.
* Verify RP PL GPIO DIP switches are registered.
* Move the DIP Switches ON/OFF and verify the interrupt counts.
```
root@yocto-vck190-dfx-2023:~# cat /proc/interrupts
           CPU0       CPU1
 11:      21074      64756     GICv3  30 Level     arch_timer
 14:          0          0     GICv3  62 Level     zynqmp_ipi
 15:          0          0     GICv3  23 Level     arm-pmu
 16:          0          0     GICv3  15 Edge      xlnx_event_mgmt
 17:          0          0     GICv3 176 Level     sysmon-irq
 19:        791          0     GICv3  50 Level     uart-pl011
 21:          0          0     GICv3  92 Level     zynqmp-dma
 22:          0          0     GICv3  93 Level     zynqmp-dma
 23:          0          0     GICv3  94 Level     zynqmp-dma
 24:          0          0     GICv3  95 Level     zynqmp-dma
 25:          0          0     GICv3  96 Level     zynqmp-dma
 26:          0          0     GICv3  97 Level     zynqmp-dma
 27:          0          0     GICv3  98 Level     zynqmp-dma
 28:          0          0     GICv3  99 Level     zynqmp-dma
 29:          3          0     GICv3 157 Level     f1030000.spi
 31:          0          0     GICv3  88 Level     eth0, eth0
 32:          0          0     GICv3  90 Level     eth1, eth1
 33:          0          0     GICv3  54 Level     xhci-hcd:usb1
 34:          0          0     GICv3 174 Level     f12a0000.rtc
 35:          0          0     GICv3 175 Level     f12a0000.rtc
 36:          0          0     GICv3  47 Level     cdns-i2c
 37:          0          0     GICv3 155 Level     cdns-i2c
 38:       1089          0     GICv3 160 Level     mmc0
 40:          7          0  gpio-xilinx   3 Edge      PL_GPIO_DIP_SW3
 41:          1          0  gpio-xilinx   2 Edge      PL_GPIO_DIP_SW2
 42:          1          0  gpio-xilinx   1 Edge      PL_GPIO_DIP_SW1
 43:          1          0  gpio-xilinx   0 Edge      PL_GPIO_DIP_SW0
IPI0:        89         90       Rescheduling interrupts
IPI1:      1520       2664       Function call interrupts
IPI2:         0          0       CPU stop interrupts
IPI3:         0          0       CPU stop (for crash dump) interrupts
IPI4:         0          0       Timer broadcast interrupts
IPI5:         0          0       IRQ work interrupts
IPI6:         0          0       CPU wake-up interrupts
Err:          0
root@yocto-vck190-dfx-2023:~#
```
---

### Unloading DFx RP PL pdi and dt overlay
* Versal DFx RP
```
root@yocto-vck190-dfx-2023:~# fpgautil -R -n PR0
root@yocto-vck190-dfx-2023:~# cat /proc/interrupts
           CPU0       CPU1
 11:      23001      83170     GICv3  30 Level     arch_timer
 14:          0          0     GICv3  62 Level     zynqmp_ipi
 15:          0          0     GICv3  23 Level     arm-pmu
 16:          0          0     GICv3  15 Edge      xlnx_event_mgmt
 17:          0          0     GICv3 176 Level     sysmon-irq
 19:        967          0     GICv3  50 Level     uart-pl011
 21:          0          0     GICv3  92 Level     zynqmp-dma
 22:          0          0     GICv3  93 Level     zynqmp-dma
 23:          0          0     GICv3  94 Level     zynqmp-dma
 24:          0          0     GICv3  95 Level     zynqmp-dma
 25:          0          0     GICv3  96 Level     zynqmp-dma
 26:          0          0     GICv3  97 Level     zynqmp-dma
 27:          0          0     GICv3  98 Level     zynqmp-dma
 28:          0          0     GICv3  99 Level     zynqmp-dma
 29:          3          0     GICv3 157 Level     f1030000.spi
 31:          0          0     GICv3  88 Level     eth0, eth0
 32:          0          0     GICv3  90 Level     eth1, eth1
 33:          0          0     GICv3  54 Level     xhci-hcd:usb1
 34:          0          0     GICv3 174 Level     f12a0000.rtc
 35:          0          0     GICv3 175 Level     f12a0000.rtc
 36:          0          0     GICv3  47 Level     cdns-i2c
 37:          0          0     GICv3 155 Level     cdns-i2c
 38:       1089          0     GICv3 160 Level     mmc0
IPI0:        93         93       Rescheduling interrupts
IPI1:      1585       3067       Function call interrupts
IPI2:         0          0       CPU stop interrupts
IPI3:         0          0       CPU stop (for crash dump) interrupts
IPI4:         0          0       Timer broadcast interrupts
IPI5:         0          0       IRQ work interrupts
IPI6:         0          0       CPU wake-up interrupts
Err:          0
root@yocto-vck190-dfx-2023:~#
```
---

## References
* https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/1188397412/Solution+Versal+PL+Programming
