# Build Instructions to create Versal Segmented Configuration firmware recipes

- [Build Instructions to create Versal Segmented Configuration firmware recipes](#build-instructions-to-create-versal-segmented-configuration-firmware-recipes)
  - [Introduction](#introduction)
  - [How to create a firmware recipe app](#how-to-create-a-firmware-recipe-app)
  - [Test Procedure on Target](#test-procedure-on-target)
    - [Loading PL pdi and dt overlay](#loading-pl-pdi-and-dt-overlay)
    - [Testing PL functionality](#testing-pl-functionality)
    - [Unloading PL pdi and dt overlay](#unloading-pl-pdi-and-dt-overlay)
  - [References](#references)

## Introduction
This readme describes the build instructions to create firmware recipes using
dfx_dtg_versal_full.bbclass for Versal Segmented Configuration(full pdi loading)
vivado design.

> **Note:** Refer https://github.com/Xilinx/dfx-mgr/blob/master/README.md for
> shell.json and accel.json file content.

* **Versal**:
  * Design: Vivado Segmented Configuration design.
    * Input files to firmware recipes: .xsa, .dtsi (optional: to add pl custom dt
      nodes), shell.json (optional) and .xclbin (optional).
    * Usage Examples:
```
SRC_URI = " \
    file://<segmented_config_design>.xsa \
    file://<segmented_config_pl_custom>.dtsi \
    file://shell.json \
    file://<segmented_config_design_pl>.xclbin \
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
3. Now create the recipes for Versal or Versal-Net Segmented Configuration(full pdi loading) firmware app using recipetool.
```
$ recipetool create -o <meta-layer>/recipes-firmware/<firmware-app-name>/firmware-app-name.bb file:///<meta-layer>/recipes-firmware/<firmware-app-name>/files
```
4. Modify the recipe and inherit dfx_dtg_versal_full bbclass as shown below.

* Versal
```
SUMMARY = "Versal Segmented Configuration(full pdi loading) firmware app using dfx_dtg_versal_full bbclass"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit dfx_dtg_versal_full

SRC_URI = "\
    file://vck190_dfx_full.xsa \
    file://shell.json \
    file://vck190-dfx-full.dtsi \
    "

COMPATIBLE_MACHINE:versal = ".*"
```

* Versal-Net
```
SUMMARY = "Versal-Net Segmented Configuration(full pdi loading) firmware app using dfx_dtg_versal_full bbclass"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit dfx_dtg_versal_full

SRC_URI = "\
    file://versal_net_dfx_full.xsa \
    file://shell.json \
    file://versal-net-dfx-full.dtsi \
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

### Loading PL pdi and dt overlay

* Versal or Versal-Net
```
yocto-vck190-versal-dfx-full-2023:~$ sudo su
yocto-vck190-versal-dfx-full-2023:/home/petalinux# tree /lib/firmware/xilinx/
/lib/firmware/xilinx/
`-- vck190-dfx-full
    |-- shell.json
    |-- vck190-dfx-full.dtbo
    `-- vck190-dfx-full.pdi

1 directory, 3 files
yocto-vck190-versal-dfx-full-2023:/home/petalinux#
yocto-vck190-versal-dfx-full-2023:/home/petalinux# cat /proc/interrupts
           CPU0       CPU1
 11:      19576       8781     GICv3  30 Level     arch_timer
 14:          0          0     GICv3  23 Level     arm-pmu
 15:          0          0     GICv3  15 Edge      xlnx_event_mgmt
 16:          0          0     GICv3 176 Level     sysmon-irq
 18:        594          0     GICv3  50 Level     uart-pl011
 20:          0          0     GICv3  92 Level     zynqmp-dma
 21:          0          0     GICv3  93 Level     zynqmp-dma
 22:          0          0     GICv3  94 Level     zynqmp-dma
 23:          0          0     GICv3  95 Level     zynqmp-dma
 24:          0          0     GICv3  96 Level     zynqmp-dma
 25:          0          0     GICv3  97 Level     zynqmp-dma
 26:          0          0     GICv3  98 Level     zynqmp-dma
 27:          0          0     GICv3  99 Level     zynqmp-dma
 28:          3          0     GICv3 157 Level     f1030000.spi
 30:          0          0     GICv3  88 Level     eth0, eth0
 31:          0          0     GICv3  90 Level     eth1, eth1
 32:          0          0     GICv3  54 Level     xhci-hcd:usb1
 33:          0          0     GICv3 174 Level     f12a0000.rtc
 34:          0          0     GICv3 175 Level     f12a0000.rtc
 35:          0          0     GICv3  47 Level     cdns-i2c
 36:          0          0     GICv3 155 Level     cdns-i2c
 37:        548          0     GICv3 160 Level     mmc0
IPI0:        58        137       Rescheduling interrupts
IPI1:      1988       1545       Function call interrupts
IPI2:         0          0       CPU stop interrupts
IPI3:         0          0       CPU stop (for crash dump) interrupts
IPI4:         0          0       Timer broadcast interrupts
IPI5:         0          0       IRQ work interrupts
IPI6:         0          0       CPU wake-up interrupts
Err:          0
yocto-vck190-versal-dfx-full-2023:/home/petalinux#
yocto-vck190-versal-dfx-full-2023:/home/petalinux# fpgautil -b /lib/firmware/xilinx/vck190-dfx-full/vck190-dfx-full.pdi -o /lib/firmware/xilinx/vck190-dfx-full/vck190-dfx-full.dtbo
[  190.152104] fpga_manager fpga0: writing vck190-dfx-full.pdi to Xilinx Versal FPGA Manager
[198901.414]Loading PDI from DDR
[198901.505]Monolithic/Master Device
[198904.771]3.350 ms: PDI initialization time
[198908.752]+++Loading Image#: 0x0, Name: pl_cfi, Id: 0x18700001
[198914.379]---Loading Partition#: 0x0, Id: 0x103
[198932.815] 14.082 ms for Partition#: 0x0, Size: 22256 Bytes
[198935.380]---Loading Partition#: 0x1, Id: 0x105
[198939.990] 0.259 ms for Partition#: 0x1, Size: 4784 Bytes
[198944.930]---Loading Partition#: 0x2, Id: 0x205
[198952.838] 3.554 ms for Partition#: 0x2, Size: 64368 Bytes
[198955.318]---Loading Partition#: 0x3, Id: 0x203
[198959.698] 0.030 ms for Partition#: 0x3, Size: 672 Bytes
[198964.781]---Loading Partition#: 0x4, Id: 0x303
[198996.603] 27.468 ms for Partition#: 0x4, Size: 1121280 Bytes
[198999.337]---Loading Partition#: 0x5, Id: 0x305
[199004.745] 1.056 ms for Partition#: 0x5, Size: 69056 Bytes
[199008.968]---Loading Partition#: 0x6, Id: 0x403
[199013.482] 0.165 ms for Partition#: 0x6, Size: 242352 Bytes
[199018.684]---Loading Partition#: 0x7, Id: 0x405
ERR PldMemCtrlrMap: 0x490E
ERR PldInitNode: 0xFFFF
ERR XPm_InitNode: 0xFFFF
ERR XPm_ProcessCmd: Error 0x15 while processing command 0xC023E
ERR XPm_ProcessCmd: Err Code: 0x15
[199038.367]CMD: 0x000C023E execute failed, Processed Cdo Length 0x129C
[199044.587]CMD Payload START, Len:0x00000008
 0x00000000F20012C0: 0x18700001 0x0000000A 0xF6110000 0x00000002
 0x00000000F20012CC: 0x00000000 0x00000000 0x80000000 0x00000000
 0x00000000F20012DC:
[199061.967]CMD Payload END
[199064.440]Error loading PL data:
CFU_ISR: 0x00000000, CFU_STATUS: 0x00002A8C
PMC ERR1: 0x00000000, PMC ERR2: 0x00000000
[199075.275]PLM Error Status: 0x223E0015
[199078.842]XPlmi_IpiDispatchHand er: Error: rPI command failed for CommandoID: 0x1000701
[199086.596]PLM Error Status: 0x27010015
[  190.358755] fpga_region region0: failed to load FPGA image
[  190.364277] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga/firmware-name
[  190.373950] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga/pid
[  190.382744] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga/uid
[  190.392021] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/axi_bram_ctrl_0
[  190.402494] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/axi_gpio_dip_sw
[  190.412960] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/axi_gpio_led
[  190.423158] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/axi_gpio_pb
[  190.433268] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/axi_uartlite_0
[  190.464867] gpio gpiochip1: (a4010000.gpio): not an immutable chip, please consider fixing it!
[  190.496479] gpio gpiochip3: (a4030000.gpio): not an immutable chip, please consider fixing it!
[  190.507802] 20100000000.serial: ttyUL0 at MMIO 0x20100000000 (irq = 40, base_baud = 0) is a uartlite
[  190.519143] uartlite 20100000000.serial: Runtime PM usage count underflow!
[  190.527430] input: axi:pl-gpio-keys as /devices/platform/axi/axi:pl-gpio-keys/input/input0
BIN FILE loading through FPGA manager failed
yocto-vck190-versal-dfx-full-2023:/home/petalinux#
```

---

### Testing PL functionality

* This examples uses PL GPIO DIP switches and Push buttons to capture interrupts.
* Verify PL GPIO DIP switches and Push buttons are registered.
* Move the DIP Switches ON/OFF and verify the interrupt counts.

* Versal
```
yocto-vck190-versal-dfx-full-2023:/home/petalinux# cat /proc/interrupts
           CPU0       CPU1
 11:      20203       8980     GICv3  30 Level     arch_timer
 14:          0          0     GICv3  23 Level     arm-pmu
 15:          0          0     GICv3  15 Edge      xlnx_event_mgmt
 16:          0          0     GICv3 176 Level     sysmon-irq
 18:        747          0     GICv3  50 Level     uart-pl011
 20:          0          0     GICv3  92 Level     zynqmp-dma
 21:          0          0     GICv3  93 Level     zynqmp-dma
 22:          0          0     GICv3  94 Level     zynqmp-dma
 23:          0          0     GICv3  95 Level     zynqmp-dma
 24:          0          0     GICv3  96 Level     zynqmp-dma
 25:          0          0     GICv3  97 Level     zynqmp-dma
 26:          0          0     GICv3  98 Level     zynqmp-dma
 27:          0          0     GICv3  99 Level     zynqmp-dma
 28:          3          0     GICv3 157 Level     f1030000.spi
 30:          0          0     GICv3  88 Level     eth0, eth0
 31:          0          0     GICv3  90 Level     eth1, eth1
 32:          0          0     GICv3  54 Level     xhci-hcd:usb1
 33:          0          0     GICv3 174 Level     f12a0000.rtc
 34:          0          0     GICv3 175 Level     f12a0000.rtc
 35:          0          0     GICv3  47 Level     cdns-i2c
 36:          0          0     GICv3 155 Level     cdns-i2c
 37:        548          0     GICv3 160 Level     mmc0
 41:          0          0  gpio-xilinx   1 Edge      PL_GPIO_PB_SW5
 42:          0          0  gpio-xilinx   0 Edge      PL_GPIO_PB_SW4
 43:          0          0  gpio-xilinx   3 Edge      PL_GPIO_DIP_SW3
 44:          0          0  gpio-xilinx   2 Edge      PL_GPIO_DIP_SW2
 45:          0          0  gpio-xilinx   1 Edge      PL_GPIO_DIP_SW1
 46:          0          0  gpio-xilinx   0 Edge      PL_GPIO_DIP_SW0
IPI0:        69        141       Rescheduling interrupts
IPI1:      2063       1606       Function call interrupts
IPI2:         0          0       CPU stop interrupts
IPI3:         0          0       CPU stop (for crash dump) interrupts
IPI4:         0          0       Timer broadcast interrupts
IPI5:         0          0       IRQ work interrupts
IPI6:         0          0       CPU wake-up interrupts
Err:          0
yocto-vck190-versal-dfx-full-2023:/home/petalinux#
yocto-vck190-versal-dfx-full-2023:/home/petalinux# cat /proc/interrupts
           CPU0       CPU1
 11:      21385       9142     GICv3  30 Level     arch_timer
 14:          0          0     GICv3  23 Level     arm-pmu
 15:          0          0     GICv3  15 Edge      xlnx_event_mgmt
 16:          0          0     GICv3 176 Level     sysmon-irq
 18:        895          0     GICv3  50 Level     uart-pl011
 20:          0          0     GICv3  92 Level     zynqmp-dma
 21:          0          0     GICv3  93 Level     zynqmp-dma
 22:          0          0     GICv3  94 Level     zynqmp-dma
 23:          0          0     GICv3  95 Level     zynqmp-dma
 24:          0          0     GICv3  96 Level     zynqmp-dma
 25:          0          0     GICv3  97 Level     zynqmp-dma
 26:          0          0     GICv3  98 Level     zynqmp-dma
 27:          0          0     GICv3  99 Level     zynqmp-dma
 28:          3          0     GICv3 157 Level     f1030000.spi
 30:          0          0     GICv3  88 Level     eth0, eth0
 31:          0          0     GICv3  90 Level     eth1, eth1
 32:          0          0     GICv3  54 Level     xhci-hcd:usb1
 33:          0          0     GICv3 174 Level     f12a0000.rtc
 34:          0          0     GICv3 175 Level     f12a0000.rtc
 35:          0          0     GICv3  47 Level     cdns-i2c
 36:          0          0     GICv3 155 Level     cdns-i2c
 37:        548          0     GICv3 160 Level     mmc0
 41:         12          0  gpio-xilinx   1 Edge      PL_GPIO_PB_SW5
 42:         12          0  gpio-xilinx   0 Edge      PL_GPIO_PB_SW4
 43:          2          0  gpio-xilinx   3 Edge      PL_GPIO_DIP_SW3
 44:          8          0  gpio-xilinx   2 Edge      PL_GPIO_DIP_SW2
 45:          2          0  gpio-xilinx   1 Edge      PL_GPIO_DIP_SW1
 46:          2          0  gpio-xilinx   0 Edge      PL_GPIO_DIP_SW0
IPI0:        69        142       Rescheduling interrupts
IPI1:      2078       1694       Function call interrupts
IPI2:         0          0       CPU stop interrupts
IPI3:         0          0       CPU stop (for crash dump) interrupts
IPI4:         0          0       Timer broadcast interrupts
IPI5:         0          0       IRQ work interrupts
IPI6:         0          0       CPU wake-up interrupts
Err:          0
yocto-vck190-versal-dfx-full-2023:/home/petalinux#
```
---

### Unloading PL pdi and dt overlay
* Versal
```
yocto-vck190-versal-dfx-full-2023:/home/petalinux# fpgautil -R
```
---

## References
* https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/1188397412/Solution+Versal+PL+Programming
