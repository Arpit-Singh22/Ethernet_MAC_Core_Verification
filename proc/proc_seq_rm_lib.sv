class proc_reg_read_rm_seq extends proc_base_seq;

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

			if (reg_name == "collconf") data_t = data_t & 32'h000F_003F;
			if (reg_name == "miiaddress") data_t = data_t & {19'h0, 5'h1F, 3'h0, 5'h1F};
			if (access_type == FD) regQ[i].write(status, data_t);
			else regQ[i].poke(status, data_t);	//back door write
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
			if (access_type == FD) regQ[i].read(status, dut_data);
			else regQ[i].peek(status, dut_data);	//back door read
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

