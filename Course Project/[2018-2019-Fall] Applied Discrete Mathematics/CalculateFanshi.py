#! /usr/bin/env python3
# -*- coding:utf-8 -*-
# 网络代码 用于计算范式


from tkinter import *
from tkinter import ttk

sInput1 = '' #输入的命题公式字符串
sInput=''  #暂存输入的命题公式字符串
sSimply = '' #化简后的sInput1
variable = [] #保存公式中的变量
xiqumin = [] #主析取范式最小项
hequmin = [] #主合取范式最大项
before = '' #符号前面的部分
after = '' #符号后面的部分

def getVariale():
    global variable
    for a in sInput1:
        if a >= 'A' and a <= 'Z' or a >= 'a' and a <= 'z' :
            if a not in variable:
                variable.append(a)
        elif a!='!' and a!='&' and a!='|' and a!='(' and a!=')' and a!='>' and a!=':':
            print('输入有误！！')

def Rank(c):
    global sInput,sSimply,before,after
    slen = len(sInput)
    for i in range(0,slen):  #遍历sSimply中所有字符
        if sInput[i] is c:
            if sInput[i-1] is not ')': #找到before
                before = sInput[i-1]
            else:
                flag = 1
                j = i-2
                while flag is not 0:
                    if sInput[j] is '!':
                        j-=1
                    if sInput[j] is '(': #直到找到对应的左括号为止，flag＝0，退出循环
                        flag-=1
                    if sInput[j] is ')':
                        flag+=1
                    j-=1
                before = sInput[j+1:i]  #before为符号前面的部分（括号中的内容或字母）
            if sInput[i+1] is not '(': #找到after
                after = sInput[i+1]
            else:
                flag = 1
                j = i+2
                while flag is not 0:
                    if sInput[j] is '!':
                        j+=1
                    if sInput[j] is ')':
                        flag-=1
                    if sInput[j] is '(':
                        flag+=1
                    j+=1
                after = sInput[i+1:j]
            if c is '!':
                sSimply=sSimply.replace('!'+after,'('+'not '+after+')')
            elif c is '&':
                sSimply=sSimply.replace(before+'&'+after,'('+before+'&'+after+')')
            elif c is '>':
                sSimply = sSimply.replace(before+'>'+after,'('+'not '+before+')'+'|'+after)
            elif c is ':':
                sSimply = sSimply.replace(before+':'+after,'('+before+'&'+after+')|(('+'not '+before+')'+'&'+'('+'not '+after+'))')

def simpleInput():
    global sInput,sSimply
    sInput=sInput1
    sSimply = sInput1
    Rank('!')
    sInput=sSimply
    Rank('&')
    sInput = sSimply
    Rank('>')
    sInput = sSimply
    Rank(':')
    sInput = sSimply

def getresult():
    try:
        global sInput1,sInput,sSimply,variable
        sInput1 = str(shuru.get())
        getVariale()
        simpleInput()
        vlen = len(variable) #变量个数
        n = 2**vlen   #所有情况个数
        count1=0
        count2=0
        for nl in range(0,n):      #获取真值表
            value1 = []    #数值
            j = nl   #真值表当前行
            for i in range(0,vlen):
                value1.append(0)
            i = 0
            while j!=0:
                value1[i]=j%2
                j=j//2 #浮点除法，结果四舍五入
                i+=1
            value1.reverse()
            value = list(map(str,value1))
            s = sSimply
            for x in range(0,vlen):
                s = s.replace(variable[x],value[x]) #将value里的值带入variable的变量中
            result =eval(s)
            if result is 1:
                if count1 is not 0:
                    xiqumin.append("∨")
                    xiqumin.append("(")
                    for i in range(0, vlen - 1):
                        if value1[i] is 1:
                            xiqumin.append(variable[i])
                            xiqumin.append("∧")
                        else:
                            xiqumin.append("!")
                            xiqumin.append(variable[i])
                            xiqumin.append("∧")
                    else:
                        if value1[vlen - 1] is 0:
                            xiqumin.append("!")
                            xiqumin.append(variable[vlen - 1])
                        else:
                            xiqumin.append(variable[vlen - 1])

                    xiqumin.append(")")
                else:
                    xiqumin.append("(")
                    for i in range(0, vlen - 1):
                        if value1[i] is 1:
                            xiqumin.append(variable[i])
                            xiqumin.append("∧")
                        else:
                            xiqumin.append("!")
                            xiqumin.append(variable[i])
                            xiqumin.append("∧")
                    else:
                        if value1[vlen - 1] is 0:
                            xiqumin.append("!")
                            xiqumin.append(variable[vlen - 1])
                        else:
                            xiqumin.append(variable[vlen - 1])
                    xiqumin.append(")")
                count1=count1+1
            else:
                if count2 is not 0:
                    hequmin.append("∧")
                    hequmin.append("(")
                    for i in range(0, vlen - 1):
                        if value1[i] is 1:
                            hequmin.append(variable[i])
                            hequmin.append("∨")
                        else:
                            hequmin.append("!")
                            hequmin.append(variable[i])
                            hequmin.append("∨")
                    else:
                        if value1[vlen - 1] is 0:
                            hequmin.append("!")
                            hequmin.append(variable[vlen - 1])
                        else:
                            hequmin.append(variable[vlen - 1])
                    hequmin.append(")")
                else:
                    hequmin.append("(")
                    for i in range(0, vlen - 1):
                        if value1[i] is 1:
                            hequmin.append(variable[i])
                            hequmin.append("∨")
                        else:
                            hequmin.append("!")
                            hequmin.append(variable[i])
                            hequmin.append("∨")
                    else:
                        if value1[vlen - 1] is 0:
                            hequmin.append("!")
                            hequmin.append(variable[vlen - 1])
                        else:
                            hequmin.append(variable[vlen - 1])
                    hequmin.append(")")
                count2=count2+1
        shuchuxiqu.set(xiqumin)
        shuchuhequ.set(hequmin)
    except ValueError:
        pass

