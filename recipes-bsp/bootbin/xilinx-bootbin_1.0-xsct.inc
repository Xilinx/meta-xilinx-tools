BIF_BITSTREAM_ATTR ?= "${@bb.utils.contains('MACHINE_FEATURES', 'fpga-overlay', '', ' bitstream', d)}"
