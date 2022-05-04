# -*- coding: utf-8 -*-
"""
Created on Wed Dec 19 14:13:19 2018

@author: 13248
"""

import tkinter as tk
import re
#import tkinter.Massagebox
def ClickButtonSetcal():
    window_Setcal = tk.Toplevel(window_Entry)
    window_Setcal.title('集合运算器')
    window_Setcal.geometry('600x600')
    
    var_answer = tk.StringVar()
    var_answer.set('注意!若未设置全集E,则全集E默认为A∪B∪C∪D！')
    var_inset = tk.StringVar()
    var_formula = tk.StringVar()
    
    en = tk.Entry(window_Setcal,show=None,textvariable=var_inset,width=40)
    en.place(x=20,y=225)
    en_formula = tk.Entry(window_Setcal,show=None,textvariable=var_formula,width=60)
    en_formula.place(x=20,y=325)
    
    tk.Label(window_Setcal, text='集合A: ').place(x=20, y= 20)
    tk.Label(window_Setcal, text='集合B: ').place(x=20, y= 50)
    tk.Label(window_Setcal, text='集合C: ').place(x=20, y= 80)
    tk.Label(window_Setcal, text='集合D: ').place(x=20, y= 110)
    tk.Label(window_Setcal, text='全集E: ').place(x=20, y= 140)
    tk.Label(window_Setcal, text='请输入要插入集合的元素：').place(x=20,y=200)
    tk.Label(window_Setcal, text='请输入集合算式：').place(x=20,y=300)
    
    setA = tk.StringVar()
    setA.set('∅')
    setB = tk.StringVar()
    setB.set('∅')
    setC = tk.StringVar()
    setC.set('∅')
    setD = tk.StringVar()
    setD.set('∅')
    setE = tk.StringVar()
    setE.set('∅')
    
    tk.Label(window_Setcal,height=1,textvariable=setA).place(x=70,y=20)
    tk.Label(window_Setcal,height=1,textvariable=setB).place(x=70,y=50)
    tk.Label(window_Setcal,height=1,textvariable=setC).place(x=70,y=80)
    tk.Label(window_Setcal,height=1,textvariable=setD).place(x=70,y=110)
    tk.Label(window_Setcal,height=1,textvariable=setE).place(x=70,y=140)
    ANSWER = tk.Label(window_Setcal,height=5,textvariable=var_answer)
    ANSWER.place(x=20,y=450)
    
    
    def insertA():         #将输入的元素插入集合
        inset = var_inset.get()
        x = setA.get()
        if inset != '':
            if x == '∅':
                setA.set(inset)
            else:    
                setA.set(x+','+inset)
                
    def insertB():
        inset = var_inset.get()
        x = setB.get()
        if inset != '':
            if x == '∅':
                setB.set(inset)
            else:    
                setB.set(x+','+inset)
                
    def insertC():
        inset = var_inset.get()
        x = setC.get()
        if inset != '':
            if x == '∅':
                setC.set(inset)
            else:    
                setC.set(x+','+inset)
                
    def insertD():
        inset = var_inset.get()
        x = setD.get()
        if inset != '':
            if x == '∅':
                setD.set(inset)
            else:    
                setD.set(x+','+inset)
                
    def insertE():
        inset = var_inset.get()
        x = setE.get()
        if inset != '':
            if x == '∅':
                setE.set(inset)
            else:    
                setE.set(x+','+inset)
                
    def GoCalculate():    #点击计算按钮
        True_list = ['A','B','C','D','E','∪','∩','⊕','-','~','(',')']
        Vital_list = ['∪','∩','⊕','-']
        var_answer.set('')
        strA = setA.get()         #将集合中元素提取，变为列表
        A0 = strA.split(',')
        setA0 = set(A0)
        A = list(setA0)
        if len(A)==1:
            if A[0]=='∅':
                A = []
        
        strB = setB.get()
        B0 = strB.split(',')
        setB0 = set(B0)
        B = list(setB0)
        if len(B)==1:
            if B[0]=='∅':
                B = []
        
        strC = setC.get()
        C0 = strC.split(',')
        setC0 = set(C0)
        C = list(setC0)
        if len(C)==1:
            if C[0]=='∅':
                C = []
        
        strD = setD.get()
        D0 = strD.split(',')
        setD0 = set(D0)
        D = list(setD0)
        if len(D)==1:
            if D[0]=='∅':
                D = []
        
        strE = setE.get()
        E0 = strE.split(',')
        setE0 = set(E0)
        E = list(setE0)
        if len(E)==1:
            if E[0]=='∅':
                E = []
             
        if E == []:   
            E = list(set(A).union(set(B)).union(set(C)).union(set(D)))
            
        
        def check_operator(e):  #如果是运算符，返回True
            operators = ['∪','∩','⊕','-','~','(',')']
            return True if e in operators else False
        
        
        def formula_format(formula):#将公式列表中集合符号替代为集合中元素
            formula = re.sub(' ','',formula)
            formulalist0 = list(formula)
            formulalistA = [A if x == 'A' else x for x in formulalist0]
            formulalistB = [B if x == 'B' else x for x in formulalistA]
            formulalistC = [C if x == 'C' else x for x in formulalistB]
            formulalistD = [D if x == 'D' else x for x in formulalistC]
            formulalist = [E if x == 'E' else x for x in formulalistD]
            return formulalist
        #    final_formula = []
        #    item_spilt = [i for i in re.split('∪∩⊕-~()',item) if i]
        #    final_formula += item_spilt
            
        
        def calculate(set1,set2,operator,E):  #定义运算
            result = 0
            if operator == '∪':
                result = list(set(set1).union(set(set2)))
            if operator == '∩':
                result = list(set(set1).intersection(set(set2)))
            if operator == '⊕':
                result = list((set(set1).difference(set(set2))).
                              union(set(set2).difference(set(set1))))
            if operator == '-':
                result = list(set(set1).difference(set(set2)))
            if operator == '~':
                result = list(set(E).difference(set(set1)))
            return result
        
        
        def decision(tail_op,now_op):
            rate1 = ['∪','∩','⊕','-']#设定优先级
            rate2 = ['~']
            rate3 = ['(']
            rate4 = [')']
        #-1入栈   0一起弹出   1出栈
            if tail_op in rate1:
                if now_op in rate2 or now_op in rate3:
                    return -1
                else:
                    return 1
            #栈顶为低优先级运算，新运算符号为~或（入栈，同为低优先级则出栈
            elif tail_op in rate2:
                if now_op in rate3:
                    return -1
                else:
                    return 1
            #栈顶为~，只有（入栈，其他出栈    
            elif tail_op in rate3:
                if now_op in rate4:
                    return 0
                else:
                    return -1
            #栈顶为（，除）以外全部入栈    
            else:
                return -1
            #栈顶为），全部入栈
            
        formula = en_formula.get()#获取输入框中公式
        i = 0
        errorcode = 0#'A∪(~B-C）'#'A∪（(B∩C)∩(D∩A)）'
        formula_list = formula_format(formula)
        formula = re.sub(' ','',formula)
        formulalist0 = list(formula)
        if (set(formulalist0).issubset(set(True_list))):#检查公式合法性
            if (formula_list.count('(')) != (formula_list.count(')')):
                errorcode = 1
            else:
                while i < len(formula_list)-1:
                    if (formula_list[i] != [] and set(formula_list[i]).issubset(set(Vital_list))):
                        if i == 0:
                            errorcode = 4
                            i += 1
                            continue
                        elif ((formula_list[i-1] == '(') or (formula_list[i+1] == ')')
                    or (formula_list[i+1] != [] and set(formula_list[i+1]).issubset(set(Vital_list)))
                    or (formula_list[i-1] != [] and set(formula_list[i-1]).issubset(set(Vital_list)))):
                            errorcode = 4
                            i += 1
                            continue
                        else:
                            i += 1
                            continue
                    elif formula_list[i] == '~':
                        if formula_list[i+1] == ')' or formula_list[i-1] == ')':
                            errorcode =4
                            i += 1
                            continue
                        else:
                            i += 1
                            continue
                    elif formula_list[i] == formula_list[i+1]:
                        if formula_list[i] == '~' :
                            del formula_list[i]
                            del formula_list[i]
                        elif ((formula_list[i] != '(') and (formula_list[i] != ')')):
                            errorcode = 2
                            i += 1
                            continue
                        else:
                            i += 1
                            continue
                    else:
                            i += 1
        else:
            errorcode = 3
        
        if errorcode == 1:#若公式不合法，则报错
            var_answer.set('ERROR!左右括号数量不等!请检查公式!')
        elif errorcode == 2:
            var_answer.set('ERROR!存在重复字符!请检查公式!')
        elif errorcode == 3:
            var_answer.set('ERROR!存在非法字符!请不要使用键盘输入!')
        elif errorcode == 4:
            var_answer.set('ERROR!公式不合法!请检查公式!')
