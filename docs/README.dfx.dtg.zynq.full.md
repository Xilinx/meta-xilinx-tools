# Build Instructions to create Zynq-7000 full bitstream loading firmware recipes

* [Introduction](#introduction)
* [How to create a firmware recipe app](#how-to-create-a-firmware-recipe-app)
* [Test Procedure on Target](#test-procedure-on-target)
  * [Loading PL bitstream and dt overlay](#loading-pl-bitstream-and-dt-overlay)
  * [Testing PL functionality](#testing-pl-functionality)
  * [Unloading PL bitstream and dt overlay](#unloading-pl-bitstream-and-dt-overlay)
* [References](#references)

## Introduction
This readme describes the build instructions to create firmware recipes using
dfx_dtg_zynq_full.bbclass for Zynq-7000 full bitstream loading configuration.

> **Note:**
> 1. Refer https://github.com/Xilinx/dfx-mgr/blob/master/README.md for shell.json
>   and accel.json file content.
> 2. Using dfx_dtg_zynq_full.bbclass loading bitstream file .bin format is
>    supported but .bit format is not supported as it can't be used for production
>    deployment.

* **Zynq-7000**:
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
4. Modify the recipe and inherit dfx_dtg_zynq_full bbclass as shown below.
```
SUMMARY = "Zynq-7000 Full Bitstream loading firmware app using dfx_dtg_zynq_full bbclass"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit dfx_dtg_zynq_full

SRC_URI = "\
    file://zc702_pl_demo.xsa \
    file://shell.json \
    file://zc702-pl-demo.dtsi \
    "

COMPATIBLE_MACHINE:zynq = "zynq"
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

* Zynq-7000
```
yocto-zc702-zynq7:~$ sudo su
yocto-zc702-zynq7:/home/petalinux# cat /proc/interrupts
           CPU0       CPU1
 24:          0          0 GIC-0  27 Edge      gt
 25:       7153       1437 GIC-0  29 Edge      twd
 26:          0          0 GIC-0  37 Level     arm-pmu
 27:          0          0 GIC-0  38 Level     arm-pmu
 29:          0          0 GIC-0  45 Level     f8003000.dma-controller
 30:          0          0 GIC-0  46 Level     f8003000.dma-controller
 31:          0          0 GIC-0  47 Level     f8003000.dma-controller
 32:          0          0 GIC-0  48 Level     f8003000.dma-controller
 33:          0          0 GIC-0  49 Level     f8003000.dma-controller
 34:          0          0 GIC-0  72 Level     f8003000.dma-controller
 35:          0          0 GIC-0  73 Level     f8003000.dma-controller
 36:          0          0 GIC-0  74 Level     f8003000.dma-controller
 37:          0          0 GIC-0  75 Level     f8003000.dma-controller
 38:      15907          0 GIC-0  51 Level     e000d000.spi
 40:         64          0 GIC-0  54 Level     eth0
 41:          0          0 GIC-0  53 Level     e0002000.usb
 42:       1466          0 GIC-0  57 Level     cdns-i2c
 43:          0          0 GIC-0  41 Edge      f8005000.watchdog
 44:        372          0 GIC-0  56 Level     mmc0
 45:          0          0 GIC-0  43 Level     ttc_clockevent
 46:         43          0 GIC-0  39 Level     f8007100.adc
 47:          0          0 GIC-0  40 Level     f8007000.devcfg
 48:        146          0 GIC-0  82 Level     xuartps
 49:          0          0  zynq-gpio  12 Edge      sw14
 50:          0          0  zynq-gpio  14 Edge      sw13
IPI0:          0          0  CPU wakeup interrupts
IPI1:          0          0  Timer broadcast interrupts
IPI2:        283       6962  Rescheduling interrupts
IPI3:        574        697  Function call interrupts
IPI4:          0          0  CPU stop interrupts
IPI5:          0          0  IRQ work interrupts
IPI6:          0          0  completion interrupts
Err:          0
yocto-zc702-zynq7:/home/petalinux# tree /lib/firmware/
/lib/firmware/
`-- xilinx
    `-- zc702-pl-demo
        |-- shell.json
        |-- zc702-pl-demo.bin
        `-- zc702-pl-demo.dtbo

2 directories, 3 files
yocto-zc702-zynq7:/home/petalinux# fpgautil -b /lib/firmware/xilinx/zc702-pl-demo/zc702-pl-demo.bin -o /lib/firmware/xilinx/zc702-pl-demo/zc702-pl-demo.dtbo
fpga_manager fpga0: writing zc702-pl-demo.bin to Xilinx Zynq FPGA Manager
OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga-full/firmware-name
OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga-full/pid
OF: overlay: WARNING: memory leak will occur if overlay removed, property: /fpga-full/uid
OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/clocking0
OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/axi_bram_ctrl_0
OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/axi_gpio_dip_sw
OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/axi_gpio_leds
OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/axi_gpio_pb
gpio gpiochip1: (41210000.gpio): not an immutable chip, please consider fixing it!
gpio gpiochip3: (41220000.gpio): not an immutable chip, please consider fixing it!
Time taken to load BIN is 207.000000 Milli Seconds
BIN FILE loaded through FPGA manager successfully
yocto-zc702-zynq7:/home/petalinux#
```

---

### Testing PL functionality

* This examples uses PL GPIO DIP switches and Push buttons to capture interrupts.
* Verify PL GPIO DIP switches and Push buttons are registered.
* Move the DIP Switches ON/OFF and verify the interrupt counts.

* Zynq-7000
```
yocto-zc702-zynq7:/home/petalinux# cat /proc/interrupts
 24:          0          0 GIC-0  27 Edge      gt
 25:       8413       1662 GIC-0  29 Edge      twd
 26:          0          0 GIC-0  37 Level     arm-pmu
 27:          0          0 GIC-0  38 Level     arm-pmu
 29:          0          0 GIC-0  45 Level     f8003000.dma-controller
 30:          0          0 GIC-0  46 Level     f8003000.dma-controller
 31:          0          0 GIC-0  47 Level     f8003000.dma-controller
 32:          0          0 GIC-0  48 Level     f8003000.dma-controller
 33:          0          0 GIC-0  49 Level     f8003000.dma-controller
 34:          0          0 GIC-0  72 Level     f8003000.dma-controller
 35:          0          0 GIC-0  73 Level     f8003000.dma-controller
 36:          0          0 GIC-0  74 Level     f8003000.dma-controller
 37:          0          0 GIC-0  75 Level     f8003000.dma-controller
 38:      15907          0 GIC-0  51 Level     e000d000.spi
 40:        103          0 GIC-0  54 Level     eth0
 41:          0          0 GIC-0  53 Level     e0002000.usb
 42:       1466          0 GIC-0  57 Level     cdns-i2c
 43:          0          0 GIC-0  41 Edge      f8005000.watchdog
 44:        372          0 GIC-0  56 Level     mmc0
 45:          0          0 GIC-0  43 Level     ttc_clockevent
 46:         43          0 GIC-0  39 Level     f8007100.adc
 47:          3          0 GIC-0  40 Level     f8007000.devcfg
 48:        291          0 GIC-0  82 Level     xuartps
 49:          0          0  zynq-gpio  12 Edge      sw14
 50:          0          0  zynq-gpio  14 Edge      sw13
 51:          0          0  gpio-xilinx  1 Edge      PL_GPIO_DIP_SW1_SW12
 52:          0          0  gpio-xilinx  0 Edge      PL_GPIO_DIP_SW0_SW12
 53:          0          0  gpio-xilinx  1 Edge      PL_GPIO_PB_SW_S_SW7
 54:          0          0  gpio-xilinx  0 Edge      PL_GPIO_PB_SW_N_SW5
IPI0:          0          0  CPU wakeup interrupts
IPI1:          0          0  Timer broadcast interrupts
IPI2:        294       6973  Rescheduling interrupts
IPI3:        619        785  Function call interrupts
IPI4:          0          0  CPU stop interrupts
IPI5:          0          0  IRQ work interrupts
IPI6:          0          0  completion interrupts
Err:          0
yocto-zc702-zynq7:/home/petalinux# cat /proc/interrupts
 24:          0          0 GIC-0  27 Edge      gt
 25:      11730       6937 GIC-0  29 Edge      twd
 26:          0          0 GIC-0  37 Level     arm-pmu
 27:          0          0 GIC-0  38 Level     arm-pmu
 29:          0          0 GIC-0  45 Level     f8003000.dma-controller
 30:          0          0 GIC-0  46 Level     f8003000.dma-controller
 31:          0          0 GIC-0  47 Level     f8003000.dma-controller
 32:          0          0 GIC-0  48 Level     f8003000.dma-controller
 33:          0          0 GIC-0  49 Level     f8003000.dma-controller
 34:          0          0 GIC-0  72 Level     f8003000.dma-controller
 35:          0          0 GIC-0  73 Level     f8003000.dma-controller
 36:          0          0 GIC-0  74 Level     f8003000.dma-controller
 37:          0          0 GIC-0  75 Level     f8003000.dma-controller
 38:      15907          0 GIC-0  51 Level     e000d000.spi
 40:        397          0 GIC-0  54 Level     eth0
 41:          0          0 GIC-0  53 Level     e0002000.usb
 42:       1466          0 GIC-0  57 Level     cdns-i2c
 43:          0          0 GIC-0  41 Edge      f8005000.watchdog
 44:        372          0 GIC-0  56 Level     mmc0
 45:          0          0 GIC-0  43 Level     ttc_clockevent
 46:         43          0 GIC-0  39 Level     f8007100.adc
 47:          3          0 GIC-0  40 Level     f8007000.devcfg
 48:        383          0 GIC-0  82 Level     xuartps
 49:          0          0  zynq-gpio  12 Edge      sw14
 50:          0          0  zynq-gpio  14 Edge      sw13
 51:          4          0  gpio-xilinx  1 Edge      PL_GPIO_DIP_SW1_SW12
 52:          6          0  gpio-xilinx  0 Edge      PL_GPIO_DIP_SW0_SW12
 53:          2          0  gpio-xilinx  1 Edge      PL_GPIO_PB_SW_S_SW7
 54:          8          0  gpio-xilinx  0 Edge      PL_GPIO_PB_SW_N_SW5
IPI0:          0          0  CPU wakeup interrupts
IPI1:          0          0  Timer broadcast interrupts
IPI2:        298       6973  Rescheduling interrupts
IPI3:        638       1065  Function call interrupts
IPI4:          0          0  CPU stop interrupts
IPI5:          0          0  IRQ work interrupts
IPI6:          0          0  completion interrupts
Err:          0
yocto-zc702-zynq7:/home/petalinux#
```
---

### Unloading PL bitstream and dt overlay
* Zynq
```
yocto-zc702-zynq7:/home/petalinux# fpgautil -R
```

---

## References
* https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18841645/Solution+Zynq+PL+Programming+With+FPGA+Manager
