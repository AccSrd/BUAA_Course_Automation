#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jun 25 15:56:40 2020

@author: hantao.li

----Input:  the matrix which indicates the map of maze.
----Output: a window shows the process of finding way out of maze.
            the process will also giving out in the console.

The Homework of AI part in ML course in Beihang spring 2020. 
Using A* method to deal with a maze.

2020spring，模式识别课程，AI部分大作业。使用A*算法破解自定义迷宫。使用数组矩阵自定义迷宫。
机器人拥有八个自由度，对应八种移动方法。输出搜索过程、输出最终路径的单支树状图，使用窗口可视化搜索过程。
"""

from tkinter import Tk
from tkinter import Canvas
import math
import time

#手动建立地图，1为起点，3为终点，2为障碍
#build the maze. 1->start point, 3->destination, 2->obstacle

env_data = [[0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
            [2, 0, 0, 2, 0, 0, 0, 0, 2, 0],
            [0, 0, 0, 0, 0, 2, 0, 0, 0, 0],
            [0, 0, 2, 2, 2, 2, 2, 0, 2, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 2, 0],
            [0, 0, 0, 2, 2, 0, 0, 0, 2, 2],
            [0, 0, 0, 0, 0, 0, 0, 2, 2, 3],
            [0, 0, 2, 0, 2, 2, 2, 2, 0, 0],
            [0, 0, 2, 0, 0, 0, 0, 0, 0, 0],
            [2, 0, 2, 0, 0, 0, 0, 0, 2, 0]]


# 机器人运动的八种方式
# 8 moving direction of the robot.
orders = ['u', 'd', 'l', 'r','ul','ur','dl','dr']

# 定位起点和终点
# indicate the start point and destination 
start_loc = []
des_loc = []
for index, value in enumerate(env_data, 1):
    if len(start_loc) == 0 or len(des_loc) == 0:
        if 1 in value:
            start_loc = (index, value.index(1) + 1)
        if 3 in value:
            des_loc = (index, value.index(3) + 1)
    else:
        break

# 搜索机器人当前位置能够做出的运动
# search the moving can be finished currently.
def valid_actions(loc):
    loc_actions = []
    for order in orders:
        if is_move_valid(loc, order):
            loc_actions.append(order)
    return loc_actions

# 判断能够进行某个运动
# check if the move can be done
def is_move_valid(loc, act):
    x = loc[0] - 1
    y = loc[1] - 1
    if act not in orders:
        return False
    else:
        if   act == orders[0]:#u
            return x != 0 and env_data[x-1][y] != 2
        elif act == orders[1]:#d
            return x != len(env_data)-1 and env_data[x+1][y] != 2
        elif act == orders[2]:#l
            return y != 0 and env_data[x][y-1] != 2
        elif act == orders[3]:#r
            return y != len(env_data[0])-1 and env_data[x][y+1] != 2
        elif act == orders[4]:#ul
            return x != 0 and y != 0 and env_data[x-1][y-1] != 2
        elif act == orders[5]:#ur
            return x != 0 and y != len(env_data[0])-1 and env_data[x-1][y+1] != 2
        elif act == orders[6]:#dl
            return x != len(env_data)-1 and y != 0 and env_data[x+1][y-1] != 2
        else:                 #dr
            return x != len(env_data)-1 and y != len(env_data[0])-1 and env_data[x+1][y+1] != 2

# 搜索机器人当前位置能够前往的位置
# search the valid location
def get_all_valid_loc(loc):
    all_valid_data = []
    cur_acts = valid_actions(loc)
    for act in cur_acts:
        all_valid_data.append(move_robot(loc, act))
    if loc in all_valid_data:
        all_valid_data.remove(loc)
    return all_valid_data

# 得到某个运动后坐标
# get the location after the moving
def move_robot(loc, act):
    if is_move_valid(loc, act):
        if   act == orders[0]:#u
            return loc[0] - 1, loc[1]
        elif act == orders[1]:#d
            return loc[0] + 1, loc[1]
        elif act == orders[2]:#l
            return loc[0], loc[1] - 1
        elif act == orders[3]:#r
            return loc[0], loc[1] + 1
        elif act == orders[4]:#ul
            return loc[0] - 1, loc[1] - 1
        elif act == orders[5]:#ur
            return loc[0] - 1, loc[1] + 1
        elif act == orders[6]:#dl
            return loc[0] + 1, loc[1] - 1
        else:                 #dr
            return loc[0] + 1, loc[1] + 1
    else:
        return loc

def compute_g(loc,cur_node):
    g = cur_node[3] + math.sqrt((loc[0]-cur_node[0][0])**2 + (loc[1]-cur_node[0][1])**2);
    return round(g,2)
    
def compute_f(loc):
    f = math.sqrt((loc[0]-des_loc[0])**2 + (loc[1]-des_loc[1])**2)
    return round(f,2)

def takeh(elem):
    return elem[4]

# 制作画布
# build the canvas
root = Tk()
root.title('A*_LHT')
root.geometry("360x360")
canvas = Canvas(root, width=360, height=360, bg="white")
canvas.pack()
for i in range(1, 12):
    canvas.create_line(30, 30 * i, 330, 30 * i)  # 横线
    canvas.create_line(30 * i, 30, 30 * i, 330)  # 竖线

# 墙壁格子
# Draw the block of wall
for i_x in range(0,len(env_data)):
    for i_y in range(0,len(env_data[i_x])):
        if env_data[i_x][i_y] == 2:
            j = i_x
            i = i_y 
            canvas.create_rectangle((i + 1)*30, (j + 1)*30, 
                                    (i + 2)*30, (j + 2)*30, fill='black')

#  (1)
Openlist = [[start_loc,start_loc,compute_f(start_loc),0,compute_f(start_loc)]]
Closelist = []
#格式为[坐标，父节点坐标，f,g,h]

while True:
    Routelist = []
    #  (2)
    if len(Openlist) == 0:
        print("失败，无解")
        break
    
    #  (3)
    Openlist.sort(key=takeh)
    
    #  (4)
    cur_node = Openlist[0]                  #选取要扩展的点i
    cur_node_loc = Openlist[0][0]           #i坐标
    Closelist.append(Openlist.pop(0))       #把i从OPEN表中取出，放入Close表

    
    #  (5)
    if cur_node_loc == des_loc:
        print("以上为搜索过程")
        print('-'*30)
        print('以下为最终路径单支树状图')
        Routelist.append(cur_node)
        while Routelist[-1][0] != start_loc:
            for close_node in Closelist:
                if Routelist[-1][1] == close_node[0]:
                    Routelist.append(close_node)
        Routelist.reverse()
        break
    
    #  (6)
    Curlist = []
    valid_loc_now = get_all_valid_loc(cur_node_loc)      #可行的后继节点
    #(a)
    for i in range(0,len(valid_loc_now)):
        f = compute_f(valid_loc_now[i])
        g = compute_g(valid_loc_now[i],cur_node)
        h = round((f+g),2)
        Curlist.append([valid_loc_now[i],cur_node_loc,f,g,h])

    
    Checklist = Openlist + Closelist
    Checklist = [x[0] for x in Checklist]  #合并Openlist/Closelist，方便检验j是否不在
    
    for i_Cur in range(0,len(Curlist)):
        #(b)
        if Curlist[i_Cur][0] not in Checklist:
            Openlist.append(Curlist[i_Cur])
        #(c)
        else:
            for i_Open in range(0,len(Openlist)):
                if Curlist[i_Cur][0] == Openlist[i_Open][0]:
                    if Curlist[i_Cur][4] - Openlist[i_Open][4] < 0:
                        Openlist[i_Open] = Curlist[i_Cur]
                    
            for i_Close in range(0,len(Closelist)):
                if Curlist[i_Cur][0] == Closelist[i_Close][0]:
                    if Curlist[i_Cur][4] - Closelist[i_Close][4] < 0:
                        Closelist[i_Close] = Curlist[i_Cur]
                        Openlist.append(Closelist[i_Close])
            Closelist = [i for i in Closelist if i not in Openlist]

    Routelist.append(cur_node)
    while Routelist[-1][0] != start_loc:
        for close_node in Closelist:
            if Routelist[-1][1] == close_node[0]:
                Routelist.append(close_node)
    Routelist.reverse()

    # 搜索过的格子
    # Draw the block have been searched
    Checklist = Openlist + Closelist
    Checklist = [x[0] for x in Checklist]  
    for node in Checklist:
        canvas.create_rectangle((node[1])*30, (node[0])*30,
                                (node[1]+1)*30, (node[0]+1)*30, fill='Aquamarine')
    
    # 路径格子
    # Draw the block on the path
    RouteNode = [x[0] for x in Routelist]
    for node in RouteNode:
        canvas.create_rectangle((node[1])*30, (node[0])*30, 
                                (node[1]+1)*30, (node[0]+1)*30, fill='DarkGreen')

    # 起点终点格子
    # Draw the block of start and end point
    canvas.create_rectangle((start_loc[1])*30, (start_loc[0])*30,
                            (start_loc[1]+1)*30, (start_loc[0]+1)*30, fill='SlateBlue')
    canvas.create_rectangle((des_loc[1])*30, (des_loc[0])*30,
                            (des_loc[1]+1)*30, (des_loc[0]+1)*30, fill='GreenYellow')    

    print (RouteNode)
    root.update()
    time.sleep(0.5)
root.mainloop()

# 制作最终路径树状图
# Draw the tree-map
box_up = "┌"+"─"*29+"┐"
box_mid = "├"+"─"*9+"┬"+"─"*9+"┬"+"─"*9+"┤"
box_bot = "└"+"─"*9+"┴"+"─"*9+"┴"+"─"*9+"┘"
box_bb = "┴"
box_bar = "│"
box_arr = ' '*15+"↓"*2+' '*15

for node in Routelist:
    loc = str(node[0])
    f = "f="+str(node[2])
    g = "g="+str(node[3])
    h = "h="+str(node[4])
    len_loc = len(loc)
    len_f = len(str(node[2]))
    len_g = len(str(node[3]))
    len_h = len(str(node[4]))
    print (box_up)
    print (box_bar + ' '*12 + loc + ' '*(17-len_loc) + box_bar)
    print (box_mid)
    print (box_bar+' '+f+' '*(6-len_f)+box_bar+' '+g+' '*(6-len_g)+box_bar+' '+h+' '*(6-len_h)+box_bar)
    print (box_bot)
    print (box_arr+'\n'+box_arr)
print (' '*10 + 'Destination!')
