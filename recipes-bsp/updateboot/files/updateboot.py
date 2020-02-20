#!/usr/bin/env python
#put together bif fragments and paths to elfs pointed to by softlinks in /boot
import os,sys,glob

#default basepath is /boot, basepath can be supplied as an input
if len(sys.argv) > 1:
    basepath = sys.argv[1]
else:
    basepath = '/boot/'

cfgstr = 'the_ROM_image:\n{\n'
finalbif = os.path.join(basepath, 'bootgen.bif')

for cfg in '@@BOOTBIN_BIF_ATTR@@'.split(' '):
    try:
        if cfg == 'bitstream-extraction':
            ext = 'bit'
        elif cfg == 'device-tree':
            ext = 'dtb'
        else:
            ext = 'elf'
        cfgelf = os.path.join(basepath, cfg + '.' + ext)
        #need this for host build as the symlink pointing to /boot/${PN}.elf isnt there
        if basepath != '/boot/':
            cfgelf = os.path.join(basepath, os.path.basename(os.readlink(cfgelf)))
    except:
        print('The binary for ' + cfg + ' is not present')
	continue
    cfgbif = os.path.join(basepath, cfg + '.bif')
    if os.path.isfile(cfgbif):
        with open(cfgbif, 'r') as f:
            lines = '['+f.read().strip('\n')+']'
    else:
        lines = ''
    cfgstr = cfgstr + "\t %s %s\n" % (lines, cfgelf)

cfgstr = cfgstr + '}'
with open(finalbif, 'w') as f:
    f.write(cfgstr)
print("BIF file now at " + finalbif)
