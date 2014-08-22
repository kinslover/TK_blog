---
layout: post
title: First Missing Positive
published: true
comments: true
category: algorithms
tag: leetcode, recursive
---

# Description

Link: https://oj.leetcode.com/problems/first-missing-positive/

# Solution

{% highlight c++ linenos %}
class Solution {
public:
    int firstMissingPositive(int A[], int n) {
    	for (int i =0; i < n; ++ i)
    		if (A[i] == -1)
    			A[i] = -3;

        for (int i = 0; i < n; ++ i){
        	if (A[i] > n || A[i] < 1)        		
        		continue;
        	int tp = A[i];
        	while (tp-1 > i && tp-1 < n){
        		int cache = A[tp-1];
        		A[tp-1] = -1;
        		tp = cache;
        	}
        	if (tp <= n && tp >= 1)
        		A[tp-1] = -1;
        }
       
        for (int i = 0; i < n; ++ i){
        	if (A[i] != -1)
        		return i + 1;
        }
        return n+1;
    }
};
{% endhighlight %}

# Analysis

This problem requires using $$O(n)$$ time and $$O(1)$$ space. Thus we re-use the array A[] to record which positive number has appeared.

In my algorithm, I use A[i] = -1 to mark the appearance of the positive number i+1, however, it is possible that some A[j] = -1 in the first place. Thus we preprocess A[] changing all navtive -1 into -3.

Then in every loop $$i$$, we mark A[A[i]-1] = -1. One problem is that, maybe A[i]-1 is greater than i, which means A[A[i]-1] has not been visited yet, if we blindly change A[A[i]-1] to -1 to mark the appearance of A[i], we will lose the information about A[A[i]-1].

Therefore, I use a while loop to up at line 12 to solve this problem. Whenever we meet a A[i], where A[i]-1 > i, we cache tp = A[A[i]-1] and change A[A[i]-1] to -1, then we do the same thing to the cached tp, until we find tp <= i or tp is not legal (negative or above n).

## Time complextiy

- In the preprocess step is $$O(n)$$. 
- In the loop part, A[j] will be visited if 
    - i = j
    - or $$\exists k, A[k]-1 = j$$

So the total time of visits is at most $$2n$$, which means the time complexity of this algorithm is $$O(n)$$.
