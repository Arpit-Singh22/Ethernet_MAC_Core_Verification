class tx_agent extends uvm_agent;
	tx_mon mon;
	`uvm_component_utils(tx_agent)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		mon = tx_mon::type_id::create("mon", this);
	endfunction
endclass
