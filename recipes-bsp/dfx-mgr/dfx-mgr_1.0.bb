SUMMARY  = "Xilinx dfx-mgr libraries"
DESCRIPTION = "Xilinx Runtime User Space Libraries and Binaries"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=d67bcef754e935bf77b6d7051bd62b5e"

REPO ?= "git://github.com/Xilinx/dfx-mgr.git;protocol=https"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH', True) != '']}"
SRC_URI = "${REPO};${BRANCHARG}"

BRANCH = "xlnx_rel_v2021.2"
SRCREV = "c3c0553089f9243d20825ee7f33c88260cbd0477"
SOVERSION = "1.0"

S = "${WORKDIR}/git"

inherit cmake update-rc.d

DEPENDS += " libwebsockets inotify-tools libdfx zocl libdrm"
EXTRA_OECMAKE += " \
		-DCMAKE_INCLUDE_PATH=${S}/include \
		"
INITSCRIPT_NAME = "dfx-mgr.sh"
INITSCRIPT_PARAMS = "start 99 S ."

do_install(){
	install -d ${D}${bindir}
	install -d ${D}${libdir}
	install -d ${D}${includedir}
	install -d ${D}${sysconfdir}/init.d/
	install -d ${D}${base_libdir}/firmware/xilinx
	install -d ${D}${sysconfdir}/dfx-mgrd

	cp ${B}/example/sys/linux/dfx-mgrd-static ${D}${bindir}/dfx-mgrd
	cp ${B}/example/sys/linux/dfx-mgr-client-static ${D}${bindir}/dfx-mgr-client
	chrpath -d ${D}${bindir}/dfx-mgrd
	chrpath -d ${D}${bindir}/dfx-mgr-client
	install -m 0755 ${S}/src/dfx-mgr.sh ${D}${sysconfdir}/init.d/
	install -m 0755 ${S}/src/daemon.conf ${D}${sysconfdir}/dfx-mgrd/
	install -m 0644 ${S}/src/dfxmgr_client.h ${D}${includedir}

	oe_soinstall ${B}/src/libdfx-mgr.so.${SOVERSION} ${D}${libdir}
}

FILES_${PN} += "${base_libdir}/firmware/xilinx"
