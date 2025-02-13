require ${@'device-tree_xsct.inc' if d.getVar('XILINX_WITH_ESW') == 'xsct' else ''}
require ${@'device-tree_xsct_qemu.inc' if d.getVar('XILINX_WITH_ESW') == 'xsct' else ''}
