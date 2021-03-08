set option {
        {hdf.arg        ""                      "hardware Definition file"}
	{hdf_type.arg   "hdf"                   "hardware Defination file type: xsa"}
        {processor_ip.arg  ""                   "target processor_ip"}
        {processor.arg	""			"target processor_ip instance name"}
        {rp.arg         ""                      "repo path"}
        {app.arg        "Empty Application"     "Application project fsbl, empty.."}
        {lib.arg        ""                      "Add library"}
        {pname.arg      ""                      "Project Name"}
        {bspname.arg    ""                      "standalone bsp name"}
        {ws.arg         ""                      "Work Space Path"}
        {hwpname.arg    ""                      "hardware project name"}
        {arch.arg       "64"                    "32/64 bit architecture"}
        {do_compile.arg "0"                     "Build the project"}
        {forceconf.arg  "0"                     "Apply the yaml comfigs on existing project"}
        {yamlconf.arg   ""                      "Path to Config File"}
}

set usage  "xsct bitstream.tcl <arguments>"
array set params [cmdline::getoptions argv $option $usage]

if {$params(hwpname) eq ""} {
        set params(hwpname) "$params(pname)\_hwproj"
}

catch {cd $params(ws)}
set project "$params(hwpname)"
file delete -force "$project"
file mkdir "$project"
if { [catch { exec cp $params(hdf) $project/hardware_description.$params(hdf_type) } msg] } {
        puts "$::errorInfo"
}

if { [catch {openhw $project/hardware_description.$params(hdf_type)} res] } {
        error "Failed to open hardware design \
               $project/hardware_description.$params(hdf_type)"
}

