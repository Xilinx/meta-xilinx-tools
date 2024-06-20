addhandler xsct_bbappend_distrocheck
xsct_bbappend_distrocheck[eventmask] = "bb.event.SanityCheck"
python xsct_bbappend_distrocheck() {
    skip_check = e.data.getVar('SKIP_META_XILINX_TOOLS_SANITY_CHECK') == "1"
    if e.data.getVar('XILINX_WITH_ESW') != 'xsct' and not skip_check:
        bb.warn("You have included the meta-xilinx-tools layer, but \
it has not been enabled using XILINX_WITH_ESW in your configuration. Some \
bbappend files and preferred version setting may not take effect. See the \
meta-xilinx-tools README for details.")
    elif e.data.getVar('XILINX_WITH_ESW') == 'xsct':
        bb.warn("XSCT has been deprecated. It will still be available for \
several releases. In the future, it's recommended to start new projects \
with SDT workflow.")
}
