#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Nov 30 11:14:25 2019

@author: hantao.li

输出结果图像
"""

import numpy as np  
from numpy.linalg import cholesky  
import matplotlib.pyplot as plt  
from mpl_toolkits import mplot3d  
from matplotlib import cm

sampleNo = 100  
mu1 = np.array([[0,0]])  
mu2 = np.array([[2,4]])  
mu3 = np.array([[4,0]])  
Sigma1 = np.array([[1.2,0], [0,1.2]])  
Sigma2 = np.array([[1.3,0], [0,1.3]])  
Sigma3 = np.array([[1.4,0], [0,1.4]])  

a = np.dot(np.random.randn(100, 2), cholesky(Sigma1)) + mu1  
b = np.dot(np.random.randn(100, 2), cholesky(Sigma2)) + mu2  
c = np.dot(np.random.randn(100, 2), cholesky(Sigma3)) + mu3  

plt.scatter(a[:,0],a[:,1],marker='.',color = 'r')  
plt.scatter(b[:,0],b[:,1],marker='.',color = 'y')  
plt.scatter(c[:,0],c[:,1],marker='.',color = 'b') 
plt.title('Pattern Datasets') 
plt.savefig('./Pattern Datasets.png',dpi=500,bbox_inches = 'tight')  
plt.show()  


mua = np.mean(a,axis=0)  
mub = np.mean(b,axis=0)  
muc = np.mean(c,axis=0)  
sigmaa = np.cov(a[:,0],a[:,1])  
sigmab = np.cov(b[:,0],b[:,1])  
sigmac = np.cov(c[:,0],c[:,1])  

Pa = 0.5  
Pb = 0.3  
Pc = 0.2  

x1 = np.linspace(-5,10,200)  
x2 = np.linspace(-5,10,200)  
pa = np.zeros([200,200])  
pb = np.zeros([200,200])  
pc = np.zeros([200,200])  
for i in range(200):  
    for j in range(200):  
        x_mu = np.array([[x1[i],x2[j]]-mua])  
        pa[i,j] = 1/(2*np.pi*np.linalg.det(sigmaa))\
        *np.exp(-0.5*np.dot(np.dot(x_mu,np.linalg.inv(sigmaa)),x_mu.T))  
for i in range(200):  
    for j in range(200):  
        x_mu = np.array([[x1[i],x2[j]]-mub])  
        pb[i,j] = 1/(2*np.pi*np.linalg.det(sigmab))\
        *np.exp(-0.5*np.dot(np.dot(x_mu,np.linalg.inv(sigmab)),x_mu.T))  
for i in range(200):  
    for j in range(200):  
        x_mu = np.array([[x1[i],x2[j]]-mua])  
        pc[i,j] = 1/(2*np.pi*np.linalg.det(sigmac))\
        *np.exp(-0.5*np.dot(np.dot(x_mu,np.linalg.inv(sigmac)),x_mu.T))  
x, y = np.meshgrid(x1, x2)  

ax = plt.gca(projection='3d')
ax.plot_wireframe(x, y, pa, color='r') 
ax.set_title('P1(X|$\omega1$)')
plt.savefig('./Prior1.png',dpi=500,bbox_inches = 'tight')  
plt.show()  
ax = plt.gca(projection='3d')
ax.plot_wireframe(x, y, pb, color='y') 
ax.set_title('P2(X|$\omega1$)')
plt.savefig('./Prior2.png',dpi=500,bbox_inches = 'tight')  
plt.show()  
ax = plt.gca(projection='3d')
ax.plot_wireframe(x, y, pc, color='b') 
ax.set_title('P3(X|$\omega1$)')
plt.savefig('./Prior3.png',dpi=500,bbox_inches = 'tight')  
plt.show()  

ax = plt.gca(projection='3d')
ax.plot_wireframe(x, y, pa, color='r',rstride=10, cstride=10)  
ax.plot_wireframe(x, y, pb, color='y',rstride=10, cstride=10)  
ax.plot_wireframe(x, y, pc, color='b',rstride=10, cstride=10)  
ax.legend(["P1(X|$\omega1$)","P2(X|$\omega2$)","P3(X|$\omega3$)"])  
ax.set_title('Prior Probability Density Functions')
plt.savefig('./main1_2.png',dpi=500,bbox_inches = 'tight')  
plt.show()  




#绘制后验概率  
p_a = pa*Pa/(pa*Pa+pb*Pb+pc*Pc)  
p_b = pb*Pb/(pa*Pa+pb*Pb+pc*Pc)  
p_c = pc*Pc/(pa*Pa+pb*Pb+pc*Pc)  
x, y= np.meshgrid(x1, x2)  


bx = plt.gca(projection='3d')
bx.plot_wireframe(x, y, p_a, color='r',rstride=5, cstride=5) 
bx.set_title('P1($\omega1$|X)')
plt.savefig('./Post1.png',dpi=500,bbox_inches = 'tight') 
plt.show()  
bx = plt.gca(projection='3d')
bx.plot_wireframe(x, y, p_b, color='y',rstride=5, cstride=5) 
bx.set_title('P2($\omega1$|X)')
plt.savefig('./Post2.png',dpi=500,bbox_inches = 'tight') 
plt.show()  
bx = plt.gca(projection='3d')
bx.plot_wireframe(x, y, p_c, color='b',rstride=5, cstride=5) 
bx.set_title('P3($\omega1$|X)')
plt.savefig('./Post3.png',dpi=500,bbox_inches = 'tight') 
plt.show()  

bx = plt.gca(projection='3d')  
bx.plot_wireframe(x, y, p_a, color='r',rstride=10, cstride=10)  
bx.plot_wireframe(x, y, p_b, color='y',rstride=10, cstride=10)  
bx.plot_wireframe(x, y, p_c, color='b',rstride=10, cstride=10)  
bx.legend(["P1($\omega1$|X)","P2($\omega2$|X)","P3($\omega3$|X)"])  
bx.set_title('Posterior Probability Density Functions')
plt.savefig('./Posterior Probability Density Functions.png',dpi=500,bbox_inches = 'tight')  
plt.show()  
#绘制损失  


cost = np.array([[0,1,2],[1,0,4],[2,4,0]],dtype=np.float32)  
cost1 = cost[0,1]*p_b+cost[0,2]*p_c  
cost2 = cost[1,0]*p_a+cost[1,2]*p_c  
cost3 = cost[2,0]*p_a+cost[2,1]*p_b  
x, y= np.meshgrid(x1, x2)  

cx = plt.gca(projection='3d')
cx.plot_wireframe(x, y, cost1, color='r',rstride=5, cstride=5) 
cx.set_title('Conditional Risk in Decision of $\omega1$')
plt.savefig('./Risk1.png',dpi=500,bbox_inches = 'tight') 
plt.show()  
cx = plt.gca(projection='3d')
cx.plot_wireframe(x, y, cost2, color='y',rstride=5, cstride=5) 
cx.set_title('Conditional Risk in Decision of $\omega2$')
plt.savefig('./Risk2.png',dpi=500,bbox_inches = 'tight') 
plt.show()  
cx = plt.gca(projection='3d')
cx.plot_wireframe(x, y, cost3, color='b',rstride=5, cstride=5) 
cx.set_title('Conditional Risk in Decision of $\omega3$')
plt.savefig('./Risk3.png',dpi=500,bbox_inches = 'tight') 
plt.show()  

cx = plt.gca(projection='3d')  
cx.plot_wireframe(x, y, cost1, color='r',rstride=10, cstride=10)  
cx.plot_wireframe(x, y, cost2, color='y',rstride=10, cstride=10)  
cx.plot_wireframe(x, y, cost3, color='b',rstride=10, cstride=10)  
cx.legend(['Decision of $\omega1$','Decision of $\omega2$','Decision of $\omega3$'])  
cx.set_title('Conditional Risk')
plt.savefig('./Conditional Risk.png',dpi=500,bbox_inches = 'tight')  
plt.show()  



y1=[]  
y2=[]  
y3=[]  
for i in range(200):  
    for j in range(200):  
        p=[p_a[i,j],p_b[i,j],p_c[i,j]]  
        if p.index(max(p)) == 0:  
            y1.append([i,j])  
        if p.index(max(p)) == 1:  
            y2.append([i,j])  
        if p.index(max(p)) == 2:  
            y3.append([i,j])  
y1=np.array(y1)  
y2=np.array(y2)  
y3=np.array(y3)  
plt.scatter(y1[:,0]*15/200-5,y1[:,1]*15/200-5,color='r')  
plt.scatter(y2[:,0]*15/200-5,y2[:,1]*15/200-5,color='y')  
plt.scatter(y3[:,0]*15/200-5,y3[:,1]*15/200-5,color='b')  
plt.xlim((-2, 7))  
plt.ylim((-2, 7))  
plt.legend(["$\omega1$","$\omega2$","$\omega3$"])
plt.title('Minimum Error')
plt.savefig('./Minimum Error.png',dpi=500,bbox_inches = 'tight')  
plt.show()  


y1=[]  
y2=[]  
y3=[]  
for i in range(200):  
    for j in range(200):  
        p=[1/(cost1[i,j]+1),1/(cost2[i,j]+1),1/(cost3[i,j]+1)]  
        if p.index(max(p)) == 0:  
            y1.append([i,j])  
        if p.index(max(p)) == 1:  
            y2.append([i,j])  
        if p.index(max(p)) == 2:  
            y3.append([i,j])  
y1=np.array(y1)  
y2=np.array(y2)  
y3=np.array(y3)  
plt.scatter(y1[:,0]*15/200-5,y1[:,1]*15/200-5,color='r')  
plt.scatter(y2[:,0]*15/200-5,y2[:,1]*15/200-5,color='y')  
plt.scatter(y3[:,0]*15/200-5,y3[:,1]*15/200-5,color='b')  
plt.xlim((-2, 7))  
plt.ylim((-2, 7))  
plt.legend(["$\omega1$","$\omega2$","$\omega3$"])
plt.title('Minimum Risk')
plt.savefig('./Minimum Risk.png',dpi=500,bbox_inches = 'tight')  
plt.show()  