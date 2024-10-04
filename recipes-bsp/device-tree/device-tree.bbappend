require ${@'device-tree_xsct.inc' if d.getVar('XILINX_WITH_ESW') == 'xsct' else ''}
require ${@'device-tree_xsct_qemu.inc' if d.getVar('XILINX_WITH_ESW') == 'xsct' else ''}

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SDFEC_EXTRA_OVERLAYS ??= ""
SDFEC_EXTRA_OVERLAYS:zcu111-zynqmp = "system-zcu111.dtsi"

EXTRA_OVERLAYS:append = "${@' ${SDFEC_EXTRA_OVERLAYS}' if d.getVar('ENABLE_SDFEC_DT') == '1' else ''}"
EXTRA_OVERLAYS:append:vek280-versal = " system-vek280.dtsi"
