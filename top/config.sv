`define NEW_COMP \
	function new(string name="", uvm_component parent); \
		super.new(name, parent); \
	endfunction

`define NEW_OBJ \
	function new(string name=""); \
		super.new(name); \
	endfunction

bit [31:0] reg_maskA[20:0];
int num_matches;
int num_mismatches;

`define MODER    12'h0
`define INT_SRC  12'h1
`define INT_MASK 12'h2
`define FRAME_LENGTH 16'h100

typedef bit [3:0] nibble_t;
