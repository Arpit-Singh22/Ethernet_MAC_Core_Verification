module top;
	bit wb_clk,wb_rst;
	bit phy_clk;
	//proc intf
	proc_intf 	proc_pif	(wb_clk, wb_rst);
	mem_intf 	mem_pif		(wb_clk, wb_rst);
	tx_intf 	tx_pif	(phy_clk);
	rx_intf 	rx_pif	(phy_clk);
	miim_intf	miim_pif	();

	//dut
  	ethmac dut(
	.wb_clk_i(proc_pif.wb_clk_i), 
  	.wb_rst_i(proc_pif.wb_rst_i), 
  	.wb_dat_i(proc_pif.wb_dat_i), 
  	.wb_dat_o(proc_pif.wb_dat_o), 

  	.wb_adr_i(proc_pif.wb_adr_i), 
	.wb_sel_i(proc_pif.wb_sel_i), 
	.wb_we_i(proc_pif.wb_we_i), 
	.wb_cyc_i(proc_pif.wb_cyc_i), 
	.wb_stb_i(proc_pif.wb_stb_i), 
	.wb_ack_o(proc_pif.wb_ack_o), 
	.wb_err_o(proc_pif.wb_err_o), 

  	//MEMORY INTERFACE
  	.m_wb_adr_o(mem_pif.m_wb_adr_o), 
	.m_wb_sel_o(mem_pif.m_wb_sel_o), 
	.m_wb_we_o(mem_pif.m_wb_we_o), 
  	.m_wb_dat_o(mem_pif.m_wb_dat_o), 
	.m_wb_dat_i(mem_pif.m_wb_dat_i), 
	.m_wb_cyc_o(mem_pif.m_wb_cyc_o), 
  	.m_wb_stb_o(mem_pif.m_wb_stb_o), 
	.m_wb_ack_i(mem_pif.m_wb_ack_i), 
	.m_wb_err_i(mem_pif.m_wb_err_i), 
	.m_wb_cti_o(mem_pif.m_wb_cti_o), 
  	.m_wb_bte_o(mem_pif.m_wb_bte_o), 
		
  	//PHY_TX
  	.mtx_clk_pad_i(tx_pif.mtx_clk_pad_i), 
	.mtxd_pad_o(tx_pif.mtxd_pad_o), 
	.mtxen_pad_o(tx_pif.mtxen_pad_o), 
	.mtxerr_pad_o(tx_pif.mtxerr_pad_o),

  	//PHY_RX
  	.mrx_clk_pad_i(rx_pif.mrx_clk_pad_i), 
	.mrxd_pad_i(rx_pif.mrxd_pad_i), 
	.mrxdv_pad_i(rx_pif.mrxdv_pad_i), 
	.mrxerr_pad_i(rx_pif.mrxerr_pad_i), 
	.mcoll_pad_i(rx_pif.mcoll_pad_i), 
	.mcrs_pad_i(rx_pif.mcrs_pad_i),
  	
  	// MIIM
  	.mdc_pad_o(miim_pif.mdc_pad_o), 
	.md_pad_i(miim_pif.md_pad_i), 
	.md_pad_o(miim_pif.md_pad_o), 
	.md_padoe_o(miim_pif.md_padoe_o),
  	.int_o(proc_pif.int_o)
	);


	initial begin
		uvm_config_db#(virtual proc_intf)::set(null,"*","vif",proc_pif);
		uvm_config_db#(virtual tx_intf)::set(null,"*","vif",tx_pif);
		uvm_config_db#(virtual rx_intf)::set(null,"*","vif",rx_pif);
		uvm_config_db#(virtual mem_intf)::set(null,"*","vif",mem_pif);
		uvm_config_db#(virtual miim_intf)::set(null,"*","vif",miim_pif);
	end
	//wb_clk => 100Mhz -> 10ns
	always #5 wb_clk = ~wb_clk;
	always #(`PHY_CLK_TP/2.0) phy_clk = ~phy_clk;

	initial begin
		//set reg_maskA
		reg_maskA[0] = {15'h0, 17'h1FFFF};
		reg_maskA[1] = 32'h0;
		reg_maskA[2] = {25'h0, 7'h7F};
		reg_maskA[3] = {25'h0, 7'h7F};
		reg_maskA[4] = {25'h0, 7'h7F};
		reg_maskA[5] = {25'h0, 7'h7F};
		reg_maskA[6] = 32'hFFFF_FFFF;
		reg_maskA[7] = {12'h0, 4'hF, 10'h0, 6'h3F};
		reg_maskA[8] = {24'h0, 8'hFF};
		reg_maskA[9] = {29'h0, 3'h7};
		reg_maskA[10] = {23'h0, 9'h1FF};
		reg_maskA[11] = {29'h0, 3'h7};
		reg_maskA[12] = {19'h0, 5'h1F, 3'h0, 5'h1F};
		reg_maskA[13] = {16'h0, 16'hFFFF};
		reg_maskA[14] = 32'h0;
		reg_maskA[15] = 32'h0;
		reg_maskA[16] = 32'hFFFF_FFFF;
		reg_maskA[17] = 16'hFFFF;
		reg_maskA[18] = 32'hFFFF_FFFF;
		reg_maskA[19] = 32'hFFFF_FFFF;
		reg_maskA[20] = {15'h0, 17'h1FFFF};
		wb_clk = 0;
		wb_rst = 1;
		phy_clk = 0;
		repeat(4) @(posedge wb_clk) wb_rst = 0;
	end
	initial begin
		//run_test("mac_base_test");
		//run_test("proc_reg_read_test");
		//run_test("proc_reg_write_read_test");
		//run_test("mac_tx_test");
		run_test("mac_rx_test");
		//run_test("mac_tx_rx_test");
		//run_test("mac_hd_tx_test");
		//run_test("mac_hd_rx_test");
		//run_test("mac_hd_tx_rx_test");
		//run_test("proc_reg_read_rm_test");
		//run_test("proc_reg_write_read_rm_test");
		//run_test("proc_reg_write_read_rm_bd_test");
	end
endmodule
