package require cmdline
package require yaml

proc clean_n_build {type name} {
	cd $params(ws)
	cd $name
	make clean
}

proc build_only {type name} {
	cd $params(ws)
	cd $name
	make
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


set option {
	{hdf.arg	""			"hardware Definition file"}
	{processor_ip.arg	""		"target processor_ip"}
	{processor.arg	""			"target processor_ip instance name"}
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
	if { $prop == "build-config" } {
		if { $val == "Debug"} {
			set flags "-O0 -g3"
			::sdk::append_app_compiler_flags $flags
		} else {
			#puts "DEBUG: No change for Release Configuration."
		}
	} else {
		::sdk::append_app_compiler_flags $val
	}
}

proc set_bsp_conf {action prop val} {
	if { $action == "set"} {
		if { [catch {bsp config $prop $val} result1] } {
			if { [catch {bsp config $prop $val} result2] } {
				puts "ERROR:[info level 0]: Cannot set Property \"$prop\" with $val \n$result2"
			}
		}
	} else {
		if { [catch {bsp config -$action $prop $val} result1] } {
			if { [catch {bsp config $prop $val} result2] } {
				puts "ERROR:[info level 0]: Cannot set Property \"$prop\" with $val \n$result2"
			}
		}
	}
}

proc xsct_config {type conf} {
	foreach prop [dict keys $conf] {
		foreach action [dict keys [dict get $conf $prop]] {
			set_$type\_conf $action $prop [dict get $conf $prop $action]
		}
	}
}

proc xsct_set_libs {addlib} {
	foreach l $addlib {
		bsp setlib -name $l
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
	#
	#  puts "DEBUG: bsp conf  $conf "
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
	#
	#   puts "DEBUG: app conf  $conf "
	if { [catch {xsct_config app [dict get $conf app]} result] } {
		puts "XSCTHELPER INFO: No APP configuration \n\t $result"
	}
}

set libs [split $params(lib) { }]

# Workspace required
if { $params(ws) ne "" } {
	#Local Work Space available
	if { $params(pname) ne "" } {
		# hwpname/bspname is empty then default it to pname+_hwproj/bsp
		if {$params(hwpname) eq ""} {
			set params(hwpname) "$params(pname)\_plat"
		}
		if {$params(bspname) eq ""} {
			set params(bspname) "$params(pname)\_domain"
			# set autogenbsp 1
		}
		if { $params(do_compile) == 1 } {
			clean_n_build app $params(pname)
			build_only app $params(pname)
			exit 0
		}

		if { $params(yamlconf) ne "" } {
			set conf_dict [::yaml::yaml2dict -file $params(yamlconf)]
		}

		if { $params(rp) ne "none" } {
			#Local Repo Available, Set repo path. Or will pick it up from build
			set path [split $params(rp) { }]
			::hsi::utils::add_repo "$path/lib $path"
		}

		# Check if $hwpname exist
		catch {cd $params(ws) }
		if { [catch { set dirlist [glob -type d *] } msg ]  }  {
			set poke_hwproj -1
			set poke_app -1
		} else {
			set poke_hwproj [lsearch -exact $dirlist $params(hwpname)]
			set poke_app [lsearch -exact $dirlist  $params(pname)]
		}


		if { $poke_hwproj >= 0 } {
			puts "INFO: Update hw $params(hwpname) project"
			cd $params(ws)
			set platname $params(hwpname)
			platform read $params(ws)/$platname/platform.spr
			platform remove $platname
		}
		platform create -name $params(hwpname) -hw $params(hdf) -out $params(ws)
		set hsitemplate [::scw::get_app_template $params(app)]
		sysconfig create -name sysconfig1
		if { $params(processor) ne "" } {
			set processor $params(processor)
		} else {
			set processor [lindex [hsi get_cells -hier -filter IP_NAME==$params(processor_ip)] 0]
		}
		domain create -name $params(bspname) -proc $processor \
				  -os $params(osname) -support-app $hsitemplate	-arch $params(arch)
		if { [info exists conf_dict] } {
			xsct_set_libs $libs
			do_bsp_config $conf_dict
			platform generate -quick
		}

		puts "INFO: create bsp using $params(bspname)"
		cd $params(ws)
		set platname $params(hwpname)
		# Create a App for custom bsp
		if { [info exists conf_dict] } {
			do_app_config $conf_dict
		}
		app create -name $params(pname) -lang c -template $params(app) -plnx
	}
} else {
	# Error: Workspace is needed
	puts stderr "ERROR: Workspace not mentioned"
}

exit
