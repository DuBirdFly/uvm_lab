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
