
---
layout: post
title: Reverse Words in a String 
comments: true
category: Algorithms
tag: algorithm, leetcode
---


# Description

https://oj.leetcode.com/problems/reverse-words-in-a-string/

Difficulty: 2.0/5.0


# Solution

We can do an in-place reversal by

- First, reverse the whole string
- Second, reverse the individual string

In this way, the time complexity is $$O(N)$$ and the space complexity is $$O(1)$$. 

A simpler solution is to use some auxiliary space ($$O(N)$$), as below.

{% highlight c++%}
class Solution {
public:
	void reverseWords(string &s) {
		string result;
		int idxLeft = 0;
		while(idxLeft < s.size() && s[idxLeft] == ' ')
			idxLeft ++;

		while(idxLeft < s.size()){
			int idxRight = idxLeft;
			while(idxRight < s.size() && s[idxRight] != ' ')
				idxRight ++;
			result = s.substr(idxLeft, idxRight-idxLeft)+ ((result.size())?" ":"") + result;
			while(idxRight < s.size() && s[idxRight] == ' ' ) // skip the spaces
				idxRight ++;
			idxLeft = idxRight;
		}
		s = result;
	}
};
{% endhighlight %}
