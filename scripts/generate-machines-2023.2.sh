#! /bin/bash -e

XSCT_VERSION=2023.2

### The following table controls the automatic generated of the machine .conf files (lines start with #M#)
### Machine               Board Template                     OTHER
#M# ac701-microblazeel    ac701-full                         QB_MEM = \"-m 1024\"\\n
#M# kc705-microblazeel    kc705-full                         QB_MEM = \"-m 1024\"\\n
#M# kcu105-microblazeel   kcu105                             QB_MEM = \"-m 2G\"\\n
#M# sp701-microblazeel    sp701-rev1.0                       QB_MEM = \"-m 2G\"\\n
#M# vck190-emmc-versal    versal-vck190-reva-x-ebm-01-reva   MACHINE_FEATURES += \"aie\"\\n\\nQB_MEM = \"-m 8G\"\\nQEMU_HW_DTB_PS = \"\${QEMU_HW_DTB_PATH}/board-versal-ps-vck190.dtb\"\\nQEMU_HW_DTB_PMC = \"${QEMU_HW_DTB_PATH}/board-versal-pmc-virt.dtb\"\\n
#M# vck190-ospi-versal    versal-vck190-reva-x-ebm-01-reva   MACHINE_FEATURES += \"aie\"\\n\\nQB_MEM = \"-m 8G\"\\nQEMU_HW_DTB_PS = \"\${QEMU_HW_DTB_PATH}/board-versal-ps-vck190.dtb\"\\nQEMU_HW_DTB_PMC = \"${QEMU_HW_DTB_PATH}/board-versal-pmc-virt.dtb\"\\n
#M# vck190-versal         versal-vck190-reva-x-ebm-01-reva   MACHINE_FEATURES += \"aie\"\\n\\nQB_MEM = \"-m 8G\"\\nQEMU_HW_DTB_PS = \"\${QEMU_HW_DTB_PATH}/board-versal-ps-vck190.dtb\"\\nQEMU_HW_DTB_PMC = \"${QEMU_HW_DTB_PATH}/board-versal-pmc-virt.dtb\"\\n
#M# vcu118-microblazeel   vcu118-rev2.0                      QB_MEM = \"-m 4G\"\\n
#M# vek280-versal         versal-vek280-revb                 MACHINE_FEATURES += \"aie\"\\n\\nQB_MEM = \"-m 12G\"\\nQEMU_HW_DTB_PS = \"\${QEMU_HW_DTB_PATH}/board-versal-ps-vek280.dtb\"\\nQEMU_HW_DTB_PMC = \"${QEMU_HW_DTB_PATH}/board-versal-pmc-virt.dtb\"\\n
#M# vmk180-emmc-versal    versal-vmk180-reva-x-ebm-01-reva   QB_MEM = \"-m 8G\"\\nQEMU_HW_DTB_PS = \"\${QEMU_HW_DTB_PATH}/board-versal-ps-vmk180.dtb\"\\nQEMU_HW_DTB_PMC = \"${QEMU_HW_DTB_PATH}/board-versal-pmc-virt.dtb\"\\n
#M# vmk180-ospi-versal    versal-vmk180-reva-x-ebm-01-reva   QB_MEM = \"-m 8G\"\\nQEMU_HW_DTB_PS = \"\${QEMU_HW_DTB_PATH}/board-versal-ps-vmk180.dtb\"\\nQEMU_HW_DTB_PMC = \"${QEMU_HW_DTB_PATH}/board-versal-pmc-virt.dtb\"\\n
#M# vmk180-versal         versal-vmk180-reva-x-ebm-01-reva   QB_MEM = \"-m 8G\"\\nQEMU_HW_DTB_PS = \"\${QEMU_HW_DTB_PATH}/board-versal-ps-vmk180.dtb\"\\nQEMU_HW_DTB_PMC = \"${QEMU_HW_DTB_PATH}/board-versal-pmc-virt.dtb\"\\n
#M# vpk120-versal         versal-vpk120-reva                 QB_MEM = \"-m 12G\"\\nQEMU_HW_DTB_PS = \"${QEMU_HW_DTB_PATH}/board-versal-ps-vpk120.dtb\"\\nQEMU_HW_DTB_PMC = \"${QEMU_HW_DTB_PATH}/board-versal-pmc-virt.dtb\"\\n
#M# vpk180-versal         versal-vpk180-reva                 QB_MEM = \"-m 12G\"\\nQEMU_HW_DTB_PS = \"${QEMU_HW_DTB_PATH}/board-versal-ps-vpk180.dtb\"\\nQEMU_HW_DTB_PMC = \"${QEMU_HW_DTB_PATH}/board-versal-pmc-virt.dtb\"\\n
#M# zc702-zynq7           zc702                              QB_MEM = \"-m 1024\"\\nQEMU_HW_SERIAL = \"-serial null -serial mon:stdio\"\\n
#M# zc706-zynq7           zc706                              QB_MEM = \"-m 1024\"\\nQEMU_HW_SERIAL = \"-serial null -serial mon:stdio\"\\n
#M# zcu102-zynqmp         zcu102-rev1.0                      QB_MEM = \"-m 4G\"\\nQEMU_HW_DTB_PS = \"\${QEMU_HW_DTB_PATH}/zcu102-arm.dtb\"\\nQEMU_HW_DTB_PMU = \"${QEMU_HW_DTB_PATH}/zynqmp-pmu.dtb\"\\n
#M# zcu104-zynqmp         zcu104-revc                        QB_MEM = \"-m 4G\"\\nQEMU_HW_DTB_PS = \"\${QEMU_HW_DTB_PATH}/board-zynqmp-zcu104.dtb\"\\nQEMU_HW_DTB_PMU = \"${QEMU_HW_DTB_PATH}/zynqmp-pmu.dtb\"\\n
#M# zcu106-zynqmp         zcu106-reva                        
#M# zcu111-zynqmp         zcu111-reva                        
#M# zcu208-sdfec-zynqmp   zcu208-reva                        
#M# zcu208-zynqmp         zcu208-reva                        
#M# zcu216-zynqmp         zcu216-reva                        

