---
layout: post
title: Search in Rotated Sorted Array
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, binary search
---

# Description

https://oj.leetcode.com/problems/search-in-rotated-sorted-array/

Difficulty: 2.5/5.0

# Analysis and solution


We solve this problem by first locating the pivot and then do binary searches on each part seperately.

The way to locate the pivot is to locate the $i$, where $A[i] > A[i+1]$. Thus we initialize ``left = 0, right = n-1`` and then shrink the length of interval ``[left, right]`` by half while maintaining ``A[left] > A[right]`` until ``left = right - 1``.

{% highlight c++ %}
class Solution {
public:
    int search(int A[], int n, int target) {
        int left = 0, right = n - 1;
        while (right - left > 1){
            int mid = (left + right) >> 1;            
            if (A[mid] > A[left])
                left = mid;
            else
                right = mid;
        }
            
        int idx = binary_search(0, left, A, target);
        if (idx == -1)
            idx = binary_search(right, n-1, A, target);
        return idx;
    }

    int binary_search(int left, int right, int A[], int target){
        while(left <= right){
            int mid = (left + right) >>1;
            if (A[mid] == target)
                return mid;
            else if (target < A[mid])
                right = mid -1;
            else
                left = mid + 1;
        }
        return -1;
    }
};
{% endhighlight%}
