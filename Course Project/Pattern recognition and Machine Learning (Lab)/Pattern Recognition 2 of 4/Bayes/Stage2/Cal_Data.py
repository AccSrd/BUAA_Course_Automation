"""
Created on Thu Nov 28 22:53:42 2019

@author: hantao.li

计算数据特征
"""
import numpy as np
import math 

arr1 = [-3.9847,-3.5549,-1.2401,-0.9780,-0.7932,-2.8531,-2.7605,-3.7287,
       -3.5414,-2.2692,-3.4549,-3.0752,-3.9934,-0.9780,-1.5799,-1.4885,
       -0.7431,-0.4221,-1.1186,-2.3462,-1.0826,-3.4196,-1.3193,-0.8367,
       -0.6579,-2.9683]
arr2 = np.array([1.0,2.0,3.0,4.0])

#求均值
arr_mean1 = np.mean(arr1)
#求方差
arr_var1 = np.var(arr1)
#求标准差
arr_std1 = np.std(arr1,ddof=1)


arr_mean2 = np.mean(arr2)
arr_var2 = np.var(arr2)
arr_std2 = np.std(arr2,ddof=1)

total = 0
for value in arr1:
    total += (value - arr_mean1) ** 2
 
stddev = math.sqrt(total/len(arr1))
print(stddev)



print("平均值1为：%f" % arr_mean1)
print("方差1为：%f" % arr_var1)
print("标准差1为:%f" % arr_std1)
print("平均值2为：%f" % arr_mean2)
print("方差2为：%f" % arr_var2)
print("标准差2为:%f" % arr_std2)