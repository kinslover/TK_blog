---
layout: post
title: Valid Parentheses
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode
---


# Description

https://oj.leetcode.com/submissions/detail/12337172/

Difficulty: 1.5/5.0 star


# Analysis and solution

We use a stack to check if the current parenthesis is valid. 

{% highlight c++%}
class Solution {
public:
    bool isValid(string s) {
        stack<char>valid;
        unordered_map<char, char>match;
        match['}'] = '{'; match[']'] = '['; match[')'] = '(';
        for (int i = 0; i < s.length(); ++ i ){
            if (s[i] == '}' || s[i] == ']' || s[i] == ')'){
                if (!valid.size() || valid.top() != match[s[i]])
                    return false;
                else
                    valid.pop();
            }
            else
                valid.push(s[i]);
        }
        if (!valid.size())
            return true;
        return false;
    }
};
{% endhighlight%}