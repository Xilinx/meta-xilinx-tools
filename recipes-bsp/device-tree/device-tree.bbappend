require ${@'device-tree_xsct.inc' if d.getVar('XILINX_WITH_ESW') == 'xsct' else ''}
require ${@'device-tree_xsct_qemu.inc' if d.getVar('XILINX_WITH_ESW') == 'xsct' else ''}

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SDFEC_EXTRA_DT_INCLUDE_FILES ??= ""
SDFEC_EXTRA_DT_INCLUDE_FILES:zcu111-zynqmp = " system-zcu111.dtsi"

EXTRA_DT_INCLUDE_FILES:append = "${@' ${SDFEC_EXTRA_DT_INCLUDE_FILES}' if d.getVar('ENABLE_SDFEC_DT') == '1' else ''}"
EXTRA_DT_INCLUDE_FILES:append:vek280-versal = " system-vek280.dtsi"
EXTRA_DT_INCLUDE_FILES:append:qemu-versal-net = " system-qemu-versal-net.dtsi"
