---
layout: post
title: Pascal's Triangle
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, combinatorial, BFS
---


# Description

https://oj.leetcode.com/submissions/detail/12004124/

Difficulty: 2.0/5.0 star

Related: https://oj.leetcode.com/problems/pascals-triangle-ii/

# Solution

Here we use pascals-triangle-ii as a subprocess which speeds up the compution. It finishes in 4ms in leetcode OJ.

{% highlight c++ %}
class Solution {
public:
	vector<vector<int> > generate(int numRows) {
		vector<vector<int> > pascalTriangle;
		if (!numRows)
			return pascalTriangle;
		vector<int>curLayer; curLayer.push_back(1);
		pascalTriangle.push_back(curLayer);
		for (int i = 1; i < numRows; ++ i){	  		
	  		for (int j = i; j > 0; -- j)
	  			curLayer[j] += curLayer[j-1];
	  		curLayer.push_back(1);
			pascalTriangle.push_back(curLayer);
		}
		return pascalTriangle;
	}
};

{% endhighlight c++ %}