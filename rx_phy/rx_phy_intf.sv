interface rx_intf(input mrx_clk_pad_i);
	bit [3:0] mrxd_pad_i;    // Receive nibble (from PHY)
	bit       mrxdv_pad_i;   // Receive data valid (from PHY)
	bit       mrxerr_pad_i;  // Receive data error (from PHY)
	bit       mcoll_pad_i;   // Collision (from PHY)
	bit       mcrs_pad_i;    // Carrier sense (from PHY)

	clocking rx_mon_cb @(posedge mrx_clk_pad_i);
		default input #0 output #0;
		input mrxd_pad_i, mrxdv_pad_i, mrxerr_pad_i, mcoll_pad_i, mcrs_pad_i; 
	endclocking
 endinterface 
