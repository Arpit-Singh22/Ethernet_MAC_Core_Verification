class proc_agent extends uvm_agent;
	proc_drv drv;
	proc_sqr sqr;
	`uvm_component_utils(proc_agent)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		drv = proc_drv::type_id::create("drv", this);
		sqr = proc_sqr::type_id::create("sqr", this);
	endfunction

	function void connect_phase(uvm_phase phase);
		drv.seq_item_port.connect(sqr.seq_item_export);
	endfunction
endclass
