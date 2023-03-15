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
HDF_PATH[ac701-microblazeel] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/ac701-microblazeel/ac701-microblazeel-2023.1_0313_1.xsa'
BRANCHARG[ac701-microblazeel] = 'name=ac701-microblazeel'
SRC_URI[ac701-microblazeel.sha256sum] = '74264e353d554c7f192a87786df74bb3cd5e806e84fc3c98a3bb5b6bd80dbc16'

# eval-brd-sc
HDF_BASE[eval-brd-sc] = 'https://'
HDF_PATH[eval-brd-sc] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/eval-brd-sc/eval-brd-sc-2023.1_0313_1.xsa'
BRANCHARG[eval-brd-sc] = 'name=eval-brd-sc'
SRC_URI[eval-brd-sc.sha256sum] = '42b5bf37a836c0259c08098b43ba3cb0658e3d56abaf9925036c80544a2f40ed'

# k24-kd
HDF_BASE[k24-kd] = 'https://'
HDF_PATH[k24-kd] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/k24-kd/k24-kd-2023.1_0313_1.xsa'
BRANCHARG[k24-kd] = 'name=k24-kd'
SRC_URI[k24-kd.sha256sum] = 'efc20b22ac048f71a8c6c5b92887098f0ee2ccabd48d0e15dd4dd5c1a91c17b9'

# k24-kv
HDF_BASE[k24-kv] = 'https://'
HDF_PATH[k24-kv] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/k24-kv/k24-kv-2023.1_0309_1.xsa'
BRANCHARG[k24-kv] = 'name=k24-kv'
SRC_URI[k24-kv.sha256sum] = '9fbc8c13168d8364bf09cb1d1a811fc5e894f44c0c789314ae38dcbed17e6473'

# k24-sm
HDF_BASE[k24-sm] = 'https://'
HDF_PATH[k24-sm] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/k24-sm/k24-sm-2023.1_0313_1.xsa'
BRANCHARG[k24-sm] = 'name=k24-sm'
SRC_URI[k24-sm.sha256sum] = 'a53f83e720089c8f002dcb49895bfd5abc647b33fb75b324d9379b8040118102'

# k24-smk
HDF_BASE[k24-smk] = 'https://'
HDF_PATH[k24-smk] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/k24-smk/k24-smk-2023.1_0313_1.xsa'
BRANCHARG[k24-smk] = 'name=k24-smk'
SRC_URI[k24-smk.sha256sum] = 'c0a30685fb48b0db053d20081441abba70c4300ad177a033d6e8c5848be039e6'

# k26-kr
HDF_BASE[k26-kr] = 'https://'
HDF_PATH[k26-kr] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/k26-kr/k26-kr-2023.1_0309_1.xsa'
BRANCHARG[k26-kr] = 'name=k26-kr'
SRC_URI[k26-kr.sha256sum] = 'ba3fe56c8dace72d8a519fd205831775027492ec30bdd918b372595821d40a38'

# k26-kv
HDF_BASE[k26-kv] = 'https://'
HDF_PATH[k26-kv] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/k26-kv/k26-kv-2023.1_0309_1.xsa'
BRANCHARG[k26-kv] = 'name=k26-kv'
SRC_URI[k26-kv.sha256sum] = 'f25ff509e371706b934cb9f4aacfc9284d2a9c4df24967f109a197f419b33e1f'

# k26-sm
HDF_BASE[k26-sm] = 'https://'
HDF_PATH[k26-sm] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/k26-sm/k26-sm-2023.1_0309_1.xsa'
BRANCHARG[k26-sm] = 'name=k26-sm'
SRC_URI[k26-sm.sha256sum] = 'effe88361c9d0acd48a58c72dded7ee520225e963cde57292046f43c38c8eb5d'

# k26-smk
HDF_BASE[k26-smk] = 'https://'
HDF_PATH[k26-smk] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/k26-smk/k26-smk-2023.1_0309_1.xsa'
BRANCHARG[k26-smk] = 'name=k26-smk'
SRC_URI[k26-smk.sha256sum] = '1f9c24106969789cdc9a7dd1a772222c6e5a40ee668bf514e0ca682bb98863f6'

# kc705-microblazeel
HDF_BASE[kc705-microblazeel] = 'https://'
HDF_PATH[kc705-microblazeel] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/kc705-microblazeel/kc705-microblazeel-2023.1_0313_1.xsa'
BRANCHARG[kc705-microblazeel] = 'name=kc705-microblazeel'
SRC_URI[kc705-microblazeel.sha256sum] = 'ea26639b4a20cd39a87403c9e0a6b88b881211bcb1ba528e20bd6f3d5081aed6'

