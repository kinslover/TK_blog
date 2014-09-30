---
layout: post
title: Best Time to Buy and Sell Stock I, II and III
published: true
comments: true
category: algorithms
tag: leetcode, algorithm, DP
---



# Description

https://oj.leetcode.com/problems/pascals-triangle-ii/

Difficulty: 2.0/5.0 star

Related: https://oj.leetcode.com/problems/pascals-triangle/

# Analysis and solution

This is actually a subprocess of pascal-trangle i. However, as we want to reuse the space, we have more restrictions, such as we have to iterate from the right end to the left.


{% highlight c++ %}

class Solution {
public:
    vector<int> getRow(int rowIndex) {
  		vector<int>result;
  		result.push_back(1);
  		for (int i = 0; i < rowIndex; ++ i){
  			for (int j = i; j > 0; -- j)
  				result[j] += result[j-1];
  			result.push_back(1);
  		}
  		return result;
    }
};

{% endhighlight %}