#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Dec 20 20:24:52 2018

@author: hantao.li

用于生成报告中演示代码
"""
import re

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
        

        
    print('out=',out[i],'E=',list(set(E)),'A=',list(set(A)),'B=',list(set(B)),
          'C=',list(set(C)),'AB=',list(set(AB)),'AC=',list(set(AC)),'BC=',
          list(set(BC)),'ABC=',list(set(ABC)))
        

#out[0] = '∅'
#print(out)