class proc_reg_read_rm_seq extends proc_base_seq;
	uvm_reg regQ[$];
	uvm_reg_data_t dut_data, rm_data;
	uvm_status_e status;

	`uvm_object_utils(proc_reg_read_seq)
	`NEW_OBJ

	task body();
		reg_block.get_registers(regQ);
		//regQ.shuffle();
		foreach(regQ[i]) begin
			rm_data = regQ[i].get_reset();
			regQ[i].read(status, dut_data);
			if(rm_data != dut_data) begin
				`uvm_error("REG_TEST_SQ",$sformatf("get/read: Read error for %s: Expected: %0h Acutal: %0h",regQ[i].get_name(), rm_data, dut_data))
				num_mismatches++;
			end
			else begin
				`uvm_info("REG_TEST_SQ",$sformatf("compare passed for %s",regQ[i].get_name()),UVM_LOW)
				num_matches++;
			end
		end
	endtask
endclass

