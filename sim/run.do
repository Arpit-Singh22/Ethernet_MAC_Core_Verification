vlog list.svh +acc=rn +incdir+C:/uvm-1.2/src \
+define+ETH_WISHBONE_B3
vsim top \
-sv_lib C:/questasim64_2024.1/uvm-1.2/win64/uvm_dpi
#add wave -r sim:top/*
do wave.do
run -all
