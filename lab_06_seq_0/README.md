# MEADME

## lab_03_factory_0

����ļ�: my_driver_count.sv, my_test_da3.sv, my_transaction_da3.sv
�޸��ļ�: pgm.sv, ���� include
�޸Ľű�: vsim.f, `+UVM_TESTNAME=my_test` --> `+UVM_TESTNAME=my_test_da3`

˵��: ѧϰUVM�е�factory���Ƶ� Override ����

## lab_03_factory_1

�̳��� lab_03_factory_0
�޸� `user/sim_uvm` ���ļ��ṹ

**Question: both in "lab_03_factory_0" and "lab_03_factory_1"**

1. `my_driver_count` ��û�гɹ����� `my_driver`
2. �� `my_test_da3.sv`
3. �ᱨ��: `set_type_override_by_type(my_driver::get_type(), my_driver_count::get_type());`
4. ������, ��������: `set_inst_override_by_type("my_env.m_agent.m_drv.*", my_driver::get_type(), my_driver_count::get_type());`

    ```log
        # UVM_FATAL @ 0: reporter [FCTTYP] Factory did not return a component of type 'my_driver'. A component of type 'my_driver_count' was returned instead. Name=m_drv Parent=master_agent contxt=uvm_test_top.my_env.m_agent
    ```

## lab_04_config_0_variable

�̳�: lab_03_factory_1
��Ƶ: "29-07 - UVM_configuration���� - 03_���ʹ��configuration���� - 2.mp4"

�޸�����:

1. my_sequence.sv ����һ�� int:item_num = 3 ��������, ����������������� transaction �ĸ���
2. my_test.sv ���� `uvm_config_db#(int)::set` ��������������ֵ -> �� `pre_randomize()` ������, ��ȷ�����������֮ǰ����
3. my_sequence.sv ���� `uvm_config_db#(int)::get` ��ȡ����������ֵ

*NOTE: һ���� `pre_randomize()` ���ʲô:*

1. *�����޸������������ȡֵ��Χ*
2. *�����������Ա��ֵ�����������������Լ��*
3. *ִ��һЩԤ�����߼�*
4. *�������������򷽷���׼�����������*

## lab_04_config_1_interface

�̳�: lab_04_config_0_variable
��Ƶ: "29-07 - UVM_configuration���� - 04_���ʹ��configuration���� - 3.mp4"

�޸�����:

1. �����һ�� dut: "router.sv" -> ֻ�� IO, ��û��д����
2. �����һ�� interface: "dut_interface.sv"
3. �� "driver.sv" ��ʵ��������� interface
   1. ������һ�� `virtual dut_interface m_vif;` �ľ��(ָ��)
   2. �� `build_phase` ��ʹ�� `uvm_config_db #(type)::get()`, type ʹ�� **virtual interface**
   3. �� `pre_reset_phase()` �� `reset_phase()`, ʵ�� 'x �� '0 �ĸ�λ
   4. �� `main_phase()`, ʵ�ּ����ķ���

## lab_04_config_2_object

�̳�: lab_04_config_1_interface
��Ƶ: "29-07 - UVM_configuration���� - 05_���ʹ��configuration���� - 4.mp4"

�޸�����:

1. ����� agent_config.sv �� env_config.sv
2. ʵ���� config ��, ���忴ͼ "config��.png"

## lab_05_remake

�̳�: lab_04_config_2_object
��Ƶ: ��

�޸�����:

1. �ع��˴���, �����涨:
   1. ����ô��շ�, �������С�շ�
   2. ������� Comp ��ͷ, ��������� Cfg ��ͷ, �źŽӿھ��� Intf ��ͷ
   3. top ��ӿڵ��������� intf ��ͷ, ����ӿڵ��������� vif ��ͷ
2. ����� CompIMon.sv
3. ������ dut
4. ����� iverilog �ķ�������ļ�
