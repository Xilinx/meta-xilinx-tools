# Automatically generated.  Manual changes will be lost.

# Redefine the default to use our values if not overriden by the user
# fall back to the original default if necessary
HDF_BASE_DEFAULT := '${HDF_BASE}'
HDF_PATH_DEFAULT := '${HDF_PATH}'
BRANCHARG_DEFAULT := '${BRANCHARG}'
HDF_BASE ??= "${@d.getVarFlag('HDF_BASE', d.getVar('HDF_MACHINE')) or '${HDF_BASE_DEFAULT}'}"
HDF_PATH ??= "${@d.getVarFlag('HDF_PATH', d.getVar('HDF_MACHINE')) or '${HDF_PATH_DEFAULT}'}"
BRANCHARG ??= "${@d.getVarFlag('BRANCHARG', d.getVar('HDF_MACHINE')) or '${BRANCHARG_DEFAULT}'}"

# ac701-microblazeel
HDF_BASE[ac701-microblazeel] = 'https://'
HDF_PATH[ac701-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/ac701-microblazeel/ac701-microblazeel-2023.2_1002_1.xsa'
BRANCHARG[ac701-microblazeel] = 'name=ac701-microblazeel'
SRC_URI[ac701-microblazeel.sha256sum] = '951461342ee4c3536d53ba6d601f9da79b4a2325ccf2ec422d17e96fe87904ea'

# eval-brd-sc
HDF_BASE[eval-brd-sc] = 'https://'
HDF_PATH[eval-brd-sc] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/eval-brd-sc/eval-brd-sc-2023.2_1002_1.xsa'
BRANCHARG[eval-brd-sc] = 'name=eval-brd-sc'
SRC_URI[eval-brd-sc.sha256sum] = '965cf35910b7a4dcdc76ebbdee374a091882bbd222b2fadbc934f71ebc324533'

# k24-sm
HDF_BASE[k24-sm] = 'https://'
HDF_PATH[k24-sm] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/k24-sm/k24-sm-2023.2_1002_1.xsa'
BRANCHARG[k24-sm] = 'name=k24-sm'
SRC_URI[k24-sm.sha256sum] = '38c028a667ad9f031f6cf323fca3e31e8d7cac34abf4744723bcc2c101674e02'

# k24-smk
HDF_BASE[k24-smk] = 'https://'
HDF_PATH[k24-smk] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/k24-smk/k24-smk-2023.2_1002_1.xsa'
BRANCHARG[k24-smk] = 'name=k24-smk'
SRC_URI[k24-smk.sha256sum] = 'cf5a360583cfb576bb9b3d2919b11a514220c36f006cf3231f6637ef3c0e38ef'

# k24-smk-kd
HDF_BASE[k24-smk-kd] = 'https://'
HDF_PATH[k24-smk-kd] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/k24-smk-kd/k24-smk-kd-2023.2_1002_1.xsa'
BRANCHARG[k24-smk-kd] = 'name=k24-smk-kd'
SRC_URI[k24-smk-kd.sha256sum] = '859a37b8bc11b55d0f211528de745900b28f208b73fad803ef54b413c21b3de4'

# k26-sm
HDF_BASE[k26-sm] = 'https://'
HDF_PATH[k26-sm] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/k26-sm/k26-sm-2023.2_1002_1.xsa'
BRANCHARG[k26-sm] = 'name=k26-sm'
SRC_URI[k26-sm.sha256sum] = '43c992937f2edfb9c1e7e909da169c96e57450d02601d42c971630934728951b'

# k26-smk
HDF_BASE[k26-smk] = 'https://'
HDF_PATH[k26-smk] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/k26-smk/k26-smk-2023.2_1002_1.xsa'
BRANCHARG[k26-smk] = 'name=k26-smk'
SRC_URI[k26-smk.sha256sum] = 'faeaeb9e923a279ccbecbdc8ccf2810bfee7bd092965566d71da49b1960875df'

# k26-smk-kr
HDF_BASE[k26-smk-kr] = 'https://'
HDF_PATH[k26-smk-kr] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/k26-smk-kr/k26-smk-kr-2023.2_1002_1.xsa'
BRANCHARG[k26-smk-kr] = 'name=k26-smk-kr'
SRC_URI[k26-smk-kr.sha256sum] = 'eea32ca3461e1c02cc093648a5279248138a46f6861001fd01e74af1997540c5'

# k26-smk-kv
HDF_BASE[k26-smk-kv] = 'https://'
HDF_PATH[k26-smk-kv] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/k26-smk-kv/k26-smk-kv-2023.2_1002_1.xsa'
BRANCHARG[k26-smk-kv] = 'name=k26-smk-kv'
SRC_URI[k26-smk-kv.sha256sum] = '52329cae55181817235cdb582118a75a629ae67e7593e121db4a450317ff4721'

# kc705-microblazeel
HDF_BASE[kc705-microblazeel] = 'https://'
HDF_PATH[kc705-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/kc705-microblazeel/kc705-microblazeel-2023.2_1002_1.xsa'
BRANCHARG[kc705-microblazeel] = 'name=kc705-microblazeel'
SRC_URI[kc705-microblazeel.sha256sum] = '145409c32e14e6b262ad824f5010f716764ae29f5bf95cc342dd6cc0556a3aa8'

# kcu105-microblazeel
HDF_BASE[kcu105-microblazeel] = 'https://'
HDF_PATH[kcu105-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/kcu105-microblazeel/kcu105-microblazeel-2023.2_1002_1.xsa'
BRANCHARG[kcu105-microblazeel] = 'name=kcu105-microblazeel'
SRC_URI[kcu105-microblazeel.sha256sum] = 'fa69515c357edac92227c5ede8bd9d9c1da88880f23faeb8cbb178c831f60fa8'

# sp701-microblazeel
HDF_BASE[sp701-microblazeel] = 'https://'
HDF_PATH[sp701-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/sp701-microblazeel/sp701-microblazeel-2023.2_1002_1.xsa'
BRANCHARG[sp701-microblazeel] = 'name=sp701-microblazeel'
SRC_URI[sp701-microblazeel.sha256sum] = '5bf9ea49031a5b71460f8c15941fa0c4d8639c50609ef46ef0d87138baac097d'

# ultra96-zynqmp
HDF_BASE[ultra96-zynqmp] = 'https://'
HDF_PATH[ultra96-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/ultra96-zynqmp/ultra96-zynqmp-2023.2_1002_1.xsa'
BRANCHARG[ultra96-zynqmp] = 'name=ultra96-zynqmp'
SRC_URI[ultra96-zynqmp.sha256sum] = 'b19f9c8cdf98c5323b622ecc7090e9ad2af7f686219160648e20e0514bf43b69'

# vck190-emmc-versal
HDF_BASE[vck190-emmc-versal] = 'https://'
HDF_PATH[vck190-emmc-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/vck190-emmc-versal/vck190-emmc-versal-2023.2_1002_1.xsa'
BRANCHARG[vck190-emmc-versal] = 'name=vck190-emmc-versal'
SRC_URI[vck190-emmc-versal.sha256sum] = '5bc20e4224767f695567d21ca5cfe672e1090748d7761883f3525afc339b486a'

# vck190-ospi-versal
HDF_BASE[vck190-ospi-versal] = 'https://'
HDF_PATH[vck190-ospi-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/vck190-ospi-versal/vck190-ospi-versal-2023.2_1002_1.xsa'
BRANCHARG[vck190-ospi-versal] = 'name=vck190-ospi-versal'
SRC_URI[vck190-ospi-versal.sha256sum] = 'c20bd7813b4bc2509b68ea6f1555d2acd077f417281a4d136b01da2a2969a5e0'

# vck190-versal
HDF_BASE[vck190-versal] = 'https://'
HDF_PATH[vck190-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/vck190-versal/vck190-versal-2023.2_1002_1.xsa'
BRANCHARG[vck190-versal] = 'name=vck190-versal'
SRC_URI[vck190-versal.sha256sum] = '5ca5f3bfd485288fd66259bb08cd5dcb1db781339d5df53023f00d2c80c5130a'

# vck-sc-zynqmp
HDF_BASE[vck-sc-zynqmp] = 'https://'
HDF_PATH[vck-sc-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/vck-sc-zynqmp/vck-sc-zynqmp-2023.2_1002_1.xsa'
BRANCHARG[vck-sc-zynqmp] = 'name=vck-sc-zynqmp'
SRC_URI[vck-sc-zynqmp.sha256sum] = 'e10af96328f72de2b948da605e3fd0e93ba99988f261363fd5ee17efce22393d'

# vcu118-microblazeel
HDF_BASE[vcu118-microblazeel] = 'https://'
HDF_PATH[vcu118-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/vcu118-microblazeel/vcu118-microblazeel-2023.2_1002_1.xsa'
BRANCHARG[vcu118-microblazeel] = 'name=vcu118-microblazeel'
SRC_URI[vcu118-microblazeel.sha256sum] = '8dc7b5be0286089324908d2e3db41d6dd1e346d779db89f074076f89d1d86109'

# versal-net-generic
HDF_BASE[versal-net-generic] = 'https://'
HDF_PATH[versal-net-generic] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/versal-net-generic/versal-net-generic-2023.2_0810_1.xsa'
BRANCHARG[versal-net-generic] = 'name=versal-net-generic'
SRC_URI[versal-net-generic.sha256sum] = 'fda7601b7d812a1ba97dad365f989c2f2665baf56ba5db79d7a38e7d3dea002f'

# vmk180-emmc-versal
HDF_BASE[vmk180-emmc-versal] = 'https://'
HDF_PATH[vmk180-emmc-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/vmk180-emmc-versal/vmk180-emmc-versal-2023.2_1002_1.xsa'
BRANCHARG[vmk180-emmc-versal] = 'name=vmk180-emmc-versal'
SRC_URI[vmk180-emmc-versal.sha256sum] = 'af0621f2c6fd6ddeae28d5377b395a64a4957089ff37dde429211958ed715cf1'

# vmk180-ospi-versal
HDF_BASE[vmk180-ospi-versal] = 'https://'
HDF_PATH[vmk180-ospi-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/vmk180-ospi-versal/vmk180-ospi-versal-2023.2_1002_1.xsa'
BRANCHARG[vmk180-ospi-versal] = 'name=vmk180-ospi-versal'
SRC_URI[vmk180-ospi-versal.sha256sum] = 'a334211e7904d683d8374745f5b7e2e70989cd984b5816a610d03a196373c2c5'

# vmk180-versal
HDF_BASE[vmk180-versal] = 'https://'
HDF_PATH[vmk180-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/vmk180-versal/vmk180-versal-2023.2_1002_1.xsa'
BRANCHARG[vmk180-versal] = 'name=vmk180-versal'
SRC_URI[vmk180-versal.sha256sum] = 'd97df17f1863ae5cb76691784f186df3b9c1e73942542093d901be8ffce32e33'

# vpk120-versal
HDF_BASE[vpk120-versal] = 'https://'
HDF_PATH[vpk120-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/vpk120-versal/vpk120-versal-2023.2_1002_1.xsa'
BRANCHARG[vpk120-versal] = 'name=vpk120-versal'
SRC_URI[vpk120-versal.sha256sum] = 'c8d69c3e0e97e82e95ad35f09fdac514e1790f2f3444fa60386f013e2a9758af'

# vpk180-versal
HDF_BASE[vpk180-versal] = 'https://'
HDF_PATH[vpk180-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/vpk180-versal/vpk180-versal-2023.2_1002_1.xsa'
BRANCHARG[vpk180-versal] = 'name=vpk180-versal'
SRC_URI[vpk180-versal.sha256sum] = 'c38c97b47749619c0c3e6996d2d434d0fcc462080405a9f9f9918a2b1452f33e'

# zc702-zynq7
HDF_BASE[zc702-zynq7] = 'https://'
HDF_PATH[zc702-zynq7] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/zc702-zynq7/zc702-zynq7-2023.2_1002_1.xsa'
BRANCHARG[zc702-zynq7] = 'name=zc702-zynq7'
SRC_URI[zc702-zynq7.sha256sum] = 'b9086e721d13aa0ddd3b8a8d9cfcf40fe044e3fb733b6921091f2acfe064fe63'

# zc706-zynq7
HDF_BASE[zc706-zynq7] = 'https://'
HDF_PATH[zc706-zynq7] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/zc706-zynq7/zc706-zynq7-2023.2_1002_1.xsa'
BRANCHARG[zc706-zynq7] = 'name=zc706-zynq7'
SRC_URI[zc706-zynq7.sha256sum] = '61308981b54e1843b596be8bd7d612e0e0c67c39df40c2bfc7d7c7a3662184d8'

# zcu102-zynqmp
HDF_BASE[zcu102-zynqmp] = 'https://'
HDF_PATH[zcu102-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/zcu102-zynqmp/zcu102-zynqmp-2023.2_1002_1.xsa'
BRANCHARG[zcu102-zynqmp] = 'name=zcu102-zynqmp'
SRC_URI[zcu102-zynqmp.sha256sum] = '14d6a45fcdfaec7e5225575a74cfa7fc109c0bb9192b641ed5afc823b597a7ba'

# zcu104-zynqmp
HDF_BASE[zcu104-zynqmp] = 'https://'
HDF_PATH[zcu104-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/zcu104-zynqmp/zcu104-zynqmp-2023.2_1002_1.xsa'
BRANCHARG[zcu104-zynqmp] = 'name=zcu104-zynqmp'
SRC_URI[zcu104-zynqmp.sha256sum] = '334c4d82e6d4a7efa313e0c2f78a90c90a60e69366869360d1afd8b790aaa80b'

# zcu106-zynqmp
HDF_BASE[zcu106-zynqmp] = 'https://'
HDF_PATH[zcu106-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/zcu106-zynqmp/zcu106-zynqmp-2023.2_1002_1.xsa'
BRANCHARG[zcu106-zynqmp] = 'name=zcu106-zynqmp'
SRC_URI[zcu106-zynqmp.sha256sum] = 'ab78c53d0991da77c6c6335713e93d492b7b7e3810244a5bc6f8c55f04a5a081'

# zcu111-zynqmp
HDF_BASE[zcu111-zynqmp] = 'https://'
HDF_PATH[zcu111-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/zcu111-zynqmp/zcu111-zynqmp-2023.2_1002_1.xsa'
BRANCHARG[zcu111-zynqmp] = 'name=zcu111-zynqmp'
SRC_URI[zcu111-zynqmp.sha256sum] = 'f1cd1f77e79d1dcfaa82922a3f07254dea777ff660a55a42cb5676da42b63b36'

# zcu208-sdfec-zynqmp
HDF_BASE[zcu208-sdfec-zynqmp] = 'https://'
HDF_PATH[zcu208-sdfec-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/zcu208-sdfec-zynqmp/zcu208-sdfec-zynqmp-2023.2_1002_1.xsa'
BRANCHARG[zcu208-sdfec-zynqmp] = 'name=zcu208-sdfec-zynqmp'
SRC_URI[zcu208-sdfec-zynqmp.sha256sum] = '5f30196287450b5827a7139afff4ac3a1ca171fed29cab25dba97e1980716edc'

# zcu208-zynqmp
HDF_BASE[zcu208-zynqmp] = 'https://'
HDF_PATH[zcu208-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/zcu208-zynqmp/zcu208-zynqmp-2023.2_1002_1.xsa'
BRANCHARG[zcu208-zynqmp] = 'name=zcu208-zynqmp'
SRC_URI[zcu208-zynqmp.sha256sum] = '700a3e99fadde2c194c56e88a9c732aaa2069a06a0c392687b41f6b3be84cd30'

# zcu216-zynqmp
HDF_BASE[zcu216-zynqmp] = 'https://'
HDF_PATH[zcu216-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_1002_1_10030058/external/zcu216-zynqmp/zcu216-zynqmp-2023.2_1002_1.xsa'
BRANCHARG[zcu216-zynqmp] = 'name=zcu216-zynqmp'
SRC_URI[zcu216-zynqmp.sha256sum] = 'b5acbd79b1cf84419014c238fadccd829689cb0f06a988072cd9cb4cf4da3233'
