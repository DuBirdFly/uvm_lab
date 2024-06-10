// work 库是当前目录下的 work 目录
-work work
// 使用 sv 语法
-sv
// 使用增量编译
// -incr
// 支持 Avm, Ovm, Uvm, UPF
-L mtiAvm
-L mtiOvm
-L mtiUvm
-L mtiUPF

+acc

// "include 目录" 与 "需要编译的 sv 文件"
+incdir+D:/Codes/Modelsim/Modelsim_10_7/verilog_src/uvm-1.1d/src
D:/Codes/Modelsim/Modelsim_10_7/verilog_src/uvm-1.1d/src/uvm_pkg.sv

+incdir+../../user/dut
../../dut/lpddr_ctl.sv

+incdir+../../sim
+incdir+../../sim/agent
+incdir+../../sim/config
+incdir+../../sim/env
+incdir+../../sim/interface
+incdir+../../sim/seq
+incdir+../../sim/top
../../sim/top/Top.sv
