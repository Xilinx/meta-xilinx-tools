TOOL_VER_MAIN ?= "${XILINX_VER_MAIN}"
TOOL_VER_MAIN[doc] = "XSCT version, usually the same as XILINX_VER_MAIN"

XILINX_SDK_TOOLCHAIN ??= "${XSCT_STAGING_DIR}/Vitis/${TOOL_VER_MAIN}"
XSCT_LOADER ?= "${XILINX_SDK_TOOLCHAIN}/bin/xsct"

XSCT_URL ?= "http://petalinux.xilinx.com/sswreleases/rel-v2022/xsct-trim/xsct-2022-2.tar.xz"
XSCT_TARBALL ?= "xsct_${XILINX_VER_MAIN}.tar.xz"
XSCT_DLDIR ?= "${DL_DIR}/xsct/"
XSCT_STAGING_DIR ?= "${TOPDIR}/xsct"

XSCT_CHECKSUM ?= "8a3272036ca61f017f357bf6ad9dfbdec6aebb39f43c3ca0cee7ec86ea4c066f"
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

    def check_xsct_version():
        xsct_path = d.getVar("XILINX_SDK_TOOLCHAIN")
        if not os.path.exists(xsct_path):
            bb.fatal("XSCT path was not found.  This usually means the wrong version of XSCT is\nbeing used.\nUnable to find %s." % xsct_path)
        loader = d.getVar("XSCT_LOADER")
        if not os.path.exists(loader):
            bb.fatal("XSCT binary is not found.\nUnable to find %s." % loader)

    # Only a handful of targets/tasks need XSCT
    tasks_xsct = [t + '.do_configure' for t in d.getVar('XSCT_TARGETS').split()]

    xsct_buildtargets = False
    for mct in e._depgraph['tdepends']:
        t = mct.split(':')[-1]
        for x in tasks_xsct:
            if t == x:
                xsct_buildtargets = True
                break
        if xsct_buildtargets:
            break

    if not xsct_buildtargets and d.getVar('FORCE_XSCT_DOWNLOAD') != '1':
      return

    ext_tarball = d.getVar("EXTERNAL_XSCT_TARBALL")
    use_xscttar = d.getVar("USE_XSCT_TARBALL")
    chksum_tar_recipe = d.getVar("XSCT_CHECKSUM")
    validate = d.getVar("VALIDATE_XSCT_CHECKSUM")
    xsct_url = d.getVar("XSCT_URL")
    chksum_tar_actual = ""

    if use_xscttar == '0':
        if d.getVar('WITHIN_EXT_SDK') != '1':
            check_xsct_version()
        return
    elif d.getVar('WITHIN_EXT_SDK') != '1':
        if not ext_tarball and not xsct_url:
            bb.fatal('xsct-tarball class is enabled but no external tarball or url is provided.\n\
\tEither set USE_XSCT_TARBALL to "0" or provide a path/url')
        if ext_tarball and os.path.exists(ext_tarball):
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
        elif ext_tarball:
            bb.fatal("Unable to find %s" % ext_tarball)
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

        check_xsct_version()

    except bb.fetch2.BBFetchException as e:
        bb.fatal(str(e))
    except RuntimeError as e:
        bb.fatal(str(e))
    except subprocess.CalledProcessError as exc:
        bb.fatal("Unable to extract xsct tarball: %s" % str(exc))
}

# The following two items adjust some functions in populate_sdk_ext, so they are benign when set globally.
# Copy xsct tarball to esdk's download dir, where this class is expecting it to be
python copy_buildsystem:prepend() {

    if bb.data.inherits_class('xsct-tarball', d):
        ext_tarball = d.getVar("COPY_XSCT_TO_ESDK")
        #including xsct tarball in esdk
        if ext_tarball == '1':
            import shutil
            baseoutpath = d.getVar('SDK_OUTPUT') + '/' + d.getVar('SDKPATH')
            xsct_outdir = '%s/downloads/xsct/' % (baseoutpath)
            bb.utils.mkdirhier(xsct_outdir)
            shutil.copy(os.path.join(d.getVar("DL_DIR"), 'xsct', d.getVar("XSCT_TARBALL")), xsct_outdir)
        #not including tarball in esdk
        else:
            d.setVar('sdk_extraconf','USE_XSCT_TARBALL = "0"')
}

#Add dir with the tools to PATH
sdk_ext_postinst:append() {
    if [ "${COPY_XSCT_TO_ESDK}" = "1" ]; then
        echo "export PATH=$target_sdk_dir/tmp/sysroots-xsct/Vitis/${TOOL_VER_MAIN}/bin:\$PATH" >> $env_setup_script
    fi
}

