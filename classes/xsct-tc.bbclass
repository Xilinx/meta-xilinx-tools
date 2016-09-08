XSCT_PATH_ADD = "${XILINX_SDK_TOOLCHAIN}/bin:"
PATH =. "${XSCT_PATH_ADD}"

def xsct_run(d):
    import bb.process
    import subprocess

    topdir = d.getVar('TOPDIR', True)
    toolchain_path = d.getVar('XILINX_SDK_TOOLCHAIN', True)
    if not toolchain_path:
        return 'UNKNOWN', 'UNKNOWN'

    cmd = os.path.join(toolchain_path, 'bin', 'xsct -h')
    try:
        (output, error) = bb.process.run(cmd, cwd=topdir, stderr=subprocess.PIPE)
    except bb.process.CmdError as e:
        bb.fatal("Command %s could not be run:\n %s" % (e.command, e.msg))

    cmd = os.path.join(toolchain_path, 'bin', 'hsi -version')
    return bb.process.run(cmd, cwd=topdir, stderr=subprocess.PIPE)

def xsct_get_version(d):
    import re
    try:
        stdout, stderr = xsct_run(d)
    except bb.process.CmdError as exc:
        bb.error('Failed to execute xsct version is : %s' % exc)
        return 'UNKNOWN'
    else:
        last_line = stdout.splitlines()[0].split()[-2]
        return last_line[1:]

python xsct_setup () {
    d = e.data
    d = d.createCopy()
    d.finalize()

    XILINX_XSCT_VERSION = xsct_get_version(d)
    XILINX_REQ_VERSION = d.getVar("XILINX_VER_MAIN", True)
    if XILINX_XSCT_VERSION != XILINX_REQ_VERSION:
        bb.fatal("XSCT version does not match. Version is %s: checking for %s " % (XILINX_XSCT_VERSION,XILINX_REQ_VERSION))

    bb.note("XSCT is valid, version is %s" % XILINX_XSCT_VERSION)
}
addhandler xsct_setup
xsct_setup[eventmask] = "bb.event.BuildStarted"
