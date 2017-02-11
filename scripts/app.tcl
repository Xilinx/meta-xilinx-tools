package require cmdline
package require yaml

proc clean_n_build {type name} {
	projects -clean -type $type -name $name
}

proc build_only {type name} {
	projects -build -type $type -name $name
}

proc env_read {name} {
	# Assume env as false if dosent exists
	if { [info exists ::env($name)] } {
		return $::env($name)
	}
	return 0
}

proc check_ws {workspace} {
	# Check if any Projects exits and import them to retain right metadata
}

# re/auto generation of bsp is FALSE by default.
set autogenbsp 0

set option {
	{hdf.arg	""			"hardware Definition file"}
	{processor.arg	""			"target processor"}
	{osname.arg	"standalone"		"target OS"}
	{rp.arg		""			"repo path"}
	{app.arg	"Empty Application"	"Application project fsbl, empty.."}
	{lib.arg	""			"Add library"}
	{pname.arg	""			"Project Name"}
	{bspname.arg	""			"standalone bsp name"}
	{ws.arg		""			"Work Space Path"}
	{hwpname.arg	""			"hardware project name"}
	{arch.arg	"64"			"32/64 bit architecture"}
	{do_compile.arg	"0"			"Build the project"}
	{forceconf.arg	"0"			"Apply the yaml comfigs on existing project"}
	{yamlconf.arg	""			"Path to Config File"}
}

set usage  "xsct app.tcl <arguments>"
array set params [cmdline::getoptions argv $option $usage]

proc set_app_conf {action prop val} {
	if { [catch {configapp -$action -app $::params(pname) $prop $val} result] } {
		puts "ERROR:[info level 0]: Cannot set Property \"$prop\" with $val \n$result"
	}
}

proc set_bsp_conf {action prop val} {
	if { [catch {configbsp -$action -hw $::params(hwpname) -bsp $::params(bspname) $prop $val} result1] } {
		if { [catch {configbsp -hw $::params(hwpname) -bsp $::params(bspname) $prop $val} result2] } {
			puts "ERROR:[info level 0]: Cannot set Property \"$prop\" with $val \n$result2"
		}
	}
        regenbsp -bsp $::params(bspname)
}

proc xsct_config {type conf} {
	foreach prop [dict keys $conf] {
		foreach action [dict keys [dict get $conf $prop]] {
			set_$type\_conf $action $prop [dict get $conf $prop $action]
		}
	}
}

proc do_bsp_config {conf} {
	#  Availabe BSP configs
	#  proc :
	#  archiver   ex: aarch64-none-elf-ar
	#  compiler   ex: aarch64-none-elf-gcc
	#  compiler_flags
	#  extra_compiler_flags
	#
	#  OS: (standalone)
	#  enable_sw_intrusive_profiling
	#  microblaze_exceptions
	#  predecode_fpu_exceptions
	#  profile_timer
	#  stdin
	#  stdout
	#
	#  Also can configure  Library Specific Configs
	if { [catch {xsct_config bsp [dict get $conf bsp]} result] } {
		puts "XSCTHELPER INFO: No BSP Configuration \n\t $result"
	}
}

proc do_app_config {conf} {
	# Available App Configurations
	#   assembler-flags                Miscellaneous flags for assembler
	#   build-config                   Get/set build configuration
	#   compiler-misc                  Compiler miscellaneous flags
	#   compiler-optimization          Optimization level
	#   define-compiler-symbols        Define symbols. Ex. MYSYMBOL
	#   include-path                   Include path for header files
	#   libraries                      Libraries to be added while linking
	#   library-search-path            Search path for the libraries added
	#   linker-misc                    Linker miscellaneous flags
	#   linker-script                  Linker script for linking the program sections
	#   undef-compiler-symbols         Undefine symbols. Ex. MYSYMBOL
	if { [catch {xsct_config app [dict get $conf app]} result] } {
		puts "XSCTHELPER INFO: No APP configuration \n\t $result"
	}
}

set libs [split $params(lib) { }]

