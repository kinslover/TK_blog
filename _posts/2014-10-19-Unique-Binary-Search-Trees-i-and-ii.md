
---
layout: post
title: Unique Binary Search Trees i and ii
comments: true
category: Algorithms
tag: algorithm, leetcode
---



# Description

- https://oj.leetcode.com/problems/unique-binary-search-trees/
- https://oj.leetcode.com/problems/unique-binary-search-trees-ii/

Difficulty: 1.5/5.0, 3.0/5.0


# Solution

We can solve the first problem by search with memorization.



{% highlight c++%}
class Solution {
public:
int numTrees(int n) {
	    if (n < 3)
		    return n;
	    int numTreesCache[n+1];
	    memset(numTreesCache, 0, sizeof(int) * (n+1));
	    numTreesCache[0] = 1; numTreesCache[1] = 1; numTreesCache[2] = 2;
	    return compute_num_trees(n, numTreesCache);	
    }
    int compute_num_trees(int n, int numTreesCache[]){
	    if (numTreesCache[n]  == 0 && n != 0){
            for (int i = 0; i < n; ++ i){
		        numTreesCache[n] += compute_num_trees(i, numTreesCache) * compute_num_trees(n-i-1, numTreesCache);
            }
        }
        return numTreesCache[n];
    }
};
{% endhighlight%}


For the second problem, we follow the same idea, but the procedure is more complicated.

For a root at $i$, we construct the vector of possible left subtrees and the vector of possible right subtrees. Then we construct a new tree with each pair of left and right substrees.

Note that copy_tree is a very important function here, if we do ``root->left = leftSubstree[i];`` without ``copy_tree``, then different roots will share subtrees, which is problematic.


{% highlight c++%}
class Solution {
public:
	vector<TreeNode *> generateTrees(int n) {
		vector<TreeNode *> treeSet = generate_trees_helper( 1, n);
		return treeSet;
	}
	vector<TreeNode *> generate_trees_helper( int left, int right){
		vector<TreeNode *> result;
		if(left > right)
			result.push_back(NULL);
		
		for (int mid = left; mid <= right; ++ mid){
			vector<TreeNode *> leftSubstree = generate_trees_helper(left, mid-1);
			vector<TreeNode *> rightSubstree = generate_trees_helper(mid+1, right);
			for (int i = 0; i < leftSubstree.size(); ++ i){
				for (int j = 0; j < rightSubstree.size(); ++ j){
					TreeNode * root = new TreeNode(mid);
					root->left = copy_tree(leftSubstree[i]);
					root->right = copy_tree(rightSubstree[j]);
					result.push_back(root);
				}
			}
		}
		return result;
	}
	TreeNode * copy_tree(TreeNode * root){
		if (!root)
			return NULL;
		TreeNode * newRoot = new TreeNode(root->val);
		newRoot->left = copy_tree(root->left);
		newRoot->right = copy_tree(root->right);
		return newRoot;
	}
};

{% endhighlight%}