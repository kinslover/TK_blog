---
layout: post
title: Single Number ii
published: true
comments: true
category: algorithms
tag: leetcode, algorithm, bit operation
---

# Description

https://oj.leetcode.com/problems/single-number-ii/

Difficulty: 2.5/5.0

Related: https://oj.leetcode.com/problems/single-number/

# Analysis and solution


{% highlight c++ %}
class Solution {
public:
    int singleNumber(int A[], int n) {
        int count[32] = {0};
        for (int i = 0; i < n; ++ i){
            int tmp = A[i];
            for (int j = 0; j < 32 && tmp; ++ j, tmp = tmp >> 1)
                count[j] += tmp%2;
        }
        int result = 0;
        for (int i = 0, unit = 1; i < 32; ++ i, unit = unit << 1)
            result += (count[i]%3)?unit:0;
        return result;        
    }
};
{% endhighlight %}