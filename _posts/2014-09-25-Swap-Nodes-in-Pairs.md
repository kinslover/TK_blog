---
layout: post
title: Balanced Binary Tree
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, linked list
---

# Description

https://oj.leetcode.com/problems/swap-nodes-in-pairs/

Difficulty: 1.0/5.0 star

# Solution

Only two moving pointers suffice.

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
 	ListNode *swapPairs(ListNode *head) {
 		if (!head || !head->next)
			return head;
		ListNode * newHead = new ListNode(0);
 		newHead->next = head;
		ListNode * cur = head, * pre = newHead;
		while(cur && cur->next){
			// swap cur and cur->next
			pre->next = cur->next;
			cur->next = cur->next->next;
			pre->next->next = cur;
			pre = cur;
			cur = cur->next;
 		}
		head = newHead->next;
		delete newHead;
		return head;
 	}
};




{% endhighlight%}