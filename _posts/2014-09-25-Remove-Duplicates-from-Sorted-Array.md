---
layout: post
title: Remove Duplicates from Sorted Array
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode
---


# Description

https://oj.leetcode.com/problems/remove-duplicates-from-sorted-array/

Difficulty: 0.5/5.0 star

related:

- Remove Duplicates from Sorted List
- Remove Element


# Analysis

{% highlight c++ %}
class Solution {
public:
 	int removeDuplicates(int A[], int n) {
 		int currentPosition = 1;
		for (int i = 1; i < n; ++ i)
			if (A[i] != A[i-1])
 				A[currentPosition++] = A[i];	
		return min(currentPosition, n);
	
 	}
};
{% endhightlight%}

