// work 库是当前目录下的 work 目录
-work work
// 使用 sv 语法
-sv
// 使用增量编译
-incr
// 使用 uvm 1.1d 版本
-L mtiAvm
-L mtiOvm
-L mtiUvm
-L mtiUPF

+acc

// "include 目录" 与 "需要编译的 sv 文件"
+incdir+../uvm-1.1d/src
../uvm-1.1d/src/uvm_pkg.sv

+incdir+../../user/dut
../../user/dut/Router.sv
../../user/dut/RouterIPort.sv
../../user/dut/Lib.sv

+incdir+../../user/sim_uvm
+incdir+../../user/sim_uvm/agent
+incdir+../../user/sim_uvm/config
+incdir+../../user/sim_uvm/env
+incdir+../../user/sim_uvm/interface
+incdir+../../user/sim_uvm/top
../../user/sim_uvm/top/Top.sv