#def final_clac(formula_list,A,B,C,D,E):
#        if errorcode == 1:
#            var_answer.set('error!1')
        else:    
            #def final_clac(formula_list,A,B,C,D,E):
            set_stack = []
            op_stack = []
            for e in formula_list:
                operator = check_operator(e)
                if not operator:     #是集合，则入集合栈
                    set_stack.append(e)
                else:                #是运算符号
                    while True:
                        if len(op_stack) == 0:
                            op_stack.append(e)
                            break         #符号栈长度为0，直接入栈
                        
                        tag = decision(op_stack[-1],e)
                        if tag == -1:     #入栈
                            op_stack.append(e)
                            break
                        elif tag == 0:
                            op_stack.pop()
                            break
                        elif tag == 1:
                            op = op_stack.pop()
                            if op == '~':
                                set1 = set_stack.pop()
                                set_stack.append(calculate(set1,set1,op,E))
                            else:#弹栈计算
                                set2 = set_stack.pop()
                                set1 = set_stack.pop()
                                set_stack.append(calculate(set1,set2,op,E))
            while len(op_stack) != 0:#循环完结后若符号栈还有元素，再进行一次运算
                op = op_stack.pop()
                if op == '~':
                    set1 = set_stack.pop()
                    set_stack.append(calculate(set1,set1,op,E))
                else:
                    set2 = set_stack.pop()
                    set1 = set_stack.pop()
                    set_stack.append(calculate(set1,set2,op,E))
            result = set_stack
            if result[0] == []:
                result[0] = '∅'
            var_answer.set(result[0])

    
    def CALinsertA():         #用户输入公式
        en_formula.insert('insert','A')
