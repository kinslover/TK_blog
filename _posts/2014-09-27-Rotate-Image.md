---
layout: post
title: Rotate Image
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode
---

# Description

https://oj.leetcode.com/problems/rotate-image/

Difficulty: 1.5/5.0 star


# Analysis and solution

We enumerate each block in the pink area and swap the four purple blocks following the arrows.

<p align="center">
<img src="{{ site.baseurl }}/images/rotate_image.png" height="200">
</p>

{% highlight c++ %}

class Solution {
public:
 	void rotate(vector<vector<int> > &matrix) {
 		int n = matrix.size();
 		int tmpSwap;
 		for (int i = 0; i < n/2; ++ i){
 			for (int j = 0; j < (n+1)/2; ++ j){
 				tmpSwap = matrix[i][j];
 				int x = i, y = j, xTmp;
 				for (int k = 0; k < 3; k ++){
 					matrix[x][y] = matrix[n-1-y][x];
 					xTmp = x;
 					x = n-1-y;
 					y = xTmp;
 				}
 				matrix[x][y] = tmpSwap;
 			}
 		}
 	}
};
{% endhighlight %}



