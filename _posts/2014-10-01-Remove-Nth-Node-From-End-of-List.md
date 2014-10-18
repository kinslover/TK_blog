---
layout: post
title: Remove Nth Node From End of List
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode
---

# Description

https://oj.leetcode.com/problems/remove-nth-node-from-end-of-list/

Difficulty: 2.5/5.0

# Analysis and solution

The problem requires to remove the $$n_{th}$$ node from the end of the list within one sweep. So we set two pointers with one being $$n$$ nodes ahead the other.

{% highlight c++%}

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
 	ListNode *removeNthFromEnd(ListNode *head, int n) {
 	    if (!head)
 	        return head;
        ListNode *pt1 = head, *pt2 = head, *newHead = new ListNode(0);
		newHead->next = head;
        ListNode *pt3 = newHead;
		while(n--)
			pt2 = pt2->next;
		while(pt2){
			pt1 = pt1->next;
            pt3 = pt3->next;
			pt2 = pt2->next;
		}
		pt3->next = pt1->next;
		delete pt1;
		head = newHead->next;
		delete newHead;
		return head;
 	}
};

{% endhighlight%}
