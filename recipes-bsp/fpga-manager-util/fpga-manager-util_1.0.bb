SUMMARY = "Recipe to generate necessary artifacts to use fpga-manager"
DESCRIPTION = "This recipe generates bin and dtbo files to load/unload overlays using fpga-manager-script"

LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://xadcps/data/xadcps.mdd;md5=f7fa1bfdaf99c7182fc0d8e7fd28e04a"

inherit deploy xsctbase xsctyaml
require recipes-bsp/device-tree/device-tree.inc

S = "${WORKDIR}/git"
B = "${WORKDIR}/build"

PV = "xilinx+git${SRCPV}"

FILESEXTRAPATHS_append := ":${XLNX_SCRIPTS_DIR}"

SRC_URI_append = " \
        file://multipleHDF.tcl \
        file://base-hsi.tcl \
        "
DEPENDS += "\
    virtual/hdf \
    virtual/bitstream \
    virtual/dtb \
    dtc-native \
    bootgen-native \
"

PACKAGE_ARCH ?= "${MACHINE_ARCH}"
COMPATIBLE_MACHINE ?= "^$"
COMPATIBLE_MACHINE_zynqmp = ".*"
COMPATIBLE_MACHINE_zynq = ".*"

XSCTH_SCRIPT = "${WORKDIR}/multipleHDF.tcl"
XSCTH_BUILD_CONFIG ?= 'Release'

DTS_INCLUDE ?= "${WORKDIR}"
DT_PADDING_SIZE ?= "0x1000"

DEVICETREE_FLAGS ?= " \
                -R 8 -p ${DT_PADDING_SIZE} -b 0 -@ -H epapr \
                ${@' '.join(['-i %s' % i for i in d.getVar('DTS_INCLUDE').split()])} \
               "
DEVICETREE_PP_FLAGS ?= " \
                -nostdinc -Ulinux -x assembler-with-cpp \
                ${@' '.join(['-I%s' % i for i in d.getVar('DTS_INCLUDE').split()])} \
                "
HDF_EXT ?= "xsa"
EXTRA_HDF ?= ""
XSCTH_HDF ?= "${WORKDIR}${EXTRA_HDF}"
XSCTH_MISC = " -hdf_type ${HDF_EXT}"
HDF_LIST = ""

YAML_OVERLAY_CUSTOM_DTS = "pl-final.dts"

do_fetch[cleandirs] = "${XSCTH_HDF}"
do_configure[cleandirs] = "${XSCTH_WS}"

do_configure_append () {
    for hdf in ${HDF_LIST}; do
        customfile=${WORKDIR}${EXTRA_HDF}/${hdf}.dtsi
        if [ -f "${customfile}" ];then
            echo "Using pl-custom.dtsi from: ${EXTRA_HDF}/${hdf}.dtsi"
            cp ${customfile} ${XSCTH_WS}/${hdf}/pl-custom.dtsi
        fi
    done
}

