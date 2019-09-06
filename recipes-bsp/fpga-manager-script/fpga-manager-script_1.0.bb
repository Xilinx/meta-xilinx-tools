SUMMARY = "Install user script to support fpga-manager"
DESCRIPTION = "Install user script that loads and unloads overlays using kernel fpga-manager"
LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://${WORKDIR}/fpgautil.c;beginline=1;endline=24;md5=101eeb5b9855c3d38b305e04d0455ca6"

SRC_URI = "\
	file://fpgautil.c \
	"
S = "${WORKDIR}"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

do_compile() {
	${CC} ${LDFLAGS} fpgautil.c -o fpgautil
}

do_install() {
        install -Dm 0755 ${S}/fpgautil ${D}${bindir}/fpgautil
}

FILES_${PN} = "\
        ${bindir}/fpgautil \
        "
