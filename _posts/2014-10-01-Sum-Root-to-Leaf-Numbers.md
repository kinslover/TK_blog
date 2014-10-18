---
layout: post
title: Sum Root to Leaf Numbers 
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, recursion
---


# Description

https://oj.leetcode.com/problems/sum-root-to-leaf-numbers/

Difficulty: 1.5/5.0

# Analysis and solution

{% highlight c++ %}
/**
 * Definition for binary tree
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */
class Solution {
public:
    int sumNumbers(TreeNode *root) {
    	if (!root) return 0;
  		return sumNumbersSolver(root, 0);
    }
    int sumNumberSolver(TreeNode * pt, int sum){    	
    	if (!pt->left && !pt->right)
    		return pt->val + sum * 10;
    	int totalSum = 0;
    	if (pt->left)
    		totalSum+= sumNumberSolver(pt->left, sum * 10 + pt->val);
    	if (pt->right)
    		totalSum+= sumNumberSolver(pt->right, sum * 10 + pt->val);    		
    	return totalSum;
    }
};

{% endhighlight %}