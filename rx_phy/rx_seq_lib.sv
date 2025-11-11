class rx_base_seq extends uvm_sequence#(eth_frame);
	uvm_phase phase;
	`uvm_object_utils(rx_base_seq)
	`NEW_OBJ
endclass

class frame_gen_seq extends rx_base_seq;
	`uvm_object_utils(frame_gen_seq)
	`NEW_OBJ

	task body();
		`uvm_do_with(req, {req.length == `FRAME_LENGTH;})
	endtask
endclass

