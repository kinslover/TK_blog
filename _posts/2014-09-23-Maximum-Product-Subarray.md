---
layout: post
title: Maximum Product Subarray
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, greedy
---

# Description

https://oj.leetcode.com/problems/maximum-product-subarray/

Difficulty: 2.5/5.0 star


# Analysis

This problem looks like a DP problem, however, it can be solved by purely greedy solution.

It is the existence of negative numbers and zeros make this problem non-trivial, so the key lies in how to deal with negative numbers and zeros. For zeros, if we take a span containing zero, then the product is zero, which is not interesting at all. Thus in cases where there are more than two numbers, a span containing zeros will not be the optimal solution.

Supposed that there is no zero in the array, if there are even number of negative numbers, the optimal span would trivially be the whole range.

If there are odd number of negative numbers, please look at the following examples.

``3, -1, 2, 3, -2, 4, 6, -3, 4, 2``

then the solution would be the best in the following two cases

- seq1: ``3, -1, 2, 3, -2, 4, 6``
- seq2: ``2, 3, -2, 4, 6, -3, 4, 2``

Thus the difference is that seq1 has ``3,-1``, while seq2 has ``-3, 4, 2``. Picking the seq that has larger absolute value of the different part will yield the best solution.

When it comes to implementation, two simple sweeps would be enough. The time complexity is $$O(N)$$ and space complexity is constant.


{% highlight c++ %}
class Solution {
public:
	int maxProduct(int A[], int n) {
		if (n == 0)
			return 0;
		if (n == 1)
			return A[0];

		int maxProduct = 0;
		int curProduct = 1;
		int curProductReverse = 1;
		for (int i = 0; i < n; ++ i){
			if (A[i] == 0)
				curProduct = 1;				
			else {
				curProduct *= A[i];
				maxProduct = max(maxProduct, curProduct);
			}
			if (A[n-i-1] == 0)
				curProductReverse = 1;
			else {
				curProductReverse *= A[n-i-1];
				maxProduct = max(maxProduct, curProductReverse);
			}		
		}
		return maxProduct;
	}
};



{% endhighlight %}







