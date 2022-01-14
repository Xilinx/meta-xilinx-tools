#requires xsa repo path proc dir yaml-file-location
package require cmdline
package require yaml

proc get_os_config_list {} {
	set prop_data [hsi report_property -all -return_string \
				[hsi get_os] CONFIG.*]
	set conf_data [split $prop_data "\n"]
	set config_list {}
	foreach line $conf_data {
		if { [regexp "^CONFIG..*" $line matched] == 1 } {
			set config_name [split $line " "]
			set config_name [lindex $config_name 0]
			regsub -- "CONFIG." $config_name "" config_name
			lappend config_list $config_name
		}
	}
	return $config_list
}


proc set_properties { yamlconf } {
	set os_config_list [get_os_config_list]
	if { $yamlconf ne "" } {
		set conf_dict [::yaml::yaml2dict -file $yamlconf]
		if {[dict exists $conf_dict "bsp"]} {
			foreach prop [dict keys [dict get $conf_dict "bsp"]] {
				foreach action [dict keys \
						[dict get $conf_dict "bsp" $prop]] {
					if { [lsearch -exact -nocase $os_config_list $prop] < 0} {
						continue
					}
					if { [catch {hsi set_property CONFIG.$prop \
						[dict get $conf_dict "bsp" $prop $action] \
							[hsi get_os]} res] } {
						error "NO BSP configuration available"
					}
				}
			}
		}
	}
}

proc set_hw_design {project hdf rphdf hdf_type} {
	file mkdir $project
	if { [catch { exec cp $hdf $project/hardware_description.$hdf_type } msg] } {
        	puts "$::errorInfo"
	}
	if { [catch { exec cp $rphdf $project/rp.$hdf_type } msg] } {
        	puts "$::errorInfo"
	}

	if { [catch {hsi open_hw_design -static  $project/hardware_description.$hdf_type -cells [list rp1rm1:$project/rp.$hdf_type]} res] } {
        	error "Failed to open hardware design \
                       $project/hardware_description.$hdf_type"
	}
}
