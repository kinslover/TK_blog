---
layout: post
title: Length of Last Word 
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode
---

# Description

https://oj.leetcode.com/problems/length-of-last-word/

Difficulty: 1.0/5.0

# Analysis and solution

We count the length of each word sequentially and keep the last one as the result;

{% highlight c++%}
class Solution {
public:
    int lengthOfLastWord(const char *s) {
     	int len = 0;
     	int lenS = strlen(s);
     	char state = 0;
     	for (int i = 0; i < lenS; ++i){
    		if (state == 1 && s[i] == ' ')
    		    state = 0;
    	    else if (state == 1 && s[i] != ' ')
    	        len ++;
            else if (state == 0 && s[i] != ' ')
                len = 1, state = 1;
     	}
     	return len;
    }
};
{% endhighlight %}

