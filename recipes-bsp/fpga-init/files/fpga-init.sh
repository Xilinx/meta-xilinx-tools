#!/bin/sh

BASE=fpgamanager

if [ -f /etc/default/$BASE ]; then
    . /etc/default/$BASE
fi

if [ "$FPGA_INIT" = true ]; then
    source /lib/firmware/fpga-default.env
    #Script to loads default bitstream and dtbo on startup
    echo "Loading bitstream"
    fpgautil -b ${BIN} -o ${DTBO}
fi
