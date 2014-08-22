---
layout: post
title: Implement strStr()
published: true
comments: true
category: algorithms
tag: leetcode, kmp
---

# Description

https://oj.leetcode.com/problems/implement-strstr/

Difficulty: ?

# Analysis

Solved by KMP algorithm in $$O(n+m)$$ time.

# Solution

{% highlight c++ linenos %}
class Solution {
public:
    char *strStr(char *str1, char *str2) {
		int len1 = strlen(str1);
		int len2 = strlen(str2);
		if (len2 > len1)
			return NULL;
		int move[len2];
		genMove(str2, move);

		int idx1 = 0;
		int idx2 = 0;
		while (idx1 < len1 && idx2 < len2){		
			if (str1[idx1] != str2[idx2]){
			    if (!idx2)
					idx1 ++ ;
			    else
				    idx2  = move[idx2];
			}
			else{
				idx1++;
				idx2++;
			}
		}

		if (idx2 == len2)
			return str1 + idx1 - len2;
		
		return NULL;
    }

	void genMove(char* str, int move[])
	{
		int n = strlen(str);

		int idx = 0;
		move[0] = 0;
		for (int i = 1; i < n; ++ i){
		move[i] = idx++;
			if (str[i] != str[idx])
				idx = 0;			
		}      
	}
};
{% endhighlight %}