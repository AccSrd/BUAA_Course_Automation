#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Nov 18 14:23:51 2019

@author: hantao.li
"""

g_dict_layouts = {}
g_dict_shifts = {0:[1, 3], 1:[0, 2, 4], 2:[1, 5],
                 3:[0,4,6], 4:[1,3,5,7], 5:[2,4,8],
                 6:[3,7],  7:[4,6,8], 8:[5,7]}
#-----------------------------------------------定义九宫格中每一个方格可以移动的位置

def swap_chr(a, i, j):
    if i > j:
        i, j = j, i
    b = a[:i] + a[j] + a[i+1:j] + a[i] + a[j+1:]
    return b
#-----------------------------------------------两个方格交换后的数组

def solvePuzzle_depth(srcLayout, destLayout):
    src=0;dest=0
    for i in range(1,9):
        fist=0
        for j in range(0,i):
          if srcLayout[j]>srcLayout[i] and srcLayout[i]!='0':
              fist=fist+1
        src=src+fist

    for i in range(1,9):
        fist=0
        for j in range(0,i):
          if destLayout[j]>destLayout[i] and destLayout[i]!='0':
              fist=fist+1
        dest=dest+fist
    if (src%2)!=(dest%2):
        return -1, None
#----------------------------------------------求初始格局和目标格局逆序数，然后在比较两者的逆序数的奇偶性是否相同
    g_dict_layouts[srcLayout] = -1
    stack_layouts = []
    stack_layouts.append(srcLayout)

    while len(stack_layouts) > 0:
        curLayout = stack_layouts.pop(0)
        if curLayout == destLayout:
            break
#----------------------------------------------判断当前格局是否为目标格局
        ind_slide = curLayout.index("0")
        lst_shifts = g_dict_shifts[ind_slide]
#----------------------------------------------找到能交换的方格
        for nShift in lst_shifts:
            newLayout = swap_chr(curLayout, nShift, ind_slide)

            if g_dict_layouts.get(newLayout) == None:#判断交换后的状态是否已经查询过
                g_dict_layouts[newLayout] = curLayout
                stack_layouts.append(newLayout)#存入集合

    lst_steps = []
    lst_steps.append(curLayout)
    while g_dict_layouts[curLayout] != -1:
        curLayout = g_dict_layouts[curLayout]
        lst_steps.append(curLayout)
#----------------------------------------------将结果存入路径
    lst_steps.reverse()
    return 0, lst_steps


if __name__ == "__main__":
    srcLayout  = "123405678"#输入原始格局
    destLayout = "123804567"#输入目标格局

    retCode, lst_steps = solvePuzzle_depth(srcLayout, destLayout)
    if retCode != 0:
        print("目标布局不可达")
    else:
        for nIndex in range(len(lst_steps)):
            print("Step Number:" + str(nIndex + 1))
            print('-------------')
            print('| '+lst_steps[nIndex][0]+' | '+lst_steps[nIndex][1]+' | '+lst_steps[nIndex][2]+' |')
            print('-------------')         
            print('| '+lst_steps[nIndex][3]+' | '+lst_steps[nIndex][4]+' | '+lst_steps[nIndex][5]+' |')
            print('-------------')
            print('| '+lst_steps[nIndex][6]+' | '+lst_steps[nIndex][7]+' | '+lst_steps[nIndex][8]+' |')
            print('-------------\n')
        print('=======================\n本次求解共'+str(nIndex+1)+'步')
