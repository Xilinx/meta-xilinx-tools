inherit python3native

# Override site package path for multilib builds
PYTHON_SITEPACKAGES_DIR = "${libdir_native}/${PYTHON_DIR}/site-packages"

do_create_yaml[depends] = "python3-pyyaml-native:do_populate_sysroot"

YAML_APP_CONFIG ?= ''
YAML_BSP_CONFIG ?= ''
YAML_FILE_PATH ?= ''

YAML_FILE_PATH = "${WORKDIR}/${PN}.yaml"
XSCTH_MISC_append = " -yamlconf ${YAML_FILE_PATH}"

YAML_BUILD_CONFIG ?= "${@d.getVar('XSCTH_BUILD_CONFIG', True).lower()}"
YAML_APP_CONFIG += "${@'build-config' if d.getVar('YAML_BUILD_CONFIG', True) != '' else ''}"
YAML_APP_CONFIG[build-config] = "set,${YAML_BUILD_CONFIG}"

YAML_COMPILER_FLAGS ?= "${@d.getVar('XSCTH_COMPILER_DEBUG_FLAGS', True) if d.getVar('XSCTH_BUILD_DEBUG', True) != "0" else ''}"
YAML_APP_CONFIG += "${@'compiler-misc' if d.getVar('YAML_COMPILER_FLAGS', True) != '' else ''}"
YAML_APP_CONFIG[compiler-misc] = "add,${YAML_COMPILER_FLAGS}"

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
    os.sys.path.append(os.path.join(d.getVar('STAGING_DIR_NATIVE', True),d.getVar('PYTHON_SITEPACKAGES_DIR', True)[1::]))
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

    fp = d.getVar("YAML_FILE_PATH", True)
    if fp :
        yamlfile = open(fp, 'w')
        yamlfile.write(yaml.dump(yaml_dict, default_flow_style=True))
}

addtask create_yaml before do_configure
