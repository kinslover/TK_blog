---
layout: post
title: Merge Sorted Array 
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode
---



# Description

https://oj.leetcode.com/problems/merge-sorted-array/

Difficulty: 1.5/5.0


# Analysis

Unlike list, you cannot insert element in array ``A`` in constant time, but you have extra space at the end of ``A``. So we start from putting the largest element at the end.

{% highlight c++%}
class Solution {
public:
 	void merge(int A[], int m, int B[], int n) {
		int indexA = m-1, indexB = n-1, indexC = m + n - 1;
		while(indexA>=0 && indexB >=0){
 			if (A[indexA] < B[indexB]) A[indexC--] =  B[indexB--];
			else A[indexC--] =  A[indexA--];			
 		}
		while(indexA>=0)
			A[indexC--] =A[indexA--];
		while(indexB>=0)
			A[indexC--] =B[indexB--];
 	}
};
{% endhighlight%}