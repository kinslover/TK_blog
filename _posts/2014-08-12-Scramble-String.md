---
layout: post
title: Scramble String
published: true
comments: true
category: algorithms
tag: leetcode, recursive
---

# Description

Given a string s1, we may represent it as a binary tree by partitioning it to two non-empty substrings recursively.

Below is one possible representation of s1 = "great":

{% highlight ruby%}
    great
   /    \
  gr    eat
 / \    /  \
g   r  e   at
           / \
          a   t
{% endhighlight%}

To scramble the string, we may choose any non-leaf node and swap its two children.

For example, if we choose the node "gr" and swap its two children, it produces a scrambled string "rgeat".

{% highlight ruby%}
    rgeat
   /    \
  rg    eat
 / \    /  \
r   g  e   at
           / \
          a   t
{% endhighlight%}

We say that "rgeat" is a scrambled string of "great".

Similarly, if we continue to swap the children of nodes "eat" and "at", it produces a scrambled string "rgtae".

{% highlight ruby%}
    rgtae
   /    \
  rg    tae
 / \    /  \
r   g  ta  e
       / \
      t   a
{% endhighlight%}

We say that "rgtae" is a scrambled string of "great".

Given two strings s1 and s2 of the same length, determine if s2 is a scrambled string of s1.

# Solution

{% highlight c++ linenos %}
class Solution {
public:
    bool isScramble(string s1, string s2) {
  		if (s1 == s2)
  			return true;
  		if (revserse_equal(s1, s2))
  			return true;

		int len = s1.size();

  		int count[26];
  		memset(count, 0, sizeof(int) * 26);
  		for (int i = 0; i < len; ++ i){
  			count[s1[i]-'a'] ++;
  			count[s2[i]-'a'] --;
  		}
  		// check if the frequency of letters are the same in s1 and s2
  		for (int i = 0; i < 26; ++ i) 
  			if (count[i] )
  				return false;
  				
  		if (len == 1)
  			return true;  				

  		bool flg = false;
  		for (int par = 1; par < len; ++ par){ // select the partition point
  			flg = flg || judge(par, s1, s2);
  			if (flg)
  				return flg;
  		}
  		return flg;  		
    }
    bool judge(int par, string &s1, string &s2){
        int len = s1.size();
  		bool flg = isScramble(s1.substr(0, par), s2.substr(0, par)) && \
  		isScramble(s1.substr(par, len - par),s2.substr(par, len - par));
  		flg = flg || ( isScramble(s1.substr(0, par), s2.substr(len - par, par)) &&\
  		 isScramble(s1.substr(par, len - par), s2.substr(0, len - par)) );
  		return flg;
    }
    bool revserse_equal(string s1, string s2){
    	for (int i = 0; i < s1.length(); ++ i){
    		if (s1[i] != s2[s1.length()-1 - i])
    			return false;
    	}
    	return true;
    }
};

{% endhighlight%}

# Analysis

This is a recursive solution. We iteratively select a partition point at each level and divide each string into two substrings. As we can swap the children of any non-leaf node, we have to judge recursively if

1.(Children not swapped) s1[0, par-1] == s2[0, par-1] AND s1[par, end] == s2[par, end]  
2.(Children swapped) s1[0, par-1] == s2[len - par, end] AND s1[par, end] == s2[0, par-1]

S1 would be a SS of S2 if either of (1) and (2) is satisfied.

There also exists DP solution to this problem.

