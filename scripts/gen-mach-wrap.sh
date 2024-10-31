#! /bin/bash

for each in `ls -1 *.conf | sed 's,-202.*\.conf,,' | sort -u` ; do
  echo "processing $each..."

  header=
  for release in 2025.1 2024.2 2024.1 2023.2 2023.1 2022.2 2022.1; do 
    if [ -e ${each}-${release}.conf ]; then
      header=${each}-${release}.conf
      break
    fi
  done
  if [ -z ${header} ]; then
    continue
  fi

  head -n 3 $header > ${each}.new
  machine=${each}
  cat << EOF >> ${each}.new

require conf/machine/${machine}-\${XILINX_XSCT_VERSION}.conf
EOF

  mv ${each}.new ${each}.conf
done
