#!/bin/bash
# Generate the hdf-files.inc file
#
# Usage:
# cd sources/meta-xilinx-tools
# ./scripts/hdf-repository-generate-srcuri.sh \
#    https://artifactory.xilinx.com/artifactory/petalinux-hwproj-dev/hdf-examples/2022.2/06062022 \
#    /usr/local/hdf-examples \
#    > recipes-bsp/hdf/hdf-repository.inc
#
# It is assumed the URL being pointed to will be a series of directories.  The HDF_MACHINE value
# will be the directory name, and the contents within the directory will be the XSA file.
#
# Each HDF_MACHINE can be inside subdirectories, but that HDF_MACHINE directory needs to be unique
# within the entire repository, i.e.
#
# <base_url>/MACHINE-1/system.xsa
# <base_url>/MACHINE-2/my_system.xsa
# ...
# <base_url>/MACHINE-n/system.xsa
#
# or
#
# <base_url>/group/MACHINE-1/system.xsa
# <base_url>/group/MACHINE-2/my_system.xsa
# <base_url>/other/MACHINE-3/system.xsa
# <base_url>/other/MACHINE-4/my_system.xsa
# ...
# <base_url>/dir/MACHINE-n/system.xsa
#

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
echo "# Redefine the default to use our values if not overriden by the user"
echo "# fall back to the original default if necessary"
echo "HDF_BASE_DEFAULT := '\${HDF_BASE}'"
echo "HDF_PATH_DEFAULT := '\${HDF_PATH}'"
echo "BRANCHARG_DEFAULT := '\${BRANCHARG}'"
echo "HDF_BASE ??= \"\${@d.getVarFlag('HDF_BASE', d.getVar('HDF_MACHINE')) or '\${HDF_BASE_DEFAULT}'}\""
echo "HDF_PATH ??= \"\${@d.getVarFlag('HDF_PATH', d.getVar('HDF_MACHINE')) or '\${HDF_PATH_DEFAULT}'}\""
echo "BRANCHARG ??= \"\${@d.getVarFlag('BRANCHARG', d.getVar('HDF_MACHINE')) or '\${BRANCHARG_DEFAULT}'}\""

# Downloaded but not used
README="README.md"
if [ ! -e ${README} ]; then
    echo "WARNING: No ${README} file!" >&2
else
    echo "SRC_URI += '${url}/$README;name=readme'"
    echo "SRC_URI[readme.sha256sum] = '$(sha256sum $README | cut -d ' ' -f 1)'"
    echo
fi

# Include the files, but don't setup LIC_FILES_CHKSUM.  User can manually
# file the LICENSE file if needed.
LICENSE="LICENSE.md"
if [ ! -e ${LICENSE} ]; then
    echo "WARNING: No ${LICENSE} file!" >&2
else
    echo "SRC_URI += '${url}/$LICENSE;name=license'"
    echo "SRC_URI[license.sha256sum] = '$(sha256sum $LICENSE | cut -d ' ' -f 1)'"

    # Disable since it breaks current PetaLinux workflow
    #if [ ${urlproto} = "file://" ]; then
    #    echo "LIC_FILES_CHKSUM = 'file://${urlpath}/$LICENSE;md5=$(md5sum $LICENSE | cut -d ' ' -f 1)'"
    #else
    #    echo "LIC_FILES_CHKSUM = 'file://$LICENSE;md5=$(md5sum $LICENSE | cut -d ' ' -f 1)'"
    echo
fi

for each_file in $(find . -type f -name '*.xsa' | sort) ; do
    case ${each_file} in
        *index.html)  continue ;;
        *${README})   continue ;;
        *${LICENSE})  continue ;;
        *)
            id=$(basename `dirname $each_file` | tr '/' '_')
            # Find subdirectories, if present
            subdir=$(dirname `dirname $each_file`)
            subdir=${subdir##.}
            file=$(basename $each_file)
            sha=$(sha256sum $each_file | cut -d ' ' -f 1)
            echo
            echo "# ${id}"
            echo "HDF_BASE[${id}] = '${urlproto}'"
            echo "HDF_PATH[${id}] = '${urlpath}${subdir}/${id}/${file}'"
            echo "BRANCHARG[${id}] = 'name=${id}'"
            echo "SRC_URI[${id}.sha256sum] = '${sha}'"
            ;;
    esac
done
if [ -n "${tempdir}" ]; then
    rm -r $tempdir
fi
