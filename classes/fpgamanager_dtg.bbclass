# This class inherits dfx_dtg_full_internal.bbclass for below use cases.
# Zynq-7000 and ZynqMP: Full bitstream loading.
# ZynqMP: DFx Static bitstream loading.
# Versal: DFx Static pdi loading.

inherit dfx_dtg_full_internal

python fpgamanager_warn_msg () {
    if not d.getVar("FPGAMANAGER_NO_WARN"):
        arch = d.getVar('SOC_FAMILY')
        pn = d.getVar('PN')        
        warn_msg = 'Users should start using '
        if arch == 'zynq':
            warn_msg += 'dfx_dtg_zynq_full bbclass for Zynq-7000 Full bitstream loading use case.'
        elif arch == 'zynqmp':
            warn_msg += 'dfx_dtg_zynqmp_full bbclass for ZynqMP Full bitstream loading use case or dfx_dtg_zynqmp_static bbclass for ZynqMP DFx Static bitstream loading use.'
        elif arch == 'versal':
            warn_msg += 'dfx_dtg_versal_static bbclass for Versal Static PDI loading use case.'

        bb.warn("Recipe %s has inherited fpgamanager_dtg bbclass which will be deprecated in 2024.1 release. \n%s" % (pn, warn_msg))
}

do_install[postfuncs] += "fpgamanager_warn_msg"
