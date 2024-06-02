# command: vsim -c -do modelsim_shell.do
# command: vsim -view vsim.wlf

if {[file exists work]} {
	vdel -lib work -all
}

# �����ǰĿ¼������ work �ļ���, ���� vlib �����һ��
vlib work

# ���߼���ӳ�䵽 work �ļ���
vmap work work

vlog -f "vlog.f"
vsim -f "vsim.f"

run -all
q
