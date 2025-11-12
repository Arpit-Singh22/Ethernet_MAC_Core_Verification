`uvm_analysis_imp_decl(_mem)
`uvm_analysis_imp_decl(_tx)
`uvm_analysis_imp_decl(_rx)
class mac_sbd extends uvm_scoreboard;
	uvm_analysis_imp_mem#(wb_tx, mac_sbd) imp_mem;
	uvm_analysis_imp_tx#(eth_frame, mac_sbd) imp_tx;
	uvm_analysis_imp_rx#(eth_frame, mac_sbd) imp_rx;

	`uvm_component_utils(mac_sbd)
	`NEW_COMP

	bit [7:0] rd_byteQ[$];
	bit [7:0] wr_byteQ[$];
	bit [7:0] rx_payloadQ[$];
	bit [7:0] rx_phy_data; 

	function void build_phase(uvm_phase phase);
		imp_mem = new("imp_mem", this);
		imp_tx = new("imp_tx", this);
		imp_rx = new("imp_rx", this);
	endfunction
	
	function void write_mem(wb_tx t);
		if (t.wr_rd == 0) begin
			rd_byteQ.push_back(t.data[31:24]);
			rd_byteQ.push_back(t.data[23:16]);
			rd_byteQ.push_back(t.data[15:8]);
			rd_byteQ.push_back(t.data[7:0]);
		end
		else begin
			for (int i=0; i<4; i++) begin
				rx_phy_data = rx_payloadQ.pop_front();
				if (t.data[31:24] == rx_phy_data) begin
					num_matches++;
				end
				else num_mismatches++;
			end
			t.data <<= 8;
		end
	endfunction

	function void write_tx(eth_frame t);
		bit [7:0] tx_phy_data, mem_read_data;
		foreach (t.payload[i]) begin
			tx_phy_data = t.payload[i];
			mem_read_data = rd_byteQ.pop_front();
			if (tx_phy_data != mem_read_data) begin
				num_mismatches++;
			end
			else num_matches++;
		end
	endfunction

	function void write_rx(eth_frame t);
		rx_payloadQ = t.payload;
	endfunction
endclass
