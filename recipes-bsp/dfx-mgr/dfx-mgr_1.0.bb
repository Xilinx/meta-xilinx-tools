SUMMARY  = "Xilinx dfx-mgr libraries"
DESCRIPTION = "Xilinx Runtime User Space Libraries and Binaries"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=d67bcef754e935bf77b6d7051bd62b5e"

REPO ?= "git://github.com/Xilinx/dfx-mgr.git;protocol=https"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH', True) != '']}"
SRC_URI = "${REPO};${BRANCHARG}"

BRANCH = "master"
SRCREV = "9989200612b149d926077c5c8096f95b9a74e5ff"

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
	install -d ${D}${sysconfdir}/init.d/
	install -d ${D}${base_libdir}/firmware/xilinx
	install -d ${D}/etc/dfx-mgrd

	cp ${B}/example/sys/linux/dfx-mgrd-static ${D}${bindir}/dfx-mgrd
	cp ${B}/example/sys/linux/dfx-mgr-client-static ${D}${bindir}/dfx-mgr-client
	chrpath -d ${D}${bindir}/dfx-mgrd
	chrpath -d ${D}${bindir}/dfx-mgr-client
	install -m 0755 ${S}/src/dfx-mgr.sh ${D}${sysconfdir}/init.d/
	install -m 0755 ${S}/src/daemon.conf ${D}/etc/dfx-mgrd/
}

FILES_${PN} += "${base_libdir}/firmware/xilinx"
