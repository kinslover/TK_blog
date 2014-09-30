---
layout: post
title: Remove Duplicates from Sorted Array ii
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode
---

# Description

https://oj.leetcode.com/problems/remove-duplicates-from-sorted-array-ii/

Difficulty: 2.0/5.0

Related: https://oj.leetcode.com/problems/remove-duplicates-from-sorted-array/

# Analysis and solution

This problem is not hard at all, but coming up with a neat solution is not that easy. This solution is almost the same with the one for the related problem.

{% highlight c++%}
class Solution {
public:
    int removeDuplicates(int A[], int n) {
    	int currentPosition = 2;
    	for (int i = 2; i < n; ++ i)
    		if (A[i] != A[currentPosition-2])
    			A[currentPosition++] = A[i];
    	return  min(currentPosition, n);
    }
};
{% endhighlight %}