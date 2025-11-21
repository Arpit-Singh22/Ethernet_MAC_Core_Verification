class mac_env extends uvm_env;
	proc_agent proc_agent_i;
	mem_agent mem_agent_i;
	tx_agent tx_agent_i;
	rx_agent rx_agent_i;
	miim_agent	miim_agent_i;
	mac_sbd		mac_sbd_i;
	mac_reg_block	reg_block;
	wb_adapter		adapter;

	`uvm_component_utils(mac_env)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		proc_agent_i = proc_agent::type_id::create("proc_agent_i", this);
		tx_agent_i = tx_agent::type_id::create("tx_agent_i", this);
		rx_agent_i = rx_agent::type_id::create("rx_agent_i", this);
		miim_agent_i = miim_agent::type_id::create("miim_agent_i", this);
		mem_agent_i = mem_agent::type_id::create("mem_agent_i", this);
		mac_sbd_i =  mac_sbd::type_id::create("mac_sbd_i", this);
		reg_block =  mac_reg_block::type_id::create("reg_block");
		adapter	  =  wb_adapter::type_id::create("adapter");
		reg_block.build();	//this builds the register block
		//putting register model instance into resource DB
		uvm_resource_db#(mac_reg_block)::set("GLOBAL", "MAC_RM", reg_block, this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		mem_agent_i.mon.ap_port.connect(mac_sbd_i.imp_mem);
		tx_agent_i.mon.ap_port.connect(mac_sbd_i.imp_tx);
		rx_agent_i.mon.ap_port.connect(mac_sbd_i.imp_rx);
		reg_block.wb_map.set_sequencer(proc_agent_i.sqr, adapter);
	endfunction
endclass
