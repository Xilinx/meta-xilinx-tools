# Automatically generated.  Manual changes will be lost.

# Redefine the default to use our values if not overriden by the user
# fall back to the original default if necessary
HDF_BASE_DEFAULT := '${HDF_BASE}'
HDF_PATH_DEFAULT := '${HDF_PATH}'
BRANCHARG_DEFAULT := '${BRANCHARG}'
HDF_BASE ??= "${@d.getVarFlag('HDF_BASE', d.getVar('HDF_MACHINE') or 'undefined') or '${HDF_BASE_DEFAULT}'}"
HDF_PATH ??= "${@d.getVarFlag('HDF_PATH', d.getVar('HDF_MACHINE') or 'undefined') or '${HDF_PATH_DEFAULT}'}"
BRANCHARG ??= "${@d.getVarFlag('BRANCHARG', d.getVar('HDF_MACHINE') or 'undefined') or '${BRANCHARG_DEFAULT}'}"

# ac701-microblazeel
HDF_BASE[ac701-microblazeel] = 'https://'
HDF_PATH[ac701-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/ac701-microblazeel/ac701-microblazeel-2023.1_0426_1.xsa'
BRANCHARG[ac701-microblazeel] = 'name=ac701-microblazeel'
SRC_URI[ac701-microblazeel.sha256sum] = 'ff3ee8049a3bc39ecb793bfdaa8f9850f327e63e388f25e768dc8e33b4777751'

# eval-brd-sc
HDF_BASE[eval-brd-sc] = 'https://'
HDF_PATH[eval-brd-sc] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/eval-brd-sc/eval-brd-sc-2023.1_0426_1.xsa'
BRANCHARG[eval-brd-sc] = 'name=eval-brd-sc'
SRC_URI[eval-brd-sc.sha256sum] = '7fcc616a1ad23f5bc2b6c79c8e74de3aa2dd4a23c3add09a905bc0d41383dab6'

# k24-kd
HDF_BASE[k24-kd] = 'https://'
HDF_PATH[k24-kd] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0508_1_08160121/k24-kd/k24-kd-2023.1_0508_1.xsa'
BRANCHARG[k24-kd] = 'name=k24-kd'
SRC_URI[k24-kd.sha256sum] = '4e3eb9ad6c80918cab53196ad0067bd531f08402c8e5cbe39f0b8feb20bef3c6'

#k24-smk
HDF_BASE[k24-smk] = 'https://'
HDF_PATH[k24-smk] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0508_1_08160121/k24-smk/k24-smk-2023.1_0508_1.xsa'
BRANCHARG[k24-smk] = 'name=k24-smk'
SRC_URI[k24-smk.sha256sum] = 'aa79a5bbb1ba22d2a39283e555b94ad3b4f078096ace7eddd02ee5cc784d32e6'

# k26-kr
HDF_BASE[k26-kr] = 'https://'
HDF_PATH[k26-kr] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/k26-kr/k26-kr-2023.1_0426_1.xsa'
BRANCHARG[k26-kr] = 'name=k26-kr'
SRC_URI[k26-kr.sha256sum] = '72303e274ad15932dd9b92bae98c36e607792355cd7f9af3c8711b6f07ad06d5'

# k26-kv
HDF_BASE[k26-kv] = 'https://'
HDF_PATH[k26-kv] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/k26-kv/k26-kv-2023.1_0426_1.xsa'
BRANCHARG[k26-kv] = 'name=k26-kv'
SRC_URI[k26-kv.sha256sum] = '411d01d05bf07ef74492669ab9cebfe171c896c51a5e9828e6fef631319d0632'

# k26-sm
HDF_BASE[k26-sm] = 'https://'
HDF_PATH[k26-sm] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/k26-sm/k26-sm-2023.1_0426_1.xsa'
BRANCHARG[k26-sm] = 'name=k26-sm'
SRC_URI[k26-sm.sha256sum] = '67d470531d3f8bf5d68c2f59b6135c8082964da9ec8bc1c68e7ce3c15bd2d54b'

# k26-smk
HDF_BASE[k26-smk] = 'https://'
HDF_PATH[k26-smk] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/k26-smk/k26-smk-2023.1_0426_1.xsa'
BRANCHARG[k26-smk] = 'name=k26-smk'
SRC_URI[k26-smk.sha256sum] = 'f47495636cf1197910a57504c2c70c475f087a01a9278699b403f69d9fd09373'

# kc705-microblazeel
HDF_BASE[kc705-microblazeel] = 'https://'
HDF_PATH[kc705-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/kc705-microblazeel/kc705-microblazeel-2023.1_0426_1.xsa'
BRANCHARG[kc705-microblazeel] = 'name=kc705-microblazeel'
SRC_URI[kc705-microblazeel.sha256sum] = '251494dd5eefbc6a797ae56cf145888b3eb25b0710111e63ffd442a6f1f90100'

# kcu105-microblazeel
HDF_BASE[kcu105-microblazeel] = 'https://'
HDF_PATH[kcu105-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/kcu105-microblazeel/kcu105-microblazeel-2023.1_0426_1.xsa'
BRANCHARG[kcu105-microblazeel] = 'name=kcu105-microblazeel'
SRC_URI[kcu105-microblazeel.sha256sum] = 'a5466e3a7bcbba33564be61ae2c6b11829ebc1231a77496ba891423b3bcc1ae8'

# microblaze-generic
HDF_BASE[microblaze-generic] = 'https://'
HDF_PATH[microblaze-generic] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/microblaze-generic/microblaze-generic.xsa'
BRANCHARG[microblaze-generic] = 'name=microblaze-generic'
SRC_URI[microblaze-generic.sha256sum] = 'd85dd540eb0c7c19e1e683761780aea5fc895136b5e43087e74c58d719bace00'

# ultra96-zynqmp
HDF_BASE[ultra96-zynqmp] = 'https://'
HDF_PATH[ultra96-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/ultra96-zynqmp/ultra96-zynqmp-2023.1_0426_1.xsa'
BRANCHARG[ultra96-zynqmp] = 'name=ultra96-zynqmp'
SRC_URI[ultra96-zynqmp.sha256sum] = '0f410b17df62c1a57a3b612affd22dd6db3bbde0832e8ca10b70596347355da6'

# vck190-versal
HDF_BASE[vck190-versal] = 'https://'
HDF_PATH[vck190-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/vck190-versal/vck190-versal-2023.1_0426_1.xsa'
BRANCHARG[vck190-versal] = 'name=vck190-versal'
SRC_URI[vck190-versal.sha256sum] = '041634eae4480ad56a9c4b0f97bbedfd4dc54dfceaacb5ae443e9a97d5f5bdee'

# vck-sc-zynqmp
HDF_BASE[vck-sc-zynqmp] = 'https://'
HDF_PATH[vck-sc-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/vck-sc-zynqmp/vck-sc-zynqmp-2023.1_0426_1.xsa'
BRANCHARG[vck-sc-zynqmp] = 'name=vck-sc-zynqmp'
SRC_URI[vck-sc-zynqmp.sha256sum] = '81d170a1266e0ee51ba2ed3baa791007640d8a19b01caa3ebfd5fb045edb8177'

# vcu118-microblazeel
HDF_BASE[vcu118-microblazeel] = 'https://'
HDF_PATH[vcu118-microblazeel] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/vcu118-microblazeel/vcu118-microblazeel-2023.1_0426_1.xsa'
BRANCHARG[vcu118-microblazeel] = 'name=vcu118-microblazeel'
SRC_URI[vcu118-microblazeel.sha256sum] = '52dd56bf871a2b31660dadcbf116b529c28104996c6f56aaa604c80271009e97'

# versal-generic
HDF_BASE[versal-generic] = 'https://'
HDF_PATH[versal-generic] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/versal-generic/versal-generic.xsa'
BRANCHARG[versal-generic] = 'name=versal-generic'
SRC_URI[versal-generic.sha256sum] = 'c1533005887a83791a89bbacc3b56935ba10b1938c7a8a16d48026370236d72c'

# vmk180-versal
HDF_BASE[vmk180-versal] = 'https://'
HDF_PATH[vmk180-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/vmk180-versal/vmk180-versal-2023.1_0426_1.xsa'
BRANCHARG[vmk180-versal] = 'name=vmk180-versal'
SRC_URI[vmk180-versal.sha256sum] = '47202fdd409afd6fb7853785e70b1d2d48a85e3ab2f583bc12da283400516787'

# vpk120-versal
HDF_BASE[vpk120-versal] = 'https://'
HDF_PATH[vpk120-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/vpk120-versal/vpk120-versal-2023.1_0426_1.xsa'
BRANCHARG[vpk120-versal] = 'name=vpk120-versal'
SRC_URI[vpk120-versal.sha256sum] = '2b60af07c84ca666c7871626214b2a53c8da4a3e0b5e142d729039275b975813'

# vpk180-versal
HDF_BASE[vpk180-versal] = 'https://'
HDF_PATH[vpk180-versal] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/vpk180-versal/vpk180-versal-2023.1_0426_1.xsa'
BRANCHARG[vpk180-versal] = 'name=vpk180-versal'
SRC_URI[vpk180-versal.sha256sum] = '6bfe70b478b32efcee2a75f8240c2c14c08af10f26a3a89742d787b990783f63'

# zc702-zynq7
HDF_BASE[zc702-zynq7] = 'https://'
HDF_PATH[zc702-zynq7] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/zc702-zynq7/zc702-zynq7-2023.1_0426_1.xsa'
BRANCHARG[zc702-zynq7] = 'name=zc702-zynq7'
SRC_URI[zc702-zynq7.sha256sum] = '5f69b5b535ca2ca2d1c4724e785328b4c55ca28ffd763c165b198d489ab05f13'

# zc706-zynq7
HDF_BASE[zc706-zynq7] = 'https://'
HDF_PATH[zc706-zynq7] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/zc706-zynq7/zc706-zynq7-2023.1_0426_1.xsa'
BRANCHARG[zc706-zynq7] = 'name=zc706-zynq7'
SRC_URI[zc706-zynq7.sha256sum] = '3688560243317ef5a1fe8d1234c2163c48cbbe8a17278cfbbb10a64ac73e302c'

# zcu102-zynqmp
HDF_BASE[zcu102-zynqmp] = 'https://'
HDF_PATH[zcu102-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/zcu102-zynqmp/zcu102-zynqmp-2023.1_0426_1.xsa'
BRANCHARG[zcu102-zynqmp] = 'name=zcu102-zynqmp'
SRC_URI[zcu102-zynqmp.sha256sum] = '2a32da418e5216af2fd75eb6851b84c23be7672d4dda9c63e1e4b3a8bae43ec8'

# zcu104-zynqmp
HDF_BASE[zcu104-zynqmp] = 'https://'
HDF_PATH[zcu104-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/zcu104-zynqmp/zcu104-zynqmp-2023.1_0426_1.xsa'
BRANCHARG[zcu104-zynqmp] = 'name=zcu104-zynqmp'
SRC_URI[zcu104-zynqmp.sha256sum] = '264ab082462c4f2aeb965db2e7b00720eccbae2dffda3946d606beb499c742a8'

# zcu106-zynqmp
HDF_BASE[zcu106-zynqmp] = 'https://'
HDF_PATH[zcu106-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/zcu106-zynqmp/zcu106-zynqmp-2023.1_0426_1.xsa'
BRANCHARG[zcu106-zynqmp] = 'name=zcu106-zynqmp'
SRC_URI[zcu106-zynqmp.sha256sum] = '1fb89f0c34e633135650b53aad2ad7fccc83bb86930d9de2f24c558bf079bf10'

# zcu111-zynqmp
HDF_BASE[zcu111-zynqmp] = 'https://'
HDF_PATH[zcu111-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/zcu111-zynqmp/zcu111-zynqmp-2023.1_0426_1.xsa'
BRANCHARG[zcu111-zynqmp] = 'name=zcu111-zynqmp'
SRC_URI[zcu111-zynqmp.sha256sum] = '588f935ae098b9ac98e5dc967857f1c38c9e40a52c9b451d7d9d61297c2197f7'

# zcu1275-zynqmp
HDF_BASE[zcu1275-zynqmp] = 'https://'
HDF_PATH[zcu1275-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/zcu1275-zynqmp/zcu1275-zynqmp-2023.1_0426_1.xsa'
BRANCHARG[zcu1275-zynqmp] = 'name=zcu1275-zynqmp'
SRC_URI[zcu1275-zynqmp.sha256sum] = 'd58ea572a547f3e6070c000e266201a8e6d2b5460fcf7b457db58a6dd534e72e'

# zcu1285-zynqmp
HDF_BASE[zcu1285-zynqmp] = 'https://'
HDF_PATH[zcu1285-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/zcu1285-zynqmp/zcu1285-zynqmp-2023.1_0426_1.xsa'
BRANCHARG[zcu1285-zynqmp] = 'name=zcu1285-zynqmp'
SRC_URI[zcu1285-zynqmp.sha256sum] = '5e8963a28b30849e1d4f70a449817c797f6cd5143e3c0c0ca1d584e890857e3c'

# zcu208-zynqmp
HDF_BASE[zcu208-zynqmp] = 'https://'
HDF_PATH[zcu208-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/zcu208-zynqmp/zcu208-zynqmp-2023.1_0426_1.xsa'
BRANCHARG[zcu208-zynqmp] = 'name=zcu208-zynqmp'
SRC_URI[zcu208-zynqmp.sha256sum] = '615fe10d8599b79055e061ca39c9b49b84b567df4f2e4f02793271172336e8bb'

# zcu216-zynqmp
HDF_BASE[zcu216-zynqmp] = 'https://'
HDF_PATH[zcu216-zynqmp] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/zcu216-zynqmp/zcu216-zynqmp-2023.1_0426_1.xsa'
BRANCHARG[zcu216-zynqmp] = 'name=zcu216-zynqmp'
SRC_URI[zcu216-zynqmp.sha256sum] = '819a4f807b6469608b041363aee5734ad88ffdef01e1623c149d932b7bafbf53'

# zynq-generic
HDF_BASE[zynq-generic] = 'https://'
HDF_PATH[zynq-generic] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/zynq-generic/zynq-generic.xsa'
BRANCHARG[zynq-generic] = 'name=zynq-generic'
SRC_URI[zynq-generic.sha256sum] = '13f64b348a54df7e56b56870b5ad06217dd49f1250345c55d7c8b163ea5fa406'

# zynqmp-generic
HDF_BASE[zynqmp-generic] = 'https://'
HDF_PATH[zynqmp-generic] = 'petalinux.xilinx.com/sswreleases/rel-v2023/hdf-examples/2023.1/2023.1_0426_1_04270351/zynqmp-generic/zynqmp-generic.xsa'
BRANCHARG[zynqmp-generic] = 'name=zynqmp-generic'
SRC_URI[zynqmp-generic.sha256sum] = '74c1609f64f4d5c361a31664e396b33ce5d1a4786450ded85c11cdb1e51178e2'
