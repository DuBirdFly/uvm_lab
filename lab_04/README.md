# MEADME

lab_03_factory_0:
    添加文件: my_driver_count.sv, my_test_da3.sv, my_transaction_da3.sv
    修改文件: pgm.sv, 新增 include
    修改脚本: vsim.f, `+UVM_TESTNAME=my_test` --> `+UVM_TESTNAME=my_test_da3`

    说明: 学习UVM中的factory机制的 Override 机制

lab_03_factory_1:
    继承自 lab_03_factory_0
    修改 `user/sim_uvm` 的文件结构

lab_04:
    继承自 lab_03_factory_1
    Video : UVM-configuration 03
    Config sequence --> change the number of transactions

