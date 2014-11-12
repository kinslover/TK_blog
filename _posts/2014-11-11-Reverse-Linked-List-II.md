---
layout: post
title: Reverse Linked List II
comments: true
category: Algorithms
tag: algorithm, leetcode, linked list
---


# Description

Difficulty: 1.5/5.0

url: https://oj.leetcode.com/problems/reverse-linked-list-ii/

# Solution

{% highlight c++%}

class Solution {
public:
    ListNode *reverseBetween(ListNode *head, int m, int n) {
        ListNode new_head(0);
        new_head.next = head;
        ListNode *p1 = &new_head;
        n -= m;
        while(--m)
            p1 = p1->next;
        ListNode *p2 = p1->next, *p3 = p2->next;
        ListNode *p_temp;
        while(n--){
            p_temp = p3->next;
            p3->next = p2;
            p2 = p3;
            p3 = p_temp;
        }
        p1->next->next = p3;
        p1->next = p2;
        return new_head.next;
    }
};
{% endhighlight %}

