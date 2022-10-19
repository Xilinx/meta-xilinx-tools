#!/bin/bash
# Generate the hdf-files.inc file
#
# Usage:
# cd sources/meta-xilinx-tools
# ./scripts/hdf-repository-generate-srcuri.sh \
#    https://artifactory.xilinx.com/artifactory/petalinux-hwproj-dev/hdf-examples/2022.2/06062022 \
#    /usr/local/hdf-examples \
#    > recipes-bsp/hdf/hdf-repository.inc

if [ $# -lt 1 -o $# -gt 2 ]; then
    echo "Usage: $0 <url> [<local_dir>]" >&2
    exit 1
fi

url=$(echo $1 | sed -e 's,/$,,')

localdir=${2}

urlproto=$(echo $url | sed -e 's,://.*,://,')
urlpath=$(echo $url | sed -e 's,'${urlproto}',,')

if [ ${url} = ${urlproto} -o -z ${url} ]; then
    echo "URL $url is invalid" >&2
    exit 1
fi

if [ ${urlproto} = "file://" ]; then
    # file:// URL, usually only for testing
    cd ${urlpath}
elif [ -n "${localdir}" ]; then
    # Remote url, but using a local cache to generate
    cd ${localdir}
else
    # Remove url, recursive fetch and then generate
    tempdir=$(mktemp -d)

    cd ${tempdir}
    wget --recursive --no-parent $url/

    cd ${urlpath}
fi

echo "# Automatically generated.  Manual changes will be lost."
echo
echo "HDF_BASE ??= '${urlproto}'"
echo "HDF_PATH ??= '${urlpath}/\${HDF_MACHINE}/system.xsa'"
echo
if [ ${urlproto} = "file://" ]; then
    echo "BRANCHARG ??= 'name=\${HDF_MACHINE}'"
else
    echo "BRANCHARG ??= 'downloadfilename=\${HDF_MACHINE}_system.xsa;name=\${HDF_MACHINE}'"
fi
echo

# Downloaded but not used
README="README.md"
if [ ! -e ${README} ]; then
    README=""
    echo "WARNING: No README file!" >&2
else
    echo "SRC_URI += '${url}/$README;name=readme'"
    echo "SRC_URI[readme.sha256sum] = '$(sha256sum $README | cut -d ' ' -f 1)'"
fi

echo

# Include the files, but don't setup LIC_FILES_CHKSUM.  User can manually
# file the LICENSE file if needed.
LICENSE="LICENSE.md"
if [ ! -e ${LICENSE} ]; then
    LICENSE=""
    echo "WARNING: No README file!" >&2
else
    echo "SRC_URI += '${url}/$LICENSE;name=license'"
    echo "SRC_URI[license.sha256sum] = '$(sha256sum $LICENSE | cut -d ' ' -f 1)'"

    # Disable since it breaks current PetaLinux workflow
    #if [ ${urlproto} = "file://" ]; then
    #    echo "LIC_FILES_CHKSUM = 'file://${urlpath}/$LICENSE;md5=$(md5sum $LICENSE | cut -d ' ' -f 1)'"
    #else
    #    echo "LIC_FILES_CHKSUM = 'file://$LICENSE;md5=$(md5sum $LICENSE | cut -d ' ' -f 1)'"
fi

echo

for each_file in `find . -type f -name system.xsa | sed 's,\./,,'`; do
    id=$(dirname $each_file | tr '/' '_') ; \
    sha=$(sha256sum $each_file | cut -d ' ' -f 1) ; \
    echo "SRC_URI[$id.sha256sum] = '$sha'" ; \
done
if [ -n "${temp}" ]; then
    rm -r $temp
fi
