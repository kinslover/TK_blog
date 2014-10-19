---
layout: post
title: Reorder List 
comments: true
category: Algorithms
tag: algorithm, leetcode, list
---



# Description

https://oj.leetcode.com/problems/reorder-list/

Difficulty: 2.0/5.0

# Solution

We can solve this problem in three steps.

1. First, locate the head of the second half
2. Second, reverse the second list
3. Third, Merge the two lists


{% highlight c++%}
class Solution {
public:
    void reorderList(ListNode *head) {

    	//count the number of nodes
        int nNode = 0;
        ListNode * pt = head;
        while(pt){
            pt = pt->next;
            nNode ++;
        }
        
        if (nNode < 3)
            return;
        
        // get the head of the second half
        ListNode * ptCur = head;
        for (int i = 0; i < (nNode-1)/2; ++ i)
            ptCur = ptCur->next;
        pt = ptCur->next;
        ptCur->next = NULL;
        
        //reserve the second half and combine the two lists
        pt = reverse_list(pt);
        head = combine_list(head, pt);    

    }
    
    ListNode * reverse_list(ListNode *pt){
        ListNode * ptCur = pt, * ptNext = pt->next;
        ptCur->next = NULL;
        while(ptNext){
            pt = ptNext->next;
            ptNext->next = ptCur;
            ptCur = ptNext;
            ptNext = pt;
        }
        return ptCur;
    }
    
    ListNode * combine_list(ListNode * l1, ListNode * l2){
        ListNode* head = l1;
        while(l1&&l2){
            ListNode* tp1 = l1->next, * tp2 = l2->next;
            l1->next = l2;
            l2->next = tp1;
            l1 = tp1, l2 = tp2;
        }
        return head;
    }
};
{% endhighlight%}