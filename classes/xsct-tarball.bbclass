XSCT_LOADER ?= "${XSCT_STAGING_DIR}/SDK/${XILINX_VER_MAIN}/bin/xsct"

XSCT_TARBALL ?= "xsct.tar.xz"
XSCT_DLDIR ?= "${DL_DIR}/xsct/"
XSCT_STAGING_DIR ?= "${STAGING_DIR}-xsct"

XSCT_CHECKSUM ?= "3efde32122fe5de7f820194b54cbc4fd"
VALIDATE_XSCT_CHECKSUM ?= '1'

USE_XSCT_TARBALL ?= '1'
USE_XSCT_TARBALL[doc] = "Flag to determine whether or not to use the xsct-tarball class. \
If enabled, the tarball from path EXTERNAL_XSCT_TARBALL is copied to downloads/xsct, and extracted \
to tmp/sysroots-xsct. XILINX_SDK_TOOLCHAIN is set accordingly to use xsct from this path."

COPY_XSCT_TO_ESDK ?= "0"
COPY_XSCT_TO_ESDK[doc] = "Flag to determine whether or not to copy the xsct-tarball to the eSDK"

EXTERNAL_XSCT_TARBALL ?= ""
EXTERNAL_XSCT_TARBALL[doc] = "Variable that defines where the xsct tarball is stored"

addhandler xsct_event_extract
xsct_event_extract[eventmask] = "bb.event.BuildStarted"

python xsct_event_extract() {
    ext_tarball = d.getVar("EXTERNAL_XSCT_TARBALL")
    use_xscttar = d.getVar("USE_XSCT_TARBALL")
    chksum_tar = d.getVar("XSCT_CHECKSUM")
    validate = d.getVar("VALIDATE_XSCT_CHECKSUM")
    chksum_tar_actual = ""

    if use_xscttar == '0':
        return
    elif d.getVar('WITHIN_EXT_SDK') != '1':
        if not ext_tarball:
            bb.fatal('xsct-tarball class is enabled but no external tarball is provided.\n\
\tEither set USE_XSCT_TARBALL to "0" or provide a path to EXTERNAL_XSCT_TARBALL')
        import hashlib
        with open(ext_tarball, 'rb') as f:
            chksum_tar_actual = hashlib.md5(f.read()).hexdigest()
        if validate == '1' and chksum_tar != chksum_tar_actual:
            bb.fatal('Provided external tarball\'s md5sum does not match checksum defined in xsct-tarball class')

    xsctdldir = d.getVar("XSCT_DLDIR")
    tarballname = d.getVar("XSCT_TARBALL")
    xsctsysroots = d.getVar("XSCT_STAGING_DIR")
    loader = d.getVar("XSCT_LOADER")

    tarballchksum = os.path.join(xsctsysroots, tarballname  + ".chksum")

    if os.path.exists(loader) and os.path.exists(tarballchksum):
        with open(tarballchksum, "r") as f:
            readchksum = f.read().strip()
        if readchksum == chksum_tar_actual:
            return
    bb.note('Extracting external xsct-tarball to sysroots')

    try:
        import subprocess
        import shutil

        if not os.path.exists(xsctdldir):
            bb.utils.mkdirhier(xsctdldir)
        if ext_tarball:
            shutil.copy(ext_tarball, os.path.join(xsctdldir, tarballname))

        cmd = d.expand("\
            mkdir -p ${STAGING_DIR}-xsct; \
            cd ${STAGING_DIR}-xsct; \
            tar -xvf ${XSCT_DLDIR}/${XSCT_TARBALL};")
        subprocess.check_output(cmd, shell=True)

        with open(tarballchksum, "w") as f:
            f.write(chksum_tar_actual)

    except RuntimeError as e:
        bb.error(str(e))
    except subprocess.CalledProcessError as exc:
        bb.error("Unable to extract xsct tarball: %s" % str(exc))
}
