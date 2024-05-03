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
HDF_PATH[ac701-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/ac701-microblazeel/ac701-microblazeel-2024.1_0429_1.xsa'
BRANCHARG[ac701-microblazeel] = 'name=ac701-microblazeel'
SRC_URI[ac701-microblazeel.sha256sum] = 'bf4a771328a3909212c3c1c342cc7a88e522714d50aacfa842e62c5ee15031d0'

# eval-brd-sc
HDF_BASE[eval-brd-sc] = 'https://'
HDF_PATH[eval-brd-sc] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/eval-brd-sc/eval-brd-sc-2024.1_0429_1.xsa'
BRANCHARG[eval-brd-sc] = 'name=eval-brd-sc'
SRC_URI[eval-brd-sc.sha256sum] = '2bf98b912e39b0345172ffc5ba3112db76fea02885d78ade31a7bc7b24c3084c'

# k24c-sm
HDF_BASE[k24c-sm] = 'https://'
HDF_PATH[k24c-sm] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/k24c-sm/k24c-sm-2024.1_0429_1.xsa'
BRANCHARG[k24c-sm] = 'name=k24c-sm'
SRC_URI[k24c-sm.sha256sum] = '51545cef3e66157b320f3d2e9bd5c127770cd38f6eaca6b31b0b1c183c07f3cd'

# k24i-sm
HDF_BASE[k24i-sm] = 'https://'
HDF_PATH[k24i-sm] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/k24i-sm/k24i-sm-2024.1_0429_1.xsa'
BRANCHARG[k24i-sm] = 'name=k24i-sm'
SRC_URI[k24i-sm.sha256sum] = '27dca8cb23e027b137fdc5428a18d27c2f27dcf709053f97a05bf42a818dfc9a'

# k24-smk
HDF_BASE[k24-smk] = 'https://'
HDF_PATH[k24-smk] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/k24-smk/k24-smk-2024.1_0429_1.xsa'
BRANCHARG[k24-smk] = 'name=k24-smk'
SRC_URI[k24-smk.sha256sum] = '2fd20e480a1371fb75e5e1372c831548a9acc8fa0efd63ecb8f3e3892e980fe4'

# k24-smk-kd
HDF_BASE[k24-smk-kd] = 'https://'
HDF_PATH[k24-smk-kd] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/k24-smk-kd/k24-smk-kd-2024.1_0429_1.xsa'
BRANCHARG[k24-smk-kd] = 'name=k24-smk-kd'
SRC_URI[k24-smk-kd.sha256sum] = '0ad6a7cdbe7105c778c495bb31399964ee165a237a84560aa25f2fbec5cd4645'

# k26-sm
HDF_BASE[k26-sm] = 'https://'
HDF_PATH[k26-sm] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/k26-sm/k26-sm-2024.1_0429_1.xsa'
BRANCHARG[k26-sm] = 'name=k26-sm'
SRC_URI[k26-sm.sha256sum] = '5af32cb662936e8a28e66509438a9f70ab0906e6be23b816bbad289df6c95e91'

# k26-smk
HDF_BASE[k26-smk] = 'https://'
HDF_PATH[k26-smk] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/k26-smk/k26-smk-2024.1_0429_1.xsa'
BRANCHARG[k26-smk] = 'name=k26-smk'
SRC_URI[k26-smk.sha256sum] = '78ea5301fdbcccee2371c3e6241e1ea123e12bc0273b00283cfb65f2a82c2e9c'

# k26-smk-kr
HDF_BASE[k26-smk-kr] = 'https://'
HDF_PATH[k26-smk-kr] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/k26-smk-kr/k26-smk-kr-2024.1_0429_1.xsa'
BRANCHARG[k26-smk-kr] = 'name=k26-smk-kr'
SRC_URI[k26-smk-kr.sha256sum] = 'e9c84b3019e300af3ab8f796b5994ddd8cdaef15df0ef7d8ee04290660b698ab'

# k26-smk-kv
HDF_BASE[k26-smk-kv] = 'https://'
HDF_PATH[k26-smk-kv] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/k26-smk-kv/k26-smk-kv-2024.1_0429_1.xsa'
BRANCHARG[k26-smk-kv] = 'name=k26-smk-kv'
SRC_URI[k26-smk-kv.sha256sum] = '116f9a30f5b67b48561c41de12679982e1c7ab020b367ed1875f96473b30d842'

# kc705-microblazeel
HDF_BASE[kc705-microblazeel] = 'https://'
HDF_PATH[kc705-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/kc705-microblazeel/kc705-microblazeel-2024.1_0429_1.xsa'
BRANCHARG[kc705-microblazeel] = 'name=kc705-microblazeel'
SRC_URI[kc705-microblazeel.sha256sum] = 'bf160f1b5adbc9f70a9718bba104fe9f331afb274f854abb987ee00141a78158'

# kcu105-microblazeel
HDF_BASE[kcu105-microblazeel] = 'https://'
HDF_PATH[kcu105-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/kcu105-microblazeel/kcu105-microblazeel-2024.1_0429_1.xsa'
BRANCHARG[kcu105-microblazeel] = 'name=kcu105-microblazeel'
SRC_URI[kcu105-microblazeel.sha256sum] = '05d3ee70ef346ba7d890e5c131f351915c4ca5d2b70491feba2fcacbf9b1ef30'

# sp701-microblazeel
HDF_BASE[sp701-microblazeel] = 'https://'
HDF_PATH[sp701-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/sp701-microblazeel/sp701-microblazeel-2024.1_0429_1.xsa'
BRANCHARG[sp701-microblazeel] = 'name=sp701-microblazeel'
SRC_URI[sp701-microblazeel.sha256sum] = 'd26672937986531f36cd87f2754795bbb90df704a469f93ee491cb32a0d24482'

# ultra96-zynqmp
HDF_BASE[ultra96-zynqmp] = 'https://'
HDF_PATH[ultra96-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/ultra96-zynqmp/ultra96-zynqmp-2024.1_0429_1.xsa'
BRANCHARG[ultra96-zynqmp] = 'name=ultra96-zynqmp'
SRC_URI[ultra96-zynqmp.sha256sum] = 'e19ae51b86ba333246ca8d9707401eb7377cec516ca5480b7ec05b259b640285'

# vck190-emmc-versal
HDF_BASE[vck190-emmc-versal] = 'https://'
HDF_PATH[vck190-emmc-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/vck190-emmc-versal/vck190-emmc-versal-2024.1_0429_1.xsa'
BRANCHARG[vck190-emmc-versal] = 'name=vck190-emmc-versal'
SRC_URI[vck190-emmc-versal.sha256sum] = '41a4a36d3188f0afdeb47ef990af129b1d112a32643b1947a7348e0942a96444'

# vck190-ospi-versal
HDF_BASE[vck190-ospi-versal] = 'https://'
HDF_PATH[vck190-ospi-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/vck190-ospi-versal/vck190-ospi-versal-2024.1_0429_1.xsa'
BRANCHARG[vck190-ospi-versal] = 'name=vck190-ospi-versal'
SRC_URI[vck190-ospi-versal.sha256sum] = '00e18aec6281d7b7f65ae83d203d6d6d6a488d00ac2adde75c18cd36d3799ac8'

# vck190-versal
HDF_BASE[vck190-versal] = 'https://'
HDF_PATH[vck190-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/vck190-versal/vck190-versal-2024.1_0429_1.xsa'
BRANCHARG[vck190-versal] = 'name=vck190-versal'
SRC_URI[vck190-versal.sha256sum] = 'f918d738541ab5986bb28ef8eb5b7e907bb41b6224d959181f17fbb436c76fed'

# vck-sc-zynqmp
HDF_BASE[vck-sc-zynqmp] = 'https://'
HDF_PATH[vck-sc-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/vck-sc-zynqmp/vck-sc-zynqmp-2024.1_0429_1.xsa'
BRANCHARG[vck-sc-zynqmp] = 'name=vck-sc-zynqmp'
SRC_URI[vck-sc-zynqmp.sha256sum] = '8ec84787e7eb1c5a7509e48b62094339ac836da0b9199082139aa63e50d27d34'

# vcu118-microblazeel
HDF_BASE[vcu118-microblazeel] = 'https://'
HDF_PATH[vcu118-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/vcu118-microblazeel/vcu118-microblazeel-2024.1_0429_1.xsa'
BRANCHARG[vcu118-microblazeel] = 'name=vcu118-microblazeel'
SRC_URI[vcu118-microblazeel.sha256sum] = '6b725fe58f4bd8fda62a042e7b3f6d2cb4e8f2041bd9942bdbf6fcf4c4dfd65b'

# vek280-versal
HDF_BASE[vek280-versal] = 'https://'
HDF_PATH[vek280-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/vek280-versal/vek280-versal-2024.1_0429_1.xsa'
BRANCHARG[vek280-versal] = 'name=vek280-versal'
SRC_URI[vek280-versal.sha256sum] = '53d387bda8b8ee9690415edf83daa24e1e3c72134d6720edee6b4a1562fe32e0'

# versal-net-generic
HDF_BASE[versal-net-generic] = 'https://'
HDF_PATH[versal-net-generic] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/versal-net-generic/versal-net-generic-2024.1_0418_1.xsa'
BRANCHARG[versal-net-generic] = 'name=versal-net-generic'
SRC_URI[versal-net-generic.sha256sum] = 'acf2cb44e3a3b130fe1f94ce311d4c03f9c9632ccbf6bcab66d6ce92ba8038fc'

# vmk180-emmc-versal
HDF_BASE[vmk180-emmc-versal] = 'https://'
HDF_PATH[vmk180-emmc-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/vmk180-emmc-versal/vmk180-emmc-versal-2024.1_0429_1.xsa'
BRANCHARG[vmk180-emmc-versal] = 'name=vmk180-emmc-versal'
SRC_URI[vmk180-emmc-versal.sha256sum] = '585c3ba71eff08bc3bc3dd166a7b822e4e620da4890ba9ea6f1a324ba7fcb726'

# vmk180-ospi-versal
HDF_BASE[vmk180-ospi-versal] = 'https://'
HDF_PATH[vmk180-ospi-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/vmk180-ospi-versal/vmk180-ospi-versal-2024.1_0429_1.xsa'
BRANCHARG[vmk180-ospi-versal] = 'name=vmk180-ospi-versal'
SRC_URI[vmk180-ospi-versal.sha256sum] = '261872cc2bd00a7fcc038abe275fa12d445bf4850c7bdd3ec659eedab06e982f'

# vmk180-versal
HDF_BASE[vmk180-versal] = 'https://'
HDF_PATH[vmk180-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/vmk180-versal/vmk180-versal-2024.1_0429_1.xsa'
BRANCHARG[vmk180-versal] = 'name=vmk180-versal'
SRC_URI[vmk180-versal.sha256sum] = '85c31886baf34baca9ecfa2bf84773e079bcd7e4312f25820964287ee1bc025a'

# vpk120-versal
HDF_BASE[vpk120-versal] = 'https://'
HDF_PATH[vpk120-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/vpk120-versal/vpk120-versal-2024.1_0429_1.xsa'
BRANCHARG[vpk120-versal] = 'name=vpk120-versal'
SRC_URI[vpk120-versal.sha256sum] = 'e27e289e2d9f2f07a062374bceae2d28cf4f1d8318e455e48c6bde1938f24de4'

# vpk180-versal
HDF_BASE[vpk180-versal] = 'https://'
HDF_PATH[vpk180-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/vpk180-versal/vpk180-versal-2024.1_0429_1.xsa'
BRANCHARG[vpk180-versal] = 'name=vpk180-versal'
SRC_URI[vpk180-versal.sha256sum] = '9544a6b9ff25f2f409f0b89e19e07d8383528b28eb1389886d349966d26072c3'

# zc702-zynq7
HDF_BASE[zc702-zynq7] = 'https://'
HDF_PATH[zc702-zynq7] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/zc702-zynq7/zc702-zynq7-2024.1_0429_1.xsa'
BRANCHARG[zc702-zynq7] = 'name=zc702-zynq7'
SRC_URI[zc702-zynq7.sha256sum] = 'e9502f647f90f90d98d1649b6f242beaa84accfe5fc758956202ba5dc52d8f4f'

# zc706-zynq7
HDF_BASE[zc706-zynq7] = 'https://'
HDF_PATH[zc706-zynq7] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/zc706-zynq7/zc706-zynq7-2024.1_0429_1.xsa'
BRANCHARG[zc706-zynq7] = 'name=zc706-zynq7'
SRC_URI[zc706-zynq7.sha256sum] = '7d8788cd3de633bff43f52a41a9993923ef685912f50c69a0fd0cb31fd6bf693'

# zcu102-zynqmp
HDF_BASE[zcu102-zynqmp] = 'https://'
HDF_PATH[zcu102-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/zcu102-zynqmp/zcu102-zynqmp-2024.1_0429_1.xsa'
BRANCHARG[zcu102-zynqmp] = 'name=zcu102-zynqmp'
SRC_URI[zcu102-zynqmp.sha256sum] = '6b2bd4e6de5f2c731705fe852d44e532e029e8be141d0a8f25d5a271debe0ac6'

# zcu104-zynqmp
HDF_BASE[zcu104-zynqmp] = 'https://'
HDF_PATH[zcu104-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/zcu104-zynqmp/zcu104-zynqmp-2024.1_0429_1.xsa'
BRANCHARG[zcu104-zynqmp] = 'name=zcu104-zynqmp'
SRC_URI[zcu104-zynqmp.sha256sum] = '6832d8606d4325b97451dbea1ecb1e29043c14322cdfe9ebc581cdc7415f90b6'

# zcu106-zynqmp
HDF_BASE[zcu106-zynqmp] = 'https://'
HDF_PATH[zcu106-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/zcu106-zynqmp/zcu106-zynqmp-2024.1_0429_1.xsa'
BRANCHARG[zcu106-zynqmp] = 'name=zcu106-zynqmp'
SRC_URI[zcu106-zynqmp.sha256sum] = 'c7f6b0d99a3b8f2c68b2c78970efe7a5d66520792c8f71560deed84a0a120b1e'

# zcu111-zynqmp
HDF_BASE[zcu111-zynqmp] = 'https://'
HDF_PATH[zcu111-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/zcu111-zynqmp/zcu111-zynqmp-2024.1_0429_1.xsa'
BRANCHARG[zcu111-zynqmp] = 'name=zcu111-zynqmp'
SRC_URI[zcu111-zynqmp.sha256sum] = '4a3d8966ff0e8abf1ba018197b2b461de66afcc1cde69d8ecb6d5421c85e7106'

# zcu208-sdfec-zynqmp
HDF_BASE[zcu208-sdfec-zynqmp] = 'https://'
HDF_PATH[zcu208-sdfec-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/zcu208-sdfec-zynqmp/zcu208-sdfec-zynqmp-2024.1_0429_1.xsa'
BRANCHARG[zcu208-sdfec-zynqmp] = 'name=zcu208-sdfec-zynqmp'
SRC_URI[zcu208-sdfec-zynqmp.sha256sum] = 'ee9449c7dce1077c910c4eb704acd536b68ff50055857646923bb0e0a4ffac68'

# zcu208-zynqmp
HDF_BASE[zcu208-zynqmp] = 'https://'
HDF_PATH[zcu208-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/zcu208-zynqmp/zcu208-zynqmp-2024.1_0429_1.xsa'
BRANCHARG[zcu208-zynqmp] = 'name=zcu208-zynqmp'
SRC_URI[zcu208-zynqmp.sha256sum] = '69184c2ceb564c8dd0593d1495ab2fcaa66a11dd0ba37025169de1314d2bf3f6'

# zcu216-zynqmp
HDF_BASE[zcu216-zynqmp] = 'https://'
HDF_PATH[zcu216-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/zcu216-zynqmp/zcu216-zynqmp-2024.1_0429_1.xsa'
BRANCHARG[zcu216-zynqmp] = 'name=zcu216-zynqmp'
SRC_URI[zcu216-zynqmp.sha256sum] = '037ec13a202a08464c719f76cc8b3c3eea9fb15cba1e0811e1bc664508100323'

# zcu670-zynqmp
HDF_BASE[zcu670-zynqmp] = 'https://'
HDF_PATH[zcu670-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0429_1_04292211/external/zcu670-zynqmp/zcu670-zynqmp.xsa'
BRANCHARG[zcu670-zynqmp] = 'name=zcu670-zynqmp'
SRC_URI[zcu670-zynqmp.sha256sum] = '7ef9bae62ace1c96ce784477e110d8c47c86417b4340ad121d71bf09cd2fae16'
