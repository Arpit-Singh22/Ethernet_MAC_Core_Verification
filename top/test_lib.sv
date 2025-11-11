class mac_base_test extends uvm_test;
	mac_env env;
	`uvm_component_utils(mac_base_test)
	`NEW_COMP
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = mac_env::type_id::create("env",this);
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction
endclass

`MAC_TEST(proc_reg_read_test, proc_reg_read_seq)
`MAC_TEST(proc_reg_write_read_test, proc_reg_write_read_seq)
`MAC_TEST(mac_fd_tx_test, mac_fd_tx_seq)

`MAC_TEST_RX(mac_fd_rx_test, mac_fd_rx_seq)

