class mem_model extends uvm_component;
	virtual mem_intf vif;
	wb_tx tx;
	byte mem[int];
	`uvm_component_utils(mem_model)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(virtual mem_intf)::get(this, "","vif",vif))
			`uvm_fatal("INTFERR", "virtual interface not set")
	endfunction

	function void start_of_simulation_phase(uvm_phase phase);
		for (int i=0; i<2048; i++) begin
			mem[32'h1000_0000 + i] = $random;
		end
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
			@(vif.slave_cb);
			if(vif.slave_cb.m_wb_cyc_o && vif.slave_cb.m_wb_stb_o) begin
				vif.slave_cb.m_wb_ack_i <= 1;
				if(vif.slave_cb.m_wb_we_o) begin
					mem[vif.slave_cb.m_wb_adr_o ]  = vif.slave_cb.m_wb_dat_o[7:0];
					mem[vif.slave_cb.m_wb_adr_o+1] = vif.slave_cb.m_wb_dat_o[15:8];
					mem[vif.slave_cb.m_wb_adr_o+2] = vif.slave_cb.m_wb_dat_o[23:16];
					mem[vif.slave_cb.m_wb_adr_o+3] = vif.slave_cb.m_wb_dat_o[31:24];
				end
				else begin
					vif.slave_cb.m_wb_dat_i[7:0]   <= mem[vif.slave_cb.m_wb_adr_o ];  
					vif.slave_cb.m_wb_dat_i[15:8]  <= mem[vif.slave_cb.m_wb_adr_o+1]; 
					vif.slave_cb.m_wb_dat_i[23:16] <= mem[vif.slave_cb.m_wb_adr_o+2];
					vif.slave_cb.m_wb_dat_i[31:24] <= mem[vif.slave_cb.m_wb_adr_o+3];
				end
				@(vif.slave_cb);
				vif.slave_cb.m_wb_ack_i <= 0;
			end
		end
	endtask
endclass
