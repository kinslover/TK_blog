---
layout: post
title: Interleaving String
published: true
comments: true
category: Algorithms
tag: algorithm, DP, leetcode
---


# Description

Given s1, s2, s3, find whether s3 is formed by the interleaving of s1 and s2.

For example,

Given:

    s1 = "aabcc",
    s2 = "dbbca",

When ``s3 = "aadbbcbcac"``, return true.

When ``s3 = "aadbbbaccc"``, return false.

# Analysis

The simplest way to solve this problem is DFS, whis has exponential time complexity.

Actually this is a problem that can be solved by a typical 2D DP solution.

Supposed that $$yes[i][j]$$ represent if $$S3[i+j-1]$$ can be interleaved by $$S1[0..i-1]$$ and $$S2[0..j-1]$$, then

- $$yes[i][j] = true$$, 
    - if $$S1[i] == S3[i + j - 1]$$ and $$yes[i-1][j] = true$$
    - or if $$S2[j] == S3[i + j - 1]$$ and $$yes[i][j-1] = true$$
- $$yes[i][j] = false$$, otherwise

Then it is kind of obvious that 1-d $$yes[]$$ array is enough. To make things clear, these two solutions are both shown below. The space complexity of the first one is $$O(nm)$$, while that of the second one is $$O(n)$$ (you can make $$O(min(n, m))$$ with simple modifications).

# Solution

{% highlight c++ linenos %}
class Solution {
public:
    bool isInterleave(string s1, string s2, string s3) {
        if (s1.size() + s2.size() != s3.size())
            return false;
            
        bool yes[s1.size()+1][s2.size()+1];
        yes[0][0] = true;
        for (int i = 1; i <= s1.size(); ++ i)
            yes[i][0] = (s1[i-1] ==  s3[i-1]);

        for (int i = 1; i <= s2.size(); ++ i)
            yes[0][i] = (s2[i-1] ==  s3[i-1]);
        
        for (int i = 1; i <= s1.size(); ++ i)
            for (int j = 1; j <= s2.size(); ++ j)
                yes[i][j] = (yes[i][j-1] && s2[j-1] == s3[i+j-1]) || \
                            (yes[i-1][j] && s1[i-1] == s3[i+j-1]);
        return yes[s1.size()][s2.size()];
    }

};
{% endhighlight %}

It is not hard to find out that a 1-d array is enough.

{% highlight c++ linenos %}
// space complexity: O(n) 
class Solution {
public:
    bool isInterleave(string s1, string s2, string s3) {
        if (s1.size() + s2.size() != s3.size())
            return false;
            
        bool yes[s2.size()+1];
        yes[0] = true;        

        for (int i = 1; i <= s2.size(); ++ i)
            yes[i] = (s2[i-1] ==  s3[i-1]);
        
        for (int i = 1; i <= s1.size(); ++ i){
            yes[0] = (s1[i-1] ==  s3[i-1]);
            for (int j = 1; j <= s2.size(); ++ j)
                yes[j] = (yes[j-1] && s2[j-1] == s3[i+j-1]) || \
                            (yes[j] && s1[i-1] == s3[i+j-1]);
        }
        return yes[s2.size()];
    }

};
{% endhighlight %}