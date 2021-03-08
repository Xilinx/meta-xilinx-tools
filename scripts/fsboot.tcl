set dir [file dirname [info script]]
source "$dir/base-hsi.tcl"

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
	{arch.arg	"32"			"32/64 bit architecture"}
	{do_compile.arg	"0"			"Build the project"}
	{forceconf.arg	"0"			"Apply the yaml configs on existing project"}
	{yamlconf.arg	""			"Path to Config File"}
}
set usage "A script to generate and compile device-tree and fs-boot sources"
array set params [::cmdline::getoptions argv $option $usage]
set project "$params(ws)/$params(pname)"

file delete -force "$project"

set_hw_design $project $params(hdf) $params(hdf_type)
if { [catch {hsi set_repo_path $params(rp)} res] } {
	error "Failed to set repo path $params(rp)"
}

if { $params(processor) ne "" } {
	set processor $params(processor)
} else {
	set processor [lindex [hsi get_cells -hier -filter IP_NAME==$params(processor_ip)] 0]
}
if {[catch {hsi create_sw_design $params(app) -app $params(app) \
		-os standalone -proc $processor} res] } {
	error "create_sw_design failed for $params(app)"
}
set_properties $params(yamlconf)
if { [catch {hsi generate_app -dir $project} res] } {
	error "Failed to generate app $params(app)"
}
if {[catch {hsi close_sw_design [hsi current_sw_design]} res]} {
	error "failed to close sw_design"
}
if { [catch {hsi close_hw_design [hsi current_hw_design]} res] } {
	error "Failed to close hw design [hsi current_hw_design]"
}
