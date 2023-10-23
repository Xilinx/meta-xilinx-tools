# This class inherits dfx_dtg_partial.bbclass for below use cases.
# Versal: CSoC(DFx backend) Parial pdi loading.

inherit dfx_dtg_versal_csoc

python fpgamanager_warn_msg () {
    if not d.getVar("FPGAMANAGER_NO_WARN"):
        pn = d.getVar('PN')
        arch = d.getVar('SOC_FAMILY')
        warn_msg = 'Users should start using '
        if arch == 'versal':
            warn_msg = 'dfx_dtg_versal_partial bbclass for Versal CSoC Partial PDI loading use case.'

        bb.warn("Recipe %s has inherited fpgamanager_dtg_csoc bbclass which will be deprecated in 2024.1 release. \n%s" % (pn, warn_msg))
}

do_install[postfuncs] += "fpgamanager_warn_msg"