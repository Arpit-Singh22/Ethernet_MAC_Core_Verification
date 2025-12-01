class rx_drv extends uvm_driver#(eth_frame);
	virtual rx_intf vif;
	bit [31:0] Crc;
	bit [31:0] CrcCal;
	bit [3:0] crc_nibbleQ[$];
	`uvm_component_utils(rx_drv)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(virtual rx_intf)::get(this, "","vif", vif))
			`uvm_error("INTFERR", "inteface handle error in rx_driver")
		Crc <= 32'hffffffff;
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(req);
			drive_tx(req);
			seq_item_port.item_done();
		end
	endtask

	task drive_tx(eth_frame frame);
		nibble_t nibbleQ[$];
		nibble_t nibble_l;
		//pack the fields of frame into nibble queue
		//nibbleQ = {>>nibble_t{frame.preamble, frame.sof, frame.payload, frame.crc}};
		nibbleQ = {>>nibble_t{frame.preamble, frame.sof, frame.payload}};
		//swap nibble
		for(int i=0;i<nibbleQ.size()/2;i++) begin
			nibble_l = nibbleQ[2*i];	//even position storing
			nibbleQ[2*i] = nibbleQ[2*i+1];	//putting at even 
			nibbleQ[2*i+1] = nibble_l;
		end

		//drive nibbleQ to the design on RX INTF
		foreach(nibbleQ[i]) begin
			@(posedge vif.mrx_clk_pad_i);
			vif.mrxd_pad_i = nibbleQ[i];
			vif.mrxdv_pad_i = 1'b1;
			vif.mrxerr_pad_i = 0;
			vif.mcoll_pad_i = 0;
			vif.mcrs_pad_i = 0;
			CrcCal = calc_crc(nibbleQ[i], Crc, 1'b1);
			Crc = CrcCal;
		end
		repeat(8) begin
			crc_nibbleQ.push_back(Crc[31:28]);
			Crc = Crc<<4;
		end
		for (int i=0; i<crc_nibbleQ.size()/2; i++) begin
			nibble_l = crc_nibbleQ[2*i];
			crc_nibbleQ[2*i] = crc_nibbleQ[2*i+1];
			crc_nibbleQ[2*i+1] = nibble_l;
		end
		foreach(crc_nibbleQ[i]) begin
			@(posedge vif.mrx_clk_pad_i);
			vif.mrxd_pad_i = crc_nibbleQ[i];
			vif.mrxdv_pad_i = 1'b1;
			vif.mrxerr_pad_i = 0;
			vif.mcoll_pad_i = 0;
			vif.mcrs_pad_i = 0;
		end

		@(posedge vif.mrx_clk_pad_i);
		vif.mrxd_pad_i = 0;
		vif.mrxdv_pad_i = 0;
		vif.mrxerr_pad_i = 0;
		vif.mcoll_pad_i = 0;
		vif.mcrs_pad_i = 0;

	endtask

	function bit [31:0] calc_crc(bit [3:0] Data, bit [31:0] Crc, bit Enable);
		bit [31:0] CrcNext;
		 CrcNext[0] = Enable & (Data[0] ^ Crc[28]); 
		 CrcNext[1] = Enable & (Data[1] ^ Data[0] ^ Crc[28] ^ Crc[29]); 
		 CrcNext[2] = Enable & (Data[2] ^ Data[1] ^ Data[0] ^ Crc[28] ^ Crc[29] ^ Crc[30]); 
		 CrcNext[3] = Enable & (Data[3] ^ Data[2] ^ Data[1] ^ Crc[29] ^ Crc[30] ^ Crc[31]); 
		 CrcNext[4] = (Enable & (Data[3] ^ Data[2] ^ Data[0] ^ Crc[28] ^ Crc[30] ^ Crc[31])) ^ Crc[0]; 
		 CrcNext[5] = (Enable & (Data[3] ^ Data[1] ^ Data[0] ^ Crc[28] ^ Crc[29] ^ Crc[31])) ^ Crc[1]; 
		 CrcNext[6] = (Enable & (Data[2] ^ Data[1] ^ Crc[29] ^ Crc[30])) ^ Crc[ 2]; 
		 CrcNext[7] = (Enable & (Data[3] ^ Data[2] ^ Data[0] ^ Crc[28] ^ Crc[30] ^ Crc[31])) ^ Crc[3]; 
		 CrcNext[8] = (Enable & (Data[3] ^ Data[1] ^ Data[0] ^ Crc[28] ^ Crc[29] ^ Crc[31])) ^ Crc[4]; 
		 CrcNext[9] = (Enable & (Data[2] ^ Data[1] ^ Crc[29] ^ Crc[30])) ^ Crc[5]; 
		 CrcNext[10] = (Enable & (Data[3] ^ Data[2] ^ Data[0] ^ Crc[28] ^ Crc[30] ^ Crc[31])) ^ Crc[6]; 
		 CrcNext[11] = (Enable & (Data[3] ^ Data[1] ^ Data[0] ^ Crc[28] ^ Crc[29] ^ Crc[31])) ^ Crc[7]; 
		 CrcNext[12] = (Enable & (Data[2] ^ Data[1] ^ Data[0] ^ Crc[28] ^ Crc[29] ^ Crc[30])) ^ Crc[8]; 
		 CrcNext[13] = (Enable & (Data[3] ^ Data[2] ^ Data[1] ^ Crc[29] ^ Crc[30] ^ Crc[31])) ^ Crc[9]; 
		 CrcNext[14] = (Enable & (Data[3] ^ Data[2] ^ Crc[30] ^ Crc[31])) ^ Crc[10]; 
		 CrcNext[15] = (Enable & (Data[3] ^ Crc[31])) ^ Crc[11]; 
		 CrcNext[16] = (Enable & (Data[0] ^ Crc[28])) ^ Crc[12]; 
		 CrcNext[17] = (Enable & (Data[1] ^ Crc[29])) ^ Crc[13]; 
		 CrcNext[18] = (Enable & (Data[2] ^ Crc[30])) ^ Crc[14]; 
		 CrcNext[19] = (Enable & (Data[3] ^ Crc[31])) ^ Crc[15]; 
		 CrcNext[20] = Crc[16]; 
		 CrcNext[21] = Crc[17]; 
		 CrcNext[22] = (Enable & (Data[0] ^ Crc[28])) ^ Crc[18]; 
		 CrcNext[23] = (Enable & (Data[1] ^ Data[0] ^ Crc[29] ^ Crc[28])) ^ Crc[19]; 
		 CrcNext[24] = (Enable & (Data[2] ^ Data[1] ^ Crc[30] ^ Crc[29])) ^ Crc[20]; 
		 CrcNext[25] = (Enable & (Data[3] ^ Data[2] ^ Crc[31] ^ Crc[30])) ^ Crc[21]; 
		 CrcNext[26] = (Enable & (Data[3] ^ Data[0] ^ Crc[31] ^ Crc[28])) ^ Crc[22]; 
		 CrcNext[27] = (Enable & (Data[1] ^ Crc[29])) ^ Crc[23]; 
		 CrcNext[28] = (Enable & (Data[2] ^ Crc[30])) ^ Crc[24]; 
		 CrcNext[29] = (Enable & (Data[3] ^ Crc[31])) ^ Crc[25]; 
		 CrcNext[30] = Crc[26]; 
		 CrcNext[31] = Crc[27];
		 return CrcNext;
	endfunction
endclass
