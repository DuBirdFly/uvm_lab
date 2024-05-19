# command: vsim -c -do modelsim_shell.do
# command: vsim -view vsim.wlf`

if {[file exists work]} {
	vdel -lib work -all
}

vlib work
vmap work work

vlog -f "vlog.f"
vsim -f "vsim.f"

run -all
q