root = Tk()
root.title("范式计算器")

mainframe = ttk.Frame(root, padding="15 5 15 5") #分别改变左侧，上方，右侧，下方宽度
mainframe.grid(column=0, row=0, sticky=(N, W, E, S))
mainframe.columnconfigure(0, weight=1)
mainframe.rowconfigure(0, weight=1)

shuru=StringVar()
shuchuxiqu=StringVar()
shuchuhequ=StringVar()

fanshi_entry=ttk.Entry(mainframe,width=80,textvariable=shuru)
fanshi_entry.grid(column=1, row=2, columnspan=7,sticky=W)

ttk.Label(mainframe, text="请输入一个任意命题公式(原子命题用字母表示,'!'表示非 '&'表示合取 '|'表示析取 '>'表示蕴含 ':'表示等价 ,可用括号'( )':").grid(row=1, columnspan=800, sticky=W)
ttk.Label(mainframe, text="命题公式为：").grid(column=0, row=2, sticky=W)
ttk.Label(mainframe, text="析取式为：").grid(column=0, row=6, sticky=W)
ttk.Label(mainframe, text="合取式为：").grid(column=0, row=7, sticky=W)

def callback(num):
    furm = shuru.get()+num
    shuru.set(furm)

def clear_():
    shuru.set("")
    shuchuxiqu.set("")
    shuchuhequ.set("")
    xiqumin.clear()
    hequmin.clear()
    variable.clear()

ttk.Label(mainframe,textvariable=shuchuxiqu).grid(column=1, row=6, columnspan=800, sticky=W)
ttk.Label(mainframe,textvariable=shuchuhequ).grid(column=1, row=7, columnspan=800, sticky=W)
Button(mainframe,text="计算",command=getresult).grid(column=7, row=8, sticky=W)
Button(mainframe, text="&", command=lambda: callback("&")).grid(row=3, column=1,sticky=W)
Button(mainframe, text="|", command=lambda: callback("|")).grid(row=3, column=2,sticky=W)
Button(mainframe, text=">", command=lambda: callback(">")).grid(row=3, column=3,sticky=W)
Button(mainframe, text="!", command=lambda: callback("!")).grid(row=3, column=4,sticky=W)
Button(mainframe, text=":", command=lambda: callback(":")).grid(row=3, column=5,sticky=W)
Button(mainframe, text="(", command=lambda: callback("(")).grid(row=3, column=6,sticky=W)
Button(mainframe, text=")", command=lambda: callback(")")).grid(row=3, column=7,sticky=W)
Button(mainframe, text="p", command=lambda: callback("p")).grid(row=4, column=1,sticky=W)
Button(mainframe, text="q", command=lambda: callback("q")).grid(row=4, column=2,sticky=W)
Button(mainframe, text="r", command=lambda: callback("r")).grid(row=4, column=3,sticky=W)
Button(mainframe, text="a", command=lambda: callback("a")).grid(row=4, column=4,sticky=W)
Button(mainframe, text="b", command=lambda: callback("b")).grid(row=4, column=5,sticky=W)
Button(mainframe, text="c", command=lambda: callback("c")).grid(row=4, column=6,sticky=W)
Button(mainframe, text="d", command=lambda: callback("d")).grid(row=4, column=7,sticky=W)
Button(mainframe, text="清除", command=clear_,).grid(row=9, column=7,sticky=W)

for child in mainframe.winfo_children(): child.grid_configure(padx=5, pady=5)
fanshi_entry.focus()#feed_entry聚焦，这样打开程序，光标就会自动在输入框里，不用鼠标点击再输入了
root.bind('<Return>', getresult)#第三行，通过主窗体的bind()方法，监听回车键，触发calculate方法
root.mainloop()