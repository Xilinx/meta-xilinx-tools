SUMMARY = "Xilinx AI Engine FAL(Functional Abstraction Layer)"
DESCRIPTION = "AIE FAL provides functional abstraction APIs for runtime support of Xilinx AI Engine IP"

require ai-engine.inc

SECTION	= "devel"

XAIEFAL_DIR ?= "XilinxProcessorIPLib/drivers/aiefal"
S = "${WORKDIR}/git"

COMPATIBLE_MACHINE = "^$"
COMPATIBLE_MACHINE_versal-ai-core = "versal-ai-core"

IOBACKENDS ?= "Linux"

PROVIDES = "aiefal"
ALLOW_EMPTY_${PN} = "1"

inherit pkgconfig cmake yocto-cmake-translation

DEPENDS = "libxaiengine"

OECMAKE_SOURCEPATH = "${S}/${XAIEFAL_DIR}"

EXTRA_OECMAKE = "-DWITH_TESTS=OFF "
EXTRA_OECMAKE_append = "${@'-DWITH_EXAMPLES=ON' if d.getVar('WITH_EXAMPLES') == 'y' else '-DWITH_EXAMPLES=OFF'}"

FILES_${PN}-demos = " \
    ${bindir}/* \
"

PACKAGE_ARCH_versal-ai-core = "${SOC_VARIANT_ARCH}"
