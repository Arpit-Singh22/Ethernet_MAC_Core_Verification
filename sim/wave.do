onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/proc_pif/wb_clk_i
add wave -noupdate /top/proc_pif/wb_rst_i
add wave -noupdate -expand -group PROC_INTF /top/proc_pif/wb_adr_i
add wave -noupdate -expand -group PROC_INTF /top/proc_pif/wb_dat_i
add wave -noupdate -expand -group PROC_INTF /top/proc_pif/wb_dat_o
add wave -noupdate -expand -group PROC_INTF /top/proc_pif/wb_err_o
add wave -noupdate -expand -group PROC_INTF /top/proc_pif/wb_sel_i
add wave -noupdate -expand -group PROC_INTF /top/proc_pif/wb_we_i
add wave -noupdate -expand -group PROC_INTF /top/proc_pif/wb_stb_i
add wave -noupdate -expand -group PROC_INTF /top/proc_pif/wb_cyc_i
add wave -noupdate -expand -group PROC_INTF /top/proc_pif/wb_ack_o
add wave -noupdate -expand -group PROC_INTF /top/proc_pif/int_o
add wave -noupdate -group MEM_INTF /top/mem_pif/m_wb_adr_o
add wave -noupdate -group MEM_INTF /top/mem_pif/m_wb_sel_o
add wave -noupdate -group MEM_INTF /top/mem_pif/m_wb_we_o
add wave -noupdate -group MEM_INTF /top/mem_pif/m_wb_dat_i
add wave -noupdate -group MEM_INTF /top/mem_pif/m_wb_dat_o
add wave -noupdate -group MEM_INTF /top/mem_pif/m_wb_cyc_o
add wave -noupdate -group MEM_INTF /top/mem_pif/m_wb_stb_o
add wave -noupdate -group MEM_INTF /top/mem_pif/m_wb_ack_i
add wave -noupdate -group MEM_INTF /top/mem_pif/m_wb_err_i
add wave -noupdate -group MEM_INTF /top/mem_pif/m_wb_cti_o
add wave -noupdate -group MEM_INTF /top/mem_pif/m_wb_bte_o
add wave -noupdate -group TX_PHY_INTF /top/tx_pif/mtx_clk_pad_i
add wave -noupdate -group TX_PHY_INTF /top/tx_pif/mtxd_pad_o
add wave -noupdate -group TX_PHY_INTF /top/tx_pif/mtxen_pad_o
add wave -noupdate -group TX_PHY_INTF /top/tx_pif/mtxerr_pad_o
add wave -noupdate -expand -group RX_PHY_INTF /top/rx_pif/mrx_clk_pad_i
add wave -noupdate -expand -group RX_PHY_INTF /top/rx_pif/mrxd_pad_i
add wave -noupdate -expand -group RX_PHY_INTF /top/rx_pif/mrxdv_pad_i
add wave -noupdate -expand -group RX_PHY_INTF /top/rx_pif/mrxerr_pad_i
add wave -noupdate -expand -group RX_PHY_INTF /top/rx_pif/mcoll_pad_i
add wave -noupdate -expand -group RX_PHY_INTF /top/rx_pif/mcrs_pad_i
add wave -noupdate -group MIIM_INTF /top/miim_pif/md_pad_i
add wave -noupdate -group MIIM_INTF /top/miim_pif/mdc_pad_o
add wave -noupdate -group MIIM_INTF /top/miim_pif/md_pad_o
add wave -noupdate -group MIIM_INTF /top/miim_pif/md_padoe_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/wb_dat_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/wb_adr_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/wb_sel_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/wb_stb_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/wb_we_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/wb_cyc_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/wb_dat_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/wb_err_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/wb_ack_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/int_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/drv_cb_event
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/wb_dat_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/wb_adr_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/wb_sel_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/wb_stb_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/wb_we_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/wb_cyc_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/wb_dat_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/wb_err_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/wb_ack_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/int_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/mon_cb_event
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_dat_i
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_ack_i
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_err_i
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_adr_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_sel_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_we_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_dat_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_cyc_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_stb_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_cti_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_bte_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/slave_cb_event
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_dat_i
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_ack_i
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_err_i
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_adr_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_sel_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_we_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_dat_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_cyc_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_stb_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_cti_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_bte_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/mon_cb_event
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/wb_dat_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/wb_dat_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/wb_err_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/wb_adr_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/wb_sel_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/wb_we_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/wb_stb_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/wb_cyc_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/wb_ack_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/int_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/wb_dat_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/wb_adr_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/wb_sel_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/wb_stb_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/wb_we_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/wb_cyc_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/wb_dat_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/wb_err_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/wb_ack_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/int_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/drv_cb/drv_cb_event
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/wb_dat_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/wb_adr_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/wb_sel_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/wb_stb_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/wb_we_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/wb_cyc_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/wb_dat_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/wb_err_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/wb_ack_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/int_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/mon_cb/mon_cb_event
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/m_wb_adr_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/m_wb_sel_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/m_wb_we_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/m_wb_dat_i
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/m_wb_dat_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/m_wb_cyc_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/m_wb_stb_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/m_wb_ack_i
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/m_wb_err_i
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/m_wb_cti_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/m_wb_bte_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_dat_i
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_ack_i
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_err_i
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_adr_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_sel_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_we_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_dat_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_cyc_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_stb_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_cti_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/m_wb_bte_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/slave_cb/slave_cb_event
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_dat_i
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_ack_i
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_err_i
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_adr_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_sel_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_we_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_dat_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_cyc_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_stb_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_cti_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/m_wb_bte_o
add wave -noupdate -group OTHER_SIGNALS /top/mem_pif/mon_cb/mon_cb_event
add wave -noupdate -group OTHER_SIGNALS /top/miim_pif/md_pad_i
add wave -noupdate -group OTHER_SIGNALS /top/miim_pif/mdc_pad_o
add wave -noupdate -group OTHER_SIGNALS /top/miim_pif/md_pad_o
add wave -noupdate -group OTHER_SIGNALS /top/miim_pif/md_padoe_o
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/wb_clk_i
add wave -noupdate -group OTHER_SIGNALS /top/proc_pif/wb_rst_i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5015 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 232
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {19209 ns} {20013 ns}
