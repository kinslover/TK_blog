---
layout: post
title: Add Binary
comments: true
category: Algorithms
tag: algorithm, leetcode
---

# Description

https://oj.leetcode.com/submissions/detail/13241213/

Difficulty: 1.0/5.0


# Solution

{% highlight c++ %}
class Solution {
public:
    string addBinary(string a, string b) {
    	string result("");
     	int idxA = a.length()-1, idxB = b.length()-1;
     	int carry = 0;
    	while(idxA >= 0 || idxB >= 0){
     		int re = carry;
     		re += ((idxA >= 0)?(a[idxA] - '0'):0) + ((idxB >= 0)?(b[idxB] - '0'):0);

     		result += to_string(re%2);
     		carry = re/2;
     		idxA --; idxB --;
     	}
     	if (carry)
     	    result += "1";
     	    
     	reverse(result.begin(), result.end());
     	return result;
    }
};
{% endhighlight %}

