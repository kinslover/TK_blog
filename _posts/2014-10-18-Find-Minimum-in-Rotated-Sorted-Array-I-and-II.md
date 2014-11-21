---
layout: post
title: Find Minimum in Rotated Sorted Array I and II
comments: true
category: Algorithms
tag: algorithm, leetcode
---


# Description

https://oj.leetcode.com/problems/find-minimum-in-rotated-sorted-array/

Difficulty: 1.5/5.0

Related: 

- Search in Rotated Sorted Array I
- Search in Rotated Sorted Array II
- Find Minimum in Rotated Sorted Array II


# Solution

It is a simplified version of *Search in Rotated Sorted Array I*. We are only required to find the pivot point. One thing worth attention is that **the array is not guaranteed to be rotated**.

{% highlight c++%}
class Solution {
public:
    int findMin(vector<int> &num) {            
        int left = 0, right = num.size() - 1;
        if (num[left] <= num[right]) return num[left]; //maybe not rotated.....
        while(left < right - 1){
            int mid = (left + right) >> 1;
            if (num[left] > num[mid])
                right = mid;
            else
                left = mid;
        }
        return num[right];
    }
};

class Solution {
public:
    int findMin(vector<int> &num) {
        if (num.size() == 0)
            throw runtime_error("Empty vector");
        int left = 0, right = num.size()-1;
        if (num[left] <= num[right]) return num[left]; //maybe not rotated.....

        while(left < right && num[left] == num[right]) 
            left ++;
        while(left < right-1){
            int mid = (left + right) >> 1;
            if (num[right] < num[mid])
                left = mid;
            else
                right = mid;
                
        }
        return num[right];//in case, no rotation exists
    }
};
{% endhighlight %}