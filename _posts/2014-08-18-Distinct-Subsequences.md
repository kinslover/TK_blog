---
layout: post
title: Distinct Subsequences 
published: true
comments: true
category: algorithms
tag: leetcode, DP
---

# Description

Sort a linked list in $$O(n log n)$$ time using constant space complexity.

# Analysis

We can solve this problem with DP solution. Here we use $$num[i][j]$$ to represent the number of sub-string  $$T[0..j]$$ appearing in string $$S[0...i]$$.

So if $$S[i] != T[j]$$, then we know

$$num[i][j] = num[i-1][j]$$

and if $$S[i] == T[j]$$,

$$num[i][j] = num[i-1][j] + num[i-1][j-1],$$

where $$num[i-1][j-1]$$ indicates the number of matches where we use $$S[i]$$ to match $$T[j]$$, while $$num[i-1][j]$$ indicates the number of matches where we do not use $$S[i]$$ to match $$T[j]$$.

As we can see, in the $$i_{th}$$ iteration, we only use information in $${i-1}_{th}$$ iteration. Thus there is no need to save a 2D array, as all information in $$1st..{i-2}_{th}$$ iterations is useless. One thing worth noting that in the second layer of loop, we need to loop from $$T.size()$$ to $$1$$, i.e. in the reverse order. The reason is that if we iterate from $$0..T.size()$$, $$num[i-1][j-1]$$ will be overwritten by $$num[i][j]$$, then $$num[i][j+1]$$ will be calculated using $$num[i][j]$$ instead of $$num[i-1][j]$$, which is wrong.


# Solution 

{% highlight c++ linenos%}
class Solution {
public:
    int numDistinct(string S, string T) {
        int num[T.size()+1];
        memset(num, 0, sizeof(int) * (T.size()+1));
        num[0] = 1;  
        for (int i = 1; i <= S.size(); ++ i)
            for (int j = T.size(); j >= 1; -- j) // attention here: reverse iteration
                if (S[i-1] == T[j-1])                                       
                    num[j] += num[j-1];
                   
        return num[T.size()];
    }
};
{%endhighlight%}