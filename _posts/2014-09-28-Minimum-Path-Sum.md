---
layout: post
title: Minimum Path Sum
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode
---

# Description

https://oj.leetcode.com/problems/minimum-path-sum/

Difficulty: 1.5/5.0 star


# Analysis and solution

This is an problem easy to solve. One thing worth noting is that we do not need BFS with a 2D-array. Two-layer loop with 1D-array is quite enough, as we only move from top-left to bottom-right.

This problem is kind of similar to Unique Path. Blindly using BFS is not a good solution.

{% highlight c++%}

class Solution {
public:
    int minPathSum(vector<vector<int> > &grid) {
		if (grid.size() == 0) return 0;
		int nRow = grid.size(), nCol = grid[0].size();
	    int pathSum[nCol];
		pathSum[0] = grid[0][0];
		for (int i = 1; i < nCol; i ++)
			pathSum[i] = pathSum[i-1] + grid[0][i];
		for (int i = 1; i < nRow; ++ i){
			pathSum[0] = pathSum[0] + grid[i][0];
			for ( int j  = 1; j < nCol; ++ j){
				pathSum[j] = min(pathSum[j-1], pathSum[j]) + grid[i][j];
	 		}
	 	}
	 	return pathSum[nCol-1];
    }
};




{% endhighlight%}
