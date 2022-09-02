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
	{rphdf.arg	""			"rp hardware Definition file"}
	{hdf_type.arg   ""			"hardware Definition file type: xsa"}
	{processor_ip.arg	""		"target processor_ip"}
	{processor.arg	""			"target processor_ip instance name"}
	{osname.arg	"device_tree"		"target OS"}
	{rp.arg		""			"repo path"}
	{lib.arg	""			"Add library"}
	{pname.arg	""			"Project Name"}
	{bspname.arg	""			"standalone bsp name"}
	{ws.arg		""			"Work Space Path"}
	{hwpname.arg	""			"hardware project name"}
	{arch.arg	"64"			"32/64 bit architecture"}
	{do_compile.arg	"0"			"Build the project"}
	{forceconf.arg	"0"			"Apply the yaml configs on existing project"}
	{yamlconf.arg	""			"Path to Config File"}
}

set usage  "xsct dtgen_dfx.tcl <arguments>"
array set params [cmdline::getoptions argv $option $usage]


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
	#  OS: (device_tree)
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

set libs [split $params(lib) { }]

# Workspace required
if { $params(ws) ne "" } {
	# Local Work Space available
	if { $params(pname) ne "" } {
		# hwpname/bspname is empty then default it to pname+_hwproj/bsp
		if {$params(hwpname) eq ""} {
			set params(hwpname) "$params(pname)\_plat"
		}
		if {$params(bspname) eq ""} {
			set params(bspname) "$params(pname)\_domain"
			# set autogenbsp 1
		}

		if { $params(yamlconf) ne "" } {
			set conf_dict [::yaml::yaml2dict -file $params(yamlconf)]
		}

		if { $params(rp) ne "none" } {
			#Local Repo Available, Set repo path. Or will pick it up from build
			set path [split $params(rp) { }]
			::hsi::utils::add_repo "$path"
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
		set procs [getprocessors $params(hdf)]
		if {[llength $procs] != 0} {
			set processor [lindex $procs 0]
			puts "INFO: Targeting Static XSA Processor is '$processor'"
			if {$params(rphdf) eq ""} {
				# Static xsa parsing
				platform create -name $params(hwpname) -hw $params(hdf) \
				-os device_tree -proc $processor -no-boot-bsp -out $params(ws)
			} else {
				# Partial xsa parsing which depends on static xsa for propcessor instance.
				platform create -name $params(hwpname) -hw $params(hdf) \
				-rm-hw $params(rphdf) -os device_tree -proc $processor -no-boot-bsp -out $params(ws)
			}
		} else {
			puts "Error: No processor instance found in static xsa file"
		}

		# Enable zocl by default when design is extensibale platform xsa
		if { [ishwexpandable $params(hdf)] } {
			hsi::set_property CONFIG.dt_zocl true [hsi get_os]
		}

		if { [info exists conf_dict] } {
			xsct_set_libs $libs
			do_bsp_config $conf_dict
		}
		platform generate -quick
	}
} else {
	# Error: Workspace is needed
	puts stderr "ERROR: Workspace not mentioned"
}

exit
