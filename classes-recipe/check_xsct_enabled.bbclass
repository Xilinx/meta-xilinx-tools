python() {
    if d.getVar('XILINX_WITH_ESW') != 'xsct':
        raise bb.parse.SkipRecipe("This package requires xsct, which is not enabled.  XILINX_WITH_ESW set to '%s'." % d.getVar('XILINX_WITH_ESW'))
}
