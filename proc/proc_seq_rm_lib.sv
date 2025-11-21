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

class proc_reg_write_read_rm_seq extends proc_base_seq;
	uvm_reg regQ[$];
	uvm_reg_data_t dut_data, rm_data, miicommand_wr_data;
	uvm_status_e status;
	string reg_name;
	rand bit [31:0] data_t;
	`uvm_object_utils(proc_reg_write_read_rm_seq)
	`NEW_OBJ

	task body();
		reg_block.get_registers(regQ);
		regQ.shuffle();
		foreach(regQ[i]) begin
			assert(this.randomize());
			reg_name = regQ[i].get_name();
			if(reg_name == "miicommand") begin
				miicommand_wr_data = data_t;
			end
			if (reg_name == "txbdnum") begin
				data_t = $urandom_range(0, 'h80);
			end
			regQ[i].write(status, data_t);
		end

		regQ.shuffle();
		foreach(regQ[i]) begin
			if (miicommand_wr_data[0] == 1) begin
				rm_data = reg_block.miistatus.get();
				rm_data[2] = 1;
				rm_data[1] = 1;
				reg_block.miistatus.predict(rm_data);
			end

			rm_data = regQ[i].get();
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

