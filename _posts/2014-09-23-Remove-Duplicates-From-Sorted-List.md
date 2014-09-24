---
layout: post
title: Remove Duplicates from Sorted List 
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, list
---

# Description

https://oj.leetcode.com/problems/remove-duplicates-from-sorted-list/

Difficulty: 0.5/5.0 stars

# Solution


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
 	ListNode *deleteDuplicates(ListNode *head) {
 		if (!head)
 			return head;
		ListNode *curNode = head->next;
		ListNode *preNode = head;
		while(curNode){
			while(curNode && curNode->val == preNode->val)
				curNode = curNode->next;	
			preNode->next = curNode;
			preNode = curNode;
			curNode = (curNode)?curNode->next:NULL;
}
return head;
    }
};


