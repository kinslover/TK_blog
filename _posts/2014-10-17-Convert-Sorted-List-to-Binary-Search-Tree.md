---
layout: post
title: Convert Sorted List to Binary Search Tree 
comments: true
category: Algorithms
tag: algorithm, leetcode
---

# Description

https://oj.leetcode.com/problems/convert-sorted-list-to-binary-search-tree/

Difficulty: 3.5/5.0


# Solution

This is a very interesting problem.

The key difficuly we are faced with is lack of random access to the elements. However, a list of ascending nodes can be viewed as a in-order traverval of a balanced BST. This means that we can fill the BST by visiting the list sequentially. 

Since we can know the total number of nodes in the tree by iterating through the list once, we can determine the tree structure of the balanced BST. Then we do a in-order traversal and fill the element from the list to the tree, sequentially. Thus the time complexity is $$O(N)$$ and the space complexity is $$O(log N)$$.

One advantage of motivating the solution as a in-order traversal is that we are allowed to solve this problem without recursion.


So what on earth are we trying to save here? time? space? Let us see the following two candidate solutions

1. **Same with the solution for array**: If we follow the the solution for array, then at each level, the time complextiy is O(N), so the total time complexity would be $$O(N log N)$$, while the space complexity is $$O(log N)$$.

2. **Random Access**: One naive but surprisingly effective way of solving this problem is that we just construct a array from it at first. Then we have random access... In this case, we can solve the problem with $$O(N)$$ time and $$O(log N)$$ space.

Therefore, compared with solution 1, we save time. compared with solution 2, we save space.


class Solution {
public:
    TreeNode * construct_tree(int left, int right, ListNode * & current){
        TreeNode *pt = new TreeNode(0);

        int mid = (left + right)/2;
        pt->left = (left < mid)?construct_tree(left, mid-1, current):NULL;
        pt->val = current->val;
        current = current->next;
        pt->right = (right > mid)?construct_tree(mid+1, right, current):NULL;
        return pt;
    }
        
    TreeNode *sortedListToBST(ListNode *head) {
        int nNode = 0;
        ListNode * p = head;
        while(p){
            nNode ++;
            p = p->next;
        }
        p = head;
        
        TreeNode * root = (head)?construct_tree(0, nNode-1, p):NULL;
        return root;
    }
};