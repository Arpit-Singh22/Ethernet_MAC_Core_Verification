`uvm_analysis_imp_decl(_mem)
`uvm_analysis_imp_decl(_tx)
`uvm_analysis_imp_decl(_rx)
class mac_sbd extends uvm_scoreboard;
	uvm_analysis_imp_mem#(wb_tx, mac_sbd) imp_mem;
	uvm_analysis_imp_tx#(eth_frame, mac_sbd) imp_tx;
	uvm_analysis_imp_rx#(eth_frame, mac_sbd) imp_rx;

	`uvm_component_utils(mac_sbd)
	`NEW_COMP

	bit [7:0] mem_rd_dataQ[$];
	bit [7:0] wr_byteQ[$];
	bit [7:0] rx_payloadQ[$];
	bit [7:0] rx_phy_data; 
	int FH, FH_2,FH_3;
	bit [7:0] mem_wr_dataQ[$];
	bit [7:0] mem_wr_data;

	function void build_phase(uvm_phase phase);
		imp_mem = new("imp_mem", this);
		imp_tx = new("imp_tx", this);
		imp_rx = new("imp_rx", this);
		FH = $fopen("compare.log","w");
		FH_2 = $fopen("mem_wr_data.log","w");
		FH_3 = $fopen("mem_rd_data.log","w");
	endfunction
	
	function void write_mem(wb_tx t);
		if (t.wr_rd == 0) begin
			$fdisplay(FH_3, "mem_rd_data=%0h", t.data);
			mem_rd_dataQ.push_back(t.data[31:24]);
			mem_rd_dataQ.push_back(t.data[23:16]);
			mem_rd_dataQ.push_back(t.data[15:8]);
			mem_rd_dataQ.push_back(t.data[7:0]);
		end
		else begin
			$fdisplay(FH_2, "mem_wr_data=%0h", t.data);
			mem_wr_dataQ.push_back(t.data[31:24]);
			mem_wr_dataQ.push_back(t.data[23:16]);
			mem_wr_dataQ.push_back(t.data[15:8]);
			mem_wr_dataQ.push_back(t.data[7:0]);
		end
	endfunction

	function void write_tx(eth_frame t);
		bit [7:0] tx_phy_data, mem_read_data;
		foreach (t.payload[i]) begin
			tx_phy_data = t.payload[i];
			mem_read_data = mem_rd_dataQ.pop_front();
			if (tx_phy_data != mem_read_data) begin
				num_mismatches++;
			end
			else num_matches++;
		end
	endfunction

	function void write_rx(eth_frame t);
		rx_payloadQ = t.payload;
	endfunction

	task run();
		forever begin
			wait (mem_wr_dataQ.size() == `FRAME_LENGTH && rx_payloadQ.size() ==`FRAME_LENGTH);
			for (int j=0; j<`FRAME_LENGTH; j++) begin
				rx_phy_data = rx_payloadQ.pop_front();
				mem_wr_data = mem_wr_dataQ.pop_front();
				if (mem_wr_data == rx_phy_data) begin
					num_matches++;
				end
				else begin
					num_mismatches++;
				end
			end
		end
	endtask
endclass
