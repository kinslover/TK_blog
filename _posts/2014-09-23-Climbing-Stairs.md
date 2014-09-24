---
layout: post
title: Search Insert Position
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, DP
---

# Description

https://oj.leetcode.com/problems/climbing-stairs/

Difficulty: 0.5/5 star

# Analysis

It is the simplest DP problem. The only trick here is that we can solve it with constant space.




class Solution {
public:
 	int climbStairs(int n) {
 		int numDistinctWays[3] = {1, 1, 2};
        for (int i = 3; i <= n; ++ i)
			numDistinctWays[i%3] = numDistinctWays[(i+1)%3] + numDistinctWays[(i+2)%3]; 	
		return numDistinctWays[n%3];
 	}
};




