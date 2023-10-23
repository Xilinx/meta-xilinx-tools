# This class inherits dfx_dtg_partial.bbclass for below use cases.
# ZynqMP: DFx Partial bitstream loading.
# Versal: DFx Parial pdi loading.

inherit dfx_dtg_partial

python fpgamanager_warn_msg () {
    if not d.getVar("FPGAMANAGER_NO_WARN"):
        arch = d.getVar('SOC_FAMILY')
        pn = d.getVar('PN')
        warn_msg = 'Users should start using '
        if arch == 'zynqmp':
            warn_msg += 'dfx_dtg_zynqmp_partial bbclass for ZynqMP DFx Partial bitstream loading use case.'
        elif arch == 'versal':
            warn_msg += 'dfx_dtg_versal_partial bbclass for Versal DFx Partial PDI loading use case.'

        bb.warn("Recipe %s has inherited fpgamanager_dtg_dfx bbclass which will be deprecated in 2024.1 release. \n%s" % (pn, warn_msg))
}

do_install[postfuncs] += "fpgamanager_warn_msg"
