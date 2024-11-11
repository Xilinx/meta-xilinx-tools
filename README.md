# meta-xilinx-tools

This layer enables AMD tools related metadata for MicroBlaze, Zynq, ZynqMP and
Versal devices.

See [XSCT Build Instructions](README.xsct.bsp.md) for XSCT build workflows.

## Maintainers, Mailing list, Patches

Please send any patches, pull requests, comments or questions for this layer to
the [meta-xilinx mailing list](https://lists.yoctoproject.org/g/meta-xilinx)
with ['meta-xilinx-tools'] in the subject:

	meta-xilinx@lists.yoctoproject.org

When sending patches, please make sure the email subject line includes
`[meta-xilinx-tools][<BRANCH_NAME>][PATCH]` and cc'ing the maintainers.

For more details follow the Yocto Project community patch submission guidelines,
as described in:

https://docs.yoctoproject.org/dev/contributor-guide/submit-changes.html#

`git send-email --to meta-xilinx@lists.yoctoproject.org *.patch`

> **Note:** When creating patches, please use below format. To follow best practice,
> if you have more than one patch use `--cover-letter` option while generating the
> patches. Edit the 0000-cover-letter.patch and change the title and top of the
> body as appropriate.

**Syntax:**
`git format-patch -s --subject-prefix="meta-xilinx-tools][<BRANCH_NAME>][PATCH" -1`

**Example:**
`git format-patch -s --subject-prefix="meta-xilinx-tools][scarthgap][PATCH" -1`

**Maintainers:**

	Mark Hatle <mark.hatle@amd.com>
	Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
	John Toomey <john.toomey@amd.com>
	Trevor Woerner <trevor.woerner@amd.com>
---

## Dependencies

This layer depends on: xsct and other layers

xsct-tarball class fetches the required xsct tool and installs it in the local
sysroots of Yocto build. All the recipes which depend xsct or bootgen will use
from sysroots. Please see the AMD EULA license file for xsct after
extracting the tarball.

Warning: XSCT has been deprecated. It will still be available for several release.
It is recommended to start new machines using the System Device Tree workflow, if
available. See meta-xilinx/meta-xilinx-standalone-sdt for more details.

Each release is dependent on the AMD XSCT release version. Please note that
xsct tools may not be backward compatible with embeddedsw repo. Meaning
2016.3 xsct tools might not work with older version on embeddedsw repo

	URI: https://git.yoctoproject.org/poky
	layers: meta, meta-poky
	branch: scarthgap

	URI: https://git.openembedded.org/meta-openembedded
	layers: meta-oe, meta-perl, meta-python, meta-filesystems, meta-gnome,
            meta-multimedia, meta-networking, meta-webserver, meta-xfce,
            meta-initramfs.
	branch: scarthgap

	URI: https://git.yoctoproject.org/meta-arm
	layers: meta-arm, meta-arm-toolchain
	branch: scarthgap

	URI:
        https://git.yoctoproject.org/meta-xilinx (official version)
        https://github.com/Xilinx/meta-xilinx (development and AMD release)
	layers: meta-xilinx-core, meta-xilinx-microblaze, meta-xilinx-bsp,
            meta-xilinx-standalone, meta-xilinx-vendor.
	branch: scarthgap or AMD release version (e.g. rel-v2024.2)
---

