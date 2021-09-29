# This lets pmufw be build completely within a Linux build
PMU_DEPENDS ?= "pmu-firmware:do_deploy"
PMU_MCDEPENDS ?= ""

# Use BOARDVARIANT_ARCH, but if it's undefined fall back to SOC_VARIANT_ARCH
# instead of MACHINE_ARCH.  This is because the same machine may be used with
# different variants, and zynqmp-dr is known to be 'different'.
SOC_VARIANT_ARCH ??= "${MACHINE_ARCH}"
PACKAGE_ARCH_zynqmp-dr = "${@['${BOARDVARIANT_ARCH}', '${SOC_VARIANT_ARCH}'][d.getVar('BOARDVARIANT_ARCH')==d.getVar('MACHINE_ARCH')]}"
