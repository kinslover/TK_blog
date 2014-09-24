---
layout: post
title: Search Insert Position
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, binary search
---

# Description

https://oj.leetcode.com/problems/search-insert-position/

Difficulty: 1/5.0 star

# Analysis

Ask for implementation of binary search.


{% highlight c++%}
class Solution {
public:
    int searchInsert(int A[], int n, int target) {
 		int left = 0, right = n -1;
		while(left <= right){
			int mid = (left + right) >> 1;
			if (A[mid] == target)
				return mid;
			else if (A[mid] < target)
				left = mid + 1;
			else
				right = mid - 1;
		}
		return left;
    }
};
{% endhighlight %}