#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jun 25 15:34:27 2020

@author: hantao.li

----Input:  (Data)The data giving by prof.
----Output: Fig. of the final formula and loss curve

The HW1 of ML part in ML course in Beihang spring 2020. 
Using Polynomial fitting and Gradient descent to fitting scatters.

2020spring，模式识别课程，ML部分第一次作业。将散点图拟合为曲线，选择两种方法：多项式拟合和梯度下降拟合。
根据输入散点(Data)，进行11阶多项式拟合、梯度下降拟合，并可自行指定初始A/W或随机得到。可输出拟合后图像。
"""

import matplotlib.pyplot as plt
import numpy as np
import random

Data = '-0.02583269 -0.04051301  0.12799861  0.14173928  0.17152477  0.2011345  0.2514499   0.26942975  0.22501756  0.28285966  0.31559904  0.32937735  0.51564061  0.42471355  0.55419245  0.64080295  0.51817686  0.44927417  0.5889517   0.80962372  0.48032986  0.43297626  0.6569534   0.71691291  0.52587894  0.66087249  0.62079964  0.74368168  0.56661974  0.50504992  0.44729499  0.35939382  0.30583365  0.25840365  0.06450455  0.21688696  0.09274139 -0.06697476  0.07592577  0.02670233  0.11388184 -0.09379051 -0.18439572 -0.17966559 -0.16315278 -0.26450209 -0.29813998 -0.40768861 -0.23685474 -0.4417905  -0.37100265 -0.53797068 -0.53370135 -0.62568814 -0.42158101 -0.64884222 -0.53725013 -0.65579792 -0.63923729 -0.6685564 -0.74057211 -0.40855252 -0.55777798 -0.66742682 -0.5380056  -0.41152255 -0.43906442 -0.53312085 -0.37285735 -0.41915559 -0.30230357 -0.32560979 -0.36956646 -0.25278871 -0.21815953 -0.12125635 -0.14723625 -0.1316458 -0.06763261  0.13135476 -0.00786488  0.17251539  0.00390189  0.23420464  0.03424298  0.31921242  0.46289181  0.38151237  0.31969485  0.55720336  0.32361329  0.67844812  0.64842566  0.43472184  0.58165945  0.55901493  0.74121444  0.6430677   0.6243773   0.64464953  0.53233577  0.64055675  0.62415506  0.40256586  0.43861789  0.52358594  0.66217108  0.4877558  0.41027396  0.21449227  0.2245596   0.24329612  0.46112313  0.19387336  0.17067689  0.25329545  0.01034272  0.05951573 -0.08156016 -0.01039697 -0.14914629 -0.29037328 -0.22990902 -0.24089382 -0.29532118 -0.34132541 -0.51587605 -0.53594197 -0.53559808 -0.35593396 -0.57340654 -0.62218798 -0.66848189 -0.72710317 -0.36642848 -0.58384893 -0.61940538 -0.41302691 -0.59320198 -0.66224973 -0.61647815 -0.69304147 -0.49728935 -0.46833321 -0.66194989 -0.5311272  -0.53975736 -0.52416066 -0.22056537 -0.40471053 -0.3511647  -0.26158341 -0.22755895 -0.21753077 -0.16181743 -0.00850077 -0.02816639 -0.03632056 -0.06225192  0.07980789  0.16114784  0.22501789  0.19651355  0.03039382  0.3050647   0.24537894  0.36461378  0.41820554  0.50340963  0.45723135  0.59927635  0.48420893  0.58802576  0.62976302  0.72999823  0.62190162  0.63555945  0.33838519  0.40757477  0.82995173  0.71600373  0.50335912  0.47322202  0.5808286   0.53369145  0.46285591  0.61058995  0.4309896   0.36806185  0.45229756  0.25896206  0.11139308  0.15846649  0.27199323  0.2427336   0.05156092  0.06794632  0.10848514  0.00216508 -0.07673958'
Data = list(map(float,Data.split()))  
x = np.linspace(0,len(Data)-1,len(Data))


#########Polynomial fitting#########
  
n_order = 11  # Set the order of polynomial fitting 
p = np.poly1d(np.polyfit(x, Data, n_order))
print(p.coeffs)
plt.plot(x, p(x), color = 'red')
plt.legend(['n = '+str(n_order),'Raw Data'], loc='lower right')
plt.savefig('./TASK1/n_'+str(n_order)+'.jpg',dpi=500)


#########Gradient descent#########

omega=random.random() #Set A/omega randomly.
A=random.random()

omega=0.078 #Set A/omega directly.
A=0.7


eta=0.05
time=500
Loss_1=np.zeros(time)

X = Data
t = x

def loss_function():
    L=0
    for i in range(len(t)):
        L=L+(A*np.sin(omega*t[i])-X[i])**2
    L = L/400
    return L

def div_omega():
    D_o=0
    for i in range(len(t)):
        D_o=D_o+(A*np.sin(omega*t[i])-X[i])*A*np.cos(omega*t[i])
    D_o = D_o/200
    return D_o

def div_A():
    D_A=0
    for i in range(len(t)):
        D_A=D_A+(A*np.sin(omega*t[i])-X[i])*np.sin(omega*t[i])
    D_A = D_A/200
    return D_A

def gradient_descent(cur,eta,d):
    return cur-eta*d

for j in range(time):       # method of gradient descent.
    Loss_1[j]=loss_function()
    pre=A*np.sin(omega*t)
    omega=gradient_descent(omega, eta, div_omega())
    A=gradient_descent(A, eta, div_A())

pre=A*np.sin(omega*t)    # final result formula


plt.figure()               # print the fig. of formula
plt.scatter(x,Data)
plt.plot(x, pre, color = 'green')
plt.legend(['n = '+str(n_order),'Raw Data'], loc='lower right')
plt.savefig('./TASK1/g.jpg',dpi=500)


x_l = np.linspace(0,len(Loss_1)-1,len(Loss_1))    # print the fig. of loss(g)
plt.figure()
plt.plot(x_l, Loss_1)
#plt.savefig('./TASK1/loss.jpg',dpi=500)