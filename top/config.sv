`define NEW_COMP \
	function new(string name="", uvm_component parent); \
		super.new(name, parent); \
	endfunction

`define NEW_OBJ \
	function new(string name=""); \
		super.new(name); \
	endfunction

bit [31:0] reg_maskA[20:0];

`define MODER    12'h0
`define INT_SRC  12'h1
`define INT_MASK 12'h2
`define FRAME_LENGTH 16'h100

typedef bit [3:0] nibble_t;

//isr => interrupt service routine

`define MAC_TEST(TESTNAME, SEQ) \
	class TESTNAME extends mac_base_test; \
		`uvm_component_utils(TESTNAME) \
		`NEW_COMP 	\
							\
		task run_phase(uvm_phase phase); \
			SEQ seq = new($sformatf(SEQ)); \
			proc_isr_seq isr_seq = new("isr_seq"); \
			phase.raise_objection(this);	\
			phase.phase_done.set_drain_time(this,1000);	\
			super.run_phase(phase); \
			fork	\
				isr_seq.start(env.proc_agent_i.sqr);	\
			join_none	\
			seq.start(env.proc_agent_i.sqr); \
			@(negedge top.proc_pif.int_o); \
			phase.drop_objection(this);	\
		endtask \
	endclass

`define MAC_TEST_RX(TESTNAME, SEQ) \
	class TESTNAME extends mac_base_test; \
		`uvm_component_utils(TESTNAME) \
		`NEW_COMP 	\
							\
		task run_phase(uvm_phase phase); \
			SEQ seq = new($sformatf(SEQ)); \
			proc_isr_seq isr_seq = new("isr_seq"); \
			frame_gen_seq frame_seq = new("frame_seq"); \
			phase.raise_objection(this);	\
			phase.phase_done.set_drain_time(this,1000);	\
			super.run_phase(phase); \
			fork	\
				isr_seq.start(env.proc_agent_i.sqr);	\
			join_none	\
			seq.start(env.proc_agent_i.sqr); \
			frame_seq.start(env.rx_agent_i.sqr); \
			@(negedge top.proc_pif.int_o); \
			phase.drop_objection(this);	\
		endtask \
	endclass

