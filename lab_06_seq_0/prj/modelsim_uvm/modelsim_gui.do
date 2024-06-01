quit -sim
.main clear

if {[file exists work]} {
	vdel -lib work -all
}

vlib work
vmap work work

vlog -work work +acc -sv -f "../../user/flist/run.f"
vsim -gui -voptargs=+acc -sv_seed 0 work.Top

view wave
configure wave -timelineunits ns
# add wave Top/dut_bus/*
do modelsim_wave.do

run -all
