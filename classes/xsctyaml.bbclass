inherit python3native

DEPENDS += "python3-pyyaml-native"

# Since we're not inheriting native.bbclass, we need to set libdir to correctly point to the native libdir
PYTHON_SITEPACKAGES_DIR = "${libdir_native}/${PYTHON_DIR}/site-packages"

YAML_APP_CONFIG ?= ''
YAML_BSP_CONFIG ?= ''
YAML_FILE_PATH ?= ''
YAML_DT_BOARD_FLAGS ?= ''
YAML_SERIAL_CONSOLE_STDIN ?= ''
YAML_SERIAL_CONSOLE_STDOUT ?= ''
YAML_SERIAL_CONSOLE_BAUDRATE ?= ''
YAML_MAIN_MEMORY_CONFIG ?= ''
YAML_CONSOLE_DEVICE_CONFIG ?= ''
YAML_FLASH_MEMORY_CONFIG ?= ''
YAML_REMOVE_PL_DT ?= ''
YAML_DISABLE_DT_ZOCL ?= ''
YAML_FIRMWARE_NAME ?= ''
YAML_OVERLAY_CUSTOM_DTS ?= ''
YAML_BSP_COMPILER_FLAGS ?= ''
YAML_ENABLE_NO_ALIAS ?= ''
YAML_ENABLE_DT_VERBOSE ?= ''

YAML_SERIAL_CONSOLE_STDIN_ultra96 ?= "psu_uart_1"
YAML_SERIAL_CONSOLE_STDOUT_ultra96 ?= "psu_uart_1"

YAML_COMPILER_FLAGS_append_ultra96 = " -DBOARD_SHUTDOWN_PIN=2 -DBOARD_SHUTDOWN_PIN_STATE=0 "

YAML_FILE_PATH = "${WORKDIR}/${PN}.yaml"
XSCTH_MISC_append = " -yamlconf ${YAML_FILE_PATH}"

YAML_BUILD_CONFIG ?= "${@d.getVar('XSCTH_BUILD_CONFIG').lower()}"
YAML_APP_CONFIG += "${@'build-config' if d.getVar('YAML_BUILD_CONFIG') != '' else ''}"
YAML_APP_CONFIG[build-config] = "set,${YAML_BUILD_CONFIG}"

YAML_COMPILER_FLAGS ?= "${@d.getVar('XSCTH_COMPILER_DEBUG_FLAGS') if d.getVar('XSCTH_BUILD_DEBUG') != "0" else d.getVar('XSCTH_APP_COMPILER_FLAGS')}"
YAML_APP_CONFIG += "${@'compiler-misc' if d.getVar('YAML_COMPILER_FLAGS') != '' else ''}"
YAML_APP_CONFIG[compiler-misc] = "add,${YAML_COMPILER_FLAGS}"

YAML_BSP_CONFIG += "${@'extra_compiler_flags' if d.getVar('YAML_BSP_COMPILER_FLAGS') != '' else ''}"
YAML_BSP_CONFIG[extra_compiler_flags] = "add,${YAML_BSP_COMPILER_FLAGS}"

YAML_BSP_CONFIG += "${@'periph_type_overrides' if d.getVar('YAML_DT_BOARD_FLAGS') != '' else ''}"
YAML_BSP_CONFIG[periph_type_overrides] = "set,${YAML_DT_BOARD_FLAGS}"

YAML_BSP_CONFIG += "${@'stdin' if d.getVar('YAML_SERIAL_CONSOLE_STDIN') != '' else ''}"
YAML_BSP_CONFIG[stdin] = "set,${YAML_SERIAL_CONSOLE_STDIN}"

YAML_BSP_CONFIG += "${@'stdout' if d.getVar('YAML_SERIAL_CONSOLE_STDOUT') != '' else ''}"
YAML_BSP_CONFIG[stdout] = "set,${YAML_SERIAL_CONSOLE_STDOUT}"

