// work ���ǵ�ǰĿ¼�µ� work Ŀ¼
-work work
// ʹ�� sv �﷨
-sv
// ʹ����������
-incr
// ʹ�� uvm 1.1d �汾
-L mtiAvm
-L mtiOvm
-L mtiUvm
-L mtiUPF

+acc

// "include Ŀ¼" �� "��Ҫ����� sv �ļ�"
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
