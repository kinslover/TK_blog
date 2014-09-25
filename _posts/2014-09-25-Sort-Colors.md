---
layout: post
title: Sort Colors
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode
---

# Description

https://oj.leetcode.com/problems/sort-colors/

Difficulty: 2.5/5.0 star

# Analysis

This problem is pretty trivial if it is not restricted to one sweep. When restricted to one sweep, we use three indice to track the "progress" of each color. Actually it is hard to tell which methods involve more operations. Supposed that we have $$n_0$$ zeros, $$n_1$$ ones, and $$n_2$$ twos in the array. Then the total operations involved in one-sweep method is $$3 * n_0 + 2 * n_1 + n_2$$, while that of two-sweep method is obviously $$2 * n_0 + 2 * n_1 + 2 * n_0$$. The difference is $$n_0 - n_2$$.

The reason for giving 2.5 stars to it is that coming up with an elegant and neat code needs come work.

{% highlight c++ %}

class Solution {
public:
    void sortColors(int A[], int n) {
    	int indexColor[3] = {0,0,0};
    	for (int i = 0 ; i < n; i ++){
    		int curColor = A[i];
    		for (int j = 2; j > curColor; -- j){
    			if (indexColor[j] != indexColor[j-1])
    				A[indexColor[j]] = j;
    			indexColor[j] ++;
    		}
    		A[indexColor[curColor] ++ ] = curColor;
    	}
    }
};

{% endhighlight %}