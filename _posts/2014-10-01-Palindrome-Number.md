---
layout: post
title: Palindrome Number
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode
---


# Description

https://oj.leetcode.com/problems/palindrome-number/

Difficulty: 2.5/5.0

# Analysis and solution

The main thing you want to avoid in this problem is overflow. If you reverse the integer, it overflows for ``1111119999``. If you write ``while(x/(10 * unitHigh))``, it overflows for any integer greater or equal to 1 billion.


{% highlight c++ %}
class Solution {
public:
    bool isPalindrome(int x) {
        if (x < 0)
            return false;
        int unitHigh = 1;
        while(x/10/unitHigh)
            unitHigh *= 10;
        
        while(x){
            if (x/unitHigh != x %10)
                return false;
            x = (x % unitHigh)/10; 
            unitHigh /=100;
        }
        return true;
    }
};
{% endhighlight %}
