class mac_env extends uvm_env;
	proc_agent proc_agent_i;
	mem_agent mem_agent_i;
	tx_agent tx_agent_i;
	rx_agent rx_agent_i;
	miim_agent	miim_agent_i;
	//mac_sbd		mac_sbd_i;

	`uvm_component_utils(mac_env)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		proc_agent_i = proc_agent::type_id::create("proc_agent_i", this);
		tx_agent_i = tx_agent::type_id::create("tx_agent_i", this);
		rx_agent_i = rx_agent::type_id::create("rx_agent_i", this);
		miim_agent_i = miim_agent::type_id::create("miim_agent_i", this);
		mem_agent_i = mem_agent::type_id::create("mem_agent_i", this);
		//sbd_agent sbd_agent_i = sbd_agent::type_id::create("sbd_agent_i", this);
	endfunction
endclass
