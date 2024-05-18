if {[file exists work]} {
	vdel -lib work -all
}

vlib work
vmap work work

vlog -f "vlog.f"
vsim -f "vsim.f"

run -all
q
