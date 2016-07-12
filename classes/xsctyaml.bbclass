inherit python-dir

do_create_yaml[depends] = "python-pyyaml-native:do_populate_sysroot"

YAML_APP_CONFIG ?= ''
YAML_BSP_CONFIG ?= ''
YAML_FILE_PATH ?= ''

def patch_yaml(config, configflags, type, type_dict):
    import re
    for cfg in config:
        if cfg not in configflags:
            error_msg = "%s: invalid CONFIG" % (cfg)
            bb.error("YAML config Issue: %s " % (error_msg))
        else:
            cfgval = configflags[cfg].split(',', 1)
            type_dict[type].update({cfg: {re.sub(r'\s','',cfgval[0]): cfgval[1]}})

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
        yaml_dict = patch_yaml(appconfig, configflags, 'app', yaml_dict)

    bspconfig = (d.getVar("YAML_BSP_CONFIG", True) or "").split()
    if bspconfig:
        yaml_dict.update({'bsp': {}})
        configflags = d.getVarFlags("YAML_BSP_CONFIG") or {}
        yaml_dict = patch_yaml(bspconfig, configflags, 'bsp', yaml_dict)

    fp = d.getVar("YAML_FILE_PATH", True)
    if fp :
        yamlfile = open(fp, 'w')
        yamlfile.write(yaml.dump(yaml_dict, default_flow_style=True))
}

addtask create_yaml before do_configure
