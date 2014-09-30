---
layout: post
title: Best Time to Buy and Sell Stock I, II and III
published: true
comments: true
category: algorithms
tag: leetcode, algorithm, recursive
---

# Description

https://oj.leetcode.com/problems/combinations/


Difficulty: 1.0/5.0 star

# Analysis and solution

{%highlight c++%}
class Solution {
public:
 	vector<vector<int> > combine(int n, int k) {
		vector<vector<int> > result;
		vector<int> current;
 		generateCombine(0, n, k, result, current);
		return result;
 	}
	void generateCombine(int start, int n, int k, vector<vector<int> > & result, vector<int> & current){
 		if (current.size() == k){
			result.push_back(current);
			return;
 		}
		int ending = n-(k-current.size())+1;
		for (int i = start; i < ending; ++ i){
			current.push_back(i+1);
			generateCombine(i+1, n, k, result, current);
			current.pop_back();
		}
 	}
};
{% endhighlight%}

