class rx_drv extends uvm_driver#(eth_frame);
	virtual rx_intf vif;
	`uvm_component_utils(rx_drv)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		uvm_config_db#(virtual rx_intf)::get(this, "","vif", vif);
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
		nibbleQ = {>>nibble_t{frame.preamble, frame.sof, frame.payload, frame.crc}};
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
		end
		@(posedge vif.mrx_clk_pad_i);
			vif.mrxd_pad_i = 0;
			vif.mrxdv_pad_i = 0;
	endtask
endclass
