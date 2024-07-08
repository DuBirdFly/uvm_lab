# -*- coding: utf-8 -*-

# 删除当前路径所有文件夹下相对路径为 prj/modelsim/work 的文件夹

import os, shutil

for sub_dir in [os.path.join(dir, 'prj') for dir in os.listdir() if os.path.isdir(dir)]:
    for root, dirs, files in os.walk(sub_dir):
        for dir in dirs:
            if dir == 'work':
                path = os.path.join(root, dir)
                print(path)
                shutil.rmtree(f'Delete {path}')
