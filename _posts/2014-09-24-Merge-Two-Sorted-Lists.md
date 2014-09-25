---
layout: post
title: Merge Two Sorted Lists
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode
---

# Description

https://oj.leetcode.com/problems/merge-two-sorted-lists/

Difficulty: 0.5/5.0 star


# Solution


{% highlight c++ %}

/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
class Solution {
public:
 	ListNode *mergeTwoLists(ListNode *l1, ListNode *l2) {
		ListNode * newHead = new ListNode(0);
		ListNode * curNode = newHead;
		while(l1 && l2){
			curNode->next = (l1->val < l2->val)?l1:l2;
			curNode = curNode->next;
			if (l1->val < l2->val)
			    l1 = l1->next;
			else
 			    l2 = l2->next;
		}
		ListNode * remainList = (l1)?l1:l2;
		while(remainList){
			curNode->next = remainList;
			remainList = remainList->next;
			curNode = curNode->next;
		}
		curNode = newHead;
		newHead = newHead->next;
		delete curNode;
		return newHead;
 	}
};

{% endhighlight%}