YAML_BSP_CONFIG += "${@'main_memory' if d.getVar('YAML_MAIN_MEMORY_CONFIG') != '' else ''}"
YAML_BSP_CONFIG[main_memory] = "set,${YAML_MAIN_MEMORY_CONFIG}"


YAML_BSP_CONFIG += "${@'flash_memory' if d.getVar('YAML_FLASH_MEMORY_CONFIG') != '' else ''}"
YAML_BSP_CONFIG[flash_memory] = "set,${YAML_FLASH_MEMORY_CONFIG}"

YAML_BSP_CONFIG += "${@'console_device' if d.getVar('YAML_CONSOLE_DEVICE_CONFIG') != '' else ''}"
YAML_BSP_CONFIG[console_device] = "set,${YAML_CONSOLE_DEVICE_CONFIG}"

YAML_BSP_CONFIG += "${@'dt_overlay' if d.getVar('YAML_ENABLE_DT_OVERLAY') == '1' else ''}"
YAML_BSP_CONFIG[dt_overlay] = "set,TRUE"

YAML_ENABLE_DT_OVERLAY ?= "${@bb.utils.contains('MACHINE_FEATURES', 'fpga-overlay', '1', '0', d)}"

YAML_BSP_CONFIG += "${@'firmware_name' if d.getVar('YAML_FIRMWARE_NAME') != '' else ''}"
YAML_BSP_CONFIG[firmware_name] = "set,${YAML_FIRMWARE_NAME}"

YAML_BSP_CONFIG += "${@'dt_zocl' if d.getVar('YAML_DISABLE_DT_ZOCL') == '1' else ''}"
YAML_BSP_CONFIG[dt_zocl] = "set,FALSE"

YAML_BSP_CONFIG += "${@'overlay_custom_dts' if d.getVar('YAML_OVERLAY_CUSTOM_DTS') != '' else ''}"
YAML_BSP_CONFIG[overlay_custom_dts] = "set,${YAML_OVERLAY_CUSTOM_DTS}"

YAML_BSP_CONFIG += "${@'remove_pl' if d.getVar('YAML_REMOVE_PL_DT') == '1' else ''}"
YAML_BSP_CONFIG[remove_pl] = "set,TRUE"
YAML_BSP_CONFIG += "${@'no_alias' if d.getVar('YAML_ENABLE_NO_ALIAS') == '1' else ''}"
YAML_BSP_CONFIG[no_alias] = "set,TRUE"

YAML_BSP_CONFIG += "${@'dt_verbose' if d.getVar('YAML_ENABLE_DT_VERBOSE') == '1' else ''}"
YAML_BSP_CONFIG[dt_verbose] = "set,TRUE"

YAML_BSP_CONFIG += "${@'dt_setbaud' if d.getVar('YAML_SERIAL_CONSOLE_BAUDRATE') != '' else ''}"
YAML_BSP_CONFIG[dt_setbaud] = "set,${YAML_SERIAL_CONSOLE_BAUDRATE}"

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

    appconfig = (d.getVar("YAML_APP_CONFIG") or "").split()
    if appconfig:
        yaml_dict.update({'app': {}})
        configflags = d.getVarFlags("YAML_APP_CONFIG") or {}
        yaml_dict = patch_yaml(appconfig, configflags, 'app', yaml_dict, d)

    bspconfig = (d.getVar("YAML_BSP_CONFIG") or "").split()
    if bspconfig:
        yaml_dict.update({'bsp': {}})
        configflags = d.getVarFlags("YAML_BSP_CONFIG") or {}
        yaml_dict = patch_yaml(bspconfig, configflags, 'bsp', yaml_dict, d)

    if len(yaml_dict) != 0:
        fp = d.getVar("YAML_FILE_PATH")
        if fp :
            yamlfile = open(fp, 'w')
            yamlfile.write(yaml.dump(yaml_dict, default_flow_style=True, width=2000))
            yamlfile.close()
}

addtask create_yaml after do_prepare_recipe_sysroot before do_configure

PACKAGE_ARCH_ultra96 = "${BOARD_ARCH}"
