---
layout: post
title: Populating Next Right Pointers in Each Node
published: true
comments: true
category: Algorithms
tag: algorithm, stack, leetcode, tree, traversal
---

# Problem Description

https://oj.leetcode.com/problems/populating-next-right-pointers-in-each-node/

# Analysis

The first thought that came to my mind is BFS, as the ``next`` pointers are layer-wise pointers and here is a simple implementation. This solution does not utilize the property that the tree is a perfect binary tree much. A more general solution for any binary tree is that we can have an index on each node representing the position of it in a perfect tree. 

{% highlight c++%}

/**
 * Definition for binary tree with next pointer.
 * struct TreeLinkNode {
 *  int val;
 *  TreeLinkNode *left, *right, *next;
 *  TreeLinkNode(int x) : val(x), left(NULL), right(NULL), next(NULL) {}
 * };
 */
class Solution {
public:
 	void connect(TreeLinkNode *root) {
		if (!root)
			return;
		queue<TreeLinkNode *> nodeQueue;
		nodeQueue.push(root);
		TreeLinkNode * preNode = NULL;
		int capacity = 1;
		int currentNum = 0;
		while(!nodeQueue.empty()){
			TreeLinkNode * curNode = nodeQueue.front();
			nodeQueue.pop();
			currentNum ++;
			if (currentNum == 1)
				preNode->next = NULL;
			else
				preNode->next = curNode;
			if (curNode->left)
				nodeQueue.push(curNode->left);
			if (curNode->right)
				nodeQueue.push(curNode->right);
			if (currentNum == capacity){
				capacity *= 2;
				currentNum = 0;
			}
			preNode = curNode;
 		}
		preNode->next = NULL;
	}
};
{% endhighlight %}

Both the time complexity and space complexity of this algorithm is $$O(n)$$. 

An alternative solution is DFS. While doing DFS, we maintain a vector of pointers for each layer and use these layers to construct ``next`` links. The time complexity is still $$O(N)$$, while the space complexity reduces to $$O(log N)$$.

A good programmer always ask the question: "Can we do better?".So is there any $$O(1)$$ space complextiy solution to this problem? The answer is yes. Supposed that $$i_{th}$$ layer is sorted out with all $$next$$ pointers being set. Then it is easy to set the ``next`` pointers of $${i+1}_{th}$$ layer.


{% highlight c++%}

/**
 * Definition for binary tree with next pointer.
 * struct TreeLinkNode {
 *  int val;
 *  TreeLinkNode *left, *right, *next;
 *  TreeLinkNode(int x) : val(x), left(NULL), right(NULL), next(NULL) {}
 * };
 */
class Solution {
public:
 	void connect(TreeLinkNode *root) {
		if (!root || (!root->left && !root->right ))
			return;
		root->next = NULL;
		TreeLinkNode * curLevelHead = root;
		while(curLevelHead != NULL){
			TreeLinkNode * curNode = curLevelHead;
			TreeLinkNode * curNextLevel = NULL;
			while(curNode!=NULL){
				if (curNode->left){
					curNode->left->next = curNode->right;
					if (curNextLevel == NULL)
						curNextLevel = curNode->left;
				}
				if (curNode->right){					
					curNode->right = (curNode->next)? curNode->next->left : NULL;
					if (curNextLevel == NULL)
						curNextLevel = curNode->right;						
				}
				curNode = curNode->next;
			}
			curLevelHead = curNextLevel;
		}
	}
};
{% endhighlight %}







