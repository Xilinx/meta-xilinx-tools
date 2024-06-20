addhandler xsct_bbappend_distrocheck
xsct_bbappend_distrocheck[eventmask] = "bb.event.SanityCheck"
python xsct_bbappend_distrocheck() {
    skip_check = e.data.getVar('SKIP_META_XILINX_TOOLS_SANITY_CHECK') == "1"
    if e.data.getVar('XILINX_WITH_ESW') != 'xsct' and not skip_check:
        bb.warn("You have included the meta-xilinx-tools layer, but \
it has not been enabled using XILINX_WITH_ESW in your configuration. Some \
bbappend files and preferred version setting may not take effect. See the \
meta-xilinx-tools README for details.")
    elif e.data.getVar('XILINX_WITH_ESW') == 'xsct':
        bb.warn("XSCT has been deprecated. It will still be available for \
several releases. In the future, it's recommended to start new projects \
with SDT workflow.")

        # Check that libtinfo.so.5 is available!  Use the _HOST_ compiler, skipping any
        # Yocto Project specific libraries.
        import subprocess

        try:
            env = os.environ.copy()
            output = subprocess.check_output("gcc --print-file-name=libtinfo.so.5", \
                    shell=True, env=env, stderr=subprocess.STDOUT).decode("utf-8")
        except subprocess.CalledProcessError as e:
            bb.fatal("Error running gcc --print-library-path=libtinfo.so.5: %s" % (compiler, e.output.decode("utf-8")))

        output = output.strip()

        if not os.path.exists(output):
            bb.fatal('libtinfo.so.5 is required by meta-xilinx-tools.\n' \
                     'This library must be installed before the build system ' \
                     'can use xsct.  It is often part of an ncurses5 package.')
}
