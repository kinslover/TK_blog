---
layout: post
title: Linked List Cycle i and ii 
comments: true
category: Algorithms
tag: algorithm, leetcode
---


# Description

https://oj.leetcode.com/problems/linked-list-cycle/

https://oj.leetcode.com/problems/linked-list-cycle-ii/

# Solution

Solutions to both problems are based on slow-fast pointers. If there is a cycle, the the slow and fast pointer will meet finally. 

{% highlight c++%}
class Solution {
public:
    bool hasCycle(ListNode *head) {
        ListNode * slowPt = head, * fastPt = head;
        while(fastPt){
            slowPt = slowPt->next;
            fastPt = (fastPt->next)?fastPt->next->next:NULL;
            if (slowPt == fastPt)
                break;
        }
        if (fastPt == NULL)
            return false;
        return true;
    }
};
{% endhighlight%}


For the second problem, we have to find where the circle starts, so let us look at the figure below and do some math work.

<p align="center">
<img src="{{ site.baseurl }}/images/LinkedListCycle.png" height="200">
</p>

Supposed that the slow and fast pointers met at the purple node, as the fast pointer is twice faster than slow pointer, we have the relationship

$$
a + k_1 \cdot (b+c) + b = 2  (a + k_2 \cdot (b+c) + b)
$$

Then we have 

$$
a = c + (k_1 - 2 k_2 - 1)(b+c)
$$

If we have a new pointer starting from the head and the other pointer starting at the node where slow and fast pointers meet (i.e., the purple node), they will meet at **red node**, because $$a\%(b+c) = c$$ and purple node is $$c$$ nodes far from the red node.



{% highlight c++%}
class Solution {
public:
    ListNode *detectCycle(ListNode *head) {

		ListNode *p1 = head, *p2 = head;
		while(p2){
			p1 = p1->next;
			p2 = (p2->next)?p2->next->next:NULL;
			if (p1 == p2)
				break;
 		}
 		if (p2 == NULL)// no cycle
 		    return NULL;
		p2 = head;
		while(p1 != p2){
			p2 = p2->next;
			p1 = p1->next;
 		}
		return p1;
    }
};
{% endhighlight%}