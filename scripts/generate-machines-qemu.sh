#! /bin/bash -e

XSCT_VERSION=2025.1

### The following table controls the automatic generated of the machine .conf files (lines start with #M#)
### Machine               Board Template                     PRE                                                                 POST
#M# qemu-microblazeel     kcu105                             none                                                                SERIAL_CONSOLES = \"115200;ttyUL0 115200;ttyUL1\"\\n\\nQB_MEM = \"-m 2G\"\\nQEMU_HW_SERIAL = \"\"\\n
#M# qemu-versal           versal-vck190-reva-x-ebm-01-reva   MACHINE_FEATURES\ +=\ \"vdu\"\\n                                    SERIAL_CONSOLES = \"115200;ttyAMA0 115200;ttyAMA1\"\\n\\nQB_MEM = \"-m 8G\"\\nQEMU_HW_DTB_PS = \"\${QEMU_HW_DTB_PATH}/board-versal-ps-vck190-alt.dtb\"\\nQEMU_HW_DTB_PMC = \"${QEMU_HW_DTB_PATH}/board-versal-pmc-virt-alt.dtb\"\\nQEMU_HW_SERIAL = \"\"\\n
#M# qemu-versal-net       versal-net-vn-p-b2197-00-reva      none                                                                SERIAL_CONSOLES = \"115200;ttyAMA0 115200;ttyAMA1\"\\n\\nQB_MEM = \"-m 8G\"\\nQEMU_HW_DTB_PS = \"\${QEMU_HW_DTB_PATH}/board-versal-net-psx-spp-1.4-alt.dtb\"\\nQEMU_HW_DTB_PMC = \"${QEMU_HW_DTB_PATH}/board-versal-pmx-virt-alt.dtb\"\\nQEMU_HW_SERIAL = \"\"\\n
#M# qemu-zynq7            zc702                              none                                                                SERIAL_CONSOLES = \"115200;ttyPS0 115200;ttyPS1\"\\n\\nQB_MEM = \"-m 1024\"\\nQEMU_HW_SERIAL = \"\"\\n
#M# qemu-zynqmp           zcu102-rev1.0                      MACHINE_FEATURES\ +=\ \"vcu\"\\nMACHINE_FEATURES\ +=\ \"rfsoc\"\\n  SERIAL_CONSOLES = \"115200;ttyPS0 115200;ttyPS1\"\\n\\nQB_MEM = \"-m 4G\"\\nQEMU_HW_DTB_PS = \"\${QEMU_HW_DTB_PATH}/zcu102-arm.dtb\"\\nQEMU_HW_DTB_PMU = \"${QEMU_HW_DTB_PATH}/zynqmp-pmu.dtb\"\\nQEMU_HW_SERIAL = \"\"\\n

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

  case ${mach_id} in
    kcu105-microblazeel) mach_id="qemu-microblazeel" ;;
    vck190-versal)       mach_id="qemu-versal" ;;
    versal-net-generic)  mach_id="qemu-versal-net" ;;
    zc702-zynq7)         mach_id="qemu-zynq7" ;;
    zcu102-zynqmp)       mach_id="qemu-zynqmp" ;;
    *) continue ;;
  esac

  MACHINE_ID[$count]=${mach_id}
  MACHINE_URL[$count]=${mach_url}

  count=$(expr $count + 1)
done < ${mach_index}


# Load in the arrays from this script
count=0
while read marker machine board pre post ; do
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
  if [ "$pre" = "none" ]; then
    pre=
  fi
  PRE[$count]=${pre}
  POST[$count]=${post}

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
  set -x
  rm -rf output
  gen-machineconf parse-xsa --hw-description ${URLS[${mach}]} -c ${conf_path} --machine-name ${MACHINES[${mach}]} --add-config CONFIG_SUBSYSTEM_MACHINE_NAME=\"${BOARDS[${mach}]}\"
  set +x

  ######### Post gen-machineconf changes
  #
  # Since this is a version specific XSA, set the version of XSCT to use.
  sed -i "/^# Required generic machine inclusion/e cat `dirname $0`/qemu-settings.cfg" ${conf_path}/machine/${MACHINES[${mach}]}.conf

  if [ -n "${PRE[${mach}]}" ]; then
    sed -i ${conf_path}/machine/${MACHINES[${mach}]}.conf -e 's,\(# Required generic machine inclusion\),'"${PRE[${mach}]}"'\n\1,'
  fi

  if [ -n "${POST[${mach}]}" ]; then
    sed -i ${conf_path}/machine/${MACHINES[${mach}]}.conf -e 's,\(^require conf/machine/.*\.conf\),\1\n\n'"${POST[${mach}]}"','
  fi
done