# kcu105-microblazeel
HDF_BASE[kcu105-microblazeel] = 'https://'
HDF_PATH[kcu105-microblazeel] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/kcu105-microblazeel/kcu105-microblazeel-2023.1_0313_1.xsa'
BRANCHARG[kcu105-microblazeel] = 'name=kcu105-microblazeel'
SRC_URI[kcu105-microblazeel.sha256sum] = '850084bd58f8addc36051532cf57845dcedea04ab0c26403c8e83c42f6b40629'

# microblaze-generic
HDF_BASE[microblaze-generic] = 'https://'
HDF_PATH[microblaze-generic] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/microblaze-generic/microblaze-generic.xsa'
BRANCHARG[microblaze-generic] = 'name=microblaze-generic'
SRC_URI[microblaze-generic.sha256sum] = 'd85dd540eb0c7c19e1e683761780aea5fc895136b5e43087e74c58d719bace00'

# ultra96-zynqmp
HDF_BASE[ultra96-zynqmp] = 'https://'
HDF_PATH[ultra96-zynqmp] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/ultra96-zynqmp/ultra96-zynqmp-2023.1_0313_1.xsa'
BRANCHARG[ultra96-zynqmp] = 'name=ultra96-zynqmp'
SRC_URI[ultra96-zynqmp.sha256sum] = '6ae8c17548b5492962f5ca6e192b4b969b7e52a2aa9a22f53b165187a92662d4'

# vck190-versal
HDF_BASE[vck190-versal] = 'https://'
HDF_PATH[vck190-versal] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/vck190-versal/vck190-versal-2023.1_0312_1.xsa'
BRANCHARG[vck190-versal] = 'name=vck190-versal'
SRC_URI[vck190-versal.sha256sum] = '2804ee4efca63f639ffa3318b153281ed8c27e594827a1984bba878b73480445'

# vck5000-versal
HDF_BASE[vck5000-versal] = 'https://'
HDF_PATH[vck5000-versal] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/vck5000-versal/vck5000-versal-2023.1_0313_1.xsa'
BRANCHARG[vck5000-versal] = 'name=vck5000-versal'
SRC_URI[vck5000-versal.sha256sum] = 'f897defe2da2974be6986a2013d9ba4817ab9e5bac2ceb20e1e166e561d5a511'

# vck-sc-zynqmp
HDF_BASE[vck-sc-zynqmp] = 'https://'
HDF_PATH[vck-sc-zynqmp] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/vck-sc-zynqmp/vck-sc-zynqmp-2023.1_0313_1.xsa'
BRANCHARG[vck-sc-zynqmp] = 'name=vck-sc-zynqmp'
SRC_URI[vck-sc-zynqmp.sha256sum] = '07c6e51e9debc72c4365228b65ba9195cad305553964c6d9bbd55b4820a96e0b'

# vcu118-microblazeel
HDF_BASE[vcu118-microblazeel] = 'https://'
HDF_PATH[vcu118-microblazeel] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/vcu118-microblazeel/vcu118-microblazeel-2023.1_0313_1.xsa'
BRANCHARG[vcu118-microblazeel] = 'name=vcu118-microblazeel'
SRC_URI[vcu118-microblazeel.sha256sum] = 'a157b80ca7842d10bf6047794345b3fe83de3da711b5a0abd368d02a3c3516e8'

# vek280-versal
HDF_BASE[vek280-versal] = 'https://'
HDF_PATH[vek280-versal] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/vek280-versal/vek280-versal-2023.1_0313_1.xsa'
BRANCHARG[vek280-versal] = 'name=vek280-versal'
SRC_URI[vek280-versal.sha256sum] = 'f1c1bc1ed1b0f95735bb631d5e1619f9e8e1a4e85126acfda709545c8e12a1ce'

# versal-generic
HDF_BASE[versal-generic] = 'https://'
HDF_PATH[versal-generic] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/versal-generic/versal-generic.xsa'
BRANCHARG[versal-generic] = 'name=versal-generic'
SRC_URI[versal-generic.sha256sum] = 'c1533005887a83791a89bbacc3b56935ba10b1938c7a8a16d48026370236d72c'

# versal-net-generic
HDF_BASE[versal-net-generic] = 'https://'
HDF_PATH[versal-net-generic] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/versal-net-generic/versal-net-generic.xsa'
BRANCHARG[versal-net-generic] = 'name=versal-net-generic'
SRC_URI[versal-net-generic.sha256sum] = '22f5042545c86e1f099c8a71f6a8d2b6d81eec0d98000f3b13538262452d33eb'

