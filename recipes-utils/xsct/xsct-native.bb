SUMMARY = "Trigger XSCT to download and install"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

PV = "${TOOL_VER_MAIN}"

INHIBIT_DEFAULT_DEPS = "1"

BB_STRICT_CHECKSUM = "${VALIDATE_XSCT_CHECKSUM}"

# Set defaults for parsing without XSCT enabled.
XSCT_URL ??= "https://undefined/undefined"
XSCT_TARBALL ??= "undefined"

SRC_URI = "${XSCT_URL};downloadfilename=${XSCT_TARBALL}"
SRC_URI[sha256sum] = "${XSCT_CHECKSUM}"

inherit check_xsct_enabled native

S = "${WORKDIR}/Vitis"
B = "${S}"

SYSROOT_DIRS_NATIVE += "${STAGING_DIR_NATIVE}/Vitis/${PV}"

python do_fetch() {
    src_uri = (d.getVar('SRC_URI') or "").split()
    if not src_uri:
        return

    try:
        for uri in src_uri:
            if uri.startswith("file://"):
                import shutil
                fn = uri.split("://")[1].split(";")[0]
                dfn = uri.split(";downloadfilename=")[1].split(";")[0]
                shutil.copy(fn, os.path.join(d.getVar('DL_DIR'), dfn))
            else:
                fetcher = bb.fetch2.Fetch([uri], d)
                fetcher.download()
    except bb.fetch2.BBFetchException as e:
        bb.fatal("Bitbake Fetcher Error: " + repr(e))
}

python do_unpack() {
    src_uri = (d.getVar('SRC_URI') or "").split()
    if not src_uri:
        return

    try:
        for uri in src_uri:
            if uri.startswith("file://"):
                fn = uri.split("://")[1].split(";")[0]
                dfn = uri.split(";downloadfilename=")[1].split(";")[0]
                local_uri = "file://" + os.path.join(d.getVar('DL_DIR'), dfn)
            else:
                local_uri = uri

            fetcher = bb.fetch2.Fetch([local_uri], d)
            fetcher.unpack(d.getVar('WORKDIR'))
    except bb.fetch2.BBFetchException as e:
        bb.fatal("Bitbake Fetcher Error: " + repr(e))
}

XSCT_LOADER ?= "${XILINX_SDK_TOOLCHAIN}/bin/xsct"

# Remove files we don't want
do_compile() {
    if [ "${USE_XSCT_TARBALL}" = "1" ]; then
        # Validation routines
        if [ ! -d ${PV} ]; then
            bbfatal "XSCT version mismatch.\nUnable to find `pwd`/${PV}.\nThis usually means the wrong version of XSCT is being used."
        fi

        if [ ! -e ${PV}/bin/xsct ]; then
            bbfatal "XSCT binary is not found.\nUnable to find `pwd`/${PV}/bin/xsct."
        fi

        # Various workarounds
        case ${XILINX_XSCT_VERSION} in
            2024.2)
                # Remove included cmake, we want to use YP version in all cases
                rm -rf ${PV}/tps/lnx64/cmake*
                ;;
        esac
    else
        if [ ! -e ${XSCT_LOADER} ]; then
            bbfatal "${XSCT_LOADER} not found.  Please configure XILINX_SDK_TOOLCHAIN with the path to the extracted xsct-trim."
        fi
    fi
}

do_install() {
    if [ "${USE_XSCT_TARBALL}" = "1" ]; then
        install -d ${D}${STAGING_DIR_NATIVE}/Vitis
        cp --preserve=mode,timestamps -R ${S}/* ${D}${STAGING_DIR_NATIVE}/Vitis/.
    else
        bbdebug 2 "Using external XSCT: ${XILINX_SDK_TOOLCHAIN}"
    fi
}

# If the user overrides with EXTERNAL_XSCT_TARBALL, use it instead
python() {
    ext_tarball = d.getVar("EXTERNAL_XSCT_TARBALL")

    if ext_tarball:
        d.setVar('XSCT_URL', 'file://${EXTERNAL_XSCT_TARBALL}')

    use_xsct_tarball = d.getVar("USE_XSCT_TARBALL")
    if use_xsct_tarball != '1':
        d.setVar('SRC_URI', '')
}

ERROR_QA:remove = "already-stripped"
INSANE_SKIP += "already-stripped"
INHIBIT_SYSROOT_STRIP = "1"

