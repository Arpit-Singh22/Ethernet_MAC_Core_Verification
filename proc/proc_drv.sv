class proc_drv extends uvm_driver#(wb_tx);
	virtual proc_intf vif;
	`uvm_component_utils(proc_drv)
	`NEW_COMP

	function void build_phase(uvm_phase phase);
		uvm_config_db#(virtual proc_intf)::get(this, "","vif", vif);
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(req);
			drive_tx(req);
			seq_item_port.item_done();
		end
	endtask

	task drive_tx(wb_tx tx);
		@(vif.drv_cb);
		vif.drv_cb.wb_adr_i <= tx.addr;
		if (tx.wr_rd == 1) vif.drv_cb.wb_dat_i <= tx.data;
		vif.drv_cb.wb_we_i  <= tx.wr_rd;
		vif.drv_cb.wb_sel_i <= 4'hF;
		vif.drv_cb.wb_stb_i <= 1'b1;
		vif.drv_cb.wb_cyc_i <= 1'b1;

		wait (vif.drv_cb.wb_ack_o == 1'b1);

		@(vif.drv_cb);
		vif.drv_cb.wb_adr_i <= 0; 
		if (tx.wr_rd == 1) vif.drv_cb.wb_dat_i <= 0;
		else tx.data = vif.drv_cb.wb_dat_o;
		vif.drv_cb.wb_we_i  <= 0;
		vif.drv_cb.wb_sel_i <= 0; 
		vif.drv_cb.wb_stb_i <= 0; 
		vif.drv_cb.wb_cyc_i <= 0; 
	endtask
endclass
