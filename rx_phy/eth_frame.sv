class eth_frame extends uvm_sequence_item;
	rand bit [55:0] preamble;
	rand bit [7:0] sof;
	rand bit [15:0] length;	// we will not drive it, only for constraining data size
	rand bit [7:0] payload[$];
		 bit [31:0] crc;

	`uvm_object_utils_begin(eth_frame)
		`uvm_field_int(preamble, | UVM_ALL_ON)
		`uvm_field_int(length, | UVM_ALL_ON)
		`uvm_field_int(sof, | UVM_ALL_ON)
		`uvm_field_int(length, | UVM_ALL_ON)
		`uvm_field_queue_int(payload, | UVM_ALL_ON)
		`uvm_field_int(crc, | UVM_ALL_ON)
	`uvm_object_utils_end
	`NEW_OBJ

	constraint c_payload{
		payload.size() == length;
		soft preamble == 56'h55_5555_5555_5555;
		soft sof == 8'hd5;
	}
endclass
