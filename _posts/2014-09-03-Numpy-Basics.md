---
layout: post
title: Numpy Basics
published: true
comments: true
category: Programming
tag: python, numpy
---

# Array Creation



(1) Initialize an array from a list

- ``numpy.array(list)``

(2) Initialize a $$n \times m$$ array

- all zeros: ``numpy.zeros( (n, m) )``
- all ones: ``numpy.ones( (n, m) )``
- "wild" random numbers (depends on memory)：``numpy.empty( (n, m) )``	
- random numbers（[0,1]）:``numpy.random.random((2,3))``
- identity matrix: ``eye(n)``

(3) Initialize a $$n$$-dim vector

- just pass one parameter n into the functions zeros, ones,  

(4) Initialize a ranged array

- ``arange(low, up, gap) ``, gap can be float
- ``linspace(low, up, n) ``

(5) Others

- arange, array, copy, empty, empty_like, eye, fromfile, fromfunction, identity, linspace, logspace, mgrid, ogrid, ones, ones_like, r , zeros, zeros_like
	
# Array Operation

(1) with dimensions

- a.ravel: 展成一维向量
- a.transpose：转置（或T）
- a.reshape/resize：前者生成一个新矩阵，后者修改原矩阵
	- 如果某个维度输入-1，则该维度自动计算

(2) linear algebra

- matrix multiplication: ``dot(a, b)``
- vector cross-product: ``cross(a, b)``
- outer-product: ``outer(a, b)``
- ``svd, trace, inv, eig``

(3) Arithmetic

- Elementwise

(4) Statistics

- summation/product/min/max of the whole array： 
	- ``a.sum/prod/max/min()``
- summation/product/min/max by column/row: 
	- ``a.sum/prod/max/min(axis=0/1)`` 
- cumulative summation/product：
	- ``a.cumsum/prod(axis =0/1)``
- mean, median, var, std...

(5) Universial Function

- Elementwise operation
- ``sin, cos, exp, sqrt, add, all, alltrue, any, apply along axis, argmax, argmin, argsort, average, bincount, ceil, clip, conj, conjugate, corrcoef, cov, cross, cumprod, cumsum, diff, dot, floor, inner, inv, lexsort, max, maximum, mean, median, min, minimum, nonzero, outer, prod, re, round, sometrue, sort, std, sum, trace, transpose, var, vdot, vectorize, where``

(6) Array combination

- ``vstack((a,b,c...))``: combined as rows
- ``hstack((a,b,...))``: combined as columns
- ``column/row_stack((a,b,c,...))``: can take 2-D array as parameter

(7) Split Array

- ``hsplit``:
	- ``hsplit(a, 3)``: divide ``a`` into 3 even parts horizontally
	- ``hsplit(a, (3,4))``: divide ``a`` horizontally with 3 and 4 being the split points
- ``vsplit``
- ``split``

(8) Others

- ``numpy.random.xxx``
	- ``uniform(low=0, high =10,size = (2,3))``
	- ``weibull(a = 1, size(2,3))``
	- ``permutation(n)``
	- ``binomial(n=100,p=0.5,size=(2,3))``
	- ``poisson(lam=0.5, size=(2,3))`` 
	- ``random_integers(low, high, size = (a,b))``
	- ``beta, gamma, geometric,...``
- ``numpy.unique(a)``
- ``vectorize``: 将作用于单一数字的函数改为作用于vector
- ``where()``: return the indices where a certain condition is satisfied
- ``repeat()``
- ``sort()``
	
# Examples

Please refer to http://wiki.scipy.org/Numpy_Example_List#fromfunction