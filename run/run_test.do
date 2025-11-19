if {![info exists testname]} {
	set testname "mac_base_test"
}
vlog list.svh +incdir+C:/uvm-1.2/src +define+ETH_WISHBONE_B3
vsim -novopt -suppress 12110 top \
-sv_lib C:/questasim64_2024.1/uvm-1.2/win64/uvm_dpi\
+UVM_TESTNAME=$testname 
run -all 
quit
