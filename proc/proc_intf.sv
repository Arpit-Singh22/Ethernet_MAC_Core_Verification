interface proc_intf(input wb_clk_i, wb_rst_i);
	bit [31:0]	wb_dat_i;	//wishbone data input
	bit[31:0]	wb_dat_o;	//wishbone data output
	bit			wb_err_o;	//wishbone error output

	bit [11:2]	wb_adr_i;	//wishbone address bit
	bit [3:0] 	wb_sel_i;	//wishbone byte select bit
	bit  	    wb_we_i;	//write bit
	bit			wb_stb_i;	//strobe bit
	bit 		wb_cyc_i;	//cycle bit
	bit			wb_ack_o;	//acknowledgment output
	bit			int_o;

	clocking drv_cb@(posedge wb_clk_i);
		default input #1 output #0;
		input wb_dat_o, wb_err_o, wb_ack_o, int_o;
		output wb_dat_i, wb_adr_i, wb_sel_i, wb_stb_i, wb_we_i, wb_cyc_i;
	endclocking

	clocking mon_cb@(posedge wb_clk_i);
		default input #0;
		input wb_dat_o, wb_err_o, wb_ack_o, int_o;
		input wb_dat_i, wb_adr_i, wb_sel_i, wb_stb_i, wb_we_i, wb_cyc_i;
	endclocking
endinterface
