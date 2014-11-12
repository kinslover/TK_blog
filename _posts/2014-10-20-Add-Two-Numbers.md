---
layout: post
title: Subsets i and ii
comments: true
category: Algorithms
tag: algorithm, leetcode, linked list
---

# Description

https://oj.leetcode.com/problems/add-two-numbers/

Difficulty: 1.0/5.0

# Solution


{%highlight c++%}
class Solution {
public:
    ListNode *addTwoNumbers(ListNode *l1, ListNode *l2) {
        ListNode new_head(-1);
        auto * cur = &new_head;
        int carry = 0;
        while(l1 && l2){
            cur->next = new ListNode(l1->val + l2->val + carry);
            cur = cur->next;
            carry = (cur->val/10);
            cur->val %= 10; 
            l1 = l1->next; l2 = l2->next;
        }
        for (auto * l_non_empty = (l1)?l1:l2; l_non_empty; l_non_empty = l_non_empty->next){
            cur->next = new ListNode(l_non_empty->val + carry);
            cur = cur->next;
            carry = (cur->val/10);
            cur->val %= 10; 
        }
        if (carry)
            cur->next = new ListNode(1);
        return new_head.next;
    }
};
{%endhighlight%}