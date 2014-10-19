---
layout: post
title: Path Sum II
comments: true
category: Algorithms
tag: algorithm, leetcode, DFS
---



# Description

https://oj.leetcode.com/problems/path-sum-ii/

Difficulty: 1.5/5.0


# Solution

Note that the sum can be negative, which prevents us from pruning.

{% highlight c++%}
class Solution {
public:
 	void pathSumHelper(vector<vector<int> > & result, vector<int>&path, TreeNode* pt, int remaining){
 		remaining -= pt->val;
		path.push_back(pt->val);
 		if (!pt->left && !pt->right && !remaining) //leaf and sum right
			result.push_back(path);
 		
 		if (pt->left) // possible value = 0 in a node
			pathSumHelper(result, path, pt->left, remaining);
 		if (pt->right)
			pathSumHelper(result, path, pt->right, remaining);
 		path.pop_back();
 	}
 	vector<vector<int> > pathSum(TreeNode *root, int sum) {
 	    // note that sum can be negative!!!
 		vector<vector<int> > result;
 		vector<int>path;
		if (!root) return result;
		pathSumHelper(result, path,root,sum);
 		return result;
 	}
};



{% endhighlight %}