# -*- coding: utf-8 -*-

import os, subprocess

# 获取当前路径上两级的路径
PWD : str = os.path.abspath("../..")
UVM_HOME : str = "D:/Codes/Modelsim/Modelsim_10_7/verilog_src/uvm-1.1d"
UVM_LIB : str = "D:/Codes/Modelsim/Modelsim_10_7/uvm-1.1d/win64/uvm_dpi"
TB_TOP_RELPATH : str = "sim/top/Top.sv"
TB_TOP_NAME : str = "Top"
TB_TEST_NAME : str = "Test"
SV_SEED : int = 0
RUN_PATH : str = f"./out"

##########################################################
if not os.path.exists(RUN_PATH): os.makedirs(RUN_PATH)

lines : list[str] = []
lines.append(f"vlib work")
lines.append(f"vmap work work")
lines.append(f"vlog -f \"vlog.f\"")
lines.append(f"vsim -f \"vsim.f\"")
lines.append(f"run -all")
lines.append(f"q")

with open(f"{RUN_PATH}/modelsim_shell.do", 'w') as f:
    for line in lines:
        f.write(line.replace('\\', '/') + '\n')

##########################################################
lines : list[str] = []
lines.append(f"-work work")
lines.append(f"-sv")
lines.append(f"-L mtiAvm -L mtiOvm -L mtiUvm -L mtiUPF")
lines.append(f"+acc")
lines.append(f"")

lines.append(f"+define+DUMP_VCD")
lines.append(f"+define+DUMP_WLF")
lines.append(f"")

lines.append(f"+incdir+{UVM_HOME}/src")
lines.append(f"{UVM_HOME}/src/uvm_pkg.sv")
lines.append(f"")

for root, dirs, files in os.walk(f"{PWD}/sim"):
    for dir in dirs:
        lines.append(f"+incdir+{root}/{dir}")
lines.append(f"{PWD}/{TB_TOP_RELPATH}")
lines.append(f"")

for root, dirs, files in os.walk(f"{PWD}/dut"):
    for file in files:
        if file.endswith('.sv') or file.endswith('.v'):
            lines.append(f"{root}/{file}")
lines.append(f"")

with open(f"{RUN_PATH}/vlog.f", 'w') as f:
    for line in lines:
        f.write(line.replace('\\', '/') + '\n')

##########################################################
lines : list[str] = []
lines.append(f"-c")
lines.append(f"-voptargs=+acc")
lines.append(f"-sv_seed {SV_SEED}")
lines.append(f"-sv_lib {UVM_LIB}")
lines.append(f"+UVM_TESTNAME={TB_TEST_NAME}")
lines.append(f"work.{TB_TOP_NAME}")
lines.append(f"")

with open(f"{RUN_PATH}/vsim.f", 'w') as f:
    for line in lines:
        f.write(line.replace('\\', '/') + '\n')

##########################################################
subprocess.run(f"vsim -c -do modelsim_shell.do", shell=True, cwd=RUN_PATH)
