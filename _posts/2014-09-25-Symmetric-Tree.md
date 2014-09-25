---
layout: post
title: Symmetric Tree
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, recursion, binary tree
---


# Description

https://oj.leetcode.com/problems/symmetric-tree/

Difficulty: 1.5/5.0 star

# Analysis

The first solution provided here is a recursive solution. However, as this is not a divide-and-conquer, but just a element-wise checking problem, we can easily solve it iteratively (via BFS), which is the second solution.


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
	bool isSymmetric(TreeNode *root) {
		if (!root)
			return true;
		return _isSymmetric(root->left, root->right);
	}
	bool _isSymmetric(TreeNode *leftPt, TreeNode *rightPt) {
		if (leftPt == rightPt) //i.e. NULL
			return true;
		if ( (!leftPt && rightPt) || (leftPt && !rightPt))
			return false;
		return (leftPt->val == rightPt->val) && _isSymmetric(leftPt->left, rightPt->right) && _isSymmetric(leftPt->right, rightPt->left);
 	}
};

{% endhighlight%}



{% highlight c++%}

class Solution {
public:
    bool isSymmetric(TreeNode *root) {
    		if (!root)
    			return true;
    		queue<TreeNode *>leftQ, rightQ;
    		leftQ.push(root->left);
     		rightQ.push(root->right);
    		while(!leftQ.empty() && !rightQ.empty()){
    			TreeNode * leftPt = leftQ.front(), * rightPt = rightQ.front();
     			leftQ.pop(); 
     			rightQ.pop();
    			if (leftPt == rightPt) //i.e. NULL
    				continue;
    			if ( (!leftPt && rightPt) || (leftPt && !rightPt) || (leftPt->val != rightPt->val) )
    				return false;
    			leftQ.push(leftPt->left);
    			leftQ.push(leftPt->right);
    			rightQ.push(rightPt->right);
    			rightQ.push(rightPt->left);
     	    }
     		return leftQ.empty() && rightQ.empty();
    }
};

{% endhighlight%}