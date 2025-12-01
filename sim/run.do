vlog list.svh +acc +incdir+C:/uvm-1.2/src \
+define+ETH_WISHBONE_B3 +define+PHY_MODE_100MBPS
vsim top \
-sv_lib C:/questasim64_2024.1/uvm-1.2/win64/uvm_dpi
add wave -r sim:top/*
#do wave.do
run -all
