set option {
        {hdf.arg        ""                      "hardware Definition file"}
        {processor.arg  ""                      "target processor"}
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


setws $params(ws);
set poke_hwproj [lsearch -exact [getprojects -type hw] $params(hwpname)]
if { $poke_hwproj < 0 } {
	# $hwpname not available, create new with given hdf
	createhw -name $params(hwpname) -hwspec $params(hdf)
} elseif { $params(hdf) ne "" } {
	# $hwpname and hdf availabe, regenerate hwproject
	deleteprojects -name $params(hwpname)
      	createhw -name $params(hwpname) -hwspec $params(hdf)
} else {
	puts "INFO: HDF not available. Using $params(hwpname) project"
}

