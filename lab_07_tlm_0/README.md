# MEADME

## lab_03_factory_0

添加文件: my_driver_count.sv, my_test_da3.sv, my_transaction_da3.sv
修改文件: pgm.sv, 新增 include
修改脚本: vsim.f, `+UVM_TESTNAME=my_test` --> `+UVM_TESTNAME=my_test_da3`

说明: 学习UVM中的factory机制的 Override 机制

## lab_03_factory_1

继承自 lab_03_factory_0
修改 `user/sim_uvm` 的文件结构

**Question: both in "lab_03_factory_0" and "lab_03_factory_1"**

1. `my_driver_count` 并没有成功覆盖 `my_driver`
2. 在 `my_test_da3.sv`
3. 会报错: `set_type_override_by_type(my_driver::get_type(), my_driver_count::get_type());`
4. 不报错, 但不覆盖: `set_inst_override_by_type("my_env.m_agent.m_drv.*", my_driver::get_type(), my_driver_count::get_type());`

    ```log
        # UVM_FATAL @ 0: reporter [FCTTYP] Factory did not return a component of type 'my_driver'. A component of type 'my_driver_count' was returned instead. Name=m_drv Parent=master_agent contxt=uvm_test_top.my_env.m_agent
    ```

## lab_04_config_0_variable

继承: lab_03_factory_1
视频: "29-07 - UVM_configuration机制 - 03_如何使用configuration机制 - 2.mp4"

修改内容:

1. my_sequence.sv 里有一个 int:item_num = 3 的配置项, 这个配置项用于生成 transaction 的个数
2. my_test.sv 里用 `uvm_config_db#(int)::set` 设置这个配置项的值 -> 在 `pre_randomize()` 里设置, 以确保能在随机化之前设置
3. my_sequence.sv 里用 `uvm_config_db#(int)::get` 获取这个配置项的值

*NOTE: 一般在 `pre_randomize()` 里干什么:*

1. *检查和修改随机化变量的取值范围*
2. *根据其他类成员的值来设置随机化变量的约束*
3. *执行一些预处理逻辑*
4. *调用其他函数或方法来准备随机化过程*

## lab_04_config_1_interface

继承: lab_04_config_0_variable
视频: "29-07 - UVM_configuration机制 - 04_如何使用configuration机制 - 3.mp4"

修改内容:

1. 添加了一个 dut: "router.sv" -> 只有 IO, 还没空写内容
2. 添加了一个 interface: "dut_interface.sv"
3. 在 "driver.sv" 里实例化了这个 interface
   1. 声明了一个 `virtual dut_interface m_vif;` 的句柄(指针)
   2. 在 `build_phase` 里使用 `uvm_config_db #(type)::get()`, type 使用 **virtual interface**
   3. 在 `pre_reset_phase()` 和 `reset_phase()`, 实现 'x 和 '0 的复位
   4. 在 `main_phase()`, 实现激励的发送

## lab_04_config_2_object

继承: lab_04_config_1_interface
视频: "29-07 - UVM_configuration机制 - 05_如何使用configuration机制 - 4.mp4"

修改内容:

1. 添加了 agent_config.sv 和 env_config.sv
2. 实现了 config 链, 具体看图 "config链.png"

## lab_05_remake

继承: lab_04_config_2_object
视频: 无

修改内容:

1. 重构了代码, 命名规定:
   1. 类采用大驼峰, 对象采用小驼峰
   2. 组件均以 Comp 开头, 配置类均以 Cfg 开头, 信号接口均以 Intf 开头
   3. top 里接口的例化均以 intf 开头, 类里接口的例化均以 vif 开头
2. 添加了 CompIMon.sv
3. 完善了 dut
4. 添加了 iverilog 的仿真相关文件

## lab_06_seq_0

继承: lab_05_remake
视频: 1. "35-08 - UVM sequence机制 - 04_如何使用UVM sequence机制_2_uvm_do宏.mp4"
视频: 2. "36-08 - UVM sequence机制 - 05_如何使用UVM sequence机制_3_uvm sequence的启动.mp4"
视频: 3. "37-08 - UVM sequence机制 - 06_如何使用UVM sequence机制_4_sequence嵌套&仲裁&响应和本章小结.mp4"

修改内容:

1. 修改 MySeqItem.sv, 手动实现 `uvm_do` 宏
   1. 修改 body() 这个 task
   2. 注释掉 `uvm_do` 宏
   3. 在 `body()` 里创建 uvm_sequence_item 类型的对象句柄 : tr (但暂时先不开辟空间)
      1. 在 repeat 代码块里, 用 `类名::type_id::create()` 创建对象空间
      2. 调用 `start_item(tr)`
      3. 调用 `tr.randomize()` (非 'void 函数, 有可能失败)
      4. 调用 `finish_item(tr)`

2. 修改 Test.sv, 手动启动 MySeq
   1. 注释掉 `uvm_config_db#(uvm_object_wrapper)::set(this, "*.compSeqr.run_phase", "default_sequence", MySeq::get_type());`
   2. 重载 run_phase() 任务
      1. 创建 mySeq 句柄
      2. 开辟对象空间, 使用`类名::type_id::create()`, mySeq 指向该空间
      3. `phase.raise_objection(this);` 用于开始 run_phase
      4. mySeq.start() 方法启动该对象, 注: 括号里放 mySeq 对应的 Seqr 对象
      5. `phase.drop_objection(this);` 用于结束 run_phase

3. 修改 MySeq.sv 与 CompDrv.sv, 说明 Seq 和 Drv 之间获取相应的关系
   1. MySeq.sv 的 body().repeat() 里, 用 `get_response()` 获取 Drv 的相应
   2. CompDrv.sv
      1. 添加了一个空的 rsp 句柄
      2. (用于测试) 将 req.clone() 赋值给 rsp
      3. rsp.set_id_info(req) 用于设置 rsp 的 id 信息
      4. seq_item_port.put_response(rsp);

