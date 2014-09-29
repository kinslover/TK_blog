---
layout: post
title: Search a 2D Matrix
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, binary search
---

# Description

https://oj.leetcode.com/problems/search-a-2d-matrix/

Difficulty: 1.0/5.0

# Analysis and solution

{% highlight c++ %}
class Solution {
public:
    bool searchMatrix(vector<vector<int> > &matrix, int target) {
    	vector<int>firstCol;
    	for (int i = 0 ; i < matrix.size(); i ++)
    		firstCol.push_back(matrix[i][0]);
    	int indx = binary_search(firstCol, target);
    	if (indx == -1)
    		return true;
    	if (indx == 0)
    		return false;
    	return (binary_search(matrix[indx-1], target) == -1)
    }
    int binary_search(vector<int> candidates, int target){
    	int left = 0;
    	int right = candidates.size()-1;
    	while(left <= right){
    		int mid = (left + right) >> 1;
    		if (candidates[mid] == target)
    			return -1;
    		else if(target < candidates[mid])
    			right = mid - 1;
    		else
    			left = mid + 1;
    	}
    	return left;
    }
};
{% endhighlight%}