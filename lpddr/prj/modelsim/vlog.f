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
+define+DUMP_VCD
// +define+DUMP_WLF

// "include 目录" 与 "需要编译的 sv 文件"
+incdir+D:/Codes/Modelsim/Modelsim_10_7/verilog_src/uvm-1.1d/src

+incdir+C:/Users/Administrator/Desktop/lab/lpddr/user/dut
+incdir+C:/Users/Administrator/Desktop/lab/lpddr/sim
+incdir+C:/Users/Administrator/Desktop/lab/lpddr/sim/agent
+incdir+C:/Users/Administrator/Desktop/lab/lpddr/sim/config
+incdir+C:/Users/Administrator/Desktop/lab/lpddr/sim/env
+incdir+C:/Users/Administrator/Desktop/lab/lpddr/sim/interface
+incdir+C:/Users/Administrator/Desktop/lab/lpddr/sim/seq
+incdir+C:/Users/Administrator/Desktop/lab/lpddr/sim/top

D:/Codes/Modelsim/Modelsim_10_7/verilog_src/uvm-1.1d/src/uvm_pkg.sv
C:/Users/Administrator/Desktop/lab/lpddr/dut/lpddr_ctl.sv
C:/Users/Administrator/Desktop/lab/lpddr/sim/top/Top.sv
