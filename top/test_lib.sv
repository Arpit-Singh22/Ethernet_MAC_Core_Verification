class mac_base_test extends uvm_test;
	mac_env env;
	`uvm_component_utils(mac_base_test)
	`NEW_COMP

	bit [7:0] byteQ[$];
	int exp_match_count;
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = mac_env::type_id::create("env",this);
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction

	function void report_phase(uvm_phase phase);
	string name = get_type_name();
		if (num_mismatches > 0 || num_matches != exp_match_count) begin
			`uvm_error("STATUS",$psprintf("%s TEST FAILING, num_mismatche=%0d, num_matches=%0d FRAME_LENGTH=%0d",name,num_mismatches,num_matches, `FRAME_LENGTH))
		end
		else
			`uvm_info("STATUS", $psprintf("%s TEST PASSING",name), UVM_LOW)
	endfunction
endclass

class proc_reg_read_test extends mac_base_test; 
	`uvm_component_utils(proc_reg_read_test) 
	`NEW_COMP 	
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		exp_match_count = 0;
	endfunction

	task run_phase(uvm_phase phase); 
		proc_reg_read_seq seq = new("seq"); 
		phase.raise_objection(this);	
		super.run_phase(phase); 
		phase.phase_done.set_drain_time(this,1000);	
		seq.start(env.proc_agent_i.sqr); 
		phase.drop_objection(this);	
	endtask 
endclass

class proc_reg_write_read_test extends mac_base_test; 
	`uvm_component_utils(proc_reg_write_read_test) 
	`NEW_COMP 	
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		exp_match_count = 0;
	endfunction

	task run_phase(uvm_phase phase); 
		proc_reg_write_read_seq seq = new("seq"); 
		phase.raise_objection(this);	
		super.run_phase(phase); 
		phase.phase_done.set_drain_time(this,1000);	
		seq.start(env.proc_agent_i.sqr); 
		phase.drop_objection(this);	
	endtask 
endclass

class mac_tx_test extends mac_base_test; 
	`uvm_component_utils(mac_tx_test) 
	`NEW_COMP 	
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		exp_match_count = `FRAME_LENGTH;
	endfunction

	task run_phase(uvm_phase phase); 
		mac_tx_seq seq = new("seq"); 
		proc_isr_seq isr_seq = new("isr_seq"); 
		seq.fd_hd_mode = `FD;
		phase.raise_objection(this);	
		super.run_phase(phase); 
		phase.phase_done.set_drain_time(this,1000);	
		seq.start(env.proc_agent_i.sqr); 
		fork	
			isr_seq.start(env.proc_agent_i.sqr);	
		join_none	
		@(negedge top.proc_pif.int_o); 
		phase.drop_objection(this);	
	endtask 
endclass

class mac_rx_test extends mac_base_test; 
	`uvm_component_utils(mac_rx_test) 
	`NEW_COMP 	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		exp_match_count = `FRAME_LENGTH;
	endfunction
	
	task run_phase(uvm_phase phase); 
		mac_rx_seq seq = new($sformatf(mac_rx_seq)); 
		proc_isr_seq isr_seq = new("isr_seq"); 
		frame_gen_seq frame_seq = new("frame_seq"); 
		seq.fd_hd_mode = `FD;
		phase.raise_objection(this);	
		phase.phase_done.set_drain_time(this,1000);	
		super.run_phase(phase); 
		seq.start(env.proc_agent_i.sqr); 
		fork	
			isr_seq.start(env.proc_agent_i.sqr);	
		join_none	
		frame_seq.start(env.rx_agent_i.sqr); 
		@(negedge top.proc_pif.int_o); 
		phase.drop_objection(this);	
	endtask 
endclass

class mac_tx_rx_test extends mac_base_test; 
	`uvm_component_utils(mac_tx_rx_test) 
	`NEW_COMP 	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		exp_match_count = `FRAME_LENGTH*2;
	endfunction
	
	task run_phase(uvm_phase phase); 
		mac_tx_rx_seq seq = new($sformatf(mac_tx_rx_seq)); 
		proc_isr_seq isr_seq = new("isr_seq"); 
		frame_gen_seq frame_seq = new("frame_seq"); 
		seq.fd_hd_mode = `FD;
		phase.raise_objection(this);	
		phase.phase_done.set_drain_time(this,1000);	
		super.run_phase(phase); 
		seq.start(env.proc_agent_i.sqr); 
		fork	
			isr_seq.start(env.proc_agent_i.sqr);	
		join_none	
		frame_seq.start(env.rx_agent_i.sqr); 
		@(negedge top.proc_pif.int_o); 
		@(negedge top.proc_pif.int_o); 
		phase.drop_objection(this);	
	endtask 
endclass

class mac_hd_tx_test extends mac_base_test; 
	`uvm_component_utils(mac_hd_tx_test) 
	`NEW_COMP 	
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		exp_match_count = `FRAME_LENGTH;
	endfunction

	task run_phase(uvm_phase phase); 
		mac_tx_seq seq = new("seq"); 
		proc_isr_seq isr_seq = new("isr_seq"); 
		seq.fd_hd_mode = `HD;
		phase.raise_objection(this);	
		super.run_phase(phase); 
		phase.phase_done.set_drain_time(this,1000);	
		seq.start(env.proc_agent_i.sqr); 
		fork	
			isr_seq.start(env.proc_agent_i.sqr);	
		join_none	
		@(negedge top.proc_pif.int_o); 
		phase.drop_objection(this);	
	endtask 
endclass

class mac_hd_rx_test extends mac_base_test; 
	`uvm_component_utils(mac_hd_rx_test) 
	`NEW_COMP 	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		exp_match_count = `FRAME_LENGTH;
	endfunction
	
	task run_phase(uvm_phase phase); 
		mac_rx_seq seq = new($sformatf(mac_rx_seq)); 
		proc_isr_seq isr_seq = new("isr_seq"); 
		frame_gen_seq frame_seq = new("frame_seq"); 
		seq.fd_hd_mode = `HD;
		phase.raise_objection(this);	
		phase.phase_done.set_drain_time(this,1000);	
		super.run_phase(phase); 
		seq.start(env.proc_agent_i.sqr); 
		fork	
			isr_seq.start(env.proc_agent_i.sqr);	
		join_none	
		frame_seq.start(env.rx_agent_i.sqr); 
		@(negedge top.proc_pif.int_o); 
		phase.drop_objection(this);	
	endtask 
endclass

class mac_hd_tx_rx_test extends mac_base_test; 
	`uvm_component_utils(mac_hd_tx_rx_test) 
	`NEW_COMP 	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		exp_match_count = `FRAME_LENGTH*2;
	endfunction
	
	task run_phase(uvm_phase phase); 
		mac_tx_rx_seq seq = new($sformatf(mac_tx_rx_seq)); 
		proc_isr_seq isr_seq = new("isr_seq"); 
		frame_gen_seq frame_seq = new("frame_seq"); 
		seq.fd_hd_mode = `HD;
		phase.raise_objection(this);	
		phase.phase_done.set_drain_time(this,1000);	
		super.run_phase(phase); 
		seq.start(env.proc_agent_i.sqr); 
		fork	
			isr_seq.start(env.proc_agent_i.sqr);	
		join_none	
		frame_seq.start(env.rx_agent_i.sqr); 
		@(negedge top.proc_pif.int_o); 
		@(negedge top.proc_pif.int_o); 
		phase.drop_objection(this);	
	endtask 
endclass

class proc_reg_read_rm_test extends mac_base_test; 
	`uvm_component_utils(proc_reg_read_rm_test) 
	`NEW_COMP 	
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		exp_match_count = 21;
	endfunction

	task run_phase(uvm_phase phase); 
		proc_reg_read_rm_seq seq = new("seq"); 
		phase.raise_objection(this);	
		super.run_phase(phase); 
		phase.phase_done.set_drain_time(this,1000);	
		seq.start(env.proc_agent_i.sqr); 
		phase.drop_objection(this);	
	endtask 
endclass

