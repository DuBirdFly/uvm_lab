vlib work

# vlog +incdir+$UVM_HOME/src +incdir+$WORK_HOME/user/sim -L mtiAvm -L mtiOvm -L mtiUvm -L mtiUPF $UVM_HOME/src/uvm_pkg.sv ../../user/sim/test.sv
# vsim -c -sv_lib $UVM_DPI_HOME/uvm_dpi +UVM_TESTNAME=my_test -t 1ns -sv_seed 0 work.test

vlog -f "vlog.f"
vsim -f "vsim.f"

view wave *
configure wave -timelineunits ns

run -all
q
