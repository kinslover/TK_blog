---
layout: post
title: Unique Paths 
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, combinatorial, BFS
---


# Description

https://oj.leetcode.com/problems/unique-paths/

Difficulty: 2.5/5.0 star

# Analysis

It is fairly easy to resort to BFS to solve this problem. However, as there is no obstacle at all, this problem should have closed-form combinatorial solution.

Supposed that our target is ``(m, n)`` (coordinate starts from 0), then we know that we have to take exactly ``m`` steps downwards and ``n`` steps rightwards. Thus the number of unique paths is $$C_{m+n}^n$$.



# Solution

I only included the combinatorial solution in this post. The BFS solution is fairly easy to implement.

{% highlight c++%}
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





