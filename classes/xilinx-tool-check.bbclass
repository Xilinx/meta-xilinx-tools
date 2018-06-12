# Check Xilinx tool version

def run_tool(d):
    import bb.process
    import subprocess

    topdir = d.getVar('TOPDIR', True)
    toolchain_path = d.getVar('TOOL_PATH', True)
    if not toolchain_path:
        return 'UNKNOWN', 'UNKNOWN'

    os.environ["RDI_VERBOSE"] = "0"
    cmd = os.path.join(toolchain_path, d.getVar('TOOL_VERSION_COMMAND', True))
    return bb.process.run(cmd, cwd=topdir, stderr=subprocess.PIPE)

def tool_get_version(d):
    import re
    try:
        stdout, stderr = run_tool(d)
    except bb.process.CmdError as exc:
        bb.error('Failed to execute app version is : %s' % exc)
        return 'UNKNOWN'
    else:
        if stdout != 'UNKNOWN':
            last_line = stdout.splitlines()[0].split()[-2]
            return last_line[1:7]

python tool_eventhandler () {
    TOOL_VERSION = tool_get_version(d)
    TOOL_REQ_VERSION = d.getVar("TOOL_VER_MAIN", True)
    CURRENT_TOOL_NAME = d.getVar("TOOL_NAME", True)
    if TOOL_VERSION != TOOL_REQ_VERSION:
        bb.fatal("%s version does not match. Version is %s: checking for %s. Check if XILINX_SDK_TOOLCHAIN or XILINX_VIVADO_DESIGN_SUIT in your local.conf is pointing to the right location. " % (CURRENT_TOOL_NAME, TOOL_VERSION, TOOL_REQ_VERSION))

    print("%s is valid, version is %s" % (CURRENT_TOOL_NAME,TOOL_REQ_VERSION))
}

addhandler tool_eventhandler
tool_eventhandler[eventmask] = "bb.event.BuildStarted"