# vhk158-versal
HDF_BASE[vhk158-versal] = 'https://'
HDF_PATH[vhk158-versal] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/vhk158-versal/vhk158-versal-2023.1_0313_1.xsa'
BRANCHARG[vhk158-versal] = 'name=vhk158-versal'
SRC_URI[vhk158-versal.sha256sum] = '925abda7f9f5287db19ee738df32b1fd69e1abaec1a4cfad60b9aca6a4a9925b'

# vmk180-versal
HDF_BASE[vmk180-versal] = 'https://'
HDF_PATH[vmk180-versal] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/vmk180-versal/vmk180-versal-2023.1_0313_1.xsa'
BRANCHARG[vmk180-versal] = 'name=vmk180-versal'
SRC_URI[vmk180-versal.sha256sum] = 'c2c6a95f7f4537627cd9463ef0749fa1501b80864e1578998f62c5473813fd9b'

# vpk120-versal
HDF_BASE[vpk120-versal] = 'https://'
HDF_PATH[vpk120-versal] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/vpk120-versal/vpk120-versal-2023.1_0313_1.xsa'
BRANCHARG[vpk120-versal] = 'name=vpk120-versal'
SRC_URI[vpk120-versal.sha256sum] = 'a7eb20c96b7e71fc5e5e4952cf1b82f752a07316fb51466d02394f2189c2aac4'

# vpk180-versal
HDF_BASE[vpk180-versal] = 'https://'
HDF_PATH[vpk180-versal] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/vpk180-versal/vpk180-versal-2023.1_0313_1.xsa'
BRANCHARG[vpk180-versal] = 'name=vpk180-versal'
SRC_URI[vpk180-versal.sha256sum] = 'dba59cfbe1799864e73c68ff51acfb305b42874823ed49ec6aca20663d6a37ed'

# zc1751-zynqmp
HDF_BASE[zc1751-zynqmp] = 'https://'
HDF_PATH[zc1751-zynqmp] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/zc1751-zynqmp/zc1751-zynqmp-2023.1_0313_1.xsa'
BRANCHARG[zc1751-zynqmp] = 'name=zc1751-zynqmp'
SRC_URI[zc1751-zynqmp.sha256sum] = '6aa24dec5eb32a9d394445d4baf4b22802d72e32ed16f465e822781c2885c35a'

# zc702-zynq7
HDF_BASE[zc702-zynq7] = 'https://'
HDF_PATH[zc702-zynq7] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/zc702-zynq7/zc702-zynq7-2023.1_0313_1.xsa'
BRANCHARG[zc702-zynq7] = 'name=zc702-zynq7'
SRC_URI[zc702-zynq7.sha256sum] = 'f7ac60f577929c3abf955c6e526c719cf9400988c5f837b073e05c74159971b9'

# zc706-zynq7
HDF_BASE[zc706-zynq7] = 'https://'
HDF_PATH[zc706-zynq7] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/zc706-zynq7/zc706-zynq7-2023.1_0313_1.xsa'
BRANCHARG[zc706-zynq7] = 'name=zc706-zynq7'
SRC_URI[zc706-zynq7.sha256sum] = '459cbe54619086c730911aecb90fde2f43e73053edec4a4edb476e216bdb6e41'

# zcu102-zynqmp
HDF_BASE[zcu102-zynqmp] = 'https://'
HDF_PATH[zcu102-zynqmp] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/zcu102-zynqmp/zcu102-zynqmp-2023.1_0313_1.xsa'
BRANCHARG[zcu102-zynqmp] = 'name=zcu102-zynqmp'
SRC_URI[zcu102-zynqmp.sha256sum] = '82725b334db94f8f5dd9f11ca742c95af0e0f895ad7c8a1d3515f096c6b9e0c6'

# zcu104-zynqmp
HDF_BASE[zcu104-zynqmp] = 'https://'
HDF_PATH[zcu104-zynqmp] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/zcu104-zynqmp/zcu104-zynqmp-2023.1_0313_1.xsa'
BRANCHARG[zcu104-zynqmp] = 'name=zcu104-zynqmp'
SRC_URI[zcu104-zynqmp.sha256sum] = '1e3b4c7bec8ef8a4731039a1694309d2fe425ea67a9b4188e9e9691100d0cd22'