#        var_answer.set(var_formula.get())
    def CALinsertB():
        en_formula.insert('insert','B')
    def CALinsertC():
        en_formula.insert('insert','C')
    def CALinsertD():
        en_formula.insert('insert','D')
    def CALinsertE():
        en_formula.insert('insert','E')
    def CALinsertOR():
        en_formula.insert('insert','∪')
    def CALinsertAND():
        en_formula.insert('insert','∩')
    def CALinsertDDIF():
        en_formula.insert('insert','⊕')
    def CALinsertNOT():
        en_formula.insert('insert','~')
    def CALinsertDIF():
        en_formula.insert('insert','-')
    def CALinsertBRA():
        en_formula.insert('insert','()')
        
    def RESET():          #清零，方便下次输入
        setA.set('∅')
        setB.set('∅')
        setC.set('∅')
        setD.set('∅')
        setE.set('∅')
        var_answer.set('注意!若未设置全集E,则全集E默认为A∪B∪C∪D！')
        var_inset.set('')
        var_formula.set('')
    
    
    b_inA = tk.Button(window_Setcal,text='插入集合A',command=insertA)
    b_inA.place(x=20,y=260)
    b_inB = tk.Button(window_Setcal,text='插入集合B',command=insertB)
    b_inB.place(x=100,y=260)
    b_inC = tk.Button(window_Setcal,text='插入集合C',command=insertC)
    b_inC.place(x=180,y=260)
    b_inD = tk.Button(window_Setcal,text='插入集合D',command=insertD)
    b_inD.place(x=260,y=260)
    b_inE = tk.Button(window_Setcal,text='插入全集E',command=insertE)
    b_inE.place(x=340,y=260)
    b_cal = tk.Button(window_Setcal,text='计算',height=2,bg='red',command=GoCalculate)
    b_cal.place(x=20,y=410)
    b_re = tk.Button(window_Setcal,text='清空',height=2,bg='green',command=RESET)
    b_re.place(x=100,y=410)    
    b_A = tk.Button(window_Setcal,text='A',command=CALinsertA)
    b_A.place(x=20,y=360)
    b_B = tk.Button(window_Setcal,text='B',command=CALinsertB)
    b_B.place(x=70,y=360)
    b_C = tk.Button(window_Setcal,text='C',command=CALinsertC)
    b_C.place(x=120,y=360)
    b_D = tk.Button(window_Setcal,text='D',command=CALinsertD)
    b_D.place(x=170,y=360)
    b_E = tk.Button(window_Setcal,text='E',command=CALinsertE)
    b_E.place(x=220,y=360)
    b_OR = tk.Button(window_Setcal,text='∪',command=CALinsertOR)
    b_OR.place(x=270,y=360)
    b_AND = tk.Button(window_Setcal,text='∩',command=CALinsertAND)
    b_AND.place(x=320,y=360)
    b_DDIF = tk.Button(window_Setcal,text='⊕',command=CALinsertDDIF)
    b_DDIF.place(x=370,y=360)
    b_NOT = tk.Button(window_Setcal,text='~',command=CALinsertNOT)
    b_NOT.place(x=420,y=360)
    b_DIF = tk.Button(window_Setcal,text='-',command=CALinsertDIF)
    b_DIF.place(x=470,y=360)
    b_BRA = tk.Button(window_Setcal,text='()',command=CALinsertBRA)
    b_BRA.place(x=520,y=360)




