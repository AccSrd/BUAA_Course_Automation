#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Nov 26 21:13:25 2019

@author: hantao.li
"""

import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
#from scipy.interpolate import spline

def data(num):

    X = np.random.randint(0,101,(2,num))
    y = np.zeros(num)
    y[X[0,:]>=(100-X[1,:])] = 1
    y[X[0,:]<(100-X[1,:])] = -1
    return X,y

def irisdata(num):
    
    df = pd.read_csv('https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data', header=None)
    y = df.iloc[0:num, 4].values
    y = np.where(y == 'Iris-setosa', 1, -1)
    X = df.iloc[0:num, [0, 2]].values
    X = X.T
    return X,y


def plot_data(X,y,w,b):

    plt.scatter(X[0],X[1],s=15)
    plt.show()
    
    plt.scatter(X[0,y==1],X[1,y==1],s=15,c='b',marker='o')
    plt.scatter(X[0,y==-1],X[1,y==-1],s=15,c='g',marker='x')
    #plt.plot([0,100],[100,0],linewidth=0.5,c='b')
    plt.show()
    
    plt.scatter(X[0,y==1],X[1,y==1],s=15,c='b',marker='o')
    plt.scatter(X[0,y==-1],X[1,y==-1],s=15,c='g',marker='x')
    plt.plot([0,-b/w[0]],[-b/w[1],0],linewidth=0.75,c='r')
  #  plt.plot([0,100],[100,0],linewidth=0.5,c='b')
    plt.show()
    
def wrongclass(X,y,w,b):

    return y*(w.dot(X)+b)<0

def costcompute(X,y,w,b,c):

    return -np.sum(y[c]*(w.dot(X[:,c])+b))

def grad(X,y,c):

    dw = -np.sum(y[c]*X[:,c],axis=1)
    db = -np.sum(y[c])
    return dw,db

def updata_parameters(w,b,dw,db,learning_rate):

    w = w-learning_rate*dw
    b = b-learning_rate*db*100
    return w,b

X,y = data(100)
#X,y = irisdata(100)

w = np.random.rand(2)


list_rho = list(range(100))
list_i = list(range(100))

for j in range(0,100):
    
    w[0] = 0.5
    w[1] = 0.5
    b = 0
    rho = 1 * j + 0.02 #parameters
    list_rho[j] = rho
    #计算错误分类点，求损失值
    c = wrongclass(X,y,w,b)
    cost = costcompute(X,y,w,b,c)
    i = 0
    
    #当有错位分类点不停迭代
    while cost>0:
        dw,db = grad(X,y,c)
        w,b = updata_parameters(w,b,dw,db,rho)
        c = wrongclass(X,y,w,b)#求错误分类点，bool数组形式
        cost = costcompute(X,y,w,b,c)#计算损失值
        i = i+1
        
    if rho == 0.02:
        plot_data(X,y,w,b)
        print ('==========================')
        print ('此次参数为：%s' % str(rho))
        print ('此次结果为：%s' % str(w)+str(b))
        print ('此次迭代次数为：%s' % str(i))        
    list_i[j] = i
    
#    plot_data(X,y,w,b)
#    print ('==========================')
#    print ('此次参数为：%s' % str(rho))
 #   print ('此次结果为：%s' % str(w)+str(b))
#    print ('此次迭代次数为：%s' % str(i))
    
#xnew = np.linspace(list_rho.min(),list_rho.max(),300)
#ismooth = spline(list_rho,list_i,xnew)
#plt.plot(xnew,ismooth)
#plt.show    
plt.plot(list_rho,list_i)
plt.xlabel('Learning rate')
plt.ylabel('Number of Iterations for Convergence')

