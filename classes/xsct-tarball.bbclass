XSCT_LOADER ?= "${XSCT_STAGING_DIR}/Vitis/${XILINX_VER_MAIN}/bin/xsct"

XSCT_URL ?= "http://petalinux.xilinx.com/sswreleases/rel-v2021/xsct-trim/xsct-2021-2.tar.xz"
XSCT_TARBALL ?= "xsct_${XILINX_VER_MAIN}.tar.xz"
XSCT_DLDIR ?= "${DL_DIR}/xsct/"
XSCT_STAGING_DIR ?= "${TOPDIR}/xsct"

XSCT_CHECKSUM ?= "b038e9f101c68ae691616d0976651e2be9d045e1a36d997bfe431c1526ab7a9c"
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
xsct_event_extract[eventmask] = "bb.event.DepTreeGenerated"

# Specify which targets actually need to call xsct
XSCT_TARGETS ?= "\
	base-pdi \
	bitstream-extraction \
	device-tree \
	extract-cdo \
	fpga-manager-util \
	fsbl-firmware \
	fs-boot \
	imgrcry \
	imgsel \
	openamp-fw-echo-testd \
	openamp-fw-mat-muld \
	openamp-fw-rpc-demo \
	plm-firmware \
	pmu-firmware \
	psm-firmware \
	uboot-device-tree \
	"

python xsct_event_extract() {

    # Only a handful of targets/tasks need XSCT
    tasks_xsct = [t + '.do_configure' for t in d.getVar('XSCT_TARGETS').split()]
    xsct_buildtargets = [t for t in e._depgraph['tdepends'] for x in tasks_xsct if x in t]

    if not xsct_buildtargets and d.getVar('FORCE_XSCT_DOWNLOAD') != '1':
      return

    ext_tarball = d.getVar("EXTERNAL_XSCT_TARBALL")
    use_xscttar = d.getVar("USE_XSCT_TARBALL")
    chksum_tar_recipe = d.getVar("XSCT_CHECKSUM")
    validate = d.getVar("VALIDATE_XSCT_CHECKSUM")
    xsct_url = d.getVar("XSCT_URL")
    chksum_tar_actual = ""

    if use_xscttar == '0':
        return
    elif d.getVar('WITHIN_EXT_SDK') != '1':
        if not ext_tarball and not xsct_url:
            bb.fatal('xsct-tarball class is enabled but no external tarball or url is provided.\n\
\tEither set USE_XSCT_TARBALL to "0" or provide a path/url')
        if os.path.exists(ext_tarball):
            bb.note("Checking local xsct tarball checksum")
            import hashlib
            sha256hash = hashlib.sha256()
            readsize = 1024*sha256hash.block_size
            with open(ext_tarball, 'rb') as f:
                for chunk in iter(lambda: f.read(readsize), b''):
                    sha256hash.update(chunk)
            chksum_tar_actual = sha256hash.hexdigest()
            if validate == '1' and chksum_tar_recipe != chksum_tar_actual:
                bb.fatal('Provided external tarball\'s sha256sum does not match checksum defined in xsct-tarball class')
        elif xsct_url:
            #if fetching the tarball, setting chksum_tar_actual as the one defined in the recipe as the fetcher will fail later otherwise
            chksum_tar_actual = chksum_tar_recipe
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

    try:
        import subprocess
        import shutil
        tarballpath = os.path.join(xsctdldir, tarballname)
        if not os.path.exists(xsctdldir):
            bb.utils.mkdirhier(xsctdldir)

        if os.path.exists(ext_tarball):
            shutil.copy(ext_tarball, tarballpath)
        elif xsct_url:
            localdata = bb.data.createCopy(d)
            localdata.setVar('FILESPATH', "")
            localdata.setVar('DL_DIR', xsctdldir)
            srcuri = d.expand("${XSCT_URL};sha256sum=%s;downloadfilename=%s" % (chksum_tar_actual, tarballname))
            bb.note("Fetching xsct binary tarball from %s" % srcuri)
            fetcher = bb.fetch2.Fetch([srcuri], localdata)
            fetcher.download()
            localpath = fetcher.localpath(srcuri)
            if localpath != tarballpath and os.path.exists(localpath) and not os.path.exists(tarballpath):
                # Follow the symlink behavior from the bitbake fetch2.
                # This will cover the case where an existing symlink is broken
                # as well as if there are two processes trying to create it
                # at the same time.
                if os.path.islink(tarballpath):
                    # Broken symbolic link
                    os.unlink(tarballpath)
 
                # Deal with two processes trying to make symlink at once
                try:
                    os.symlink(localpath, tarballpath)
                except FileExistsError:
                    pass

        cmd = d.expand("\
            rm -rf ${XSCT_STAGING_DIR}; \
            mkdir -p ${XSCT_STAGING_DIR}; \
            cd ${XSCT_STAGING_DIR}; \
            tar -xvf ${XSCT_DLDIR}/${XSCT_TARBALL};")
        bb.note('Extracting external xsct-tarball to sysroots')
        subprocess.check_output(cmd, shell=True)
        with open(tarballchksum, "w") as f:
            f.write(chksum_tar_actual)

        if not os.path.exists(loader):
            bb.fatal("XSCT is not usable, this usually means the wrong version of XSCT is being\nused.\nUnable to find %s." % loader)

    except bb.fetch2.BBFetchException as e:
        bb.fatal(str(e))
    except RuntimeError as e:
        bb.fatal(str(e))
    except subprocess.CalledProcessError as exc:
        bb.fatal("Unable to extract xsct tarball: %s" % str(exc))
}
