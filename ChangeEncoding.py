# -*- coding: utf-8 -*-

import os
import codecs

def convert_encoding(file_path):
    try:
        # 尝试以gbk编码打开文件并读取内容
        with codecs.open(file_path, 'r', 'gbk') as f:
            content = f.read()
    except UnicodeDecodeError:
        # 如果出现解码错误，尝试使用utf-8编码打开文件
        with codecs.open(file_path, 'r', 'utf-8') as f:
            content = f.read()
 
    # 将内容以UTF-8编码写入新文件
    with codecs.open(file_path, 'w', 'utf-8') as f:
        f.write(content)
 
    print(f'转换完成：{file_path}')

def batch_convert(root_dir):
    # 遍历root_dir目录及其子目录下所有文件
    for root, dirs, files in os.walk(root_dir):
        for file in files:
            if file.endswith('.md') or file.endswith('.f') or file.endswith('.do') or file.endswith('.sv'):
                # 生成文件的完整路径
                file_path = os.path.join(root, file)
                # 转换文件编码
                if 'uvm-1.1d' not in file_path:
                    convert_encoding(file_path)

# 在当前目录及其子目录中批量转换文件编码
batch_convert('.')