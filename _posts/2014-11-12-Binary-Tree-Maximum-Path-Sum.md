---
layout: post
title: Binary Tree Maximum Path Sum
comments: true
category: Algorithms
tag: algorithm, leetcode, binary tree
---


# Description

Difficulty: 2.5/5.0

URL: https://oj.leetcode.com/problems/binary-tree-maximum-path-sum/


# Solution

The function ``maxPathSumHelper(pt, max_sum)`` return the maximum sum path sum of the path in the subtree rooted at ``pt``, which ends/starts at ``pt``. If the sum is less than 0, then it return zero as the sum of an empty path.

{% highlight c++ %}
class Solution {
public:
    int maxPathSum(TreeNode *root) {
    	int max_sum = INT_MIN;
    	maxPathSumHelper(root, max_sum);
    	return max_sum;
    }
    int maxPathSumHelper(TreeNode *pt, int & max_sum){
    	int left_sum =  (pt->left)  ? maxPathSumHelper(pt->left, max_sum) : 0;
    	int right_sum = (pt->right) ? maxPathSumHelper(pt->right, max_sum): 0;
    		
    	max_sum = max(left_sum + right_sum + pt->val, max_sum);
    	return max(max(left_sum, right_sum) + pt->val, 0);
    }
};
{% endhighlight %}