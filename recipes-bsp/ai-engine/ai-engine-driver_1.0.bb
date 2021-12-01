SUMMARY = "Xilinx AI Engine runtime"
DESCRIPTION = "This library provides APIs for the runtime support of the Xilinx AI Engine IP"

require ai-engine.inc

AIEDIR = "${S}/XilinxProcessorIPLib/drivers/aiengine"
S = "${WORKDIR}/git"
I = "${AIEDIR}/include"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE:versal-ai-core = "versal-ai-core"
PV = "1.0"

DEPENDS = "libmetal openamp"
RDEPENDS:${PN} = "libmetal"
PROVIDES = "libxaiengine"
RPROVIDES:${PN}	= "libxaiengine"

# The makefile isn't ready for parallel execution at the moment
PARALLEL_MAKE = "-j 1"

EXTRA_OEMAKE = "-C ${AIEDIR}/src -f Makefile.Linux"

do_compile(){
	oe_runmake
}

do_install(){
	install -d ${D}${includedir}
	install ${I}/*.h ${D}${includedir}/
	install -d ${D}${includedir}/xaiengine
	install ${I}/xaiengine/*.h ${D}${includedir}/xaiengine/
	install -d ${D}${libdir}
	cp -dr ${AIEDIR}/src/*.so* ${D}${libdir}
}

PACKAGE_ARCH:versal-ai-core = "${SOC_VARIANT_ARCH}"
