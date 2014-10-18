---
layout: post
title: ZigZag Conversion
comments: true
category: Algorithms
tag: algorithm, leetcode
---

# Description

https://oj.leetcode.com/submissions/detail/13239400/

Difficulty: 1.0/5.0

# Solution

Note that the corner case where ``nRow = 1`` has to be addressed at the beginning.

{% highlight c++ %}
class Solution {
public:
 	string convert(string s, int nRows) {

 		if (nRows == 1)
 		    return s;
 		string re; 		    
		int gap = 2 * nRows - 2;
 		for (int i = 0; i < nRows; ++ i){
			for (int j = i; j < s.size(); j += gap){
 				re += s[j];
 				int idx = j - i +  gap - i;
 				if (idx < s.size() && i && i != nRows-1 )
 	 				re += s[idx];
			}
 		}
 		return re;
 	}

};
{% endhighlight %}