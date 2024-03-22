# Build Instructions to create ZynqMP full bitstream loading firmware recipes

* [Introduction](#introduction)
* [How to create a firmware recipe app](#how-to-create-a-firmware-recipe-app)
* [Test Procedure on Target](#test-procedure-on-target)
  * [Loading PL bitstream and dt overlay](#loading-pl-bitstream-and-dt-overlay)
  * [Testing PL functionality](#testing-pl-functionality)
  * [Unloading PL bitstream and dt overlay](#unloading-pl-bitstream-and-dt-overlay)
* [References](#references)

## Introduction
This readme describes the build instructions to create firmware recipes using
dfx_dtg_zynqmp_full.bbclass for ZynqMP full bitstream loading configuration.

> **Note:**
> 1. Refer https://github.com/Xilinx/dfx-mgr/blob/master/README.md for shell.json
>   and accel.json file content.
> 2. Using dfx_dtg_zynqmp_full.bbclass loading bitstream file .bin format is
>    supported but .bit format is not supported as it can't be used for production
>    deployment.

* **ZynqMP**:
  * Design: Vivado flat design.
    * Input files to firmware recipes: .xsa, .dtsi (optional: to add pl custom dt
      nodes), shell.json (optional) and .xclbin (optional).
    * Usage Examples:
```
SRC_URI = " \
    file://<flat_design_pl>.xsa \
    file://<flat_design_pl_custom>.dtsi \
    file://shell.json \
    file://<flat_design_pl>.xclbin \
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
3. Now create the recipes for full bitstream loading firmware app using recipetool.
```
$ recipetool create -o <meta-layer>/recipes-firmware/<firmware-app-name>/firmware-app-name.bb file:///<meta-layer>/recipes-firmware/<firmware-app-name>/files
```
4. Modify the recipe and inherit dfx_dtg_zynqmp_full bbclass as shown below.
```
SUMMARY = "ZynqMP Full Bitstream loading firmware app using dfx_dtg_zynqmp_full bbclass"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit dfx_dtg_zynqmp_full

SRC_URI = "\
    file://zcu111_pl_demo.xsa \
    file://shell.json \
    file://zcu111-pl-demo.dtsi \
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

### Loading PL bitstream and dt overlay

* ZynqMP
```
yocto-zynqmp-generic:~$ sudo su
yocto-zynqmp-generic:/home/petalinux# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 11:       5820       5482      14979       6981     GICv2  30 Level     arch_timer
 14:          0          0          0          0     GICv2  67 Level     zynqmp-ipi
 15:          0          0          0          0     GICv2 175 Level     arm-pmu
 16:          0          0          0          0     GICv2 176 Level     arm-pmu
 17:          0          0          0          0     GICv2 177 Level     arm-pmu
 18:          0          0          0          0     GICv2 178 Level     arm-pmu
 19:          0          0          0          0     GICv2  58 Level     ffa60000.rtc
 20:          0          0          0          0     GICv2  59 Level     ffa60000.rtc
 21:          0          0          0          0     GICv2  42 Level     ff960000.memory-controller
 22:          0          0          0          0     GICv2  88 Level     ams-irq
 23:          0          0          0          0     GICv2 155 Level     axi-pmon, axi-pmon
 24:        366          0          0          0     GICv2  53 Level     xuartps
 27:          0          0          0          0     GICv2 156 Level     zynqmp-dma
 28:          0          0          0          0     GICv2 157 Level     zynqmp-dma
 29:          0          0          0          0     GICv2 158 Level     zynqmp-dma
 30:          0          0          0          0     GICv2 159 Level     zynqmp-dma
 31:          0          0          0          0     GICv2 160 Level     zynqmp-dma
 32:          0          0          0          0     GICv2 161 Level     zynqmp-dma
 33:          0          0          0          0     GICv2 162 Level     zynqmp-dma
 34:          0          0          0          0     GICv2 163 Level     zynqmp-dma
 35:          0          0          0          0     GICv2 109 Level     zynqmp-dma
 36:          0          0          0          0     GICv2 110 Level     zynqmp-dma
 37:          0          0          0          0     GICv2 111 Level     zynqmp-dma
 38:          0          0          0          0     GICv2 112 Level     zynqmp-dma
 39:          0          0          0          0     GICv2 113 Level     zynqmp-dma
 40:          0          0          0          0     GICv2 114 Level     zynqmp-dma
 41:          0          0          0          0     GICv2 115 Level     zynqmp-dma
 42:          0          0          0          0     GICv2 116 Level     zynqmp-dma
 43:          0          0          0          0     GICv2 154 Level     fd4c0000.dma-controller
 44:       5938          0          0          0     GICv2  47 Level     ff0f0000.spi
 45:        325          0          0          0     GICv2  95 Level     eth0, eth0
 46:          0          0          0          0     GICv2  57 Level     axi-pmon, axi-pmon
 47:       2798          0          0          0     GICv2  49 Level     cdns-i2c
 48:        326          0          0          0     GICv2  50 Level     cdns-i2c
 50:          0          0          0          0     GICv2  84 Edge      ff150000.watchdog
 51:          0          0          0          0     GICv2 151 Level     fd4a0000.display
 52:        551          0          0          0     GICv2  81 Level     mmc0
 53:          0          0          0          0     GICv2 165 Level     ahci-ceva[fd0c0000.ahci]
 54:          0          0          0          0     GICv2  97 Level     xhci-hcd:usb1
 55:          0          0          0          0  zynq-gpio  22 Edge      sw19
IPI0:        51         94        136         48       Rescheduling interrupts
IPI1:      2295       6271       2952        873       Function call interrupts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop (for crash dump) interrupts
IPI4:         0          0          0          0       Timer broadcast interrupts
IPI5:         0          0          0          0       IRQ work interrupts
IPI6:         0          0          0          0       CPU wake-up interrupts
Err:          0
yocto-zynqmp-generic:/home/petalinux# tree /lib/firmware/
/lib/firmware/
`-- xilinx
    `-- zcu111-pl-demo
        |-- shell.json
        |-- zcu111-pl-demo.bin
        `-- zcu111-pl-demo.dtbo

2 directories, 3 files
yocto-zynqmp-generic:/home/petalinux# fpgautil -b /lib/firmware/xilinx/zcu111-pl-demo/zcu111-pl-demo.bin -o /lib/firmware/xilinx/zcu111-pl-demo/zcu111-pl-demo.dtbo
[  306.904758] fpga_manager fpga0: writing zcu111-pl-demo.bin to Xilinx ZynqMP FPGA Manager
[  307.129310] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga-full/firmware-name
[  307.139450] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga-full/pid
[  307.148688] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga-full/resets
[  307.158178] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga-full/uid
[  307.167744] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/afi0
[  307.177243] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/clocking0
[  307.187187] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/axi_gpio_0
[  307.197203] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/misc_clk_0
[  307.207220] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/axi_gpio_1
[  307.217238] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/axi_gpio_2
[  307.227263] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/axi_uartlite_0
[  307.237627] OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ddr4_0
[  307.260974] gpio gpiochip3: (a0010000.gpio): not an immutable chip, please consider fixing it!
[  307.261197] gpio gpiochip4: (a0000000.gpio): not an immutable chip, please consider fixing it!
[  307.293417] a0030000.serial: ttyUL0 at MMIO 0xa0030000 (irq = 58, base_baud = 0) is a uartlite
[  307.302694] uartlite a0030000.serial: Runtime PM usage count underflow!
Time taken to load BIN is 409.000000 Milli Seconds
BIN FILE loaded through FPGA manager successfully
yocto-zynqmp-generic:/home/petalinux#
```

---

### Testing PL functionality

* This examples uses PL GPIO DIP switches and Push buttons to capture interrupts.
* Verify PL GPIO DIP switches and Push buttons are registered.
* Move the DIP Switches ON/OFF and verify the interrupt counts.

* ZynqMP
```
yocto-zynqmp-generic:/home/petalinux# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 11:       7674       7136      20210       8226     GICv2  30 Level     arch_timer
 14:          0          0          0          0     GICv2  67 Level     zynqmp-ipi
 15:          0          0          0          0     GICv2 175 Level     arm-pmu
 16:          0          0          0          0     GICv2 176 Level     arm-pmu
 17:          0          0          0          0     GICv2 177 Level     arm-pmu
 18:          0          0          0          0     GICv2 178 Level     arm-pmu
 19:          0          0          0          0     GICv2  58 Level     ffa60000.rtc
 20:          0          0          0          0     GICv2  59 Level     ffa60000.rtc
 21:          0          0          0          0     GICv2  42 Level     ff960000.memory-controller
 22:          0          0          0          0     GICv2  88 Level     ams-irq
 23:          0          0          0          0     GICv2 155 Level     axi-pmon, axi-pmon
 24:       1143          0          0          0     GICv2  53 Level     xuartps
 27:          0          0          0          0     GICv2 156 Level     zynqmp-dma
 28:          0          0          0          0     GICv2 157 Level     zynqmp-dma
 29:          0          0          0          0     GICv2 158 Level     zynqmp-dma
 30:          0          0          0          0     GICv2 159 Level     zynqmp-dma
 31:          0          0          0          0     GICv2 160 Level     zynqmp-dma
 32:          0          0          0          0     GICv2 161 Level     zynqmp-dma
 33:          0          0          0          0     GICv2 162 Level     zynqmp-dma
 34:          0          0          0          0     GICv2 163 Level     zynqmp-dma
 35:          0          0          0          0     GICv2 109 Level     zynqmp-dma
 36:          0          0          0          0     GICv2 110 Level     zynqmp-dma
 37:          0          0          0          0     GICv2 111 Level     zynqmp-dma
 38:          0          0          0          0     GICv2 112 Level     zynqmp-dma
 39:          0          0          0          0     GICv2 113 Level     zynqmp-dma
 40:          0          0          0          0     GICv2 114 Level     zynqmp-dma
 41:          0          0          0          0     GICv2 115 Level     zynqmp-dma
 42:          0          0          0          0     GICv2 116 Level     zynqmp-dma
 43:          0          0          0          0     GICv2 154 Level     fd4c0000.dma-controller
 44:       5938          0          0          0     GICv2  47 Level     ff0f0000.spi
 45:        485          0          0          0     GICv2  95 Level     eth0, eth0
 46:          0          0          0          0     GICv2  57 Level     axi-pmon, axi-pmon
 47:       2798          0          0          0     GICv2  49 Level     cdns-i2c
 48:        326          0          0          0     GICv2  50 Level     cdns-i2c
 50:          0          0          0          0     GICv2  84 Edge      ff150000.watchdog
 51:          0          0          0          0     GICv2 151 Level     fd4a0000.display
 52:        551          0          0          0     GICv2  81 Level     mmc0
 53:          0          0          0          0     GICv2 165 Level     ahci-ceva[fd0c0000.ahci]
 54:          0          0          0          0     GICv2  97 Level     xhci-hcd:usb1
 55:          0          0          0          0  zynq-gpio  22 Edge      sw19
 59:          0          0          0          0  gpio-xilinx   4 Edge      PL_GPIO_PB_SW9_N
 60:          0          0          0          0  gpio-xilinx   3 Edge      PL_GPIO_PB_SW12_E
 61:          0          0          0          0  gpio-xilinx   2 Edge      PL_GPIO_PB_SW13_S
 62:          0          0          0          0  gpio-xilinx   1 Edge      PL_GPIO_PB_SW10_W
 63:          0          0          0          0  gpio-xilinx   0 Edge      PL_GPIO_PB_SW11_C
 64:          0          0          0          0  gpio-xilinx   7 Edge      PL_GPIO_DIP_SW7
 65:          0          0          0          0  gpio-xilinx   6 Edge      PL_GPIO_DIP_SW6
 66:          0          0          0          0  gpio-xilinx   5 Edge      PL_GPIO_DIP_SW5
 67:          0          0          0          0  gpio-xilinx   4 Edge      PL_GPIO_DIP_SW4
 68:          0          0          0          0  gpio-xilinx   3 Edge      PL_GPIO_DIP_SW3
 69:          0          0          0          0  gpio-xilinx   2 Edge      PL_GPIO_DIP_SW2
 70:          0          0          0          0  gpio-xilinx   1 Edge      PL_GPIO_DIP_SW1
 71:          0          0          0          0  gpio-xilinx   0 Edge      PL_GPIO_DIP_SW0
IPI0:        64        106        160         56       Rescheduling interrupts
IPI1:      2712       6721       3259        998       Function call interrupts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop (for crash dump) interrupts
IPI4:         0          0          0          0       Timer broadcast interrupts
IPI5:         0          0          0          0       IRQ work interrupts
IPI6:         0          0          0          0       CPU wake-up interrupts
Err:          0
yocto-zynqmp-generic:/home/petalinux#
yocto-zynqmp-generic:/home/petalinux# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 11:       8530       7717      22106       8626     GICv2  30 Level     arch_timer
 14:          0          0          0          0     GICv2  67 Level     zynqmp-ipi
 15:          0          0          0          0     GICv2 175 Level     arm-pmu
 16:          0          0          0          0     GICv2 176 Level     arm-pmu
 17:          0          0          0          0     GICv2 177 Level     arm-pmu
 18:          0          0          0          0     GICv2 178 Level     arm-pmu
 19:          0          0          0          0     GICv2  58 Level     ffa60000.rtc
 20:          0          0          0          0     GICv2  59 Level     ffa60000.rtc
 21:          0          0          0          0     GICv2  42 Level     ff960000.memory-controller
 22:          0          0          0          0     GICv2  88 Level     ams-irq
 23:          0          0          0          0     GICv2 155 Level     axi-pmon, axi-pmon
 24:       1234          0          0          0     GICv2  53 Level     xuartps
 27:          0          0          0          0     GICv2 156 Level     zynqmp-dma
 28:          0          0          0          0     GICv2 157 Level     zynqmp-dma
 29:          0          0          0          0     GICv2 158 Level     zynqmp-dma
 30:          0          0          0          0     GICv2 159 Level     zynqmp-dma
 31:          0          0          0          0     GICv2 160 Level     zynqmp-dma
 32:          0          0          0          0     GICv2 161 Level     zynqmp-dma
 33:          0          0          0          0     GICv2 162 Level     zynqmp-dma
 34:          0          0          0          0     GICv2 163 Level     zynqmp-dma
 35:          0          0          0          0     GICv2 109 Level     zynqmp-dma
 36:          0          0          0          0     GICv2 110 Level     zynqmp-dma
 37:          0          0          0          0     GICv2 111 Level     zynqmp-dma
 38:          0          0          0          0     GICv2 112 Level     zynqmp-dma
 39:          0          0          0          0     GICv2 113 Level     zynqmp-dma
 40:          0          0          0          0     GICv2 114 Level     zynqmp-dma
 41:          0          0          0          0     GICv2 115 Level     zynqmp-dma
 42:          0          0          0          0     GICv2 116 Level     zynqmp-dma
 43:          0          0          0          0     GICv2 154 Level     fd4c0000.dma-controller
 44:       5938          0          0          0     GICv2  47 Level     ff0f0000.spi
 45:        527          0          0          0     GICv2  95 Level     eth0, eth0
 46:          0          0          0          0     GICv2  57 Level     axi-pmon, axi-pmon
 47:       2798          0          0          0     GICv2  49 Level     cdns-i2c
 48:        326          0          0          0     GICv2  50 Level     cdns-i2c
 50:          0          0          0          0     GICv2  84 Edge      ff150000.watchdog
 51:          0          0          0          0     GICv2 151 Level     fd4a0000.display
 52:        551          0          0          0     GICv2  81 Level     mmc0
 53:          0          0          0          0     GICv2 165 Level     ahci-ceva[fd0c0000.ahci]
 54:          0          0          0          0     GICv2  97 Level     xhci-hcd:usb1
 55:          0          0          0          0  zynq-gpio  22 Edge      sw19
 59:          2          0          0          0  gpio-xilinx   4 Edge      PL_GPIO_PB_SW9_N
 60:          4          0          0          0  gpio-xilinx   3 Edge      PL_GPIO_PB_SW12_E
 61:          6          0          0          0  gpio-xilinx   2 Edge      PL_GPIO_PB_SW13_S
 62:          4          0          0          0  gpio-xilinx   1 Edge      PL_GPIO_PB_SW10_W
 63:          2          0          0          0  gpio-xilinx   0 Edge      PL_GPIO_PB_SW11_C
 64:         20          0          0          0  gpio-xilinx   7 Edge      PL_GPIO_DIP_SW7
 65:         20          0          0          0  gpio-xilinx   6 Edge      PL_GPIO_DIP_SW6
 66:          2          0          0          0  gpio-xilinx   5 Edge      PL_GPIO_DIP_SW5
 67:          8          0          0          0  gpio-xilinx   4 Edge      PL_GPIO_DIP_SW4
 68:          4          0          0          0  gpio-xilinx   3 Edge      PL_GPIO_DIP_SW3
 69:          2          0          0          0  gpio-xilinx   2 Edge      PL_GPIO_DIP_SW2
 70:          2          0          0          0  gpio-xilinx   1 Edge      PL_GPIO_DIP_SW1
 71:          2          0          0          0  gpio-xilinx   0 Edge      PL_GPIO_DIP_SW0
IPI0:        64        107        160         56       Rescheduling interrupts
IPI1:      2720       6763       3430        998       Function call interrupts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop (for crash dump) interrupts
IPI4:         0          0          0          0       Timer broadcast interrupts
IPI5:         0          0          0          0       IRQ work interrupts
IPI6:         0          0          0          0       CPU wake-up interrupts
Err:          0
yocto-zynqmp-generic:/home/petalinux#
```
---

### Unloading PL bitstream and dt overlay
* ZynqMP
```
yocto-zynqmp-generic:/home/petalinux# fpgautil -R
```

---

## References
* https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18841847/Solution+ZynqMP+PL+Programming
