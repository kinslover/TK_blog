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

Difficulty: 1.0/5.0 star

# Solution

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
			curLayer.clear();
			curLayer.push_back(1);
			for (int j = 0; j < i - 1; ++ j)
				curLayer.push_back(pascalTriangle[i-1][j] + pascalTriangle[i-1][j+1]);
			curLayer.push_back(1);
			pascalTriangle.push_back(curLayer);
		}
		return pascalTriangle;
	}
};

{% endhighlight c++ %}