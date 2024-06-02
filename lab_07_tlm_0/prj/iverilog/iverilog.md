# iverilog

直接敲 `iverilog` 命令，会显示其使用方法
filelist.f 必须以空行结尾

`iverilog -g2005-sv -o <vvp file> -I <list: includedir> -s <top file> -f <filelist file>`
iverilog -g2005-sv -o out.vvp -s tb_RoundRobinArbiter -f filelist.f

`vvp -n <vvp file> -l err.log >> run.log`
vvp -n out.vvp

