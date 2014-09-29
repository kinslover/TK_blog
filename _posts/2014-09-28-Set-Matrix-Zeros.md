---
layout: post
title: Set Matrix Zeros
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode
---



# Description

https://oj.leetcode.com/problems/set-matrix-zeroes/

Difficulty: 1.0/5.0 star.


# Analysis and solution

The key to avoid using extra space is to reuse the first row and column as marking array.


{% highlight c++ %}
class Solution {
public:
 	void setZeroes(vector<vector<int> > &matrix) {
		int nRow = matrix.size();
		if (!nRow) return;
		int nCol = matrix[0].size();
		
		bool zeroFirstCol = false, zeroFirstRow = false;
		for (int i = 0; i < nCol; ++ i){
			if (matrix[0][i] == 0){
				zeroFirstRow = true;
				break;
			}
 		}
		for (int i = 0; i < nRow; ++ i){
			if (matrix[i][0] == 0){
				zeroFirstCol = true;
				break;
			}
 		}
		for (int i = 1; i < nRow; ++ i)
			for (int j = 1; j < nCol; ++ j)
 				if (matrix[i][j] == 0)
 					matrix[i][0] = 0, matrix[0][j] = 0;
		for (int i = 1; i < nRow; ++ i)
			for (int j = 1; j < nCol; ++ j)
				if (matrix[i][0] == 0 || matrix[0][j] == 0)
					matrix[i][j] = 0;
 		if (zeroFirstCol) 
 			for (int i = 0; i < nRow; ++ i)
 				matrix[i][0] = 0;
 		if (zeroFirstRow) 
 			for (int i = 0; i < nCol; ++ i)
 				matrix[0][i] = 0;
 			 		
 	}
};
{% endhighlight%}
