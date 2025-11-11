`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "../rtl/mac_list.vh"
`include "../top/config.sv"

//interfaces
`include "../proc/proc_intf.sv"
`include "../mem/mem_intf.sv"
`include "../tx_phy/tx_phy_intf.sv"
`include "../rx_phy/rx_phy_intf.sv"
`include "../miim/miim_intf.sv"

`include "../proc/proc_tx.sv"
`include "../proc/proc_seq_lib.sv"
`include "../proc/proc_sqr.sv"
`include "../proc/proc_drv.sv"
`include "../proc/proc_agent.sv"

`include "../mem/mem_model.sv"
`include "../mem/mem_agent.sv"

`include "../tx_phy/tx_phy_agent.sv"

`include "../rx_phy/eth_frame.sv"
`include "../rx_phy/rx_seq_lib.sv"
`include "../rx_phy/rx_sqr.sv"
`include "../rx_phy/rx_drv.sv"
`include "../rx_phy/rx_phy_agent.sv"

`include "../miim/miim_agent.sv"

`include "../top/mac_env.sv"
`include "../top/test_lib.sv"
`include "../top/top.sv"
