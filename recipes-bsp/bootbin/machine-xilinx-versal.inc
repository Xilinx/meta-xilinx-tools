#Extra args for versal
BOOTGEN_EXTRA_ARGS += "-dump bh"

#Add cdo dependency for versal
DEPENDS += "virtual/cdo"

# specify BIF common attribute for FSBL
BIF_COMMON_ATTR ?= ""

# specify BIF partition attributes required for BOOT.bin
BIF_PARTITION_ATTR ?= "pmc_cdo plm psm dtb u-boot atf"

# specify BIF partition attributes for pmc_cdo
BIF_PARTITION_ATTR[pmc_cdo] ?= "pmcdata,load=0xF2000000"
BIF_PARTITION_IMAGE[pmc_cdo] ?= "${DEPLOY_DIR_IMAGE}/CDO/pmc_cdo.bin"
BIF_PARTITION_DEPENDS[pmc_cdo] ?= "virtual/cdo:do_deploy"

# specify BIF partition attributes for plm
BIF_PARTITION_ATTR[plm] ?= "bootloader"
BIF_PARTITION_IMAGE[plm] ?= "${DEPLOY_DIR_IMAGE}/plm-firmware-${MACHINE}.elf"
BIF_PARTITION_DEPENDS[plm] ?= "virtual/plm-firmware:do_deploy"

# specify BIF partition attributes for psm
BIF_PARTITION_ATTR[psm] ?= "destination_cpu=psm"
BIF_PARTITION_IMAGE[psm] ?= "${DEPLOY_DIR_IMAGE}/psm-firmware-${MACHINE}.elf"
BIF_PARTITION_DEPENDS[psm] ?= "virtual/psm-firmware:do_deploy"

# specify BIF partition attributes for dtb
BIF_PARTITION_ATTR[dtb] ?= "partition_type=raw, load=0x1000"
BIF_PARTITION_IMAGE[dtb] ?= "${DEPLOY_DIR_IMAGE}/system.dtb"
BIF_PARTITION_DEPENDS[dtb] ?= "virtual/dtb:do_deploy"

# specify BIF partition attributes for u-boot
BIF_PARTITION_ATTR[u-boot] ?= ""
BIF_PARTITION_IMAGE[u-boot] ?= "${DEPLOY_DIR_IMAGE}/u-boot-${MACHINE}.elf"
BIF_PARTITION_DEPENDS[u-boot] ?= "virtual/bootloader:do_deploy"

# specify BIF partition attributes for atf
BIF_PARTITION_ATTR[atf] ?= "destination_cpu=a72-0, exception_level = el-3, trustzone"
BIF_PARTITION_IMAGE[atf] ?= "${DEPLOY_DIR_IMAGE}/arm-trusted-firmware.elf"
BIF_PARTITION_DEPENDS[atf] ?= "virtual/arm-trusted-firmware:do_deploy"