# Workspace required
if { $params(ws) ne "" } {
	#Local Work Space available
	setws $params(ws)
	if { [catch {importprojects $params(ws)} result] } {
		puts "XSCTHELPER INFO: Empty WorkSpace"
	}
	if { $params(pname) ne "" } {
		# hwpname/bspname is empty then default it to pname+_hwproj/bsp
		if {$params(hwpname) eq ""} {
			set params(hwpname) "$params(pname)\_hwproj"
		}
		if {$params(bspname) eq ""} {
			set params(bspname) "$params(pname)\_bsp"
			set autogenbsp 1
		}
		if { $params(do_compile) == 1 } {
			clean_n_build bsp $params(bspname)
			clean_n_build app $params(pname)
			build_only bsp $params(bspname)
			build_only app $params(pname)
			exit 0
		}

		if { $params(yamlconf) ne "" } {
			set conf_dict [::yaml::yaml2dict -file $params(yamlconf)]
		}

		if { $params(rp) ne "none" } {
			#Local Repo Available, Set repo path. Or will pick it up from build
			set path [split $params(rp) { }]
			repo -set $path
		}

		# Check if $hwpname exist
		set poke_hwproj [lsearch -exact [getprojects -type hw] $params(hwpname)]
		#Check for Project(SW/HW) availablity in work space and built it.
		set poke_bsp [lsearch -exact [getprojects -type bsp] $params(bspname)]
		set poke_app [lsearch -exact [getprojects -type app] $params(pname)]


		if { $poke_hwproj >= 0 } {
			puts "INFO: Update hw $params(hwpname) project"
			updatehw -hw $params(hwpname) -newhwspec $params(hdf)

			if { $poke_app >= 0 && $poke_bsp >= 0 } {
				#check if conf_dict exists(Depends on user passed the yaml file or not)
				if { [info exists conf_dict] } {
					do_app_config $conf_dict
					do_bsp_config $conf_dict
				}
				# Configuration done
				exit 0
			}
		} else {
			createhw -name $params(hwpname) -hwspec $params(hdf)
		}

		if { [info exists autogenbsp] && $autogenbsp eq 1 } {
			puts "INFO: create app using $params(hwpname) project"
			createapp -name $params(pname) -proc $params(processor) \
			  -hwproject $params(hwpname) \
			  -os $params(osname) -lang c -app $params(app) -arch $params(arch)
			#check if conf_dict exists(Depends on user passed the yaml file or not)
			if { [info exists conf_dict] } {
				do_app_config $conf_dict
				if { $autogenbsp eq 1} {
					do_bsp_config $conf_dict
				}
			}
		} else {
			puts "INFO: create bsp using $params(bspname)"
			# BSP name given, but not availabe in ws. So creating a custome one
			createbsp -name $params(bspname) -proc $params(processor) \
				  -hwproject $params(hwpname) -os $params(osname) -arch $params(arch)
			foreach l $libs {
				setlib -hw $params(hwpname) -bsp $params(bspname) -lib $l
			}
			#check if conf_dict exists(Depends on user passed the yaml file or not)
			if { [info exists conf_dict] } {
				do_bsp_config $conf_dict
			}
			regenbsp -hw $params(hwpname) -bsp $params(bspname)
			puts "INFO: create app using custom bsp"
			# Create a App for custom bsp
			createapp -name $params(pname) -proc $params(processor) \
				  -hwproject $params(hwpname) -bsp $params(bspname) \
				  -os $params(osname) -lang c -app $params(app) -arch $params(arch)
			#check if conf_dict exists(Depends on user passed the yaml file or not)
			if { [info exists conf_dict] } {
				do_app_config $conf_dict
			}
		}
	} else {
		if { $prams(hwpname) ne "" } {
			if { $params(hdf) ne "" } {
				createhw -name $params(hwpname) -hwspec $params(hdf)
			} else {
				puts stderr "ERROR: NO HDF mentiond for HWPROJ generation"
			}
		} else {
			#Error: Project Name is needed
			puts stderr "ERROR: Project name not mentioned"
		}
	}
} else {
	# Error: Workspace is needed
	puts stderr "ERROR: Workspace not mentioned"
}

exit
