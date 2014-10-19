---
layout: post
title: Validate Binary Search Tree
comments: true
category: Algorithms
tag: algorithm, leetcode, BST, recursion
---

# Description

https://oj.leetcode.com/problems/validate-binary-search-tree/

Difficulty: 1.5/2.0

# Solution


{%highlight c++%}
class Solution {
public:
	bool isValidBST(TreeNode *pt) {
		return validate(pt, INT_MAX, INT_MIN);
	}
	bool validate(TreeNode * pt, int upperBound, int lowerBound){
		if (!pt) return true;
		return (pt->val < upperBound && pt->val > lowerBound) && \
		validate(pt->left, pt->val, lowerBound) && \
		validate(pt->right, upperBound, pt->val);
	}
};
{%endhighlight %}

