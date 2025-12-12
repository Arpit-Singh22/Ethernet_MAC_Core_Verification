import os
import subprocess

# ------------------------------
# User Configuration
# ------------------------------
testcases = [
    {"test":"mac_base_test"},
    {"test":"proc_reg_read_test"},
    {"test":"proc_reg_write_read_test"},
    {"test":"mac_tx_test"},
    {"test":"mac_rx_test"},
    {"test":"mac_tx_rx_test"},
    {"test":"mac_hd_tx_test"},
    {"test":"mac_hd_rx_test"},
    {"test":"mac_hd_tx_rx_test"},
    {"test":"proc_reg_read_rm_test"},
    {"test":"proc_reg_write_read_rm_test"},
    {"test":"proc_reg_write_read_rm_bd_test"},

]

vsim_exec = "vsim"
top_module = "top"
output_dir = "sim_results"
wave_do_path = "C:/Users/arpit/OneDrive/Desktop/Project/ETHERNET_MAC_VERIFICATION/sim"

# ------------------------------
# Functions
# ------------------------------
def create_run_do(test_name, ucdb_file, top_module, do_file="run.do"):
    content = f"""
vlog C:/Users/arpit/OneDrive/Desktop/Project/ETHERNET_MAC_VERIFICATION/sim/list.svh +incdir+C:/uvm-1.2/src +define+ETH_WISHBONE_B3 +define+PHY_MODE_100MBPS
vopt work.{top_module} +cover=fcbest -o {test_name} -assertdebug

vsim -c -coverage -assertdebug {test_name} \\
-sv_lib C:/questasim64_2024.1/uvm-1.2/win64/uvm_dpi \\
+UVM_TESTNAME={test_name}
coverage save -onexit {ucdb_file}
run -all
quit
"""
    with open(do_file, "w") as f:
        f.write(content)

def run_sim(do_file="run.do"):
    print(f"Running simulation with {do_file} ...")
    result = subprocess.run([vsim_exec, "-c", "-do", do_file])
    if result.returncode != 0:
        print("Simulation failed!")
        return False
    return True

# ------------------------------
# Main Automation Loop
# ------------------------------
if not os.path.exists(output_dir):
    os.makedirs(output_dir)

original_cwd = os.getcwd()  # save current working directory

for tc in testcases:
	test_name = tc["test"]
	log_dir = os.path.join(output_dir, test_name)
	ucdb_path = f"{test_name.upper()}.ucdb"
	
	os.makedirs(log_dir, exist_ok=True)
	   
	run_do_file = os.path.join(log_dir, "run.do")
	create_run_do(test_name, ucdb_path, top_module, run_do_file)
	
	os.chdir(log_dir)
	success = run_sim("run.do")
	os.chdir(original_cwd)  # return to project root safely
	
	if success:
	    print(f"[SUCCESS] {test_name} finished. UCDB: {ucdb_path}")
	else:
	    print(f"[FAIL] {test_name} failed.")

print("All testcases completed!")

