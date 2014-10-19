---
layout: post
title: Construct Binary Tree from Inorder and Postorder/Preorder Traversal
comments: true
category: Algorithms
tag: algorithm, leetcode, recursive, BST
---


# Description

Construct Binary Tree from Preorder and Inorder Traversal

https://oj.leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/

Construct Binary Tree from Inorder and Postorder Traversal 

https://oj.leetcode.com/problems/construct-binary-tree-from-inorder-and-postorder-traversal/

Difficulty: 2.0/5.0



# Solution

Obviously we should recover the BST in a recursive manner.

The pre/post-order traversal can be used to determine the current (sub)root, and then we search the root in the in-order traversal vector to find the pivot that seperates the left sub-tree and right sub-tree.

As this search has to be a linear search, it takes $$O(N)$$ time for each layer. In the worst case, there can be $$O(N)$$ layers. Therefore, the worst-case time complexity can be $$O(N^2)$$.

One interesting variation is that we know that the BST is balanced. Note that though this looks like *Convert Sorted List to Binary Search Tree*, they are different. Even the BST is balanced, we can have multiple solution, e.g., two solutions for [1, 2]. So we still need the pre/post order traversal result for uniqueness. 

The good side of the BST being balanced is that we can solve the problem in $$O(N)$$, which is much faster than $$O(N^2)$$. The inorder-traversal array is guanranteed to be monotonic and the current root must be at the center position(s). We just need to use the pre/post-order traversal result to determine the root, when the number of nodes in the sub-tree is even (i.e., two centers).


{% highlight c++%}
class Solution {
public:
    TreeNode *buildTree(vector<int> &preorder, vector<int> &inorder) {
        return (preorder.size())?build_tree_helper(0, 0, (int)preorder.size(), preorder, inorder):NULL;
    }
    TreeNode * build_tree_helper( int leftPre, int leftIn , int len, vector<int> & preorder, vector<int> & inorder){
        TreeNode * pt = new TreeNode(preorder[leftPre]);
        int mid = linear_search(preorder[leftPre], inorder, leftIn, leftIn+len-1);
        int leftLen = mid - leftIn; 
        int rightLen = len - leftLen - 1;
        pt->left = (leftLen > 0)?build_tree_helper( leftPre+1, leftIn, leftLen, preorder, inorder) :NULL;
        pt->right = (rightLen > 0)?build_tree_helper(leftPre+1+leftLen, mid + 1, rightLen, preorder, inorder ):NULL;
        return pt;
    }

    int linear_search(int target, vector<int>&inorder,int left, int right){
    	for (;left <= right; left++)
    		if (inorder[left] == target)
        		return left;
    }
};
{% endhighlight %}

{% highlight c++%}
class Solution {
public:
    TreeNode *buildTree(vector<int> &inorder, vector<int> &postorder) {
        return (postorder.size())?build_tree_helper(0, 0, (int)inorder.size(), postorder, inorder):NULL;
    }
    TreeNode * build_tree_helper( int leftPost, int leftIn , int len, vector<int> & postorder, vector<int> & inorder){
        TreeNode * pt = new TreeNode(postorder[leftPost+len-1]);
        int mid = linear_search(postorder[leftPost+len-1], inorder, leftIn, leftIn+len-1);
        int leftLen = mid - leftIn; 
        int rightLen = len - leftLen - 1;
        pt->left = (leftLen > 0)?build_tree_helper( leftPost, leftIn, leftLen, postorder, inorder) :NULL;
        pt->right = (rightLen > 0)?build_tree_helper(leftPost+leftLen, mid + 1, rightLen, postorder, inorder ):NULL;
        return pt;
    }

    int linear_search(int target, vector<int>&inorder,int left, int right){
        for (;left <= right; left++)
            if (inorder[left] == target)
                return left;
    }
};
{% endhighlight %}