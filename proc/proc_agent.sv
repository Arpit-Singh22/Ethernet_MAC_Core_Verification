class proc_agent extends uvm_agent;
	proc_drv drv;
	proc_sqr sqr;
	proc_mon mon;
	proc_cov cov;
	`uvm_component_utils(proc_agent)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		drv = proc_drv::type_id::create("drv", this);
		sqr = proc_sqr::type_id::create("sqr", this);
		mon = proc_mon::type_id::create("mon", this);
		cov = proc_cov::type_id::create("cov", this);
	endfunction

	function void connect_phase(uvm_phase phase);
		drv.seq_item_port.connect(sqr.seq_item_export);
		mon.ap_port.connect(cov.analysis_export);
	endfunction
endclass
