inherit deploy update-alternatives

BINARY_NAME ?= "${PN}"
BINARY_EXT ?= ".elf"

BINARY_ID = "${@d.getVar('SRCPV') if d.getVar('SRCPV') else d.getVar('PR') }"

BOOTBIN_BIF_FRAGMENT ?= ""
do_install[vardeps] += "BOOTBIN_BIF_FRAGMENT"

python() {
    pn = d.getVar("PN")
    binaryid = d.getVar('BINARY_ID')
    if bb.data.inherits_class('externalsrc', d):
        binaryid = '999'
    binaryname = d.getVar('BINARY_NAME')
    binaryext = d.getVar('BINARY_EXT')
    d.setVarFlag('ALTERNATIVE_TARGET', pn, '/boot/' + binaryname +'-'+ binaryid + binaryext)
    d.setVarFlag('ALTERNATIVE_LINK_NAME', pn, '/boot/' + pn + binaryext)
}

do_install_append(){
    if [ -n "${BOOTBIN_BIF_FRAGMENT}" ]
    then
        install -d ${D}/boot/
        echo "${BOOTBIN_BIF_FRAGMENT}" > ${D}/boot/${PN}.bif
    fi
}

#on package upgrade, update softlink, regenerate bif file, regenerate boot.bin
pkg_postinst_${PN} () {
    #!/bin/sh -e
    if [ -z "$D" ]; then
        ${bindir}/updateboot
        bootgen -image /boot/bootgen.bif -arch ${SOC_FAMILY} ${BOOTGEN_EXTRA_ARGS} -w -o /boot/BOOT.bin
    fi
}

pkg_preinst_${PN} () {
    rm -rf $D${nonarch_libdir}/opkg/alternatives/${PN}
}

ALTERNATIVE_${PN} = "${PN}"

SYSROOT_DIRS += "/boot"

FILES_${PN} += "/boot/${PN}.bif"
