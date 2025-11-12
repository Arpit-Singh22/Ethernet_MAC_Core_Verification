class mem_agent extends uvm_agent;
	mem_model mem_model_i;
	mem_mon mon;
	`uvm_component_utils(mem_agent)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		mem_model_i = mem_model::type_id::create("mem_model_i", this);
		mon = mem_mon::type_id::create("mon", this);
	endfunction
endclass
