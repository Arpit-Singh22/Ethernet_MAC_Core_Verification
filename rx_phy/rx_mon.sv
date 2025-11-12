class rx_mon extends uvm_monitor;
	virtual rx_intf vif;
	uvm_analysis_port#(eth_frame) ap_port;
	`uvm_component_utils(rx_mon)
	`NEW_COMP
	eth_frame frame;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ap_port = new("ap_port", this);
		if(!uvm_config_db#(virtual rx_intf)::get(this, "", "vif", vif))
			`uvm_error("INTFERR", "inteface handle error in rx_mon")
	endfunction
	bit [7:0] byteQ[$]; 
	bit [7:0] byteVar;
	bit [3:0] nibbleQ[$];

	task run_phase(uvm_phase phase);
		bit start_collecting_frame_flag = 0;
		forever begin
			@(posedge vif.mrx_clk_pad_i);
			if (vif.mrxdv_pad_i == 1) begin
				start_collecting_frame_flag = 1;
				nibbleQ.push_back(vif.mrxd_pad_i);
			end
			else begin
				if(start_collecting_frame_flag) begin
					for(int i=0; i<nibbleQ.size()/2; i++) begin
						byteVar = {nibbleQ[2*i+1], nibbleQ[2*i]};
						byteQ.push_back(byteVar);
					end
					frame = new("frame");
					{>>{frame.preamble, frame.sof, frame.payload, frame.crc}} = byteQ;
					$display("printing frame from rx mon");
					frame.print();
					ap_port.write(frame);
					start_collecting_frame_flag = 0;
				end
			end
		end
	endtask
endclass