generate_bin() {
    bitname=`basename ${BITPATH}`
    printf "all:\n{\n\t`ls ${BITPATH}`\n}" > ${hdf}.bif
    bootgen -image ${hdf}.bif -arch ${SOC_FAMILY} -o ${bitname}.bin_${hdf} -w on ${@bb.utils.contains('SOC_FAMILY','zynqmp','','-process_bitstream bin',d)}

    #need this as with -process_bitstream flag bin file is automatically created in same dir as bitstream
    if [ "${SOC_FAMILY}" = "zynq" ]; then
            cp ${BITPATH}.bin ./${bitname}.bin_${hdf}
    fi

    if [ ! -e "${bitname}.bin_${hdf}" ]; then
            bbfatal "bootgen failed. Enable -log debug with bootgen and check logs"
    fi
}
do_compile() {

        for hdf in ${HDF_LIST}; do

                #generate .dtbo
                DTS_FILE=${XSCTH_WS}/${hdf}/pl-final.dts
                #use the existance of the '/plugin/' tag to detect overlays
                #checking pl.dtsi but compiling pl-final.dts as pl-final.dts just includes
                #both pl.dtsi and pl-custom.dtsi
                if grep -qse "/plugin/;" ${XSCTH_WS}/${hdf}/pl.dtsi; then
                        ${BUILD_CPP} ${DEVICETREE_PP_FLAGS} -o ${hdf}-pl-final.dts.pp ${DTS_FILE}
                        dtc ${DEVICETREE_FLAGS} -I dts -O dtb -o ${hdf}.dtbo ${hdf}-pl-final.dts.pp
                else
                        #not an error
                        echo "${DTS_FILE} is not an overlay!"
                fi

                #generate .bin
                if [ "${SOC_FAMILY}" != "versal" ]; then
                    BITPATH=${XSCTH_WS}/${hdf}/*.bit
                    generate_bin
                else
                    #partial pdi in xsa is not yet supported, will need to modify this part once supported
                    echo "TODO"
                fi
        done

        #generate bin file for base hdf and copy over dtb file
        if [ ! -e "${RECIPE_SYSROOT}/boot/devicetree/pl-final.dtbo" ]; then
                echo "base dtbo was not generated.  Either base design has no pl.dtsi or dtbo was not generated. Please check logs if dtbo was expected"
        else
                cp ${RECIPE_SYSROOT}/boot/devicetree/pl-final.dtbo ${XSCTH_WS}/base.dtbo

                if [ "${SOC_FAMILY}" != "versal" ]; then
                    BITPATH=${RECIPE_SYSROOT}/boot/bitstream/*.bit
                    hdf="base"
                    generate_bin
                else
                    #partial pdi in xsa is not yet supported, will need to modify this part once supported
                    echo "TODO"
                fi
        fi
}

do_install() {
        install -d ${D}${nonarch_base_libdir}/firmware/xilinx/base
        if [ -e "base.dtbo" ]; then
            #install base hdf artifacts
            install -Dm 0644 base.dtbo ${D}${nonarch_base_libdir}/firmware/xilinx/base/base.dtbo
            if [ "${SOC_FAMILY}" != "versal" ]; then
                newname=`basename *.bit.bin_base | awk -F '.bit.bin_' '{print $1}'`
                install -Dm 0644 *.bit.bin_base ${D}${nonarch_base_libdir}/firmware/xilinx/base/${newname}.bit.bin
            else
                #partial pdi in xsa is not yet supported, will need to modify this part once supported
                echo "TODO"
            fi
        fi
        for hdf in ${HDF_LIST}; do
                install -Dm 0644 ${hdf}.dtbo ${D}${nonarch_base_libdir}/firmware/xilinx/${hdf}/${hdf}.dtbo
                if [ "${SOC_FAMILY}" != "versal" ]; then
                    newname=`basename *.bit.bin_${hdf} | awk -F '.bit.bin_' '{print $1}'`
                    install -Dm 0644 *.bit.bin_${hdf} ${D}${nonarch_base_libdir}/firmware/xilinx/${hdf}/${newname}.bit.bin
                else
                    #partial pdi in xsa is not yet supported, will need to modify this part once supported
                    echo "TODO"
                fi
        done
}

ALLOW_EMPTY_${PN} = "1"

python () {
        if d.getVar('FPGA_MNGR_RECONFIG_ENABLE') == '1':
                extra = d.getVar('EXTRA_HDF')
                pn = d.getVar('PN')
                baselib = d.getVar('nonarch_base_libdir')
                packages = d.getVar('PACKAGES').split()

                #package base hdf
                packages.append(pn + '-base')
                d.setVar('FILES_' + pn + '-base', baselib + '/firmware/xilinx/base')
                d.setVar('PACKAGES', ' '.join(packages))
                d.setVar('RDEPENDS_' + pn , pn + '-base')

                if extra:
                        hdflist = []
                        hdffullpath = []
                        import glob
                        for hdf in glob.glob(d.getVar('EXTRA_HDF')+"/*." + d.getVar('HDF_EXT')):
                                name = os.path.splitext(os.path.basename(hdf))[0]
                                hdflist.append(name)
                                hdffullpath.append(hdf)
                                dtsifile = d.getVar('EXTRA_HDF') + "/" + name + ".dtsi"
                                if os.path.isfile(dtsifile):
                                    hdffullpath.append(dtsifile)

                                d.setVar('FILES_' + pn + '-' + name, baselib + '/firmware/xilinx/' + name )
                        d.setVar('HDF_LIST', ' '.join(hdflist))
                        extrapackages = [pn + '-{0}'.format(i) for i in hdflist]
                        packages = packages + extrapackages
                        d.setVar('PACKAGES', ' '.join(packages))
                        #Add all extra hdfs to src_uri
                        d.setVar('SRC_URI', ' '.join([' file://{0}'.format(i) for i in hdffullpath] + d.getVar('SRC_URI').split()))

                        #put back base package when setting RDEPENDS
                        extrapackages.append(pn + '-base')
                        d.setVar('RDEPENDS_'+pn , ' '.join(extrapackages))
}
