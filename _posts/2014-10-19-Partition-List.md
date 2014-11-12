---
layout: post
title: Partition List
comments: true
category: Algorithms
tag: algorithm, leetcode, list
---

# Description

https://oj.leetcode.com/problems/partition-list/

Difficutly: 1.5/5.0

#Solution

{%highlight c++%}
class Solution {
public:
    ListNode *partition(ListNode *head, int x) {
        ListNode *head1 = new ListNode(-1), * head2 = new ListNode(-1);
        ListNode * pt = head, *p1 = head1, *p2 = head2;
        while(pt){
            if (pt->val < x){
                p1->next = pt;
                p1 = pt;
            }
            else{
                p2->next = pt;
                p2 = pt;
            }
            pt = pt->next;
        }
        p2->next = NULL;
        p1->next = head2->next;
        head = head1->next;
        delete head1;
        delete head2;
        return head;
    }
};
{% endhighlight %}