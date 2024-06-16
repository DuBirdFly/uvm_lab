# README

## 编译 uvm-1.2

gcc 下载: <https://download.csdn.net/download/weixin_39565666/10290013>
下载完成后, 在终端中输入 `g++ --version` 查看是否安装成功

```sh
g++.exe (GCC) 4.5.0
Copyright (C) 2010 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

在 **modelsim** 中执行以下指令以生成 dll 文件
*注意，要先新建 OUTPUT_DIR 文件夹*

```sh
set MODELSIM_DIR    D:/Codes/Modelsim/Modelsim_10_7
set OUTPUT_DIR      C:/Users/Administrator/Desktop/dll

D:/Env/MinGW/modelsim-gcc-4.5.0-mingw64/bin/g++.exe -DQUESTA -W -shared -Bsymbolic -I $MODELSIM_DIR/include $MODELSIM_DIR/verilog_src/uvm-1.2/src/dpi/uvm_dpi.cc -o $OUTPUT_DIR/uvm_dpi.dll $MODELSIM_DIR/win64/mtipli.dll -lregex
```

...没搞成功, 报错如下:

```sh
C:\Users\ADMINI~1\AppData\Local\Temp\ccnQXeIY.o:uvm_dpi.cc:(.text+0x63): undefined reference to `m__uvm_report_dpi'
collect2: ld returned 1 exit status
```

## Modelsim 常用指令

```sh
vsim -c -do modelsim_shell.do
vsim -view vsim.wlf
vsim vsim.wlf
vsim vsim.wlf -do ../signal/apb_axi.do

do ../signal/apb_axi.do
dataset reload -f
```

## axi

在写通道的时候, awsize 通常只是决定内部 addr 要多久递增一次.

举例, 当 awaddr = 0, awsize = 3 (8 byte/transfer), AXI_DATA_WIDTH = 256 (32 byte)时,
awsize 只决定说 4 个 transfer 之后, 内部 addr + 1;
而这 4 个 transfer 究竟哪些数据是有效的, 取决于 wstrb.
你甚至可以 4 个 transfer 的 wstrb 都是 1, 那么只有第四个 transfer 的数据是有效的; 但是第五个 transfer 就开始跳到下一个内部 addr 了.

极端情况, awaddr = 0, awlen = 0(+1), awsize = 0, strb = '1 --> awdata 的所有 byte 都写入了, 而不是只有 1 byte.


