class tx_mon extends uvm_monitor;
	virtual tx_intf vif;
	uvm_analysis_port#(eth_frame) ap_port;
	`uvm_component_utils(tx_mon)
	`NEW_COMP
	eth_frame frame;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ap_port = new("ap_port", this);
		if(!uvm_config_db#(virtual tx_intf)::get(this, "", "vif", vif))
			`uvm_error("INTFERR", "interface handle error in tx_mon")
	endfunction
	nibble_t nibbleQ[$]; 
	bit [7:0] byteQ[$];
	bit [7:0] byteVar;
	bit start_collecting_frame_flag = 0;

	task run_phase(uvm_phase phase);
		forever begin
			@(posedge vif.mtx_clk_pad_i);
			#1;
			if (vif.mtxen_pad_o == 1) begin
				start_collecting_frame_flag = 1;
				nibbleQ.push_back(vif.mtxd_pad_o);
			end
			else begin
			//once all nibble are collected then do unpack(nibbleQ -> eth_frame)
			//convert nibbleQ to byteQ
				if(start_collecting_frame_flag) begin
					for(int i=0; i<nibbleQ.size()/2; i++) begin
						byteVar = {nibbleQ[2*i+1], nibbleQ[2*i]};
						byteQ.push_back(byteVar);
					end
					frame = new("frame");
					{>>{frame.preamble, frame.sof, frame.payload, frame.crc}} = byteQ;
					$display("printing frame from tx mon");
					frame.print();
					ap_port.write(frame);
					start_collecting_frame_flag = 0;
				end
			end
		end
	endtask
endclass
