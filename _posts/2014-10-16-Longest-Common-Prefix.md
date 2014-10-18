---
layout: post
title: Longest Common Prefix
comments: true
category: Algorithms
tag: algorithm, leetcode
---

# Description

https://oj.leetcode.com/problems/longest-common-prefix/submissions/

Difficulty: 1.0/5.0

# Analysis and solution

``string to_string(int)`` is a very useful function here.


{% highlight c++ %}
class Solution {
public:
    string longestCommonPrefix(vector<string> &strs) {
        string result("");
        if (!strs.size())
            return result;
        for (int ps = 0; ps < strs[0].size(); ++ ps){
            int idxStr = 1;
            for (;idxStr < strs.size(); ++idxStr){
                if (ps == strs[idxStr].size() || strs[idxStr][ps] != strs[idxStr-1][ps])
                    break;
            }
            if (idxStr >= strs.size())
                result += strs[0][ps];
            else
                break;
                
        }
        return result;
    }
};

{% endhighlight%}