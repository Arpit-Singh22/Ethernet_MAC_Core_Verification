class proc_mon extends uvm_monitor;
	virtual proc_intf vif;
	wb_tx tx;
	uvm_analysis_port#(wb_tx) ap_port;
	`uvm_component_utils(proc_mon)
	`NEW_COMP
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(virtual proc_intf)::get(this,"", "vif", vif);
		ap_port = new("ap_port", this);
	endfunction
	
	task run_phase(uvm_phase phase);
		forever begin
			@(vif.mon_cb);
			if (vif.mon_cb.wb_stb_i && vif.mon_cb.wb_cyc_i && vif.mon_cb.wb_ack_o) begin //tx is valid
				tx = wb_tx::type_id::create("tx");
				tx.addr = vif.mon_cb.wb_adr_i;
				tx.data = (vif.mon_cb.wb_we_i == 1'b1) ? vif.mon_cb.wb_dat_i : vif.mon_cb.wb_dat_o;
				tx.wr_rd = vif.mon_cb.wb_we_i;
				tx.sel = vif.mon_cb.wb_sel_i;
				ap_port.write(tx);
			end
		end
	endtask
endclass
