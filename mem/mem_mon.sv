class mem_mon extends uvm_monitor;
	virtual mem_intf vif;
	uvm_analysis_port#(wb_tx) ap_port;
	`uvm_component_utils(mem_mon)
	`NEW_COMP
	wb_tx tx;

	function void build_phase(uvm_phase phase);
		ap_port = new("ap_port", this);
		if(!uvm_config_db#(virtual mem_intf)::get(this, "", "vif", vif))
			`uvm_error("INTFERR", "interface handle error in mem_mon")
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
			@(posedge vif.wb_clk_i);
			if(vif.m_wb_cyc_o && vif.m_wb_stb_o && vif.m_wb_ack_i) begin
				tx = new("tx");
				tx.addr = vif.m_wb_adr_o;
				tx.data = vif.m_wb_we_o ? vif.m_wb_dat_o : vif.m_wb_dat_i;
				tx.wr_rd = vif.m_wb_we_o;
				tx.sel = vif.m_wb_sel_o;
				$display("Printing mem mon fields");
				tx.print();
				ap_port.write(tx);
			end
		end
	endtask
endclass
