inherit bootbin-component

BOOTBIN_BIF_FRAGMENT = "destination_cpu=pmu"

# This lets pmufw be build completely within a Linux build
PMU_DEPENDS ?= "pmu-firmware:do_deploy"
PMU_MCDEPENDS ?= ""