# zcu106-zynqmp
HDF_BASE[zcu106-zynqmp] = 'https://'
HDF_PATH[zcu106-zynqmp] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/zcu106-zynqmp/zcu106-zynqmp-2023.1_0313_1.xsa'
BRANCHARG[zcu106-zynqmp] = 'name=zcu106-zynqmp'
SRC_URI[zcu106-zynqmp.sha256sum] = '3e73d57b5e3857dcef8e6ac793f6c6c45dfd3a5a00e0ec65350b82f0b5277f93'

# zcu111-zynqmp
HDF_BASE[zcu111-zynqmp] = 'https://'
HDF_PATH[zcu111-zynqmp] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/zcu111-zynqmp/zcu111-zynqmp-2023.1_0313_1.xsa'
BRANCHARG[zcu111-zynqmp] = 'name=zcu111-zynqmp'
SRC_URI[zcu111-zynqmp.sha256sum] = 'ef8dc9bd374bbdb62c17de6564d96986ec2ca2b2ecabbd8137c78b0bb9d64257'

# zcu1275-zynqmp
HDF_BASE[zcu1275-zynqmp] = 'https://'
HDF_PATH[zcu1275-zynqmp] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/zcu1275-zynqmp/zcu1275-zynqmp-2023.1_0313_1.xsa'
BRANCHARG[zcu1275-zynqmp] = 'name=zcu1275-zynqmp'
SRC_URI[zcu1275-zynqmp.sha256sum] = 'f7242f2a387e05b3ce450cb0a4e81aeb92d5bd6604273c33cde8bdddea7f87f7'

# zcu1285-zynqmp
HDF_BASE[zcu1285-zynqmp] = 'https://'
HDF_PATH[zcu1285-zynqmp] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/zcu1285-zynqmp/zcu1285-zynqmp-2023.1_0313_1.xsa'
BRANCHARG[zcu1285-zynqmp] = 'name=zcu1285-zynqmp'
SRC_URI[zcu1285-zynqmp.sha256sum] = '265880a8fd507a75975d46de9430ec041acf919b84f729704df517048453902d'

# zcu208-zynqmp
HDF_BASE[zcu208-zynqmp] = 'https://'
HDF_PATH[zcu208-zynqmp] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/zcu208-zynqmp/zcu208-zynqmp-2023.1_0313_1.xsa'
BRANCHARG[zcu208-zynqmp] = 'name=zcu208-zynqmp'
SRC_URI[zcu208-zynqmp.sha256sum] = 'e85569fcd63bfc2657d181d284b4420b2394d505bcff6c5f31d5d09ccfacd4a1'

# zcu216-zynqmp
HDF_BASE[zcu216-zynqmp] = 'https://'
HDF_PATH[zcu216-zynqmp] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/zcu216-zynqmp/zcu216-zynqmp-2023.1_0313_1.xsa'
BRANCHARG[zcu216-zynqmp] = 'name=zcu216-zynqmp'
SRC_URI[zcu216-zynqmp.sha256sum] = '47650376159d438670c4a762cc32bd7eb109abb3794f28bda89123eeaf811c8b'

# zcu670-zynqmp
HDF_BASE[zcu670-zynqmp] = 'https://'
HDF_PATH[zcu670-zynqmp] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/zcu670-zynqmp/zcu670-zynqmp.xsa'
BRANCHARG[zcu670-zynqmp] = 'name=zcu670-zynqmp'
SRC_URI[zcu670-zynqmp.sha256sum] = 'f98d19a45c039187e3164745ab6eff79641887838d7f8d6b0cfadcc953148a6c'

# zynq-generic
HDF_BASE[zynq-generic] = 'https://'
HDF_PATH[zynq-generic] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/zynq-generic/zynq-generic.xsa'
BRANCHARG[zynq-generic] = 'name=zynq-generic'
SRC_URI[zynq-generic.sha256sum] = '13f64b348a54df7e56b56870b5ad06217dd49f1250345c55d7c8b163ea5fa406'

# zynqmp-generic
HDF_BASE[zynqmp-generic] = 'https://'
HDF_PATH[zynqmp-generic] = 'petalinux.xilinx.com/sswreleases/internal/rel-v2023/hdf-examples/2023.1/2023.1_0313_1_03140327/zynqmp-generic/zynqmp-generic.xsa'
BRANCHARG[zynqmp-generic] = 'name=zynqmp-generic'
SRC_URI[zynqmp-generic.sha256sum] = '74c1609f64f4d5c361a31664e396b33ce5d1a4786450ded85c11cdb1e51178e2'
