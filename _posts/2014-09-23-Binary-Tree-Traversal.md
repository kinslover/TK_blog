---
layout: post
title: Binary Tree Traversal
published: true
comments: true
category: Algorithms
tag: algorithm, stack, leetcode, tree, traversal
---

# Definition of TreeNode

{% highlight c++%}

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 };
{% endhighlight%}


# Pre-order traversal

We maintain a stack of the children of the currently visited tree node. Right child is pushed before left child, which guanrantees that we will visit its left child first. Once a node is processed, we do not need to track it anymore, as its value is recorded in the result vector.

{% highlight c++%}

class Solution {
public:
    vector<int> preorderTraversal(TreeNode *root) {
        vector<int> preOrderTraversalVec;
        stack<TreeNode*>stackForTraversal;
        if (root == NULL)
            return preOrderTraversalVec;
        stackForTraversal.push(root);
        while(!stackForTraversal.empty()){
            TreeNode * currentPt = stackForTraversal.top();
            stackForTraversal.pop();
            preOrderTraversalVec.push_back(currentPt->val);
            if (currentPt->right)
                stackForTraversal.push(currentPt->right);
            if (currentPt->left)
                stackForTraversal.push(currentPt->left);
        }
        return preOrderTraversalVec;

    }
};
{% endhighlight%}


# In-order traversal

In-order traversal is more complicated than pre-order traversal, as the value of current tree node is recored in result vector after its left sub-tree is processed and before its right sub-tree is processed.

The basic idea is that 

1. We maintain a ``cur`` pointer indicating the current tree node, initialized as ``root``.
2. We first go along the left childs and record the nodes visited in ``nodeStk`` until we meet a node without left child, we record the value of it in our result vector. 
3. Then as long as ``cur->right == NULL`` and we still have nodes in ``nodeStk``, we record the value of ``cur`` in result vector and update ``cur`` to be the top element of stack (with pop() operation afterwards).
4. Make ``cur = cur->right``
5. if ``cur != NULL``, go back to step 2, else, end.

{% highlight c++%}

class Solution{
public:
    vector<int> inorderTraversal(TreeNode *root) {
        vector<int> result;
        stack<TreeNode *>nodeStk;
        TreeNode * cur = root;
        while(cur){
            while(cur->left != NULL){
                nodeStk.push(cur);
                cur = cur->left;
            }
            result.push_back(cur->val);
            while (cur->right == NULL && !nodeStk.empty()){
                cur = nodeStk.top();
                nodeStk.pop();
                result.push_back(cur->val);
            }

            cur = cur->right;
        }
        return result;
    }
};
{% endhighlight%}

# Post-Order traversal

It is almost the same with pre-order traversal, we just have to reverse everything.

{% highlight c++%}
class Solution {
public:
    vector<int> postorderTraversal(TreeNode *root) {
        vector<int> preOrderTraversalVec;
        stack<TreeNode*>stackForTraversal;
        if (root == NULL)
            return preOrderTraversalVec;
        stackForTraversal.push(root);
        while(!stackForTraversal.empty()){
            TreeNode * currentPt = stackForTraversal.top();
            stackForTraversal.pop();
            preOrderTraversalVec.push_back(currentPt->val);
            //revserse the order of visiting left and right children
            if (currentPt->left)
                stackForTraversal.push(currentPt->left);
            if (currentPt->right)
                stackForTraversal.push(currentPt->right);                
        }
        //revserse the result vector
        reverse(preOrderTraversalVec.begin(), preOrderTraversalVec.end());
        return preOrderTraversalVec;       
    }
};
{% endhighlight%}


# General recursive solution

The position of ``inOrderTraversalVec.push_back(pt->val);`` determines the type of traversal.

{% highlight c++%}
class Solution {
public:
    vector<int> inorderTraversal(TreeNode *root) {
        vector<int>inOrderTraversalVec;
        _inorder_traversal(root, inOrderTraversalVec);
        return inOrderTraversalVec;
    }
    void _inorder_traversal(TreeNode * pt, vector<int>& inOrderTraversalVec){
        if (pt == NULL)
            return;
        _inorder_traversal(pt->left, inOrderTraversalVec);
        inOrderTraversalVec.push_back(pt->val);
        _inorder_traversal(pt->right, inOrderTraversalVec);
    }
};
{% endhighlight%}


