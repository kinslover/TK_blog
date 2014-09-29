---
layout: post
title: Search in Rotated Sorted Array ii
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, binary search
---

# Description

https://oj.leetcode.com/problems/search-in-rotated-sorted-array/

Difficulty: 2.5/5.0

# Analysis and solution

The solution to problem i almost works for all cases with redundancy except 
	1,1,1,1,2,3,1,1,1
where the left side equals to the right side. Thus we first eliminate all the 1s at the right side and we get
	1,1,1,1,2,3.


{% highlight c++%}

class Solution {
public:
    bool search(int A[], int n, int target) {
        
        while(n != 1 && A[n-1] == A[0])
            n--;
        int left = 0, right = n - 1;
        while (right - left > 1){
            int mid = (left + right) >> 1;            
            if (A[mid] >= A[left])
                left = mid;
            else
                right = mid;
        }
            
        int idx = binary_search(0, left, A, target);
        if (idx == -1)
            idx = binary_search(right, n-1, A, target);
        return (idx != -1);
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