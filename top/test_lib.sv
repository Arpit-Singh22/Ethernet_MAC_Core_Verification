class mac_base_test extends uvm_test;
	mac_env env;
	`uvm_component_utils(mac_base_test)
	`NEW_COMP

	bit [7:0] byteQ[$];
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = mac_env::type_id::create("env",this);
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction

	function void report_phase(uvm_phase phase);
		if (num_mismatches > 0 || num_matches != `FRAME_LENGTH) begin
			`uvm_error("STATUS",$psprintf("TEST FAILING, num_mismatche=%0d, num_matches=%0d FRAME_LENGTH=%0d",num_mismatches,num_matches, `FRAME_LENGTH))
		end
		else
			`uvm_info("STATUS", "TEST PASSING", UVM_LOW)
	endfunction
endclass

`MAC_TEST(proc_reg_read_test, proc_reg_read_seq)
`MAC_TEST(proc_reg_write_read_test, proc_reg_write_read_seq)
`MAC_TEST(mac_fd_tx_test, mac_fd_tx_seq)

`MAC_TEST_RX(mac_fd_rx_test, mac_fd_rx_seq)

