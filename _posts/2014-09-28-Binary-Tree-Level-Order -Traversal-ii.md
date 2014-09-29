---
layout: post
title: Binary Tree Level Order Traversal II
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode
---

# Description

https://oj.leetcode.com/problems/binary-tree-level-order-traversal-ii/

Difficulty: 0.5/5.0 star

Related: https://oj.leetcode.com/problems/binary-tree-level-order-traversal/


# Analysis and solution

It is almost the same with the old problem. All you have to do is to reverse the result vector.

{% highlight c++%}

class Solution {
public:
	vector<vector<int> > levelOrderBottom(TreeNode *root) {
		vector<vector<int> > result;
		traverse(root, 0, result);
		reverse(result.begin(), result.end());
		return result;
	}
	void traverse(TreeNode * pt, int level, vector<vector<int> > & result){
		if (pt == NULL)
			return;
		if (result.size() == level)
			result.push_back(vector<int>());

		result[level].push_back(pt->val);
		traverse(pt->left, level + 1, result);
		traverse(pt->right, level + 1, result);
	}
};

{% endhighlight%}