this=$(realpath $0)

if [ $# -lt 2 ]; then
  echo "$0: <conf_path> <machine_url_index> [machine]" >&2
  exit 1
fi

gmc=`which gen-machineconf`
if [ -z "${gmc}" ]; then
  echo "ERROR: This script must be run in a configured Yocto Project build with gen-machineconf in the environment." >&2
  exit 1
fi

conf_path=$(realpath $1)
if [ ! -d ${conf_path} ]; then
  mkdir -p ${conf_path}
fi


mach_index=$(realpath $2)
count=0
while read mach_id mach_url; do
  if [ ${mach_id} = '#' ]; then
      continue
  fi

  # We need a rename on this to avoid a conflict
  if [ ${mach_id} = "versal-net-generic" ]; then
    mach_id="generic-versal-net"
  fi

  MACHINE_ID[$count]=${mach_id}
  MACHINE_URL[$count]=${mach_url}

  count=$(expr $count + 1)
done < ${mach_index}


# Load in the arrays from this script
count=0
while read marker machine board other; do
  if [ "${marker}" != "#M#" ]; then
      continue
  fi

  MACHINES[$count]=${machine}
  BOARDS[$count]=${board}
  for mach in ${!MACHINE_ID[@]}; do
    if [ ${MACHINE_ID[${mach}]} = ${machine} ]; then
      URLS[$count]=${MACHINE_URL[${mach}]}
      break
    fi
  done
  if [ -z "${URLS[$count]}" ]; then
    echo "ERROR: Unable to find ${machine} in ${mach_index}" >&2
    exit 1
  fi
  OTHER[$count]=${other}

  count=$(expr $count + 1)
done < ${this}


for mach in ${!MACHINES[@]}; do
  if [ -n "$3" -a "$3" != "${MACHINES[${mach}]}" ]; then
    continue
  fi

  echo "Machine: ${MACHINES[${mach}]}"
  echo "Board:   ${BOARDS[${mach}]}"
  echo "URL:     ${URLS[${mach}]}"
  echo
  if [ -e ${conf_path}/machine/${MACHINES[${mach}]}.conf ]; then
      mv ${conf_path}/machine/${MACHINES[${mach}]}.conf ${conf_path}/machine/${MACHINES[${mach}]}.conf.orig
  fi
  set -x
  rm -rf output
  gen-machineconf parse-xsa --hw-description ${URLS[${mach}]} -c ${conf_path} --machine-name ${MACHINES[${mach}]} --add-config CONFIG_SUBSYSTEM_MACHINE_NAME=\"${BOARDS[${mach}]}\"
  set +x

  ######### Post gen-machineconf changes
  #
  # Since this is a version specific XSA, set the version of XSCT to use.
  if [ -n "${OTHER[${mach}]}" ]; then
    sed -i ${conf_path}/machine/${MACHINES[${mach}]}.conf -e 's,\(# Required generic machine inclusion\),'"${OTHER[${mach}]}"'\n\1,'
  fi

  # Rename to a version specific machine.conf
  mv ${conf_path}/machine/${MACHINES[${mach}]}.conf ${conf_path}/machine/${MACHINES[${mach}]}-${XSCT_VERSION}.conf

  if [ -e ${conf_path}/machine/${MACHINES[${mach}]}.conf.orig ]; then
      mv ${conf_path}/machine/${MACHINES[${mach}]}.conf.orig ${conf_path}/machine/${MACHINES[${mach}]}.conf
  fi
done
