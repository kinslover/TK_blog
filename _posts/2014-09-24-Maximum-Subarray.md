---
layout: post
title: Maximum Subarray
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, greedy, DP
---

# Description

https://oj.leetcode.com/problems/maximum-subarray/

Difficulty: 1.0/5.0 star

Related problem: https://oj.leetcode.com/problems/maximum-product-subarray/

Resource:

http://en.wikipedia.org/wiki/Kadane%27s_Algorithm

# Analysis

This is actually a 1-D DP problem. Supposed that $$maxSum[i]$$ indicates the maximum summation you can get with $i_{th}$ element involved, the 

``maxSum[i] = max(A[i], maxSum[i] + A[i])``

When it comes to implementation, we only need constant extra space.


{% highlight c++ %}
class Solution {
public:
 	int maxSubArray(int A[], int n) {
		int curSum = 0;
		int maxSum = INT_MIN;
		for (int i = 0; i < n; ++ i){
			curSum += A[i];
			maxSum = max(maxSum, curSum);
			if (curSum < 0)
				curSum = 0;
		}
		return maxSum;
    }
};
{% endhighlight %}


This problem has a "More practice" part which requires a more subtle divide-and-conquer approach. This solution is not very interesting, but I still include it in this post for your reference. The time complexity is $$O(n log n)$$, while its space complexity is $$O(log n)$$, which are both worse than the DP solution.


{% highlight c++ %}
class Solution {
public:
 	int maxSubArray(int A[], int n) {		
		return maxSubArray(A, 0, n-1);
 	}
 	int maxSubArray(int A[], int startIndex, int endIndex) {
		if (endIndex == startIndex)
			return A[startIndex];
			
		int mid = (startIndex + endIndex)/2;
		int maxSum = max(maxSubArray(A, startIndex, mid), maxSubArray(A, mid+1, endIndex));
		int curSum = 0;
		int leftMaxSum = 0;
		for (int left = mid-1; left >= startIndex; --left){
			curSum += A[left];
			leftMaxSum = max(curSum, leftMaxSum);
		}

		curSum = 0;
		int rightMaxSum = 0;
		for (int right = mid+1; right <= endIndex; ++ right){
			curSum += A[right];
			rightMaxSum = max(curSum, rightMaxSum);
		}

		curSum = leftMaxSum + rightMaxSum + A[mid];
		return max(curSum, maxSum);
	}
};
{% endhighlight %}


