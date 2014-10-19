---
layout: post
title: Binary Tree Zigzag Level Order Traversal 
comments: true
category: Algorithms
tag: algorithm, leetcode, recursive, binary tree, pre-order traverse
---

# Description

https://oj.leetcode.com/problems/binary-tree-zigzag-level-order-traversal/

Difficulty: 2.0/5.0

# Solution

{% highlight c++%}
class Solution {
public:
 	vector<vector<int> > zigzagLevelOrder(TreeNode *root) {
		vector<vector<int> > result;
 		zigzag_helper(result, 1, root);
 		for (int i = 1; i < result.size(); i+=2)
			reverse(result[i].begin(), result[i].end());
 		return result;
 	}
 	void zigzag_helper(vector<vector<int> >& result, int height, TreeNode * pt){
 		if (!pt) return;
 		if (height > result.size())
			result.push_back(vector<int>());
 		result[height-1].push_back(pt->val);
 		zigzag_helper(result, height + 1, pt->left);
		zigzag_helper(result, height + 1, pt->right);
 	}
};
{% endhighlight %}

