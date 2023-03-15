# meta-xilinx-tools

This layer enables AMD Xilinx tools related metadata for MicroBlaze, Zynq,
ZynqMP and Versal devices.

## Maintainers, Mailing list, Patches

Please send any patches, pull requests, comments or questions for this layer to
the [meta-xilinx mailing list](https://lists.yoctoproject.org/g/meta-xilinx)
with ['meta-xilinx-tools'] in the subject:

	meta-xilinx@lists.yoctoproject.org

When sending patches, please make sure the email subject line includes
`[meta-xilinx-tools][<BRANCH_NAME>][PATCH]` and cc'ing the maintainers.

For more details follow the OE community patch submission guidelines, as described in:

https://www.openembedded.org/wiki/Commit_Patch_Message_Guidelines
https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded

`git send-email --to meta-xilinx@lists.yoctoproject.org *.patch`

> **Note:** When creating patches, please use below format. To follow best practice,
> if you have more than one patch use `--cover-letter` option while generating the
> patches. Edit the 0000-cover-letter.patch and change the title and top of the
> body as appropriate.

**Syntax:**
`git format-patch -s --subject-prefix="meta-xilinx-tools][<BRANCH_NAME>][PATCH" -1`

**Example:**
`git format-patch -s --subject-prefix="meta-xilinx-tools][langdale][PATCH" -1`

**Maintainers:**

	Mark Hatle <mark.hatle@amd.com>
	Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
	John Toomey <john.toomey@amd.com>
---

## Dependencies

This layer depends on: xsct and other layers

xsct-tarball class fetches the required xsct tool and installs it in the local
sysroots of Yocto build. All the recipes which depend xsct or bootgen will use
from sysroots. Please see the Xilinx EULA license file for xsct after
extracting the tarball.

Each release is dependent on the Xilinx XSCT release version. Please note that
xsct tools may not be backward compatible with embeddedsw repo. Meaning
2016.3 xsct tools might not work with older version on embeddedsw repo

	URI: https://git.yoctoproject.org/poky
	layers: meta, meta-poky
	branch: langdale

	URI: https://git.openembedded.org/meta-openembedded
	layers: meta-oe, meta-perl, meta-python, meta-filesystems, meta-gnome,
            meta-multimedia, meta-networking, meta-webserver, meta-xfce,
            meta-initramfs.
	branch: langdale

	URI:
        https://git.yoctoproject.org/meta-xilinx (official version)
        https://github.com/Xilinx/meta-xilinx (development and amd xilinx release)
	layers: meta-xilinx-core, meta-xilinx-microblaze, meta-xilinx-bsp,
            meta-xilinx-standalone, meta-xilinx-vendor.
	branch: langdale or amd xilinx release version (e.g. rel-v2023.1)
---

## Hardware Configuration using XSA

meta-xilinx-tools recipes depends on XSA to be provided.
As of the 2019.2 release, all design files were renamed from hdf to xsa.
But the variables and references to hdf will remain and renamed in the future release.

HDF_BASE can be set to git:// or file://

HDF_PATH will be git repository or the path containing HDF

For example:

* Using GIT subversion
```bash
HDF_BASE = "git://"
HDF_PATH = "github.com/Xilinx/hdf-examples.git"
HDF_NAME = "system.xsa"
HDF_MACHINE = "zcu102-zynqmp"
```
* Using XSA file path
```bash
HDF_BASE = "file://"
HDF_PATH = "/<absolute-path-to-xsa>/system.xsa"
```
---

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
Refer https://github.com/Xilinx/device-tree-xlnx/tree/xlnx_rel_v2023.1/device_tree/data/kernel_dtsi/2023.1/BOARD
for more details

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
YAML_DT_BOARD_FLAGS:pn-device-tree = "{BOARD versal-net-ipp-rev1.9}"
```

Note only Xilinx eval boards have the dtsi in DTG, for custom board one needs
to patch DTG to include the custom board dtsi and enable it using YAML
configuration.
