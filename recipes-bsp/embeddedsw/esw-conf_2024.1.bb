# Can't depend on esw since this is needed for setup!
inherit xlnx-embeddedsw

S = "${WORKDIR}/git"
B = "${WORKDIR}/build"

INHIBIT_DEFAULT_DEPS = "1"

python() {
    raise bb.parse.SkipRecipe(
        "%s is not available with the XSCT (meta-xilinx-tools) workflow, "
        "please remove the meta-xilinx-tools layer and enable "
        "meta-xilinx-standalone-sdt to use this recipe." % d.getVar('PN'))
}

BBCLASSEXTEND = "native nativesdk"