def ClickButtonPowerSet():
    window_PowerSet = tk.Toplevel(window_Entry)
    window_PowerSet.title('幂集计算器')
    window_PowerSet.geometry('440x350')
    
    var_inset = tk.StringVar()
    en = tk.Entry(window_PowerSet,show=None,textvariable=var_inset,width=40)
    en.place(x=20,y=75)
    var_answer = tk.StringVar()
    tk.Label(window_PowerSet, text='集合: ').place(x=20, y=20)
    ANSWER = tk.Label(window_PowerSet,wraplength=400,textvariable=var_answer)
    ANSWER.place(x=20,y=220)
    
    setA = tk.StringVar()
    setA.set('∅')
    
    tk.Label(window_PowerSet,height=1,textvariable=setA).place(x=70,y=20)
    
    def insertA():
        inset = var_inset.get()
        x = setA.get()
        if inset != '':
            if x == '∅':
                setA.set(inset)
            else:    
                setA.set(x+','+inset)

    b_inA = tk.Button(window_PowerSet,text='将元素插入集合',command=insertA)
    b_inA.place(x=20,y=110)
    
    def RESET():
        setA.set('∅')
        var_answer.set('')
        var_inset.set('')
    
    def GoCalculate():
        var_answer.set('')
        strA = setA.get()
        A0 = strA.split(',')
        setA0 = set(A0)#获取元素
        A = list(setA0)
        if len(A)==1:
            if A[0]=='∅':
                A = []
                
        
        def PowerSetsBinary(items):              #算法详情见文档 
            N = len(items)    
            set_all=[]
            
            for i in range(2**N):
                combo = []  
                for j in range(N):                      
                    if(i >> j) % 2 == 1:  #找到二级制数中为1的位数
                        combo.append(items[j])                         
                set_all.append(combo)                
            return set_all
        
        out= PowerSetsBinary(A)
        out[0] = '∅'
        var_answer.set(out)
    
    b_cal = tk.Button(window_PowerSet,text='计算',height=2,bg='red',command=GoCalculate)
    b_cal.place(x=20,y=170)
    b_re = tk.Button(window_PowerSet,text='清空',height=2,bg='green',command=RESET)
    b_re.place(x=100,y=170)    



