class proc_base_seq extends uvm_sequence#(wb_tx);
	uvm_phase phase;
	`uvm_object_utils(proc_base_seq)
	`NEW_OBJ

endclass

class proc_reg_read_seq extends proc_base_seq;
	`uvm_object_utils(proc_reg_read_seq)
	`NEW_OBJ

	task body();
		for (int i=0;i<21;i++) begin
			`uvm_do_with(req, {req.wr_rd==0; req.addr==i;})
		end
	endtask
endclass

class proc_reg_write_read_seq extends proc_base_seq;
	bit [31:0]data_t;
	`uvm_object_utils(proc_reg_read_seq)
	`NEW_OBJ

	task body();
		for (int i=0;i<21;i++) begin
			data_t = $random & reg_maskA[i];
			`uvm_do_with(req, {req.wr_rd==1; req.addr==i; req.data==data_t;})
		end
		for (int i=0;i<21;i++) begin
			`uvm_do_with(req, {req.wr_rd==0; req.addr==i;})
		end
	endtask
endclass

class mac_tx_seq extends proc_base_seq;
	bit [31:0] data_t;
	`uvm_object_utils(mac_tx_seq)
	`NEW_OBJ

	task body();
		//Program the TX DMA descriptors
		//load the Tx pointer
		data_t = 32'h1000_0000;	// addr from DMA should start read
		`uvm_do_with(req, {req.addr == 12'h101; req.data == data_t; req.wr_rd == 1'b1; })
		
		//Load length and control info of the Tx DMA descriptors
		data_t = {`FRAME_LENGTH, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 11'b0};
		`uvm_do_with(req, {req.addr == 12'h100; req.data == data_t; req.wr_rd == 1'b1; })

		//INT_MASK: enable all interrupt generation
		`uvm_do_with(req, {req.addr == `INT_MASK; req.data == 7'h7F; req.wr_rd == 1'b1; })

		//MODER
		data_t 			= $random;
		data_t[31:17]   = 0;
		data_t[13]		= 1'b1;	
		data_t[12]		= 1'b0;
		data_t[10]		= 1'b1;
		data_t[7]		= 1'b0;
		data_t[2]		= 1'b0;
		data_t[1]		= 1'b1;	//Tx En =1
		data_t[0]		= 1'b0;	//Rx En =0
		`uvm_do_with(req, {req.addr == `MODER; req.data == data_t; req.wr_rd == 1'b1; })
	endtask
endclass

class proc_isr_seq extends proc_base_seq;
	`uvm_object_utils(proc_isr_seq)
	`NEW_OBJ
	bit [31:0] data_t;

		//whenever processor agent gets interrupt
		//it should check, what is causing the interrupt (what is the reason)
		//among 7 (7 bits in interrupt source register)
		//take approriate action
		//drop the interrupt and also clear the interrupt in INT_SRC regs
	task body();
		forever begin
		@(posedge top.proc_pif.int_o);
		`uvm_do_with(req, {req.addr == `INT_SRC; req.wr_rd == 1'b0;})
		data_t = req.data;
		#20;
		`uvm_do_with(req, {req.addr == `INT_SRC; req.wr_rd == 1'b1; req.data==data_t;})
		end
	endtask
endclass

class mac_rx_seq extends proc_base_seq;
	bit [31:0] data_t;
	`uvm_object_utils(mac_rx_seq)
	`NEW_OBJ

	task body();
		//Program the RX DMA descriptors
		//load the Rx pointer
		data_t = 32'h2000_0000;	// addr from DMA should start read
		`uvm_do_with(req, {req.addr == 12'h604>>2; req.data == data_t; req.wr_rd == 1'b1; })
		
		//Load length and control info of the RX DMA descriptors
		data_t = {`FRAME_LENGTH, 1'b1, 1'b1, 1'b1, 13'b0};
		`uvm_do_with(req, {req.addr == 12'h600>>2; req.data == data_t; req.wr_rd == 1'b1; })

		//INT_MASK: enable all interrupt generation
		`uvm_do_with(req, {req.addr == `INT_MASK; req.data == 7'h7F; req.wr_rd == 1'b1; })

		//MODER
		data_t 			= $random;
		data_t[31:17]   = 0;
		data_t[13]		= 1'b1;	
		data_t[12]		= 1'b0;
		data_t[10]		= 1'b1;
		data_t[7]		= 1'b0;
		data_t[2]		= 1'b0;
		data_t[1]		= 1'b0;	//Tx En =0
		data_t[0]		= 1'b1;	//Rx En =1
		`uvm_do_with(req, {req.addr == `MODER; req.data == data_t; req.wr_rd == 1'b1; })
	endtask
endclass

class mac_tx_rx_seq extends proc_base_seq;
	bit [31:0] data_t;
	`uvm_object_utils(mac_tx_rx_seq)
	`NEW_OBJ

	task body();
		//Program the RX DMA descriptors
		//load the Tx pointer
		data_t = 32'h1000_0000;	// addr from DMA should start read
		`uvm_do_with(req, {req.addr == 12'h101; req.data == data_t; req.wr_rd == 1'b1; })
		//Load length and control info of the Tx DMA descriptors
		data_t = {`FRAME_LENGTH, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 11'b0};
		`uvm_do_with(req, {req.addr == 12'h100; req.data == data_t; req.wr_rd == 1'b1; })


		//load the Rx pointer
		data_t = 32'h2000_0000;	// addr from DMA should start read
		`uvm_do_with(req, {req.addr == 12'h604>>2; req.data == data_t; req.wr_rd == 1'b1; })
		
		//Load length and control info of the RX DMA descriptors
		data_t = {`FRAME_LENGTH, 1'b1, 1'b1, 1'b1, 13'b0};
		`uvm_do_with(req, {req.addr == 12'h600>>2; req.data == data_t; req.wr_rd == 1'b1; })

		//INT_MASK: enable all interrupt generation
		`uvm_do_with(req, {req.addr == `INT_MASK; req.data == 7'h7F; req.wr_rd == 1'b1; })

		//MODER
		data_t 			= $random;
		data_t[31:17]   = 0;
		data_t[13]		= 1'b1;	
		data_t[12]		= 1'b0;
		data_t[10]		= 1'b1;
		data_t[7]		= 1'b0;
		data_t[2]		= 1'b0;
		data_t[1]		= 1'b1;	//Tx En =1
		data_t[0]		= 1'b1;	//Rx En =1
		`uvm_do_with(req, {req.addr == `MODER; req.data == data_t; req.wr_rd == 1'b1; })
	endtask
endclass
