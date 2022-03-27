#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Mar 22 15:27:47 2020

@author: hantao.li

----Input:  (Data)The data from UCI
----Output: Fig. drawn to show the decision tree.

The HW2 of ML part in ML course in Beihang spring 2020. 
Using Decision Tree in UCI data set.

2020spring，模式识别课程，ML部分第二次作业，使用决策树处理UCI鸢尾花数据集。并用可视化界面体现。
"""

from matplotlib import pyplot as plt  
import numpy as np  
import math  
from sklearn.datasets import load_iris  

data = load_iris() 
x = data.get('data') 
y = data.get('target') 
training_data = np.c_[x, y]  
names = ["Sepal length", "Sepal width", "Petal length", "Petal width", "label"]  

def class_counts(rows):   #Calculate the number of labels in the dataset
    counts = {}    #Use dic because it's more convinence for different features
    for row in rows:  
        label = row[-1]  
        if label not in counts:  
            counts[label] = 0  
        counts[label] += 1  
    return counts  
  
def Entropy(rows): #Calculate the Entropy of the dataset
    counts = class_counts(rows)  
    entropy = 0.0  
    for label in counts:  
        p_i = counts[label] / float(len(rows))  
        entropy = entropy - (p_i * math.log(p_i,2))  
    return entropy  
  
def splitting(rows, axis, value):  
    true_rows, false_rows = [], []  
    for row in rows:  
        if row[axis] >= value:  
            true_rows.append(row)  
        else:  
            false_rows.append(row)  
    return true_rows, false_rows  
  
def find_best_split(rows):  #Find the best split point in all J_i  
    Base_entropy = Entropy(rows)  
    best_gain = 0.0    
    best_Feature = 0   
    best_value = 0.0    
    entropy_Yes = 0.0  
    entropy_No = 0.0  
    n_features = len(rows[0]) - 1    #The number of features
    for col in range(n_features):    
        values = set([row[col] for row in rows])     #Unique values in the column  
        for val in values:    
            true_rows, false_rows = splitting(rows, col, val) # Splitting each possible points  
            if len(true_rows) == 0 or len(false_rows) == 0:   # If no split occurs  
                continue                                      # Try the next value  
            p_1 = float(len(true_rows)) / (len(true_rows)+len(false_rows)) 
            p_2 = 1 - p_1
            entropy1 = Entropy(true_rows)  
            entropy2 = Entropy(false_rows)  
            gain = Base_entropy - p_1 * entropy1 - p_2 * entropy2  
            if gain >= best_gain:            #Find better split point
                best_gain, best_Feature, best_value = gain, col, val  
                entropy_Yes, entropy_No = entropy1, entropy2  
    return best_gain, best_Feature, best_value, entropy_Yes, entropy_No  
  
class Leaf:  
    def __init__(self, rows):  
        self.predictions = class_counts(rows)  
  
class Decision_Node:  
    def __init__(self, feature, value, true_branch, false_branch, entropy_Yes, entropy_No):  
        self.feature = feature  
        self.value = value  
        self.true_branch = true_branch  
        self.false_branch = false_branch  
        self.entropy_Yes = entropy_Yes  
        self.entropy_No = entropy_No  
  
def build_tree(rows):  
    gain, feature, value, entropy_Yes, entropy_No = find_best_split(rows)  
    if gain == 0:  
        return Leaf(rows)  
    true_rows, false_rows = splitting(rows, feature, value)  
    true_branch = build_tree(true_rows)  
    false_branch = build_tree(false_rows)  
    return Decision_Node(feature, value, true_branch, false_branch, entropy_Yes, entropy_No)  
  
def print_tree(node, spacing=""):  
    if isinstance(node, Leaf):  
        print (spacing + "++++++++++++++++++++++")
        print (spacing + "| " + "value = ", str(node.predictions) + " |")  
        print (spacing + "++++++++++++++++++++++\n")
        return  
    print (spacing + "---------------------")
    print (spacing + "| " + names[node.feature] + '>=' +str(node.value) + '? |' )  
    print (spacing + "---------------------")
    print (spacing + '      ||')
    print (spacing + '      VV')
    print (spacing + '     Yes:' + '->entropy={:.2f}'.format(node.entropy_Yes))  
    print (spacing + '      ||')
    print (spacing + '      VV')
    print_tree(node.true_branch, spacing + "  ")  
    print (spacing + ' =>=> No:' + '->entropy={:.2f}'.format(node.entropy_No))  
    print (spacing + '      ||')
    print (spacing + '      VV')
    print_tree(node.false_branch, spacing + "  ")  

my_tree = build_tree(training_data)  
print_tree(my_tree)  