def ClickButtonPr():
    window_Pr = tk.Toplevel(window_Entry)
    window_Pr.title('集合恒等式证明器')
    window_Pr.geometry('600x420')
    
    tk.Label(window_Pr, text='公式一:').place(x=20, y=20)    
    tk.Label(window_Pr, text='公式二:').place(x=20, y=150)
    var_inset1 = tk.StringVar()
    en1 = tk.Entry(window_Pr,show=None,textvariable=var_inset1,width=40)
    en1.place(x=100,y=20)
    var_inset2 = tk.StringVar()
    en2 = tk.Entry(window_Pr,show=None,textvariable=var_inset2,width=40)
    en2.place(x=100,y=150)
    
    def CALinsertA1():
        en1.insert('insert','A')
    def CALinsertB1():
        en1.insert('insert','B')
    def CALinsertC1():
        en1.insert('insert','C')
    def CALinsertE1():
        en1.insert('insert','E')
    def CALinsertOR1():
        en1.insert('insert','∪')
    def CALinsertAND1():
        en1.insert('insert','∩')
    def CALinsertDDIF1():
        en1.insert('insert','⊕')
    def CALinsertNOT1():
        en1.insert('insert','~')
    def CALinsertDIF1():
        en1.insert('insert','-')
    def CALinsertBRA1():
        en1.insert('insert','()')
        
    b_A1 = tk.Button(window_Pr,text='A',command=CALinsertA1)
    b_A1.place(x=20,y=70)
    b_B1 = tk.Button(window_Pr,text='B',command=CALinsertB1)
    b_B1.place(x=70,y=70)
    b_C1 = tk.Button(window_Pr,text='C',command=CALinsertC1)
    b_C1.place(x=120,y=70)
    b_E1 = tk.Button(window_Pr,text='E',command=CALinsertE1)
    b_E1.place(x=170,y=70)
    b_OR1 = tk.Button(window_Pr,text='∪',command=CALinsertOR1)
    b_OR1.place(x=220,y=70)
    b_AND1 = tk.Button(window_Pr,text='∩',command=CALinsertAND1)
    b_AND1.place(x=270,y=70)
    b_DDIF1 = tk.Button(window_Pr,text='⊕',command=CALinsertDDIF1)
    b_DDIF1.place(x=320,y=70)
    b_NOT1 = tk.Button(window_Pr,text='~',command=CALinsertNOT1)
    b_NOT1.place(x=370,y=70)
    b_DIF1 = tk.Button(window_Pr,text='-',command=CALinsertDIF1)
    b_DIF1.place(x=420,y=70)
    b_BRA1 = tk.Button(window_Pr,text='()',command=CALinsertBRA1)
    b_BRA1.place(x=470,y=70)

    def CALinsertA2():
        en2.insert('insert','A')
    def CALinsertB2():
        en2.insert('insert','B')
    def CALinsertC2():
        en2.insert('insert','C')
    def CALinsertE2():
        en2.insert('insert','E')
    def CALinsertOR2():
        en2.insert('insert','∪')
    def CALinsertAND2():
        en2.insert('insert','∩')
    def CALinsertDDIF2():
        en2.insert('insert','⊕')
    def CALinsertNOT2():
        en2.insert('insert','~')
    def CALinsertDIF2():
        en2.insert('insert','-')
    def CALinsertBRA2():
        en2.insert('insert','()')
        
    b_A2 = tk.Button(window_Pr,text='A',command=CALinsertA2)
    b_A2.place(x=20,y=200)
    b_B2 = tk.Button(window_Pr,text='B',command=CALinsertB2)
    b_B2.place(x=70,y=200)
    b_C2 = tk.Button(window_Pr,text='C',command=CALinsertC2)
    b_C2.place(x=120,y=200)
    b_E2 = tk.Button(window_Pr,text='E',command=CALinsertE2)
    b_E2.place(x=170,y=200)
    b_OR2 = tk.Button(window_Pr,text='∪',command=CALinsertOR2)
    b_OR2.place(x=220,y=200)
    b_AND2 = tk.Button(window_Pr,text='∩',command=CALinsertAND2)
    b_AND2.place(x=270,y=200)
    b_DDIF2 = tk.Button(window_Pr,text='⊕',command=CALinsertDDIF2)
    b_DDIF2.place(x=320,y=200)
    b_NOT2 = tk.Button(window_Pr,text='~',command=CALinsertNOT2)
    b_NOT2.place(x=370,y=200)
    b_DIF2 = tk.Button(window_Pr,text='-',command=CALinsertDIF2)
    b_DIF2.place(x=420,y=200)
    b_BRA2 = tk.Button(window_Pr,text='()',command=CALinsertBRA2)
    b_BRA2.place(x=470,y=200)
        
    err1 = tk.StringVar()
    err2 = tk.StringVar()
    answer = tk.StringVar()
    
    def RESET():
        var_inset1.set('')
        var_inset2.set('')
        err1.set('')
        err2.set('')
        answer.set('')
        
    def GoPr():
        True_list = ['A','B','C','E','∪','∩','⊕','-','~','(',')']
        Vital_list = ['∪','∩','⊕','-']
        
        def check_operator(e):  #如果是运算符，返回True
            operators = ['∪','∩','⊕','-','~','(',')']
            return True if e in operators else False
        
        
        def formula_format(formula):
            formula = re.sub(' ','',formula)
            formulalist0 = list(formula)
            formulalistA = [A if x == 'A' else x for x in formulalist0]
            formulalistB = [B if x == 'B' else x for x in formulalistA]
            formulalistC = [C if x == 'C' else x for x in formulalistB]
            formulalist = [E if x == 'E' else x for x in formulalistC]
            return formulalist
        #    final_formula = []
        #    item_spilt = [i for i in re.split('∪∩⊕-~()',item) if i]
        #    final_formula += item_spilt
            
        
        def calculate(set1,set2,operator,E):  #定义运算
            result = 0
            if operator == '∪':
                result = list(set(set1).union(set(set2)))
            if operator == '∩':
                result = list(set(set1).intersection(set(set2)))
            if operator == '⊕':
                result = list((set(set1).difference(set(set2))).
                              union(set(set2).difference(set(set1))))
            if operator == '-':
                result = list(set(set1).difference(set(set2)))
            if operator == '~':
                result = list(set(E).difference(set(set1)))
            return result
        
        
        def decision(tail_op,now_op):
            rate1 = ['∪','∩','⊕','-']
            rate2 = ['~']
            rate3 = ['(']
            rate4 = [')']
        #-1入栈   0一起弹出   1出栈
            if tail_op in rate1:
                if now_op in rate2 or now_op in rate3:
                    return -1
                else:
                    return 1
            #栈顶为低优先级运算，新运算符号为~或（入栈，同为低优先级则出栈
            elif tail_op in rate2:
                if now_op in rate3:
                    return -1
                else:
                    return 1
            #栈顶为~，只有（入栈，其他出栈    
            elif tail_op in rate3:
                if now_op in rate4:
                    return 0
                else:
                    return -1
            #栈顶为（，除）以外全部入栈    
            else:
                return -1
            #栈顶为），全部入栈
            
        def PowerSetsBinary(items):   
            
            N = len(items)    
            set_all=[]
            
            for i in range(2**N):
                combo = []  
                
                for j in range(N):  
                    
                    if(i >> j) % 2 == 1:  #找到二级制数中为1的位数
        #                print('i=',i,'j=',j)
                        combo.append(items[j]) 
                        
                set_all.append(combo)
                
            return set_all
        
        
        a=list(['1','2','3','4','5','6','7','8'])
        out= PowerSetsBinary(a)
        check = []
        for i in range(len(out)):#算法详情见文档
            A=[]
            B=[]
            C=[]
            AB=[]
            AC=[]
            BC=[]
            ABC=[]
            E=[]
            if ('1' in out[i]):
                E.append('E')
            if ('2' in out[i]):
                A.append('A')
                E.append('A')
            if ('3' in out[i]):
                B.append('B')
                E.append('B')
            if ('4' in out[i]):
                C.append('C')
                E.append('C')
            if ('5' in out[i]):
                A.append('AB')
                B.append('AB')
                AB.append('AB')
                E.append('AB')
            if ('6' in out[i]):
                A.append('AC')
                C.append('AC')
                AC.append('AC')
                E.append('AC')
            if ('7' in out[i]):
                B.append('BC')
                C.append('BC')
                BC.append('BC')
                E.append('BC')
            if ('8' in out[i]):
                A.append('ABC')
                B.append('ABC')
                C.append('ABC')
                AB.append('ABC')
                AC.append('ABC')
                BC.append('ABC')
                E.append('ABC')
                
            A=list(set(A))
            B=list(set(B))
            C=list(set(C))
            AB=list(set(AB))
            AC=list(set(AC))
            BC=list(set(BC))
            ABC=list(set(ABC))
            E=list(set(E))
            
            formula = en1.get()
            i = 0
            errorcode = 0#'A∪(~B-C）'#'A∪（(B∩C)∩(D∩A)）'
            formula_list = formula_format(formula)
            formula = re.sub(' ','',formula)
            formulalist0 = list(formula)
            if (set(formulalist0).issubset(set(True_list))):
                if (formula_list.count('(')) != (formula_list.count(')')):
                    errorcode = 1
                else:
                    while i < len(formula_list)-1:
                        if (formula_list[i] != [] and set(formula_list[i]).issubset(set(Vital_list))):
                            if i == 0:
                                errorcode = 4
                                i += 1
                                continue
                            elif ((formula_list[i-1] == '(') or (formula_list[i+1] == ')')
                            or (formula_list[i+1] != [] and set(formula_list[i+1]).issubset(set(Vital_list)))
                            or (formula_list[i-1] != [] and set(formula_list[i-1]).issubset(set(Vital_list)))):
                                errorcode = 4
                                i += 1
                                continue
                            else:
                                i += 1
                                continue
                        elif formula_list[i] == '~':
                            if formula_list[i+1] == ')' or formula_list[i-1] == ')':
                                errorcode = 4
                                i += 1
                                continue
                            else:
                                i += 1
                                continue
                        elif formula_list[i] == formula_list[i+1]:
                            if formula_list[i] == '~' :
                                del formula_list[i]
                                del formula_list[i]
                            elif ((formula_list[i] != '(') and (formula_list[i] != ')')):
                                errorcode = 2
                                i += 1
                                continue
                            else:
                                i += 1
                                continue
                        else:
                                i += 1
            else:
                errorcode = 3
                    
            if errorcode == 1:
                err1.set('ERROR!公式一左右括号数量不等!请检查公式!')
            elif errorcode == 2:
                err1.set('ERROR!公式一存在重复字符!请检查公式!')
            elif errorcode == 3:
                err1.set('ERROR!公式一存在非法字符!请不要使用键盘输入!')
            elif errorcode == 4:
                err1.set('ERROR!公式一不合法!请检查公式!')
            #def final_clac(formula_list,A,B,C,D,E):
            elif errorcode == 0:
                set_stack = []
                op_stack = []
                for e in formula_list:
                    operator = check_operator(e)
                    if not operator:     #是集合，则入集合栈
                        set_stack.append(e)
                    else:                #是运算符号
                        while True:
                            if len(op_stack) == 0:
                                op_stack.append(e)
                                break         #符号栈长度为0，直接入栈
                            
                            tag = decision(op_stack[-1],e)
                            if tag == -1:     #入栈
                                op_stack.append(e)
                                break
                            elif tag == 0:
                                op_stack.pop()
                                break
                            elif tag == 1:
                                op = op_stack.pop()
                                if op == '~':
                                    set1 = set_stack.pop()
                                    set_stack.append(calculate(set1,set1,op,E))
                                else:
                                    set2 = set_stack.pop()
                                    set1 = set_stack.pop()
                                    set_stack.append(calculate(set1,set2,op,E))
                while len(op_stack) != 0:
                    op = op_stack.pop()
                    if op == '~':
                        set1 = set_stack.pop()
                        set_stack.append(calculate(set1,set1,op,E))
                    else:
                        set2 = set_stack.pop()
                        set1 = set_stack.pop()
                        set_stack.append(calculate(set1,set2,op,E))
                
                        
                #    return set_stack,op_stack
                                    
                #formula = 'A∪B∪C∪D'
                #formula_list = formula_format(formula)
                #result,_ = final_clac(formula_list,A,B,C,D,E)
                result1 = set_stack
                
            formula = en2.get()
            i = 0
            errorcode = 0#'A∪(~B-C）'#'A∪（(B∩C)∩(D∩A)）'
            formula_list = formula_format(formula)
            formula = re.sub(' ','',formula)
            formulalist0 = list(formula)
            if (set(formulalist0).issubset(set(True_list))):
                if (formula_list.count('(')) != (formula_list.count(')')):
                    errorcode = 1
                else:
                    while i < len(formula_list)-1:
                        if (formula_list[i] != [] and set(formula_list[i]).issubset(set(Vital_list))):
                            if i == 0:
                                errorcode = 4
                                i += 1
                                continue
                            elif ((formula_list[i-1] == '(') or (formula_list[i+1] == ')')
                    or (formula_list[i+1] != [] and set(formula_list[i+1]).issubset(set(Vital_list)))
                    or (formula_list[i-1] != [] and set(formula_list[i-1]).issubset(set(Vital_list)))):
                                errorcode = 4
                                i += 1
                                continue
                            else:
                                i += 1
                                continue
                        elif formula_list[i] == '~':
                            if formula_list[i+1] == ')' or formula_list[i-1] == ')':
                                errorcode = 4
                                i += 1
                                continue
                            else:
                                i += 1
                                continue
                        elif formula_list[i] == formula_list[i+1]:
                            if formula_list[i] == '~' :
                                del formula_list[i]
                                del formula_list[i]
                            elif ((formula_list[i] != '(') and (formula_list[i] != ')')):
                                errorcode = 2
                                i += 1
                                continue
                            else:
                                i += 1
                                continue
                        else:
                                i += 1
            else:
                errorcode = 3
                    
                    
            if errorcode == 1:
                err2.set('ERROR!公式二左右括号数量不等!请检查公式!')
            elif errorcode == 2:
                err2.set('ERROR!公式二存在重复字符!请检查公式!')
            elif errorcode == 3:
                err2.set('ERROR!公式二存在非法字符!请不要使用键盘输入!')
            elif errorcode == 4:
                err2.set('ERROR!公式二不合法!请检查公式!')
            #def final_clac(formula_list,A,B,C,D,E):
            elif errorcode == 0:
                set_stack = []
                op_stack = []
                for e in formula_list:
                    operator = check_operator(e)
                    if not operator:     #是集合，则入集合栈
                        set_stack.append(e)
                    else:                #是运算符号
                        while True:
                            if len(op_stack) == 0:
                                op_stack.append(e)
                                break         #符号栈长度为0，直接入栈
                            
                            tag = decision(op_stack[-1],e)
                            if tag == -1:     #入栈
                                op_stack.append(e)
                                break
                            elif tag == 0:
                                op_stack.pop()
                                break
                            elif tag == 1:
                                op = op_stack.pop()
                                if op == '~':
                                    set1 = set_stack.pop()
                                    set_stack.append(calculate(set1,set1,op,E))
                                else:
                                    set2 = set_stack.pop()
                                    set1 = set_stack.pop()
                                    set_stack.append(calculate(set1,set2,op,E))
                while len(op_stack) != 0:
                    op = op_stack.pop()
                    if op == '~':
                        set1 = set_stack.pop()
                        set_stack.append(calculate(set1,set1,op,E))
                    else:
                        set2 = set_stack.pop()
                        set1 = set_stack.pop()
                        set_stack.append(calculate(set1,set2,op,E))
                
                        
                #    return set_stack,op_stack
                                    
                #formula = 'A∪B∪C∪D'
                #formula_list = formula_format(formula)
                #result,_ = final_clac(formula_list,A,B,C,D,E)
                result2 = set_stack
                if set(result1[0]) == set(result2[0]):
                    check.append(1)
                else:
                    check.append(0)
            
        if 0 in check:
            answer.set('等式：“公式一 = 公式二” 不成立')
        elif check == []:
            answer.set('公式有误,请检查后重新输入!')
        else:
            answer.set('等式：“公式一 = 公式二” 成立')

