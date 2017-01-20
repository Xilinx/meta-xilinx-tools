IMAGE_CLASSES_xilinx-hdf_append += " xilinx-bootbin"

#specify BIF partition attributes required for BOOT.bin
BIF_PARTITION_ATTR= "fsbl u-boot"

#specify BIF partition attributes for FSBL
#bootloader is FSBL. Location where FSBL binary is present and dependency to build FSBL
BIF_PARTITION_IMAGE[fsbl]="${DEPLOY_DIR_IMAGE}/fsbl-${MACHINE}.elf"
BIF_PARTITION_DEPENDS[fsbl]="virtual/fsbl"

#specify BIF partition attributes for u-boot
#Location where u-boot binary is present
BIF_PARTITION_IMAGE[u-boot]="${DEPLOY_DIR_IMAGE}/u-boot-${MACHINE}.elf"
