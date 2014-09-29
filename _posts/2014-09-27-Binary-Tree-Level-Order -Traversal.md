---
layout: post
title: Binary Tree Level Order Traversal
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode
---

# Description

https://oj.leetcode.com/problems/binary-tree-level-order-traversal/

Difficulty: 0.5/5.0 star

Related: https://oj.leetcode.com/problems/binary-tree-level-order-traversal-ii/


# Analysis and solution

{% highlight c++%}
class Solution {
public:
	vector<vector<int> > levelOrder(TreeNode *root) {
		vector<vector<int> > result;
		traverse(root, 0, result);
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