#        print(result)
        
    
    tk.Label(window_Pr,height=1,textvariable=err1).place(x=70,y=300)    
    tk.Label(window_Pr,height=1,textvariable=err2).place(x=70,y=340)    
    tk.Label(window_Pr,height=1,textvariable=answer).place(x=70,y=380)
    
    b_cal = tk.Button(window_Pr,text='验证',height=2,bg='red',command=GoPr)
    b_cal.place(x=20,y=250)
    b_re = tk.Button(window_Pr,text='清空',height=2,bg='green',command=RESET)
    b_re.place(x=100,y=250)    




window_Entry = tk.Tk()
window_Entry.title('离散数学计算器')
window_Entry.geometry('400x220')

Lable_Info = tk.Label(text='请选择功能：').place(x=20,y=20)
tk.Label(text='本程序由160324小班16711094-李翰韬提供,感谢使用!').place(x=20,y=180)

Button_Setcal = tk.Button(window_Entry,text='集合运算器',width=20,height=2,command=ClickButtonSetcal)
Button_Setcal.place(x=120,y=20)
Button_PowerSet = tk.Button(window_Entry,text='幂集计算器',width=20,height=2,command=ClickButtonPowerSet)
Button_PowerSet.place(x=120,y=70)
Button_Pr = tk.Button(window_Entry,text='集合恒等式证明器',width=20,height=2,command=ClickButtonPr)
Button_Pr.place(x=120,y=120)

window_Entry.mainloop()
