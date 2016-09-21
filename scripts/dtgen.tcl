#requires hdf repo path proc dir yaml-file-location
package require cmdline
package require yaml

set option {
	{hdf.arg	""			"hardware Definition file"}
	{processor.arg	""			"target processor"}
	{rp.arg		""			"repo path"}
	{app.arg	"empty_application"	"Application project fsbl, empty.."}
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

set usage "A script to generate device-tree sources"
array set params [::cmdline::getoptions argv $option $usage]

proc set_properties {} {
    global params
    if { $params(yamlconf) ne "" } {
        set conf_dict [::yaml::yaml2dict -file $params(yamlconf)]
        if {[dict exists $conf_dict "bsp"]} {
            foreach prop [dict keys [dict get $conf_dict "bsp"]] {
                foreach action [dict keys [dict get $conf_dict "bsp" $prop]] {
                    hsi set_property CONFIG.$prop [dict get $conf_dict "bsp" $prop $action] [hsi get_os]
                }
            }
        }
    }
}
hsi open_hw_design $params(hdf)
hsi set_repo_path $params(rp)
hsi create_sw_design device-tree -os device_tree -proc $params(processor)
set_properties
hsi generate_target -dir $params(pname)
