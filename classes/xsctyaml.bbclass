inherit python3native

DEPENDS += "python3-pyyaml-native"

YAML_APP_CONFIG ?= ''
YAML_BSP_CONFIG ?= ''
YAML_FILE_PATH ?= ''
YAML_DT_BOARD_FLAGS ?= ''
YAML_SERIAL_CONSOLE_STDIN ?= ''
YAML_SERIAL_CONSOLE_STDOUT ?= ''
YAML_MAIN_MEMORY_CONFIG ?= ''
YAML_CONSOLE_DEVICE_CONFIG ?= ''
YAML_FLASH_MEMORY_CONFIG ?= ''
YAML_REMOVE_PL_DT ?= ''

YAML_SERIAL_CONSOLE_STDIN_ultra96-zynqmp ?= "psu_uart_1"
YAML_SERIAL_CONSOLE_STDOUT_ultra96-zynqmp ?= "psu_uart_1"

YAML_COMPILER_FLAGS_append_ultra96-zynqmp = " -DBOARD_SHUTDOWN_PIN=2 -DBOARD_SHUTDOWN_PIN_STATE=0"

YAML_FILE_PATH = "${WORKDIR}/${PN}.yaml"
XSCTH_MISC_append = " -yamlconf ${YAML_FILE_PATH}"

YAML_BUILD_CONFIG ?= "${@d.getVar('XSCTH_BUILD_CONFIG', True).lower()}"
YAML_APP_CONFIG += "${@'build-config' if d.getVar('YAML_BUILD_CONFIG', True) != '' else ''}"
YAML_APP_CONFIG[build-config] = "set,${YAML_BUILD_CONFIG}"

YAML_COMPILER_FLAGS ?= "${@d.getVar('XSCTH_COMPILER_DEBUG_FLAGS', True) if d.getVar('XSCTH_BUILD_DEBUG', True) != "0" else d.getVar('XSCTH_APP_COMPILER_FLAGS', True)}"
YAML_APP_CONFIG += "${@'compiler-misc' if d.getVar('YAML_COMPILER_FLAGS', True) != '' else ''}"
YAML_APP_CONFIG[compiler-misc] = "add,${YAML_COMPILER_FLAGS}"

YAML_BSP_CONFIG += "${@'periph_type_overrides' if d.getVar('YAML_DT_BOARD_FLAGS', True) != '' else ''}"
YAML_BSP_CONFIG[periph_type_overrides] = "set,${YAML_DT_BOARD_FLAGS}"

YAML_BSP_CONFIG += "${@'stdin' if d.getVar('YAML_SERIAL_CONSOLE_STDIN', True) != '' else ''}"
YAML_BSP_CONFIG[stdin] = "set,${YAML_SERIAL_CONSOLE_STDIN}"

YAML_BSP_CONFIG += "${@'stdout' if d.getVar('YAML_SERIAL_CONSOLE_STDOUT', True) != '' else ''}"
YAML_BSP_CONFIG[stdout] = "set,${YAML_SERIAL_CONSOLE_STDOUT}"

YAML_BSP_CONFIG += "${@'main_memory' if d.getVar('YAML_MAIN_MEMORY_CONFIG', True) != '' else ''}"
YAML_BSP_CONFIG[main_memory] = "set,${YAML_MAIN_MEMORY_CONFIG}"


YAML_BSP_CONFIG += "${@'flash_memory' if d.getVar('YAML_FLASH_MEMORY_CONFIG', True) != '' else ''}"
YAML_BSP_CONFIG[flash_memory] = "set,${YAML_FLASH_MEMORY_CONFIG}"

YAML_BSP_CONFIG += "${@'console_device' if d.getVar('YAML_CONSOLE_DEVICE_CONFIG', True) != '' else ''}"
YAML_BSP_CONFIG[console_device] = "set,${YAML_CONSOLE_DEVICE_CONFIG}"

YAML_BSP_CONFIG += "${@'dt_overlay' if d.getVar('YAML_ENABLE_DT_OVERLAY', True) == '1' else ''}"
YAML_BSP_CONFIG[dt_overlay] = "set,TRUE"

YAML_ENABLE_DT_OVERLAY ?= "${@bb.utils.contains('IMAGE_FEATURES', 'fpga-manager', '1', '', d)}"

YAML_BSP_CONFIG += "${@'remove_pl' if d.getVar('YAML_REMOVE_PL_DT', True) == '1' else ''}"
YAML_BSP_CONFIG[remove_pl] = "set,TRUE"

def patch_yaml(config, configflags, type, type_dict, d):
    import re
    for cfg in config:
        if cfg not in configflags:
            error_msg = "%s: invalid CONFIG" % (cfg)
            bb.error("YAML config Issue: %s " % (error_msg))
        else:
            cfgval = configflags[cfg].split(',', 1)
            val = d.expand(cfgval[1])
            type_dict[type].update({cfg: {re.sub(r'\s','',cfgval[0]): val}})

    return type_dict

python do_create_yaml() {
    import sys, os
    os.sys.path.append(os.path.join(d.getVar('RECIPE_SYSROOT_NATIVE'),d.getVar('PYTHON_SITEPACKAGES_DIR')[1::]))
    import yaml
    yaml_dict = {}

    appconfig = (d.getVar("YAML_APP_CONFIG", True) or "").split()
    if appconfig:
        yaml_dict.update({'app': {}})
        configflags = d.getVarFlags("YAML_APP_CONFIG") or {}
        yaml_dict = patch_yaml(appconfig, configflags, 'app', yaml_dict, d)

    bspconfig = (d.getVar("YAML_BSP_CONFIG", True) or "").split()
    if bspconfig:
        yaml_dict.update({'bsp': {}})
        configflags = d.getVarFlags("YAML_BSP_CONFIG") or {}
        yaml_dict = patch_yaml(bspconfig, configflags, 'bsp', yaml_dict, d)

    if len(yaml_dict) != 0:
        fp = d.getVar("YAML_FILE_PATH", True)
        if fp :
            yamlfile = open(fp, 'w')
            yamlfile.write(yaml.dump(yaml_dict, default_flow_style=True, width=2000))
}

addtask create_yaml after do_prepare_recipe_sysroot before do_configure
