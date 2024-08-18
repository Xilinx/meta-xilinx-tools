XILINX_XSCT_VERSION ??= "${@d.getVar("XILINX_RELEASE_VERSION").replace('v','')}"
ESDK_LOCALCONF_ALLOW:append = " XILINX_XSCT_VERSION"

HOSTTOOLS += "ps"

BUILDCFG_VARS:append = " XILINX_XSCT_VERSION"

# Default to XSCT version matching XILINX_RELEASE_VERSION
PREFERRED_VERSION_xsct-native ?= "${XILINX_XSCT_VERSION}"

PREFERRED_VERSION_esw ?= "${XILINX_XSCT_VERSION}"
PREFERRED_VERSION_plm-firmware  ?= "${PREFERRED_VERSION_esw}%"
PREFERRED_VERSION_psm-firmware  ?= "${PREFERRED_VERSION_esw}%"
PREFERRED_VERSION_pmu-firmware  ?= "${PREFERRED_VERSION_esw}%"
PREFERRED_VERSION_fsbl-firmware ?= "${PREFERRED_VERSION_esw}%"

PREFERRED_VERSION_external-hdf          ?= "${XILINX_XSCT_VERSION}%"

PREFERRED_VERSION_openamp-fw-echo-testd ?= "${XILINX_XSCT_VERSION}%"
PREFERRED_VERSION_openamp-fw-mat-muld   ?= "${XILINX_XSCT_VERSION}%"
PREFERRED_VERSION_openamp-fw-rpc-demo   ?= "${XILINX_XSCT_VERSION}%"

require conf/xsct-tarball.inc
