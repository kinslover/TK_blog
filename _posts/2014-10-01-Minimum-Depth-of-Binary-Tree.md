---
layout: post
title: Minimum Depth of Binary Tree 
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, recursion
---

# Description

https://oj.leetcode.com/problems/minimum-depth-of-binary-tree/

Difficulty: 0.5/5.0

# Analysis and solution

{% highlight c++%}
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
 	int minDepth(TreeNode *root) {
		if (!root) return 0;
		int minDep = INT_MAX;
 		minDepthSolver(root, minDep, 1);
 		return minDep;
 	}
 	void minDepthSolver(TreeNode * root, int & minDep, int depth){
		if (depth > minDep)
			return;
		if (!root->left && !root->right)
			minDep = depth;
		if (root->left)
			minDepthSolver(root->left, minDep, depth+1);
		if (root->right)
			minDepthSolver(root->right, minDep, depth+1);
 	}
};

{% endhighlight %}
