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
HDF_PATH[ac701-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/ac701-microblazeel/ac701-microblazeel-2023.2_0918_1.xsa'
BRANCHARG[ac701-microblazeel] = 'name=ac701-microblazeel'
SRC_URI[ac701-microblazeel.sha256sum] = '7342227e89320111c26af2f378b00c9faba1d50039364eaab566c06f266807c4'

# eval-brd-sc
HDF_BASE[eval-brd-sc] = 'https://'
HDF_PATH[eval-brd-sc] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/eval-brd-sc/eval-brd-sc-2023.2_0918_1.xsa'
BRANCHARG[eval-brd-sc] = 'name=eval-brd-sc'
SRC_URI[eval-brd-sc.sha256sum] = 'f7d7bcc85aecdb8a0162897f3c22ea4b88e4a0c854e267160c9f1e647ec4e6ea'

# k24-sm
HDF_BASE[k24-sm] = 'https://'
HDF_PATH[k24-sm] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/k24-sm/k24-sm-2023.2_0918_1.xsa'
BRANCHARG[k24-sm] = 'name=k24-sm'
SRC_URI[k24-sm.sha256sum] = '7ed3856807d5846acf6b8ccb4d8063fbc8a8068b432ec3ff572cf504fc5ef630'

# k24-smk
HDF_BASE[k24-smk] = 'https://'
HDF_PATH[k24-smk] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/k24-smk/k24-smk-2023.2_0918_1.xsa'
BRANCHARG[k24-smk] = 'name=k24-smk'
SRC_URI[k24-smk.sha256sum] = 'a1b03cacc37a57fe065906e289abb2cf0b837fba6d2d4971fa430f53ee43882d'

# k24-smk-kd
HDF_BASE[k24-smk-kd] = 'https://'
HDF_PATH[k24-smk-kd] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/k24-smk-kd/k24-smk-kd-2023.2_0918_1.xsa'
BRANCHARG[k24-smk-kd] = 'name=k24-smk-kd'
SRC_URI[k24-smk-kd.sha256sum] = 'e3734950e81f4aed99ad7f1d5d87830f88fe4dc5cc5174ef0d254aac515001c7'

# k26-sm
HDF_BASE[k26-sm] = 'https://'
HDF_PATH[k26-sm] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/k26-sm/k26-sm-2023.2_0918_1.xsa'
BRANCHARG[k26-sm] = 'name=k26-sm'
SRC_URI[k26-sm.sha256sum] = 'd6f8e77593cc308ca74182cd8602deec511f0bdb828ba2048537bcb5a28585c8'

# k26-smk
HDF_BASE[k26-smk] = 'https://'
HDF_PATH[k26-smk] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/k26-smk/k26-smk-2023.2_0918_1.xsa'
BRANCHARG[k26-smk] = 'name=k26-smk'
SRC_URI[k26-smk.sha256sum] = '388920680172f7be880111ac28606c73c9567eb220466de0e9bd5ed06c6c32a6'

# k26-smk-kr
HDF_BASE[k26-smk-kr] = 'https://'
HDF_PATH[k26-smk-kr] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/k26-smk-kr/k26-smk-kr-2023.2_0918_1.xsa'
BRANCHARG[k26-smk-kr] = 'name=k26-smk-kr'
SRC_URI[k26-smk-kr.sha256sum] = '6932de3a71150e104864d7a7d971a18dd25d8fa86480f0834e97ee3e859d6180'

# k26-smk-kv
HDF_BASE[k26-smk-kv] = 'https://'
HDF_PATH[k26-smk-kv] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/k26-smk-kv/k26-smk-kv-2023.2_0918_1.xsa'
BRANCHARG[k26-smk-kv] = 'name=k26-smk-kv'
SRC_URI[k26-smk-kv.sha256sum] = '52ee68651f879907ab25c09760fadc3fb54056ffb9d694692a9be1e05fe80356'

# kc705-microblazeel
HDF_BASE[kc705-microblazeel] = 'https://'
HDF_PATH[kc705-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/kc705-microblazeel/kc705-microblazeel-2023.2_0918_1.xsa'
BRANCHARG[kc705-microblazeel] = 'name=kc705-microblazeel'
SRC_URI[kc705-microblazeel.sha256sum] = 'a55b17377de01622cf8f3a4f5648980f6984f8c1e9fd5235de9582eca26cbf51'

# kcu105-microblazeel
HDF_BASE[kcu105-microblazeel] = 'https://'
HDF_PATH[kcu105-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/kcu105-microblazeel/kcu105-microblazeel-2023.2_0918_1.xsa'
BRANCHARG[kcu105-microblazeel] = 'name=kcu105-microblazeel'
SRC_URI[kcu105-microblazeel.sha256sum] = 'a8fe2e2145f33e78ef5b08f86784d973a8c61e60aae19cfc370cd8b4d827a61d'

# sp701-microblazeel
HDF_BASE[sp701-microblazeel] = 'https://'
HDF_PATH[sp701-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/sp701-microblazeel/sp701-microblazeel-2023.2_0918_1.xsa'
BRANCHARG[sp701-microblazeel] = 'name=sp701-microblazeel'
SRC_URI[sp701-microblazeel.sha256sum] = '0ca90545155339ad6b67700f089672bdfbb3a6fd57cd379cfd148344bc0c1ccd'

# ultra96-zynqmp
HDF_BASE[ultra96-zynqmp] = 'https://'
HDF_PATH[ultra96-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/ultra96-zynqmp/ultra96-zynqmp-2023.2_0918_1.xsa'
BRANCHARG[ultra96-zynqmp] = 'name=ultra96-zynqmp'
SRC_URI[ultra96-zynqmp.sha256sum] = 'bd7e6468a689d086ef17d3b7e9af91f25fa9c2ef8ff02c163e0b7e6cc311fefc'

# vck190-emmc-versal
HDF_BASE[vck190-emmc-versal] = 'https://'
HDF_PATH[vck190-emmc-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/vck190-emmc-versal/vck190-emmc-versal-2023.2_0918_1.xsa'
BRANCHARG[vck190-emmc-versal] = 'name=vck190-emmc-versal'
SRC_URI[vck190-emmc-versal.sha256sum] = '45d8a946c04380a86b8cb20f287dfe3bea47d57e70278278b9461ee57fd36ac0'

# vck190-ospi-versal
HDF_BASE[vck190-ospi-versal] = 'https://'
HDF_PATH[vck190-ospi-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/vck190-ospi-versal/vck190-ospi-versal-2023.2_0918_1.xsa'
BRANCHARG[vck190-ospi-versal] = 'name=vck190-ospi-versal'
SRC_URI[vck190-ospi-versal.sha256sum] = '7da55499f52feda3c566d30d4993d2357fea2d2fb749513d0f0327f0559270ac'

# vck190-versal
HDF_BASE[vck190-versal] = 'https://'
HDF_PATH[vck190-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/vck190-versal/vck190-versal-2023.2_0918_1.xsa'
BRANCHARG[vck190-versal] = 'name=vck190-versal'
SRC_URI[vck190-versal.sha256sum] = 'd96867df8fd53f763c2705e86974f350cf6e44f39786975c634580e606d3c8d3'

# vck-sc-zynqmp
HDF_BASE[vck-sc-zynqmp] = 'https://'
HDF_PATH[vck-sc-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/vck-sc-zynqmp/vck-sc-zynqmp-2023.2_0918_1.xsa'
BRANCHARG[vck-sc-zynqmp] = 'name=vck-sc-zynqmp'
SRC_URI[vck-sc-zynqmp.sha256sum] = '11877e33e8853a1e0e9d19cf396ed6d979e92205f5c68d9505c8f4dee5a2e1f2'

# vcu118-microblazeel
HDF_BASE[vcu118-microblazeel] = 'https://'
HDF_PATH[vcu118-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/vcu118-microblazeel/vcu118-microblazeel-2023.2_0918_1.xsa'
BRANCHARG[vcu118-microblazeel] = 'name=vcu118-microblazeel'
SRC_URI[vcu118-microblazeel.sha256sum] = '43bfda8279019f1ee90925be6fbe6c547639974db71515b90505ddaf31ee66a4'

# vmk180-emmc-versal
HDF_BASE[vmk180-emmc-versal] = 'https://'
HDF_PATH[vmk180-emmc-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/vmk180-emmc-versal/vmk180-emmc-versal-2023.2_0918_1.xsa'
BRANCHARG[vmk180-emmc-versal] = 'name=vmk180-emmc-versal'
SRC_URI[vmk180-emmc-versal.sha256sum] = 'b50452f035b70edfe5fd02fdd8c03a83be05c6d259f3e0a2cc87c4f2e6f413df'

# vmk180-ospi-versal
HDF_BASE[vmk180-ospi-versal] = 'https://'
HDF_PATH[vmk180-ospi-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/vmk180-ospi-versal/vmk180-ospi-versal-2023.2_0918_1.xsa'
BRANCHARG[vmk180-ospi-versal] = 'name=vmk180-ospi-versal'
SRC_URI[vmk180-ospi-versal.sha256sum] = 'e0ea2192ba223ab0fad0fd316585b2691ef50f593a48d26af671eded69c8e978'

# vmk180-versal
HDF_BASE[vmk180-versal] = 'https://'
HDF_PATH[vmk180-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/vmk180-versal/vmk180-versal-2023.2_0918_1.xsa'
BRANCHARG[vmk180-versal] = 'name=vmk180-versal'
SRC_URI[vmk180-versal.sha256sum] = '519fe05701e215bb3b7fad754e9d0a796bf5d457cbd40cedafdce2f57b591f31'

# vpk120-versal
HDF_BASE[vpk120-versal] = 'https://'
HDF_PATH[vpk120-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/vpk120-versal/vpk120-versal-2023.2_0918_1.xsa'
BRANCHARG[vpk120-versal] = 'name=vpk120-versal'
SRC_URI[vpk120-versal.sha256sum] = '72d191df57d721dd5f00ab08d1348c95b61e89e5ef502e5ecb341c7f3dffdd91'

# vpk180-versal
HDF_BASE[vpk180-versal] = 'https://'
HDF_PATH[vpk180-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/vpk180-versal/vpk180-versal-2023.2_0918_1.xsa'
BRANCHARG[vpk180-versal] = 'name=vpk180-versal'
SRC_URI[vpk180-versal.sha256sum] = '411308968e079bad4ab245f92fc20d90ae24b29419c8dda0d09073cb9a91a452'

# zc702-zynq7
HDF_BASE[zc702-zynq7] = 'https://'
HDF_PATH[zc702-zynq7] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/zc702-zynq7/zc702-zynq7-2023.2_0918_1.xsa'
BRANCHARG[zc702-zynq7] = 'name=zc702-zynq7'
SRC_URI[zc702-zynq7.sha256sum] = '410fce3e9065df0d48784f79d33f1dc845849adae0e14eb2bcedbff7af872bf1'

# zc706-zynq7
HDF_BASE[zc706-zynq7] = 'https://'
HDF_PATH[zc706-zynq7] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/zc706-zynq7/zc706-zynq7-2023.2_0918_1.xsa'
BRANCHARG[zc706-zynq7] = 'name=zc706-zynq7'
SRC_URI[zc706-zynq7.sha256sum] = 'e9f0abd152e9acad580134187769db7651b967c7b4af7f81e20782fe31fc45a0'

# zcu102-zynqmp
HDF_BASE[zcu102-zynqmp] = 'https://'
HDF_PATH[zcu102-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/zcu102-zynqmp/zcu102-zynqmp-2023.2_0918_1.xsa'
BRANCHARG[zcu102-zynqmp] = 'name=zcu102-zynqmp'
SRC_URI[zcu102-zynqmp.sha256sum] = 'daaba89c859463bd87cc480bf36121937428bd2794935302603a4d5dfc762c00'

# zcu104-zynqmp
HDF_BASE[zcu104-zynqmp] = 'https://'
HDF_PATH[zcu104-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/zcu104-zynqmp/zcu104-zynqmp-2023.2_0918_1.xsa'
BRANCHARG[zcu104-zynqmp] = 'name=zcu104-zynqmp'
SRC_URI[zcu104-zynqmp.sha256sum] = '47bf5b3d40e464caaf5e541defecd7ffb767c13791844e8d0b39041d6aa6f647'

# zcu106-zynqmp
HDF_BASE[zcu106-zynqmp] = 'https://'
HDF_PATH[zcu106-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/zcu106-zynqmp/zcu106-zynqmp-2023.2_0918_1.xsa'
BRANCHARG[zcu106-zynqmp] = 'name=zcu106-zynqmp'
SRC_URI[zcu106-zynqmp.sha256sum] = 'd231de8cd2f7b657a2c66703607ed9588926ec4752e55405a57f012e5b65dca0'

# zcu111-zynqmp
HDF_BASE[zcu111-zynqmp] = 'https://'
HDF_PATH[zcu111-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/zcu111-zynqmp/zcu111-zynqmp-2023.2_0918_1.xsa'
BRANCHARG[zcu111-zynqmp] = 'name=zcu111-zynqmp'
SRC_URI[zcu111-zynqmp.sha256sum] = '470064652063c1df0b37c04b055fa5aee402795442ea8084c6248d10767d3076'

# zcu208-sdfec-zynqmp
HDF_BASE[zcu208-sdfec-zynqmp] = 'https://'
HDF_PATH[zcu208-sdfec-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/zcu208-sdfec-zynqmp/zcu208-sdfec-zynqmp-2023.2_0918_1.xsa'
BRANCHARG[zcu208-sdfec-zynqmp] = 'name=zcu208-sdfec-zynqmp'
SRC_URI[zcu208-sdfec-zynqmp.sha256sum] = '9ed42cc48508e48367464398f73974b18ff650b5eb4259e2e0efa2ee7f215cf6'

# zcu208-zynqmp
HDF_BASE[zcu208-zynqmp] = 'https://'
HDF_PATH[zcu208-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/zcu208-zynqmp/zcu208-zynqmp-2023.2_0918_1.xsa'
BRANCHARG[zcu208-zynqmp] = 'name=zcu208-zynqmp'
SRC_URI[zcu208-zynqmp.sha256sum] = '43df07744107b3ed919b501f5616a2b6e545c342c590090ec22c85502912ae27'

# zcu216-zynqmp
HDF_BASE[zcu216-zynqmp] = 'https://'
HDF_PATH[zcu216-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.2/2023.2_0918_1_09190319/external/zcu216-zynqmp/zcu216-zynqmp-2023.2_0918_1.xsa'
BRANCHARG[zcu216-zynqmp] = 'name=zcu216-zynqmp'
SRC_URI[zcu216-zynqmp.sha256sum] = 'a01a11cc44a9197c4e8846367cd211008510df3e4a1e135c24c5d4ad881c3244'
