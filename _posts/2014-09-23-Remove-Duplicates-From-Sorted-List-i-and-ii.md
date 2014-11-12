---
layout: post
title: Remove Duplicates from Sorted List i and ii
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, list
---

# Description

URL: https://oj.leetcode.com/problems/remove-duplicates-from-sorted-list/
https://oj.leetcode.com/problems/remove-duplicates-from-sorted-list-ii/

Difficulty: 1.0/5.0 stars for problem i and 1.5/5.0 for problem ii

# Solution

{% highlight c++%}
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */

// for problem i
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

// for problem ii
class Solution {
public:
    ListNode *deleteDuplicates(ListNode *head) {
        if (head == nullptr)
            return nullptr;
        ListNode new_head((head->val == 1)?0:1); // give the new_head a value that is different from the head
        new_head.next = head;
        ListNode * pt_father = &new_head, *pt = head, *pt_tmp;
        while(pt){
            bool flg = false;
            while(pt->next && pt->val == pt->next->val){
                flg = true;
                pt_tmp = pt->next;
                delete pt;
                pt = pt_tmp;
            }
            if (flg){ 
                pt_father->next = pt->next;
                delete pt;
            }
            else
                pt_father = pt_father->next;
            pt = (pt_father)?pt_father->next:nullptr;
        }
        return new_head.next;

    }
};

{% endhighlight %}

