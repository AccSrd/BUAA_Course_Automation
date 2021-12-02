# -*- coding: utf-8 -*-
"""
Created on Thu Dec 20 16:31:47 2018

@author: 13248

子程序，用于检验两个表达式是否相等，方法为计算集合
"""
import re


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
for i in range(len(out)):
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
    
    formula = 'A∪sB'
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
                    if formula_list[i] != [] and i == 0:
                        errorcode = 4
                        i += 1
                        continue
                    elif ((formula_list[i-1] == '(') or (formula_list[i+1] == ')')
                    or (formula_list[i+1] != [] and set(formula_list[i+1]).issubset(set(Vital_list)))
                    or (formula_list[i-1] != [] and set(formula_list[i-1]).issubset(set(Vital_list)))):
                        errorcode = 4
                        print (errorcode)
                        print (formula_list)
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
        result1 = ['()budeng']
    elif errorcode == 2:
        result1 = ['chongfu']
    elif errorcode == 3:
        result1 = ['abc']
    elif errorcode == 4:
        result1 = ['gongshicuo']
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
        
    formula = 'B∪A))'
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
                if (set(formula_list[i]).issubset(set(Vital_list))):
                    if i == 0:
                        errorcode = 4
                        i += 1
                        continue
                    elif ((formula_list[i-1] == '(') or (formula_list[i+1] == ')')
                    or set(formula_list[i+1]).issubset(set(Vital_list))
                    or set(formula_list[i-1]).issubset(set(Vital_list))):
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
            
    if errorcode == 1:
        result2 = ['()budeng']
    elif errorcode == 2:
        result2 = ['chongfu']
    elif errorcode == 3:
        result2 = ['abc']
    elif errorcode == 4:
        result2 = ['gongshicuo']
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
    result = 'nooooooo'
else:
    result = 'yessssss!!!'
print(result)
    
    
    
#    print(result[0])
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
