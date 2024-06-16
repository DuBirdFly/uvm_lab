# command: vsim -c -do modelsim_shell.do
# command: vsim -view vsim.wlf
# command: vsim -view vsim.wlf -do ../signal/apb_axi.do
# command: vsim -view vsim.wlf
# command: do ../signal/apb_axi.do

if {[file exists work]} {
	vdel -lib work -all
}

# 如果当前目录不存在 work 文件夹, 则用 vlib 命令创建一个
vlib work

# 将逻辑库映射到 work 文件夹
vmap work work

vlog -f "vlog.f"
vsim -f "vsim.f"

run -all
q
