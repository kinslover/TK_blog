---
layout: post
title: Count and Say
comments: true
category: Algorithms
tag: algorithm, leetcode
---

# Description

https://oj.leetcode.com/problems/count-and-say/

Difficulty: 1.0/5.0

# Analysis and solution

``string to_string(int)`` is a very useful function here.


{% highlight c++ %}
class Solution {
public:
    string countAndSay(int n) {
        string result("1");
        for (int i = 0;i < n-1; ++ i)
            result = countAndSayHelper(result);
        return result;
    }
    string countAndSayHelper(const string& result){
        string newResult("");
        int nCount = 1;
        for (int i = 1; i < result.size(); ++ i){
            if (result[i] == result[i-1]){
                nCount ++;
                continue;
            }
            newResult += to_string(nCount) + result[i-1];
            nCount = 1;
        }
        newResult += to_string(nCount) + result[result.size()-1];
        return newResult;
    }
};
{% endhighlight%}