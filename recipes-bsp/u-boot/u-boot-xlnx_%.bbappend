python __anonymous () {
    #check if there are any dtb providers
    providerdtb = d.getVar("PREFERRED_PROVIDER_virtual/dtb")
    if providerdtb:
       d.appendVarFlag('do_configure', 'depends', ' virtual/dtb:do_populate_sysroot')
       if d.getVar("DTB_NAME") is not None:
            d.setVar('DTB_NAME', d.getVar('BASE_DTS')+ '.dtb')

    if d.getVar('UBOOT_IMAGE_BLOB') == "1":
        d.appendVarFlag('do_compile', 'postfuncs', ' do_blob_generate')
}
BASE_DTS ?= "system-top"
DTB_PATH ?= "/boot/devicetree"
DTB_NAME ?= ""

EXTRA_OEMAKE += "${@'EXT_DTB=${RECIPE_SYSROOT}/${DTB_PATH}/${DTB_NAME}' if (d.getVar('DTB_NAME') != '') else '' }"

dtblob_emit_its_section() {
	case $2 in
	header)
		cat << EOF > $1
/dts-v1/;

/ {
	description = "DT Blob Creation";
EOF
	;;
	imagestart)
		cat << EOF >> $1

	images {
EOF
	;;
	confstart)
		cat << EOF >> $1

	configurations {
EOF
	;;
	sectend)
		cat << EOF >> $1
	};
EOF
	;;
	fitend)
		cat << EOF >> $1
};
EOF
	;;
	esac
}

dtblob_emit_dtb () {
	dtb_csum="md5"
	cat << EOF >> $1
		fdt-$2 {
			description = "$(basename $3 .dtb)";
			data = /incbin/("$3");
			type = "flat_dt";
			arch = "arm64";
			compression = "none";
			hash-1 {
				algo = "$dtb_csum";
				};
			};
EOF
}

#1.file name
#2.config node
#3.config node description
#4.DTB count
dtblob_emit_config () {
	default_dtb=1
	if [ $4 -eq $default_dtb ]; then
		cat << EOF >> $1
		default = "config_$2";
EOF
	fi
	cat  << EOF >> $1
		config_$4 {
			description = "$3";
			fdt = "fdt-$2";
		};
EOF
}

inherit image-artifact-names
UBOOT_IMAGE_BLOB ?= ""
UBOOT_IMAGE_BLOB:k26 ?= "1"
DT_BLOB_DIR ?= "${B}/arch/arm/dts/dt-blob"
DEPENDS += "u-boot-mkimage-native"
PREFIX ?= "smk"
UBOOT_BLOB_NAME ?= "${MACHINE}-fit-dtb${IMAGE_VERSION_SUFFIX}.blob"

IMPORT_CC_DTBS ?= ""
IMPORT_CC_DTBS:k26 ?= " \
		zynqmp-sck-kv-g-revA.dtbo:zynqmp-${PREFIX}-k26-xcl2g-revA-sck-kv-g-revA.dtb \
		zynqmp-sck-kv-g-revB.dtbo:zynqmp-${PREFIX}-k26-xcl2g-revA-sck-kv-g-revB.dtb \
		zynqmp-sck-kr-g-revA.dtbo:zynqmp-${PREFIX}-k26-xcl2g-revA-sck-kr-g-revA.dtb \
                "

CC_DTBS_DUP ?= ""
CC_DTBS_DUP:k26 ?= " \
		zynqmp-${PREFIX}-k26-xcl2g-revA-sck-kv-g-revA:zynqmp-${PREFIX}-k26-xcl2g-revB-sck-kv-g-revA \
		zynqmp-${PREFIX}-k26-xcl2g-revA-sck-kv-g-revA:zynqmp-${PREFIX}-k26-xcl2g-rev1.0-sck-kv-g-revA \
		zynqmp-${PREFIX}-k26-xcl2g-revA-sck-kv-g-revB:zynqmp-${PREFIX}-k26-xcl2g-revB-sck-kv-g-revB \
		zynqmp-${PREFIX}-k26-xcl2g-revA-sck-kv-g-revB:zynqmp-${PREFIX}-k26-xcl2g-rev1.0-sck-kv-g-revB \
		zynqmp-${PREFIX}-k26-xcl2g-revA-sck-kv-g-revB:zynqmp-${PREFIX}-k26-xcl2g-rev1.0-sck-kv-g-rev1.0 \
		zynqmp-${PREFIX}-k26-xcl2g-revA-sck-kr-g-revA:zynqmp-${PREFIX}-k26-xcl2g-revB-sck-kr-g-revA \
		zynqmp-${PREFIX}-k26-xcl2g-revA-sck-kr-g-revA:zynqmp-${PREFIX}-k26-xcl2g-rev1.0-sck-kr-g-revA \
		"

