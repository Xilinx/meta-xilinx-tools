#Extra args for versal
BOOTGEN_EXTRA_ARGS += "-dump bh"

#Add pdi dependency for versal
DEPENDS += "virtual/base-pdi"

# specify BIF common attribute for FSBL
BIF_COMMON_ATTR ?= ""

# specify BIF partition attributes required for BOOT.bin
BIF_PARTITION_ATTR ?= "pdi plm dtb u-boot atf"

# specify BIF partition attributes for pdi
BIF_PARTITION_ATTR[pdi] ?= "bootimage"
BIF_PARTITION_IMAGE[pdi] ?= "${RECIPE_SYSROOT}/boot/base-design.pdi"
BIF_PARTITION_DEPENDS[pdi] ?= "virtual/base-pdi:do_populate_sysroot"

# specify BIF partition attributes for plm
BIF_PARTITION_ATTR[plm] ?= "bootloader"
BIF_PARTITION_IMAGE[plm] ?= "${DEPLOY_DIR_IMAGE}/plm-${MACHINE}.elf"
BIF_PARTITION_DEPENDS[plm] ?= "virtual/plm:do_deploy"

# specify BIF partition attributes for psm
BIF_PARTITION_ATTR[psm] ?= "destination_cpu=psm"
BIF_PARTITION_IMAGE[psm] ?= "${DEPLOY_DIR_IMAGE}/psm-firmware-${MACHINE}.elf"
BIF_PARTITION_DEPENDS[psm] ?= "virtual/psm-firmware:do_deploy"

# specify BIF partition attributes for dtb
BIF_PARTITION_ATTR[dtb] ?= "partition_type=raw, load=0x1000"
BIF_PARTITION_IMAGE[dtb] ?= "${DEPLOY_DIR_IMAGE}/system.dtb"
BIF_PARTITION_DEPENDS[dtb] ?= "virtual/dtb:do_deploy"

# specify BIF partition attributes for u-boot
BIF_PARTITION_ATTR[u-boot] ?= "load=0x8000000"
BIF_PARTITION_IMAGE[u-boot] ?= "${DEPLOY_DIR_IMAGE}/u-boot-${MACHINE}.elf"
BIF_PARTITION_DEPENDS[u-boot] ?= "virtual/bootloader:do_deploy u-boot-zynq-scr:do_deploy"

# specify BIF partition attributes for atf
BIF_PARTITION_ATTR[atf] ?= "destination_cpu=a72-0, exception_level = el-3, trustzone"
BIF_PARTITION_IMAGE[atf] ?= "${DEPLOY_DIR_IMAGE}/arm-trusted-firmware.elf"
BIF_PARTITION_DEPENDS[atf] ?= "virtual/arm-trusted-firmware:do_deploy"
