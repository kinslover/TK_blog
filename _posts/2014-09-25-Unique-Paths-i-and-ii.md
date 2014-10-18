---
layout: post
title: Unique Paths i and ii
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, combinatorial, BFS
---


# Description

https://oj.leetcode.com/problems/unique-paths/

Difficulty: 2.5/5.0 star

# Analysis

It is fairly easy to resort to BFS to solve this problem. 

However, for the first problem, as there is no obstacle at all, this problem should have closed-form combinatorial solution. Supposed that our target is ``(m, n)`` (coordinate starts from 0), then we know that we have to take exactly ``m`` steps downwards and ``n`` steps rightwards. Thus the number of unique paths is $$C_{m+n}^n$$.

For the second problem, we do not need BFS either, as we can only move from top-left to bottom-right, a two-layer loop would suffice.



# Solution


{% highlight c++%}
// Problem i
class Solution {
public:
    int uniquePaths(int m, int n) {
    	int minNum = min(m-1, n-1);
    	int sumNum = m + n - 2;
    	long long result  = 1;
    	for (int i = 1; i <= minNum; ++ i){
    		result *= sumNum--;
    		result /= i;
    	}
    	return (int)result;
	}
};
{% endhighlight %}


{% highlight c++%}
class Solution {
public:
    int uniquePathsWithObstacles(vector<vector<int> > &obstacleGrid) {
        int nRow = obstacleGrid.size(), nCol = obstacleGrid[0].size();
        int nPaths[nRow][nCol];
        nPaths[0][0] = (obstacleGrid[0][0])?0:1;
        for (int i = 1; i < nRow; ++ i)
            nPaths[i][0] = (obstacleGrid[i][0]|| !nPaths[i-1][0])? 0:1;
        for (int i = 1; i < nCol; ++ i)
            nPaths[0][i] = (obstacleGrid[0][i]|| !nPaths[0][i-1])? 0:1;        

        for (int i = 1; i < nRow; ++ i)
            for (int j = 1; j < nCol; ++ j)
                nPaths[i][j] = (obstacleGrid[i][j])?0:(nPaths[i-1][j] + nPaths[i][j-1]);
        return nPaths[nRow-1][nCol-1];

    }
};
{% endhighlight %}
