---
layout: post
title: Copy List with Random Pointer
comments: true
category: Algorithms
tag: algorithm, leetcode, linked list
---



# Description

Difficulty: 1.5/5.0

URL: https://oj.leetcode.com/problems/copy-list-with-random-pointer/


# Solution

The most intuitive solution is to use a hash table to record the mapping relationship of the old nodes to the new nodes. After copying the list by setting the right next pointers, we go through the list again to set the random pointers. As we use a hash table to record the mapping relationship, the space complexity is $$O(N)$$. This is solution 1.

The other way to solve this problem is to use the random pointers in the original list as the "extra space", where we do not need the hash table any more. This means that we do not need extra space any more. However, this is usually a bad solution, because we have to alter the original list, which is usually forbidden to be modified. Leetcode OJ recently updated their data to kick the ass of this solution.

{% highlight c++%}
// Solution 1: use O(N) space complexity, O(N) time complexity
class Solution {
public:
    RandomListNode *copyRandomList(RandomListNode *head) {
        unordered_map<RandomListNode *, RandomListNode *> old_to_new;
        RandomListNode new_head(-1);
        RandomListNode *pt = &new_head, *cur = head;
        
        while(cur){
            pt->next = new RandomListNode(cur->label);
            old_to_new[cur] = pt->next;
            cur = cur->next;
            pt = pt->next;
        }
        pt->next = nullptr;
        

        for (cur = head, pt = new_head.next; cur;
                cur = cur->next,pt = pt->next){
            pt->random = old_to_new[cur->random];
            
        }
        return new_head.next;
        
    }
};

// Solution 2: use O(1) space complexity, O(N) time complexity
class Solution {
public:
    RandomListNode *copyRandomList(RandomListNode *head) {
        RandomListNode new_head(-1);
        RandomListNode *pt, *cur;
        
        for (pt = &new_head, cur = head; cur; cur = cur->next, pt = pt->next){
            pt->next = new RandomListNode(cur->label);
            pt->next->random = cur->random;
            cur->random = pt->next;
        }
        pt->next = nullptr;
        
        for (pt = new_head.next; pt; pt = pt->next)
            pt->random = (pt->random)?pt->random->random:nullptr;
        
        
        return new_head.next;
        
    }
};
{% endhighlight %}


