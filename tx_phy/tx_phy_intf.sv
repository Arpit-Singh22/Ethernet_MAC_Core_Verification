interface tx_intf(input mtx_clk_pad_i);
	bit [3:0]  mtxd_pad_o;    // Transmit nibble (to PHY)
	bit		   mtxen_pad_o;   // Transmit enable (to PHY)
	bit        mtxerr_pad_o;  // Transmit error (to PHY)
endinterface
