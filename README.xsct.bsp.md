# AMD Evaluation Boards XSCT BSP Machines files

The following boards are supported by the meta-xilinx-tools layer. Eval board XSCT
(Software Command-Line Tool) BSP machine configuration files are generated using
meta-xilinx-tools/scripts/generate-machines-<XSCT_VERSION>.sh scripts.

> **Variable usage examples:**
>
> Machine Configuration file:
>
> 1. Eval Board: `MACHINE = "zcu102-zynqmp"`
> 2. QEMU: `MACHINE = "qemu-zynqmp"`
>
> HW Board Device tree: `YAML_DT_BOARD_FLAGS = "{BOARD zcu102-rev1.0}"`

> **Note:** QEMU Machine Configuration file generated images are not intended to
> run on HW. These machile files are used for Yocto Project Tests (Image testing).

| Devices    | Evaluation Board                                                              | Machine Configuration file                                   | Reference XSA         | HW Board Device tree                | QEMU tested | HW tested |
|------------|-------------------------------------------------------------------------------|--------------------------------------------------------------|-----------------------|-------------------------------------|-------------|-----------|
| MicroBlaze | [KC705](https://www.xilinx.com/products/boards-and-kits/ek-k7-kc705-g.html)   | [kc705-microblazeel](conf/machine/kc705-microblazeel.conf)   | `kc705-microblazeel`  | `kc705-full`                        | Yes         | Yes       |
|            | [AC701](https://www.xilinx.com/products/boards-and-kits/ek-a7-ac701-g.html)   | [ac701-microblazeel](conf/machine/ac701-microblazeel.conf)   | `ac701-microblazeel`  | `ac701-full`                        | Yes         | Yes       |
|            | [KCU105](https://www.xilinx.com/products/boards-and-kits/kcu105.html)         | [kcu105-microblazeel](conf/machine/kcu105-microblazeel.conf) | `kcu105-microblazeel` | `kcu105`                            | Yes         | Yes       |
|            | [VCU118](https://www.xilinx.com/products/boards-and-kits/vcu118.html)         | [vcu118-microblazeel](conf/machine/vcu118-microblazeel.conf) | `vcu118-microblazeel` | `vcu118-rev2.0`                     | Yes         | Yes       |
|            |          | [qemu-microblazeel](conf/machine/qemu-microblazeel.conf) | `kcu105-microblazeel` | `kcu105`                     | Yes         | NA       |
| Zynq-7000  | [ZC702](https://www.xilinx.com/products/boards-and-kits/ek-z7-zc702-g.html)   | [zc702-zynq7](conf/machine/zc702-zynq7.conf)                 | `zc702-zynq7`         | `zc702`                             | Yes         | Yes       |
|            | [ZC706](https://www.xilinx.com/products/boards-and-kits/ek-z7-zc706-g.html)   | [zc706-zynq7](conf/machine/zc706-zynq7.conf)                 | `zc706-zynq7`         | `zc706`                             | Yes         | Yes       |
|            |          | [qemu-zynq7](conf/machine/qemu-zynq7.conf) | `zc702-zynq7` | `zc702` | Yes         | NA       |
| ZynqMP     | [ZCU102](https://www.xilinx.com/products/boards-and-kits/ek-u1-zcu102-g.html) | [zcu102-zynqmp](conf/machine/zcu102-zynqmp.conf)             | `zcu102-zynqmp`       | `zcu102-rev1.0`                     | Yes         | Yes       |
|            | [ZCU104](https://www.xilinx.com/products/boards-and-kits/zcu104.html)         | [zcu104-zynqmp](conf/machine/zcu104-zynqmp.conf)             | `zcu104-zynqmp`       | `zcu104-revc`                       | Yes         | Yes       |
|            | [ZCU106](https://www.xilinx.com/products/boards-and-kits/zcu106.html)         | [zcu106-zynqmp](conf/machine/zcu106-zynqmp.conf)             | `zcu106-zynqmp`       | `zcu106-reva`                       | Yes         | Yes       |
|            | [ZCU111](https://www.xilinx.com/products/boards-and-kits/zcu111.html)         | [zcu111-zynqmp](conf/machine/zcu111-zynqmp.conf)             | `zcu111-zynqmp`       | `zcu111-reva`                       | Yes         | Yes       |
|            | [ZCU208](https://www.xilinx.com/products/boards-and-kits/zcu208.html)         | [zcu208-zynqmp](conf/machine/zcu208-zynqmp.conf)             | `zcu208-zynqmp`       | `zcu208-reva`                       | Yes         | Yes       |
|            | [ZCU216](https://www.xilinx.com/products/boards-and-kits/zcu216.html)         | [zcu216-zynqmp](conf/machine/zcu216-zynqmp.conf)             | `zcu216-zynqmp`       | `zcu216-reva`                       | Yes         | Yes       |
|            | [ZCU670](https://www.xilinx.com/products/boards-and-kits/zcu670.html)         | [zcu670-zynqmp](conf/machine/zcu670-zynqmp.conf)             | `zcu670-zynqmp`       | `zcu670-revb`                       | Yes         | Yes       |
|            |          | [qemu-zynqmp](conf/machine/qemu-zynqmp.conf) | `zcu102-zynqmp` | `zcu102-rev1.0` | Yes         | NA       |
| Versal     | [VCK190](https://www.xilinx.com/products/boards-and-kits/vck190.html)         | [vck190-versal](conf/machine/vck190-versal.conf)             | `vck190-versal`       | `versal-vck190-reva-x-ebm-01-reva`  | Yes         | Yes       |
|            | [VMK180](https://www.xilinx.com/products/boards-and-kits/vmk180.html)         | [vmk180-versal](conf/machine/vmk180-versal.conf)             | `vmk180-versal`       | `versal-vmk180-reva-x-ebm-01-reva`  | Yes         | Yes       |
|            | [VPK120](https://www.xilinx.com/products/boards-and-kits/vpk120.html)         | [vpk120-versal](conf/machine/vpk120-versal.conf)             | `vpk120-versal`       | `versal-vpk120-reva`                | Yes         | Yes       |
|            | [VPK180](https://www.xilinx.com/products/boards-and-kits/vpk180.html)         | [vpk180-versal](conf/machine/vpk180-versal.conf)             | `vpk180-versal`       | `versal-vpk180-reva`                | Yes         | Yes       |
|            | [VEK280](https://www.xilinx.com/products/boards-and-kits/vek280.html)         | [vek280-versal](conf/machine/vek280-versal.conf)             | `vek280-versal`       | `versal-vek280-revb`                | Yes         | Yes       |
|            | [VHK158](https://www.xilinx.com/products/boards-and-kits/vhk158.html)         | [vhk158-versal](conf/machine/vhk158-versal.conf)             | `vhk158-versal`       | `versal-vhk158-reva`                | Yes         | Yes       |
|            |          | [qemu-versal](conf/machine/qemu-versal.conf) | `vck190-versal` | `versal-vck190-reva-x-ebm-01-reva` | Yes         | NA       |

> **Note:** Additional information on AMD Adaptive SoC's and FPGA's can be found at:
	https://www.amd.com/en/products/adaptive-socs-and-fpgas.html

## XSCT Build Instructions

The Yocto Project setup for the XSCT workflow is as follows. Be sure to read
everything below.


1. Follow [Building Instructions](https://github.com/Xilinx/meta-xilinx/blob/master/README.building.md) upto step 7.

2. Export gen-machineconf tool.
```
$ export PATH=$PATH:<ABSOLUTE_PATH>/gen-machine-conf
```

3. Run the script from the build or ${TOPDIR} directory.

> **Note:**
> 1. The -c option should point either <path-to-machine-bsp-layer>/conf or <path-to-build-directory>/build/conf
>    directory.
> 2. The -l option will automatically add the necessary parameters to the
> local.conf file.  If you need to re-run this comment, you just clear the
> parameters from the end of the file.  Without the -l option the items are
> printed to the screen and must be manually added to your conf/local.conf
> 3. The --soc-family argument is an optional argument and user can skip this.

```
 $ gen-machineconf parse-xsa --soc-family <soc_family_name> --hw-description <path_to_xsa> -c <conf-directory> -l <path-to-build-directory>/build/conf/local.conf --machine-name <soc-family>-<board-name>-xsct-<design-name>
```

The following will be written to the end of the <path-to-build-directory>/build/conf/local.conf file:
```
# Use the newly generated MACHINE
MACHINE = "zynq-zcu102-xsct"
```

4. Build your project, You should now be able to build your project normally.
   See the Yocto Project documentation if you have questions on how to work with
   the recipes. The following is a simple build for testing.

5.  Continue [Building Instructions](https://github.com/Xilinx/meta-xilinx/blob/master/README.building.md)
   from step 8.

## Hardware Configuration using XSA

meta-xilinx-tools recipes depends on XSA to be provided.
As of the 2019.2 release, all design files were renamed from hdf to xsa.

HDF_URI specifies the download url for the XSA file.  It is usually file://
or https://.

HDF_URI[sha256sum] must also be defined so the download can be verified.

These value as set automatically by gen-machineconf, and will rarely need
to be set manually.


## Additional configurations using YAML

This layer provides additional configurations through YAML

1. Example YAML based configuration for embeddedsw components(FSBL, PMUFW, etc.) uart, memory, flash settings.
   from machine or local confiruation file.

* FSBL or FS-BOOT
```bash
# MicroBlaze:
YAML_FILE_PATH:pn-fs-boot = "${WORKDIR}/fsboot.yaml"
YAML_SERIAL_CONSOLE_STDIN:pn-fs-boot = "axi_uartlite_0"
YAML_SERIAL_CONSOLE_STDOUT:pn-fs-boot = "axi_uartlite_0"

YAML_MAIN_MEMORY_CONFIG:pn-fs-boot = "mig_7series_0"
or
YAML_MAIN_MEMORY_CONFIG:pn-fs-boot = "DDR4_0"

YAML_FLASH_MEMORY_CONFIG:pn-fs-boot = "axi_quad_spi_0"

# Zynq-7000:
YAML_SERIAL_CONSOLE_STDIN:pn-fsbl-firmware = "ps7_uart_1"
YAML_SERIAL_CONSOLE_STDOUT:pn-fsbl-firmware = "ps7_uart_1"

# ZynqMP:
YAML_SERIAL_CONSOLE_STDIN:pn-fsbl-firmware = "psu_uart_0"
YAML_SERIAL_CONSOLE_STDOUT:pn-fsbl-firmware = "psu_uart_0"
```

* PMUFW or PLMFW
```bash
# ZynqMP:
YAML_SERIAL_CONSOLE_STDIN:pn-pmu-firmware = "psu_uart_1"
YAML_SERIAL_CONSOLE_STDOUT:pn-pmu-firmware = "psu_uart_1"

# Versal:
YAML_SERIAL_CONSOLE_STDIN:pn-plm-firmware = "versal_cips_0_pspmc_0_psv_sbsauart_0"
YAML_SERIAL_CONSOLE_STDOUT:pn-plm-firmware = "versal_cips_0_pspmc_0_psv_sbsauart_0"

# Versal Net:
YAML_SERIAL_CONSOLE_STDIN:pn-plm-firmware = "psx_wizard_0_psxl_0_psx_sbsauart_0"
YAML_SERIAL_CONSOLE_STDOUT:pn-plm-firmware = "psx_wizard_0_psxl_0_psx_sbsauart_0"
```

2. Example YAML based configuration for device tree serial, baudrate, memory
   configurations.

```bash
# MicroBlaze:
YAML_CONSOLE_DEVICE_CONFIG:pn-device-tree = "axi_uartlite_0"
YAML_SERIAL_CONSOLE_BAUDRATE = "115200"
YAML_MAIN_MEMORY_CONFIG:pn-device-tree = "mig_7series_0"
or
YAML_MAIN_MEMORY_CONFIG:pn-device-tree = "DDR4_0"

# Zynq-7000:
YAML_CONSOLE_DEVICE_CONFIG:pn-device-tree = "ps7_uart_1"
YAML_MAIN_MEMORY_CONFIG:pn-device-tree = "PS7_DDR_0"
YAML_SERIAL_CONSOLE_BAUDRATE = "115200"

# ZynqMP:
YAML_CONSOLE_DEVICE_CONFIG:pn-device-tree = "psu_uart_0"
YAML_MAIN_MEMORY_CONFIG:pn-device-tree = "PSU_DDR_0"
YAML_SERIAL_CONSOLE_BAUDRATE = "115200"

# Versal:
YAML_CONSOLE_DEVICE_CONFIG:pn-device-tree = "versal_cips_0_pspmc_0_psv_sbsauart_0"
YAML_SERIAL_CONSOLE_BAUDRATE = "115200"

# Versal Net:
YAML_CONSOLE_DEVICE_CONFIG:pn-device-tree = "psx_wizard_0_psxl_0_psx_sbsauart_0"
YAML_SERIAL_CONSOLE_BAUDRATE = "115200"
```

3. Example YAML based configuration for setting eval board specific dtsi files available in DTG repo.
Refer https://github.com/Xilinx/device-tree-xlnx/tree/xlnx_rel_v2024.2/device_tree/data/kernel_dtsi/2024.2/BOARD
for more details.

```bash
# MicroBlaze:
YAML_DT_BOARD_FLAGS:pn-device-tree = "{BOARD kcu105}"

# Zynq-7000:
YAML_DT_BOARD_FLAGS:pn-device-tree = "{BOARD zc702}"

# ZynqMP:
YAML_DT_BOARD_FLAGS:pn-device-tree = "{BOARD zcu102-rev1.0}"

# Versal:
YAML_DT_BOARD_FLAGS:pn-device-tree = "{BOARD versal-vck190-reva-x-ebm-01-reva}"

# Versal Net:
YAML_DT_BOARD_FLAGS:pn-device-tree = "{BOARD versal-net-vn-p-b2197-00-reva}"
```

>**Note:** Only AMD eval boards have the dtsi in DTG, for custom board user has
> to follow one of the following methods.
> 1. Patch DTG to include the custom board dtsi and enable it using YAML
> configuration.
> `YAML_DT_BOARD_FLAGS:pn-device-tree = "{BOARD custom-board}"`
> 
> 2. Create a custom board dtsi file and use EXTRA_DT_INCLUDE_FILES variable to
> include the custom board dtsi to final dtb. Here is the example usage.
> `EXTRA_DT_INCLUDE_FILES:append = " <path-to-directory>/<custom-board>.dtsi"`

## Additional documentation

* [Building Image Instructions](https://github.com/Xilinx/meta-xilinx/tree/master/README.building.md)
* [Booting Image Instructions](https://github.com/Xilinx/meta-xilinx/tree/master/README.booting.md)
