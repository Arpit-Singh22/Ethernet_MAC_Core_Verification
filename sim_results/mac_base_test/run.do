
vlog C:/Users/arpit/OneDrive/Desktop/Project/ETHERNET_MAC_VERIFICATION/sim/list.svh +incdir+C:/uvm-1.2/src +define+ETH_WISHBONE_B3 +define+PHY_MODE_100MBPS
vopt work.top +cover=fcbest -o mac_base_test -assertdebug

vsim -c -coverage -assertdebug mac_base_test \
-sv_lib C:/questasim64_2024.1/uvm-1.2/win64/uvm_dpi \
+UVM_TESTNAME=mac_base_test
coverage save -onexit MAC_BASE_TEST.ucdb
run -all
quit
