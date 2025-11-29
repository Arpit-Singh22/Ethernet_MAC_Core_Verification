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
`define FD 1
`define HD 0

`ifdef PHY_MODE_100MBPS
	`define PHY_CLK_TP 40
`else
	`define PHY_CLK_TP 400
`endif

typedef bit [3:0] nibble_t;
typedef enum bit {
	FD = 0,
	BD = 1
} access_type_t;
