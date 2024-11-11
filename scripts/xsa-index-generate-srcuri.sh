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

for each_file in $(find . -type f -name '*.xsa' | sort) ; do
    case ${each_file} in
        *index.html)  continue ;;
        *)
            id=$(basename `dirname $each_file` | tr '/' '_')
            # Find subdirectories, if present
            subdir=$(dirname `dirname $each_file`)
            subdir=${subdir##.}
            file=$(basename $each_file)
            sha=$(sha256sum $each_file | cut -d ' ' -f 1)
            echo "${id} ${urlproto}${urlpath}${subdir}/${id}/${file}"
            ;;
    esac
done
if [ -n "${tempdir}" ]; then
    rm -r $tempdir
fi
