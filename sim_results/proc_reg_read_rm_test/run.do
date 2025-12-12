
vlog C:/Users/arpit/OneDrive/Desktop/Project/ETHERNET_MAC_VERIFICATION/sim/list.svh +incdir+C:/uvm-1.2/src +define+ETH_WISHBONE_B3 +define+PHY_MODE_100MBPS
vopt work.top +cover=fcbest -o proc_reg_read_rm_test -assertdebug

vsim -c -coverage -assertdebug proc_reg_read_rm_test \
-sv_lib C:/questasim64_2024.1/uvm-1.2/win64/uvm_dpi \
+UVM_TESTNAME=proc_reg_read_rm_test
coverage save -onexit PROC_REG_READ_RM_TEST.ucdb
run -all
quit
