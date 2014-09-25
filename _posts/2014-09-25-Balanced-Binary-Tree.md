---
layout: post
title: Balanced Binary Tree
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, binary tree, recursion
---

# Description

https://oj.leetcode.com/problems/balanced-binary-tree/

Difficulty: 1.0/5.0 star

# Solution


{% hightlight c++%}

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
 	bool isBalanced(TreeNode *root) {
		int depth;
		return _isBalanced(root, depth);
 	}
	bool _isBalanced(TreeNode * pt, int& depth){
		if (!pt){
			depth = 0;
			return true;
 		}
 		int leftDepth, rightDepth;
 		bool flgBalanced = _isBalanced(pt->left, leftDepth) && _isBalanced(pt->right, rightDepth);
 		flgBalanced = flgBalanced && (abs(leftDepth - rightDepth) <= 1);
		depth = max(leftDepth, rightDepth)+1;
		return flgBalanced;
    }
};

{% endhighlight %}