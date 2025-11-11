interface rx_intf(input mrx_clk_pad_i);
	bit [3:0] mrxd_pad_i;    // Receive nibble (from PHY)
	bit       mrxdv_pad_i;   // Receive data valid (from PHY)
	bit       mrxerr_pad_i;  // Receive data error (from PHY)
	bit       mcoll_pad_i;   // Collision (from PHY)
	bit       mcrs_pad_i;    // Carrier sense (from PHY)
endinterface
