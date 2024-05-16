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
HDF_PATH[ac701-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/ac701-microblazeel/ac701-microblazeel-2024.1_0515_1.xsa'
BRANCHARG[ac701-microblazeel] = 'name=ac701-microblazeel'
SRC_URI[ac701-microblazeel.sha256sum] = 'a069348db3bbbed78ecfd928ad1ee4691db6576076dc06c80b716149f9a2ef8c'

# eval-brd-sc
HDF_BASE[eval-brd-sc] = 'https://'
HDF_PATH[eval-brd-sc] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/eval-brd-sc/eval-brd-sc-2024.1_0515_1.xsa'
BRANCHARG[eval-brd-sc] = 'name=eval-brd-sc'
SRC_URI[eval-brd-sc.sha256sum] = '7099106bde634f54a079c1621f3b291dee551bc2c073b6d056a7469cf559935b'

# k24c-sm
HDF_BASE[k24c-sm] = 'https://'
HDF_PATH[k24c-sm] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/k24c-sm/k24c-sm-2024.1_0515_1.xsa'
BRANCHARG[k24c-sm] = 'name=k24c-sm'
SRC_URI[k24c-sm.sha256sum] = '53acb29c212a88e8e189ed741d162efeb98038846691af3a736b875235467dfa'

# k24i-sm
HDF_BASE[k24i-sm] = 'https://'
HDF_PATH[k24i-sm] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/k24i-sm/k24i-sm-2024.1_0515_1.xsa'
BRANCHARG[k24i-sm] = 'name=k24i-sm'
SRC_URI[k24i-sm.sha256sum] = '10391abc36aea701a3623159061c391c0de2cb01c77a68f4b293e646e6f3308c'

# k24-smk
HDF_BASE[k24-smk] = 'https://'
HDF_PATH[k24-smk] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/k24-smk/k24-smk-2024.1_0515_1.xsa'
BRANCHARG[k24-smk] = 'name=k24-smk'
SRC_URI[k24-smk.sha256sum] = '9c21aeeb8e5bbd0cce805d265a9247c65a6f1ec33f08a3a9491c43d5e78580b2'

# k24-smk-kd
HDF_BASE[k24-smk-kd] = 'https://'
HDF_PATH[k24-smk-kd] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/k24-smk-kd/k24-smk-kd-2024.1_0515_1.xsa'
BRANCHARG[k24-smk-kd] = 'name=k24-smk-kd'
SRC_URI[k24-smk-kd.sha256sum] = '1abe7243c3534c703abe8b7e7ebc46bbfba67dce669b648f471fd8bc62221146'

# k26-sm
HDF_BASE[k26-sm] = 'https://'
HDF_PATH[k26-sm] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/k26-sm/k26-sm-2024.1_0515_1.xsa'
BRANCHARG[k26-sm] = 'name=k26-sm'
SRC_URI[k26-sm.sha256sum] = '62e566c2c18546c91e889ec45cb02eaf07af021d64cf43682faa43c271babeca'

# k26-smk
HDF_BASE[k26-smk] = 'https://'
HDF_PATH[k26-smk] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/k26-smk/k26-smk-2024.1_0515_1.xsa'
BRANCHARG[k26-smk] = 'name=k26-smk'
SRC_URI[k26-smk.sha256sum] = '0bc3856e4456e4eb47926f3fb2e9ccee4f35f63f11b944bcfd497f79cf7e378a'

# k26-smk-kr
HDF_BASE[k26-smk-kr] = 'https://'
HDF_PATH[k26-smk-kr] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/k26-smk-kr/k26-smk-kr-2024.1_0515_1.xsa'
BRANCHARG[k26-smk-kr] = 'name=k26-smk-kr'
SRC_URI[k26-smk-kr.sha256sum] = '0ff2e8de337aa3816523bc5adc550b0b1d0ae0699b53b5f9416696cbfbb96758'

# k26-smk-kv
HDF_BASE[k26-smk-kv] = 'https://'
HDF_PATH[k26-smk-kv] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/k26-smk-kv/k26-smk-kv-2024.1_0515_1.xsa'
BRANCHARG[k26-smk-kv] = 'name=k26-smk-kv'
SRC_URI[k26-smk-kv.sha256sum] = '4c573303fdb057428e5198809afd116ddfbe21b21ad4545c38ac1226556fb693'

# kc705-microblazeel
HDF_BASE[kc705-microblazeel] = 'https://'
HDF_PATH[kc705-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/kc705-microblazeel/kc705-microblazeel-2024.1_0515_1.xsa'
BRANCHARG[kc705-microblazeel] = 'name=kc705-microblazeel'
SRC_URI[kc705-microblazeel.sha256sum] = '1499cab61eb97a7180d639708d1e350ed2371f3af5c9a7da38422dbb8e7d46b2'

# kcu105-microblazeel
HDF_BASE[kcu105-microblazeel] = 'https://'
HDF_PATH[kcu105-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/kcu105-microblazeel/kcu105-microblazeel-2024.1_0515_1.xsa'
BRANCHARG[kcu105-microblazeel] = 'name=kcu105-microblazeel'
SRC_URI[kcu105-microblazeel.sha256sum] = '8032708b167ca4bd7b58d5278456837a807e2ccfbd4da3e201dd685f855ac18a'

# sp701-microblazeel
HDF_BASE[sp701-microblazeel] = 'https://'
HDF_PATH[sp701-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/sp701-microblazeel/sp701-microblazeel-2024.1_0515_1.xsa'
BRANCHARG[sp701-microblazeel] = 'name=sp701-microblazeel'
SRC_URI[sp701-microblazeel.sha256sum] = 'e23cb3f98203093b54f22a9ff89cf6f8d75ba92d127b543c85320d68ac71e030'

# ultra96-zynqmp
HDF_BASE[ultra96-zynqmp] = 'https://'
HDF_PATH[ultra96-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/ultra96-zynqmp/ultra96-zynqmp-2024.1_0515_1.xsa'
BRANCHARG[ultra96-zynqmp] = 'name=ultra96-zynqmp'
SRC_URI[ultra96-zynqmp.sha256sum] = '9476f9ddb8bd8a3e3d429b1bac2c004936ace029a8a40ad22adc6e78f4054ed0'

# vck190-emmc-versal
HDF_BASE[vck190-emmc-versal] = 'https://'
HDF_PATH[vck190-emmc-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/vck190-emmc-versal/vck190-emmc-versal-2024.1_0515_1.xsa'
BRANCHARG[vck190-emmc-versal] = 'name=vck190-emmc-versal'
SRC_URI[vck190-emmc-versal.sha256sum] = 'aa673e7a65c0180b89be9ed495582a5aa3bea1218a5bbc78cac3713b7adac206'

# vck190-ospi-versal
HDF_BASE[vck190-ospi-versal] = 'https://'
HDF_PATH[vck190-ospi-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/vck190-ospi-versal/vck190-ospi-versal-2024.1_0515_1.xsa'
BRANCHARG[vck190-ospi-versal] = 'name=vck190-ospi-versal'
SRC_URI[vck190-ospi-versal.sha256sum] = '61705cc51d65ca561ed5cfcbb061eb29a81910835fe29e4d13acdd8cbe66486e'

# vck190-versal
HDF_BASE[vck190-versal] = 'https://'
HDF_PATH[vck190-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/vck190-versal/vck190-versal-2024.1_0515_1.xsa'
BRANCHARG[vck190-versal] = 'name=vck190-versal'
SRC_URI[vck190-versal.sha256sum] = 'f5410c43bd063e4fb1a69ec7870421555fc898e61f499eff79cd391c0349db08'

# vck-sc-zynqmp
HDF_BASE[vck-sc-zynqmp] = 'https://'
HDF_PATH[vck-sc-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/vck-sc-zynqmp/vck-sc-zynqmp-2024.1_0515_1.xsa'
BRANCHARG[vck-sc-zynqmp] = 'name=vck-sc-zynqmp'
SRC_URI[vck-sc-zynqmp.sha256sum] = '29a055e7abc99498b4fb33517ef9956fb5c0b8037e50bb3ae279dc050eebdeeb'

# vcu118-microblazeel
HDF_BASE[vcu118-microblazeel] = 'https://'
HDF_PATH[vcu118-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/vcu118-microblazeel/vcu118-microblazeel-2024.1_0515_1.xsa'
BRANCHARG[vcu118-microblazeel] = 'name=vcu118-microblazeel'
SRC_URI[vcu118-microblazeel.sha256sum] = '7cddcaab10eeda93f491fc41c0a9c7c93698ce38c2d05bbe54cad4250590c066'

# vek280-versal
HDF_BASE[vek280-versal] = 'https://'
HDF_PATH[vek280-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/vek280-versal/vek280-versal-2024.1_0515_1.xsa'
BRANCHARG[vek280-versal] = 'name=vek280-versal'
SRC_URI[vek280-versal.sha256sum] = '072c6e1404d1ccb99379482d31594c80e2962709a5127abbbbf7e948d3441bf7'

# versal-net-generic
HDF_BASE[versal-net-generic] = 'https://'
HDF_PATH[versal-net-generic] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/versal-net-generic/versal-net-generic-2024.1_0418_1.xsa'
BRANCHARG[versal-net-generic] = 'name=versal-net-generic'
SRC_URI[versal-net-generic.sha256sum] = 'acf2cb44e3a3b130fe1f94ce311d4c03f9c9632ccbf6bcab66d6ce92ba8038fc'

# vmk180-emmc-versal
HDF_BASE[vmk180-emmc-versal] = 'https://'
HDF_PATH[vmk180-emmc-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/vmk180-emmc-versal/vmk180-emmc-versal-2024.1_0515_1.xsa'
BRANCHARG[vmk180-emmc-versal] = 'name=vmk180-emmc-versal'
SRC_URI[vmk180-emmc-versal.sha256sum] = 'f516de7433bae3f6651f7f3b1aebb65af33032a57e48973a6ae123a9564f9367'

# vmk180-ospi-versal
HDF_BASE[vmk180-ospi-versal] = 'https://'
HDF_PATH[vmk180-ospi-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/vmk180-ospi-versal/vmk180-ospi-versal-2024.1_0515_1.xsa'
BRANCHARG[vmk180-ospi-versal] = 'name=vmk180-ospi-versal'
SRC_URI[vmk180-ospi-versal.sha256sum] = 'a68b117fec65148b98bb1dbe5b0ab0f0fc2cdd5c3552b8dc5fd2709564c4a340'

# vmk180-versal
HDF_BASE[vmk180-versal] = 'https://'
HDF_PATH[vmk180-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/vmk180-versal/vmk180-versal-2024.1_0515_1.xsa'
BRANCHARG[vmk180-versal] = 'name=vmk180-versal'
SRC_URI[vmk180-versal.sha256sum] = 'cfa13c90244c2e54c8d3c91e1853b12324010cf3753595d155fd286dff0b2ea1'

# vpk120-versal
HDF_BASE[vpk120-versal] = 'https://'
HDF_PATH[vpk120-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/vpk120-versal/vpk120-versal-2024.1_0515_1.xsa'
BRANCHARG[vpk120-versal] = 'name=vpk120-versal'
SRC_URI[vpk120-versal.sha256sum] = '8d635930c65b33f6f01214479fb0596ee7f022bb3dbb8f8a434c33e9802a2b7a'

# vpk180-versal
HDF_BASE[vpk180-versal] = 'https://'
HDF_PATH[vpk180-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/vpk180-versal/vpk180-versal-2024.1_0515_1.xsa'
BRANCHARG[vpk180-versal] = 'name=vpk180-versal'
SRC_URI[vpk180-versal.sha256sum] = '52bcc441584031db62a3fba40a440fde2f90096aa79e9e060f34f6304f66ef99'

# zc702-zynq7
HDF_BASE[zc702-zynq7] = 'https://'
HDF_PATH[zc702-zynq7] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/zc702-zynq7/zc702-zynq7-2024.1_0515_1.xsa'
BRANCHARG[zc702-zynq7] = 'name=zc702-zynq7'
SRC_URI[zc702-zynq7.sha256sum] = 'b6770ddfc0eb22f9dbc901f73924ac2198e219ff71c465ab93405f16447ae8d9'

# zc706-zynq7
HDF_BASE[zc706-zynq7] = 'https://'
HDF_PATH[zc706-zynq7] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/zc706-zynq7/zc706-zynq7-2024.1_0515_1.xsa'
BRANCHARG[zc706-zynq7] = 'name=zc706-zynq7'
SRC_URI[zc706-zynq7.sha256sum] = '0f4739f52909f92ad10679b842a50ba6461d2a3e5a35683f9ce9ea5f4864ea5a'

# zcu102-zynqmp
HDF_BASE[zcu102-zynqmp] = 'https://'
HDF_PATH[zcu102-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/zcu102-zynqmp/zcu102-zynqmp-2024.1_0515_1.xsa'
BRANCHARG[zcu102-zynqmp] = 'name=zcu102-zynqmp'
SRC_URI[zcu102-zynqmp.sha256sum] = 'b29b34028011b558d7a9222d6ce2a3aa4608852d406d3fff8d06a0040cb4fc17'

# zcu104-zynqmp
HDF_BASE[zcu104-zynqmp] = 'https://'
HDF_PATH[zcu104-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/zcu104-zynqmp/zcu104-zynqmp-2024.1_0515_1.xsa'
BRANCHARG[zcu104-zynqmp] = 'name=zcu104-zynqmp'
SRC_URI[zcu104-zynqmp.sha256sum] = 'eb7bcb276c037e76a3f27a9b20f5dc5e5d01d7ae70eedbda4193e68103f7a62f'

# zcu106-zynqmp
HDF_BASE[zcu106-zynqmp] = 'https://'
HDF_PATH[zcu106-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/zcu106-zynqmp/zcu106-zynqmp-2024.1_0515_1.xsa'
BRANCHARG[zcu106-zynqmp] = 'name=zcu106-zynqmp'
SRC_URI[zcu106-zynqmp.sha256sum] = 'ed5c283218620851b9fd6c7c23e3b61bc701076a5ef4f3abdbf146d77d4c4d5f'

# zcu111-zynqmp
HDF_BASE[zcu111-zynqmp] = 'https://'
HDF_PATH[zcu111-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/zcu111-zynqmp/zcu111-zynqmp-2024.1_0515_1.xsa'
BRANCHARG[zcu111-zynqmp] = 'name=zcu111-zynqmp'
SRC_URI[zcu111-zynqmp.sha256sum] = '85d6f42a1accd24ef410234cb200e85f216d3629428758740b6165ac111f6c36'

# zcu208-sdfec-zynqmp
HDF_BASE[zcu208-sdfec-zynqmp] = 'https://'
HDF_PATH[zcu208-sdfec-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/zcu208-sdfec-zynqmp/zcu208-sdfec-zynqmp-2024.1_0515_1.xsa'
BRANCHARG[zcu208-sdfec-zynqmp] = 'name=zcu208-sdfec-zynqmp'
SRC_URI[zcu208-sdfec-zynqmp.sha256sum] = '36e8e492c81b4275bdcd987d4a32025bec4f7dd9a61b7ba9b39ab7ab9e79d478'

# zcu208-zynqmp
HDF_BASE[zcu208-zynqmp] = 'https://'
HDF_PATH[zcu208-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/zcu208-zynqmp/zcu208-zynqmp-2024.1_0515_1.xsa'
BRANCHARG[zcu208-zynqmp] = 'name=zcu208-zynqmp'
SRC_URI[zcu208-zynqmp.sha256sum] = '2ef22f0ccfe169b950dc0e7d8acbed9347aac8f9e2396d3c725ed271511324a1'

# zcu216-zynqmp
HDF_BASE[zcu216-zynqmp] = 'https://'
HDF_PATH[zcu216-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/zcu216-zynqmp/zcu216-zynqmp-2024.1_0515_1.xsa'
BRANCHARG[zcu216-zynqmp] = 'name=zcu216-zynqmp'
SRC_URI[zcu216-zynqmp.sha256sum] = 'dfb82e750a089a5c7a49f305cba7edb471799ff4d622446ea76d2fe94bc7d04d'

# zcu670-zynqmp
HDF_BASE[zcu670-zynqmp] = 'https://'
HDF_PATH[zcu670-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2024/hdf-examples/2024.1/2024.1_0515_1_05160530/external/zcu670-zynqmp/zcu670-zynqmp.xsa'
BRANCHARG[zcu670-zynqmp] = 'name=zcu670-zynqmp'
SRC_URI[zcu670-zynqmp.sha256sum] = '7ef9bae62ace1c96ce784477e110d8c47c86417b4340ad121d71bf09cd2fae16'
