# Build Instructions to create Versal DFx Partial firmware recipes

- [Build Instructions to create Versal DFx Partial firmware recipes](#build-instructions-to-create-versal-dfx-partial-firmware-recipes)
  - [Introduction](#introduction)
  - [How to create a DFx RP firmware recipe app](#how-to-create-a-dfx-rp-firmware-recipe-app)
  - [Test Procedure on Target](#test-procedure-on-target)
    - [Loading DFx RP PL pdi and dt overlay](#loading-dfx-rp-pl-pdi-and-dt-overlay)
    - [Testing RP PL functionality](#testing-rp-pl-functionality)
    - [Unloading DFx RP PL pdi and dt overlay](#unloading-dfx-rp-pl-pdi-and-dt-overlay)
  - [References](#references)

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
$ mkdir -p <meta-layer>/recipes-firmware/<recipes-firmware-app>/files
$ cp -r <path-to-files>/*.{xsa, dtsi, accel.json and .xclbin} <meta-layer>/recipes-firmware/<firmware-app-name>/files
```
3. Now create the recipes for Versal or Versal-Net DFx RP firmware app using recipetool.
```
$ recipetool create -o <meta-layer>/recipes-firmware/<firmware-app-name>/firmware-app-name.bb file:///<meta-layer>/recipes-firmware/<firmware-app-name>/files
```
4. Modify the recipe and inherit dfx_dtg_versal_partial bbclass as shown below.
> **Note:** DFx RP recipes depends on DFx Static xsa, hence `STATIC_PN` should
> reference to DFx Static recipe name. Optionally user can set `RP_NAME` this is
> useful when you have multiple RP regions in DFx designs.

* Versal
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

COMPATIBLE_MACHINE:versal = ".*"

STATIC_PN = "vck190-dfx-static"
RP_NAME = "rp1"
```

* Versal-Net
```
SUMMARY = "Versal-Net DFX partial firmware app using dfx_dtg_versal_partial bbclass"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit dfx_dtg_versal_partial

SRC_URI = " \
    file://versal_net_dfx_rp0rm0.xsa \
    file://accel.json \
    file://pl-partial-custom.dtsi \
    "

COMPATIBLE_MACHINE:versal-net = ".*"

STATIC_PN = "versal-net-dfx-static"
RP_NAME = "rp0"
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
> 2. Prior to load DFx RP PL pdi, Make sure DFx static pdi and dt overlay is
>    loaded following [Loading DFx Static pdi and dt overlay](README.dfx.dtg.versal.static.md).
---

### Loading DFx RP PL pdi and dt overlay
* Versal DFx RP
```
yocto-vck190-versal:/$ sudo su
yocto-vck190-versal:/# tree /lib/firmware/xilinx
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
yocto-vck190-versal:/#
yocto-vck190-versal:/# cat /proc/interrupts
           CPU0       CPU1
 11:       9830      28094     GICv3  30 Level     arch_timer
 14:          0          0     GICv3  15 Edge      xlnx_event_mgmt
 15:          0          0     GICv3 176 Level     sysmon-irq
 17:          0          0     GICv3  23 Level     arm-pmu
 18:        561          0     GICv3  50 Level     uart-pl011
 20:          0          0     GICv3  92 Level     zynqmp-dma
 21:          0          0     GICv3  93 Level     zynqmp-dma
 22:          0          0     GICv3  94 Level     zynqmp-dma
 23:          0          0     GICv3  95 Level     zynqmp-dma
 24:          0          0     GICv3  96 Level     zynqmp-dma
 25:          0          0     GICv3  97 Level     zynqmp-dma
 26:          0          0     GICv3  98 Level     zynqmp-dma
 27:          0          0     GICv3  99 Level     zynqmp-dma
 28:          7          0     GICv3 157 Level     f1030000.spi
 30:        121          0     GICv3  88 Level     eth0, eth0
 31:          0          0     GICv3  90 Level     eth1, eth1
 32:          0          0     GICv3 106 Level     usb-wakeup
 33:          0          0     GICv3  54 Level     xhci-hcd:usb1
 34:          0          0     GICv3 174 Level     f12a0000.rtc
 35:          0          0     GICv3 175 Level     f12a0000.rtc
 36:          0          0     GICv3  47 Level     cdns-i2c
 37:          0          0     GICv3 155 Level     cdns-i2c
 38:        677          0     GICv3 160 Level     mmc0
IPI0:       109         88       Rescheduling interrupts
IPI1:      1817       1859       Function call interrupts
IPI2:         0          0       CPU stop interrupts
IPI3:         0          0       CPU stop (for crash dump) interrupts
IPI4:         0          0       Timer broadcast interrupts
IPI5:         0          0       IRQ work interrupts
IPI6:         0          0       CPU wake-up interrupts
Err:          0
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
yocto-vck190-versal:/# fpgautil -b /lib/firmware/xilinx/vck190-dfx-static/rp1/vck190-dfx-rp1rm1-dipsw/vck190-dfx-rp1rm1-dipsw.pdi -o /lib/firmware/xilinx/vck190-dfx-static/rp1/vck190-dfx-rp1rm1-dipsw/vck190-dfx-rp1rm1-dipsw.dtbo -f Partial -n PR0
[  154.155127] fpga_manager fpga0: writing vck190-dfx-rp1rm1-dipsw.pdi to Xilinx Versal FPGA Manager
[173465.709]Loading PDI from DDR
[173465.800]Monolithic/Master Device
[173469.235]3.520 ms: PDI initialization time
[173473.045]+++Loading Image#: 0x0, Name: pl_cfi, Id: 0x18700002
[173478.669]---Loading Partition#: 0x0, Id: 0x103
[173483.052] 0.032 ms for Partition#: 0x0, Size: 1264 Bytes
[173488.219]---Loading Partition#: 0x1, Id: 0x203
[173492.599] 0.030 ms for Partition#: 0x1, Size: 672 Bytes
[173497.682]---Loading Partition#: 0x2, Id: 0x303
[173503.193] 1.159 ms for Partition#: 0x2, Size: 204960 Bytes
[173507.400]---Loading Partition#: 0x3, Id: 0x403
[173511.805] 0.054 ms for Partition#: 0x3, Size: 8400 Bytes
[173516.979]Subsystem PDI Load: Done
[  154.220425] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/rp1_axi_gpio_0
[  154.239592] input: axi:pl-gpio-keys as /devices/platform/axi/axi:pl-gpio-keys/input/input1
Time taken to load BIN is 99.000000 Milli Seconds
BIN FILE loaded through FPGA manager successfully
yocto-vck190-versal:/#
```
---

### Testing RP PL functionality

* This examples uses RP PL GPIO DIP switches to capture interrupts.
* Verify RP PL GPIO DIP switches are registered.
* Move the DIP Switches ON/OFF and verify the interrupt counts.
```
yocto-vck190-versal:/# cat /proc/interrupts
           CPU0       CPU1
 11:      19260      30897     GICv3  30 Level     arch_timer
 14:          0          0     GICv3  15 Edge      xlnx_event_mgmt
 15:          0          0     GICv3 176 Level     sysmon-irq
 17:          0          0     GICv3  23 Level     arm-pmu
 18:        844          0     GICv3  50 Level     uart-pl011
 20:          0          0     GICv3  92 Level     zynqmp-dma
 21:          0          0     GICv3  93 Level     zynqmp-dma
 22:          0          0     GICv3  94 Level     zynqmp-dma
 23:          0          0     GICv3  95 Level     zynqmp-dma
 24:          0          0     GICv3  96 Level     zynqmp-dma
 25:          0          0     GICv3  97 Level     zynqmp-dma
 26:          0          0     GICv3  98 Level     zynqmp-dma
 27:          0          0     GICv3  99 Level     zynqmp-dma
 28:          7          0     GICv3 157 Level     f1030000.spi
 30:        408          0     GICv3  88 Level     eth0, eth0
 31:          0          0     GICv3  90 Level     eth1, eth1
 32:          0          0     GICv3 106 Level     usb-wakeup
 33:          0          0     GICv3  54 Level     xhci-hcd:usb1
 34:          0          0     GICv3 174 Level     f12a0000.rtc
 35:          0          0     GICv3 175 Level     f12a0000.rtc
 36:          0          0     GICv3  47 Level     cdns-i2c
 37:          0          0     GICv3 155 Level     cdns-i2c
 38:        677          0     GICv3 160 Level     mmc0
 40:          0          0  gpio-xilinx   3 Edge      PL_GPIO_DIP_SW3
 41:          0          0  gpio-xilinx   2 Edge      PL_GPIO_DIP_SW2
 42:          0          0  gpio-xilinx   1 Edge      PL_GPIO_DIP_SW1
 43:          0          0  gpio-xilinx   0 Edge      PL_GPIO_DIP_SW0
IPI0:       142        114       Rescheduling interrupts
IPI1:      1933       2059       Function call interrupts
IPI2:         0          0       CPU stop interrupts
IPI3:         0          0       CPU stop (for crash dump) interrupts
IPI4:         0          0       Timer broadcast interrupts
IPI5:         0          0       IRQ work interrupts
IPI6:         0          0       CPU wake-up interrupts
Err:          0
yocto-vck190-versal:/#
yocto-vck190-versal:/# cat /proc/interrupts
           CPU0       CPU1
 11:      20582      31435     GICv3  30 Level     arch_timer
 14:          0          0     GICv3  15 Edge      xlnx_event_mgmt
 15:          0          0     GICv3 176 Level     sysmon-irq
 17:          0          0     GICv3  23 Level     arm-pmu
 18:        985          0     GICv3  50 Level     uart-pl011
 20:          0          0     GICv3  92 Level     zynqmp-dma
 21:          0          0     GICv3  93 Level     zynqmp-dma
 22:          0          0     GICv3  94 Level     zynqmp-dma
 23:          0          0     GICv3  95 Level     zynqmp-dma
 24:          0          0     GICv3  96 Level     zynqmp-dma
 25:          0          0     GICv3  97 Level     zynqmp-dma
 26:          0          0     GICv3  98 Level     zynqmp-dma
 27:          0          0     GICv3  99 Level     zynqmp-dma
 28:          7          0     GICv3 157 Level     f1030000.spi
 30:        441          0     GICv3  88 Level     eth0, eth0
 31:          0          0     GICv3  90 Level     eth1, eth1
 32:          0          0     GICv3 106 Level     usb-wakeup
 33:          0          0     GICv3  54 Level     xhci-hcd:usb1
 34:          0          0     GICv3 174 Level     f12a0000.rtc
 35:          0          0     GICv3 175 Level     f12a0000.rtc
 36:          0          0     GICv3  47 Level     cdns-i2c
 37:          0          0     GICv3 155 Level     cdns-i2c
 38:        677          0     GICv3 160 Level     mmc0
 40:         12          0  gpio-xilinx   3 Edge      PL_GPIO_DIP_SW3
 41:          2          0  gpio-xilinx   2 Edge      PL_GPIO_DIP_SW2
 42:          6          0  gpio-xilinx   1 Edge      PL_GPIO_DIP_SW1
 43:          2          0  gpio-xilinx   0 Edge      PL_GPIO_DIP_SW0
IPI0:       142        115       Rescheduling interrupts
IPI1:      1940       2153       Function call interrupts
IPI2:         0          0       CPU stop interrupts
IPI3:         0          0       CPU stop (for crash dump) interrupts
IPI4:         0          0       Timer broadcast interrupts
IPI5:         0          0       IRQ work interrupts
IPI6:         0          0       CPU wake-up interrupts
Err:          0
yocto-vck190-versal:/#
#
```
---

### Unloading DFx RP PL pdi and dt overlay
* Versal DFx RP
```
yocto-vck190-versal:/# fpgautil -R -n PR0
yocto-vck190-versal:/# cat /proc/interrupts
           CPU0       CPU1
 11:      25280      33439     GICv3  30 Level     arch_timer
 14:          0          0     GICv3  15 Edge      xlnx_event_mgmt
 15:          0          0     GICv3 176 Level     sysmon-irq
 17:          0          0     GICv3  23 Level     arm-pmu
 18:       1166          0     GICv3  50 Level     uart-pl011
 20:          0          0     GICv3  92 Level     zynqmp-dma
 21:          0          0     GICv3  93 Level     zynqmp-dma
 22:          0          0     GICv3  94 Level     zynqmp-dma
 23:          0          0     GICv3  95 Level     zynqmp-dma
 24:          0          0     GICv3  96 Level     zynqmp-dma
 25:          0          0     GICv3  97 Level     zynqmp-dma
 26:          0          0     GICv3  98 Level     zynqmp-dma
 27:          0          0     GICv3  99 Level     zynqmp-dma
 28:          7          0     GICv3 157 Level     f1030000.spi
 30:        610          0     GICv3  88 Level     eth0, eth0
 31:          0          0     GICv3  90 Level     eth1, eth1
 32:          0          0     GICv3 106 Level     usb-wakeup
 33:          0          0     GICv3  54 Level     xhci-hcd:usb1
 34:          0          0     GICv3 174 Level     f12a0000.rtc
 35:          0          0     GICv3 175 Level     f12a0000.rtc
 36:          0          0     GICv3  47 Level     cdns-i2c
 37:          0          0     GICv3 155 Level     cdns-i2c
 38:        677          0     GICv3 160 Level     mmc0
IPI0:       145        117       Rescheduling interrupts
IPI1:      1977       2202       Function call interrupts
IPI2:         0          0       CPU stop interrupts
IPI3:         0          0       CPU stop (for crash dump) interrupts
IPI4:         0          0       Timer broadcast interrupts
IPI5:         0          0       IRQ work interrupts
IPI6:         0          0       CPU wake-up interrupts
Err:          0
yocto-vck190-versal:/#

```
---

## References
* https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/1188397412/Solution+Versal+PL+Programming
