---
layout: post
title: Insertion Sort List
comments: true
category: Algorithms
tag: algorithm, leetcode, linked list
---

# Description

Difficulty: 1.5/5.0

Description: https://oj.leetcode.com/problems/insertion-sort-list/

# Solution

{% highlight c++ %}

class Solution {
public:
    ListNode *insertionSortList(ListNode *head) {
        ListNode new_head(INT_MIN);
        new_head.next = head;
        ListNode * candidate = new_head.next;
        ListNode * end = &new_head;
        while(candidate){

            if (candidate->val >= end->val){ // should be placed at the end
                end = candidate;
                candidate = candidate->next;
                continue;
            }
            // should be inserted at a certain position
            auto * pt = &new_head;
            for( ; pt->next!= candidate && pt->next->val < candidate->val; pt = pt->next)
                ;
            end->next = candidate->next;
            candidate->next = pt->next;
            pt->next = candidate;
            candidate = end->next;
        }
        return new_head.next;
    }
};
{% endhighlight %}