MKIMAGE_DTBLOB_OPTS ?= "-E -B 0x8"
do_compile[cleandirs] += "${DT_BLOB_DIR}"

do_blob_generate () {
	oe_runmake -C ${S} O=${B} dtbs
	install -d ${DT_BLOB_DIR}
	for CC_DTB in ${IMPORT_CC_DTBS}; do
		DTBO=$(echo $CC_DTB | cut -d: -f1)
		DTB=$(echo $CC_DTB | cut -d: -f2)
		bbnote "fdtoverlay -o ${DT_BLOB_DIR}/${DTB} -i ${RECIPE_SYSROOT}/${DTB_PATH}/${DTB_NAME} ${B}/arch/arm/dts/${DTBO}"
		if [ -f ${B}/arch/arm/dts/${DTBO} ]; then
		fdtoverlay -o ${DT_BLOB_DIR}/${DTB} \
			-i ${RECIPE_SYSROOT}/${DTB_PATH}/${DTB_NAME} ${B}/arch/arm/dts/${DTBO}
		fi
	done

	cd ${DT_BLOB_DIR}
	its_filename="dtblob.its"
	dtblob_emit_its_section "${its_filename}" "header"
	dtblob_emit_its_section "${its_filename}" "imagestart"
	for dtb in ${RECIPE_SYSROOT}/${DTB_PATH}/${DTB_NAME} $(find ${DT_BLOB_DIR} -name '*.dtb' | sort); do
		dtblob_emit_dtb "${its_filename}" "$(basename $dtb .dtb)" "$dtb"
	done
	dtblob_emit_its_section "${its_filename}" "sectend"
	dtblob_emit_its_section "${its_filename}" "confstart"
	dtbcount=1
	for dtb in ${RECIPE_SYSROOT}/${DTB_PATH}/${DTB_NAME} $(find ${DT_BLOB_DIR} -name '*.dtb' | sort); do
		dtblob_emit_config "${its_filename}" "$(basename $dtb .dtb)" "$(basename $dtb .dtb)" "$dtbcount"
		dtbcount=`expr $dtbcount + 1`
	done

	for CC_DTB_DUP in ${CC_DTBS_DUP}; do
		DTB=$(echo $CC_DTB_DUP | cut -d: -f1)
		DUP_DTB=$(echo $CC_DTB_DUP | cut -d: -f2)
		if [ -f ${DT_BLOB_DIR}/${DTB}.dtb ]; then
			bbnote "Node ${DT_BLOB_DIR}/${DTB} with ${DT_BLOB_DIR}/${DUP_DTB}"
			dtblob_emit_config "${its_filename}" "$DTB" "$DUP_DTB" "$dtbcount"
			dtbcount=`expr $dtbcount + 1`
		fi
	done

	dtblob_emit_its_section "${its_filename}" "sectend"
	dtblob_emit_its_section "${its_filename}" "fitend"

	mkimage ${MKIMAGE_DTBLOB_OPTS} -f "${its_filename}" "${UBOOT_BLOB_NAME}"
}

UBOOTELF_NODTB_IMAGE ?= "u-boot-nodtb.elf"
UBOOTELF_NODTB_BINARY ?= "u-boot"
do_deploy:prepend() {
    cd ${B}

    if [ -f "${UBOOTELF_NODTB_BINARY}" ]; then
            install ${UBOOTELF_NODTB_BINARY} ${DEPLOYDIR}/${UBOOTELF_NODTB_IMAGE}
    fi

    #following lines are from uboot-sign.bbclass, vars are defined there
    if [ -e "${UBOOT_DTB_BINARY}" ]; then
            install ${UBOOT_DTB_BINARY} ${DEPLOYDIR}/${UBOOT_DTB_IMAGE}
            ln -sf ${UBOOT_DTB_IMAGE} ${DEPLOYDIR}/${UBOOT_DTB_BINARY}
            ln -sf ${UBOOT_DTB_IMAGE} ${DEPLOYDIR}/${UBOOT_DTB_SYMLINK}
    fi
    if [ -f "${UBOOT_NODTB_BINARY}" ]; then
            install ${UBOOT_NODTB_BINARY} ${DEPLOYDIR}/${UBOOT_NODTB_IMAGE}
            ln -sf ${UBOOT_NODTB_IMAGE} ${DEPLOYDIR}/${UBOOT_NODTB_SYMLINK}
            ln -sf ${UBOOT_NODTB_IMAGE} ${DEPLOYDIR}/${UBOOT_NODTB_BINARY}
    fi
    if [ -e "${DT_BLOB_DIR}/${UBOOT_BLOB_NAME}" ]; then
            install -m 0644 ${DT_BLOB_DIR}/${UBOOT_BLOB_NAME} ${DEPLOYDIR}/
            ln -srf ${DEPLOYDIR}/${UBOOT_BLOB_NAME} ${DEPLOYDIR}/fit-dtb.blob
    fi
}
