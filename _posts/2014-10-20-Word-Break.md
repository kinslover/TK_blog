
---
layout: post
title: Word Break
comments: true
category: Algorithms
tag: algorithm, leetcode, search, memorization
---

# Description

https://oj.leetcode.com/problems/word-break/

Difficulty: 3.0/5.0



# Solution

*Once we have started from a position and come back to this position with the anwser "NO" for matching, we have no need to visit this position again.* This observation can save us a lot of time. Therefore we allocate a bool array to record if a position has been visited or not and search.

As the ``match_helper`` is called for at most $$s.size()$$ times and we have a $$O(N)$$ loop inside of the ``match_helper``, the time complexity is $$O(N^2)$$. The space complexity is $$O(N)$$ obviously.

{% highlight c++%}
class Solution {
public:
    bool wordBreak(string s, unordered_set<string> &dict) {
        bool notReachable[s.size()];
        memset(notReachable, 0, sizeof(bool) * s.size());
        return match_helper(s, 0, dict, notReachable);
    }
    bool match_helper(string &s, int start, unordered_set<string> &dict, bool notReachable[]){
        if (start == s.size())
            return true;
        for (int i = start; i < s.size(); ++ i){
            if (dict.count(s.substr(start, i-start+1))){
                if (!notReachable[i+1] && match_helper(s, i+1, dict, notReachable)) return true;
                else notReachable[i+1] = true;
            }
        }
        return false;
    }
};
{% endhighlight%}







