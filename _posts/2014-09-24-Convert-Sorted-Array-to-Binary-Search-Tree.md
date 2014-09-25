---
layout: post
title: Convert Sorted Array to Binary Search Tree 
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, recursion, divide-and-conquer, BST
---

# Description

https://oj.leetcode.com/problems/convert-sorted-array-to-binary-search-tree/

Difficulty: 1.0/5.0 star

# Analysis

This is a typical divide-and-conquer problem. We construct the tree recursively.

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
 	TreeNode *sortedArrayToBST(vector<int> &num) {
		return (num.size() == 0) ? NULL: constructTree(num, 0, num.size()-1);
 	}
	TreeNode * constructTree(vector<int> & num, int left, int right){
		if (right < left)
			return NULL;
 		int mid = (left + right)/2;
		TreeNode * head = new TreeNode(num[mid]);

		head->left = constructTree(num, left, mid-1);
 		head->right = constructTree(num, mid+1, right);
		return head;
 	}
};

{% endhighlight %}
