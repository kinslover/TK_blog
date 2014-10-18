---
layout: post
title: Flatten Binary Tree to Linked List 
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, recursion, binary tree
---




# Description

https://oj.leetcode.com/problems/flatten-binary-tree-to-linked-list/

Difficulty: 2.5/5.0 star


# Analysis and solution

The trick here is that we have to cache the right pointer before assigning new values to it. Besides pre-order flatten, we can also do in-order flatten or post-order flatten too. To make the code compatible with in/post-order flatten, I let the return value of function ``flatten`` to be ``TreeNode *``.

{% highlight c++%}

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    TreeNode * flatten(TreeNode *root) {
        if (!root)
            return root;
        TreeNode *hyperRoot = new TreeNode(0);
        TreeNode *father = hyperRoot;
        inOrderSolver(father, root);
        root = hyperRoot->right;
        father->right = NULL;
        delete hyperRoot;
        return root;
    }
    
    void preOrderSolver(TreeNode * & father, TreeNode * son){
        TreeNode *rightCache = son->right;
        father->right = son;
        father = son;
        if (son->left)
            preOrderSolver(father, son->left);
        son->left = NULL;
        if (rightCache)
            preOrderSolver(father, rightCache);
        
    }

    void inOrderSolver(TreeNode * & father, TreeNode * son){
        TreeNode *rightCache = son->right;
        if (son->left)
            inOrderSolver(father, son->left);        
        father->right = son;
        father = son;        
        son->left = NULL;
        if (rightCache)
            inOrderSolver(father, rightCache);
        
    }    
};

{% endhighlight %}