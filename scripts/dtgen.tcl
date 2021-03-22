set dir [file dirname [info script]]
source $dir/base-hsi.tcl
set option {
	{hdf.arg	""			"hardware Definition file"}
	{hdf_type.arg   "hdf"			"hardware Defination file type: xsa"}
	{processor_ip.arg	""		"target processor_ip"}
	{processor.arg	""			"target processor_ip instance name"}
	{rp.arg		""			"repo path"}
	{app.arg	"empty_application"	"Application project fsbl, empty.."}
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
set usage "A script to generate and compile device-tree"
array set params [::cmdline::getoptions argv $option $usage]
set project "$params(ws)/$params(pname)"

set_hw_design $project $params(hdf) $params(hdf_type)

if { [catch {hsi set_repo_path $params(rp)} res] } {
	error "Failed to set repo path $params(rp)"
}

if { $params(processor) ne "" } {
	set processor $params(processor)
} else {
	set processor [lindex [hsi get_cells -hier -filter IP_NAME==$params(processor_ip)] 0]
}
if {[catch {hsi create_sw_design $params(app) \
		-os device_tree -proc $processor} res] } {
	error "create_sw_design failed for $params(app)"
}

#Enable zocl by default when its a expandable xsa
if { [ishwexpandable $params(hdf)] } {
	hsi set_property CONFIG.dt_zocl true [hsi get_os]
}

if {[file exists $params(yamlconf)]} {
	set_properties $params(yamlconf)
}

if {[catch {hsi generate_target -dir $project} res]} {
	error "generate_target failed"
}
if { [catch {hsi close_hw_design [hsi current_hw_design]} res] } {
	error "Failed to close hw design [hsi current_hw_design]"
}
