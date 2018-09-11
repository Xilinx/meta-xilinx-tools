SUMMARY = "Recipe to generate necessary artifacts to use fpga-manager"
DESCRIPTION = "This recipe generates bin and dtbo files to load/unload overlays using fpga-manager-script"

LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://xadcps/data/xadcps.mdd;md5=f7fa1bfdaf99c7182fc0d8e7fd28e04a"

inherit deploy xsctbase xsctyaml

REPO ??= "git://gitenterprise.xilinx.com/Linux/device-tree-xlnx.git;protocol=https"
BRANCH ??= "master"
BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH', True) != '']}"
SRC_URI = "${REPO};${BRANCHARG}"

S = "${WORKDIR}/git"
B = "${WORKDIR}/build"

SRCREV ?= "${AUTOREV}"
PV = "xilinx+git${SRCPV}"

FILESEXTRAPATHS_append := ":${XLNX_SCRIPTS_DIR}"

SRC_URI_append = " \
	file://multipleHDF.tcl \
	file://base-hsi.tcl \
	"
DEPENDS = "virtual/hdf virtual/bitstream virtual/dtb dtc-native"

PACKAGE_ARCH ?= "${MACHINE_ARCH}"
COMPATIBLE_MACHINE ?= "^$"
COMPATIBLE_MACHINE_zynqmp = ".*"

XSCTH_SCRIPT = "${WORKDIR}/multipleHDF.tcl"
XSCTH_BUILD_CONFIG ?= 'Release'

DTS_INCLUDE ?= "${WORKDIR}"
DT_PADDING_SIZE ?= "0x1000"

DEVICETREE_FLAGS ?= " \
		-R 8 -p ${DT_PADDING_SIZE} -b 0 -@ -H epapr \
		${@' '.join(['-i %s' % i for i in d.getVar('DTS_INCLUDE', True).split()])} \
               "
DEVICETREE_PP_FLAGS ?= " \
		-nostdinc -Ulinux -x assembler-with-cpp \
		${@' '.join(['-I%s' % i for i in d.getVar('DTS_INCLUDE', True).split()])} \
		"
HDF_EXT ?= "hdf"
EXTRA_HDF ?= ""
XSCTH_HDF ?= "${B}/extra_hdf"
XSCTH_MISC = " -hdf_type ${HDF_EXT}"

do_configure_prepend() {
    if [ -d "${EXTRA_HDF}" ]; then
        install -d ${XSCTH_HDF}
        install -m 0644 ${EXTRA_HDF}/* ${XSCTH_HDF}
    fi
}



do_compile() {

	for DTS_FILE in `ls ${XSCTH_WS}/*/*.dtsi`; do
		DTS_NAME=`basename $(dirname ${DTS_FILE})`
		#use the existance of the '/plugin/' tag to detect overlays
		if grep -qse "/plugin/;" ${DTS_FILE}; then

			${BUILD_CPP} ${DEVICETREE_PP_FLAGS} -o ${DTS_NAME}-$(basename ${DTS_FILE}).pp ${DTS_FILE}
			dtc ${DEVICETREE_FLAGS} -I dts -O dtb -o ${DTS_NAME}.dtbo ${DTS_NAME}-$(basename ${DTS_FILE}).pp
		else
            #not an error
			echo "${DTS_FILE} is not an overlay!"
		fi
	done

	for BIT in `ls ${XSCTH_WS}/*/*.bit`; do
		name=`basename $(dirname ${BIT})`
		bitname=`basename ${BIT}`
		echo -e "all:\n{\n\t${BIT}\n}" > ${name}.bif
		bootgen -image ${name}.bif -arch zynqmp -o ${bitname}.bin_${name} -w
	done

	#generate bin file for base hdf and copy over dtb file
	basebit=`ls ${RECIPE_SYSROOT}/boot/bitstream/*`
	bitname=`basename $basebit`
	echo -e "all:\n{\n\t${basebit}\n}" > base.bif
	bootgen -image base.bif -arch zynqmp -o ${bitname}.bin_base -w

    cp ${RECIPE_SYSROOT}/boot/devicetree/*.dtb ${B}/base.dtb
}
do_install() {
	#install base hdf
	install -Dm 0644 base.dtb ${D}/lib/firmware/base/base.dtb

	for obj in `ls *.dtbo`; do
		hdfname=`basename -s .dtbo ${obj}`
		install -Dm 0644 ${obj} ${D}/lib/firmware/${hdfname}/${obj}
	done
	for obj in `ls *.bit.bin_*`; do
		hdfname=`basename ${obj} | awk -F '.bit.bin_' '{print $2}'`
		newname=`basename ${obj} | awk -F '.bit.bin_' '{print $1}'`
		install -Dm 0644 ${obj} ${D}/lib/firmware/${hdfname}/${newname}.bit.bin
	done
}

ALLOW_EMPTY_${PN} = "1"

python () {
	if bb.utils.contains("IMAGE_FEATURES", "fpga-manager", True, False, d):
		extra = d.getVar('EXTRA_HDF', True)
		pn = d.getVar('PN')
		baselib = d.getVar('base_libdir')
		packages = d.getVar('PACKAGES').split()
		extrapackages = []

		#package base hdf
		packages.append(pn + '-base')
		d.setVar('FILES_' + pn + '-base', baselib + '/firmware/base')
		d.setVar('PACKAGES', ' '.join(packages))
		d.setVar('RDEPENDS_' + pn , pn + '-base')

		if extra:
			import glob
			for hdf in glob.glob(d.getVar('EXTRA_HDF', True)+"/*.hdf"):
				name = os.path.splitext(os.path.basename(hdf))[0]
				extrapackages.append(pn + '-' + name)
				d.setVar('FILES_' + pn + '-' + name, baselib + '/firmware/' + name )
			packages = packages + extrapackages
			d.setVar('PACKAGES', ' '.join(packages))

			#put back base package when setting RDEPENDS
			extrapackages.append(pn + '-base')
			d.setVar('RDEPENDS_'+pn , ' '.join(extrapackages))
}
