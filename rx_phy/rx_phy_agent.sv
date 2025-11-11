class rx_agent extends uvm_agent;
	rx_drv drv;
	rx_sqr sqr;
	`uvm_component_utils(rx_agent)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		drv = rx_drv::type_id::create("drv", this);
		sqr = rx_sqr::type_id::create("sqr", this);
	endfunction

	function void connect_phase(uvm_phase phase);
		drv.seq_item_port.connect(sqr.seq_item_export);
	endfunction
endclass
