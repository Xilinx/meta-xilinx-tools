SUMMARY = "Trigger XSCT to download and install"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

PV = "${TOOL_VER_MAIN}"

INHIBIT_DEFAULT_DEPS = "1"

BB_STRICT_CHECKSUM = "${VALIDATE_XSCT_CHECKSUM}"

SRC_URI = "${XSCT_URL};downloadfilename=${XSCT_TARBALL}"
SRC_URI[sha256sum] = "${XSCT_CHECKSUM}"

inherit native

S = "${UNPACKDIR}/Vitis"
B = "${S}"

SYSROOT_DIRS_NATIVE += "${STAGING_DIR_NATIVE}/Vitis/${PV}"

# Based on poky/meta/classes-global/base.bbclass
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

# Based on poky/meta/classes-global/base.bbclass
python do_unpack() {
    import shutil

    sourcedir = d.getVar('S')
    # Intentionally keep SOURCE_BASEDIR internal to the task just for SDE
    d.setVar("SOURCE_BASEDIR", sourcedir)

    src_uri = (d.getVar('SRC_URI') or "").split()
    if not src_uri:
        return

    basedir = None
    unpackdir = d.getVar('UNPACKDIR')
    workdir = d.getVar('WORKDIR')
    if sourcedir.startswith(workdir) and not sourcedir.startswith(unpackdir):
        basedir = sourcedir.replace(workdir, '').strip("/").split('/')[0]
        if basedir:
            bb.utils.remove(workdir + '/' + basedir, True)
            d.setVar("SOURCE_BASEDIR", workdir + '/' + basedir)

    try:
        for uri in src_uri:
            if uri.startswith("file://"):
                fn = uri.split("://")[1].split(";")[0]
                dfn = uri.split(";downloadfilename=")[1].split(";")[0]
                local_uri = "file://" + os.path.join(d.getVar('DL_DIR'), dfn)
            else:
                local_uri = uri

            fetcher = bb.fetch2.Fetch([local_uri], d)
            fetcher.unpack(d.getVar('UNPACKDIR'))
    except bb.fetch2.BBFetchException as e:
        bb.fatal("Bitbake Fetcher Error: " + repr(e))

    if basedir and os.path.exists(unpackdir + '/' + basedir):
        # Compatibility magic to ensure ${WORKDIR}/git and ${WORKDIR}/${BP}
        # as often used in S work as expected.
        shutil.move(unpackdir + '/' + basedir, workdir + '/' + basedir)
}

XSCT_LOADER ?= "${XILINX_SDK_TOOLCHAIN}/bin/xsct"

# Remove files we don't want
do_compile() {
    # Validation routines
    if [ ! -d ${PV} ]; then
        bbfatal "XSCT version mismatch.\nUnable to find `pwd`/${PV}.\nThis usually means the wrong version of XSCT is being used."
    fi

    if [ ! -e ${PV}/bin/xsct ]; then
        bbfatal "XSCT binary is not found.\nUnable to find `pwd`/${PV}/bin/xsct."
    fi
}

do_install() {
    install -d ${D}${STAGING_DIR_NATIVE}/Vitis
    cp --preserve=mode,timestamps -R ${S}/* ${D}${STAGING_DIR_NATIVE}/Vitis/.
}

# If the user overrides with EXTERNAL_XSCT_TARBALL, use it instead
python() {
    ext_tarball = d.getVar("EXTERNAL_XSCT_TARBALL")

    if ext_tarball:
        d.setVar('XSCT_URL', 'file://${EXTERNAL_XSCT_TARBALL}')
}

ERROR_QA:remove = "already-stripped"
INSANE_SKIP += "already-stripped"
INHIBIT_SYSROOT_STRIP = "1"

