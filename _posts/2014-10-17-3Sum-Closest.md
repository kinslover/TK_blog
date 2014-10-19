---
layout: post
title: 3Sum Closest
comments: true
category: Algorithms
tag: algorithm, leetcode
---


# Description

https://oj.leetcode.com/problems/3sum-closest/

Difficulty: 2.5/5.0

# Solution

Very Samilar with 3sum.

{% highlight c++ %}

class Solution {
public:
 	int threeSumClosest(vector<int> &num, int target) {
 		int left = 0;
 		int minDiff = INT_MAX;
 		int bestSum = 0;
 		sort(num.begin(), num.end());
		while(left < ((int)num.size()-2)){
			int mid = left + 1, right = num.size()-1;
			while(mid < right){
			    int sum = num[left] + num[mid] + num[right];
				int diff = abs(sum - target);
				minDiff = min(diff, minDiff);			    
				bestSum = (minDiff == diff)?sum:bestSum;
				if (!minDiff)
					return bestSum;
 				else if (sum > target)
					do{right --;}while(mid < right && num[right] == num[right+1]);
 				else
 					do{mid ++;}while(mid < right && num[mid] == num[mid -1]);
 			}
 			do {left++;}while(left < (int)num.size() - 2 && num[left] == num[left-1]);
 		}

 		return bestSum;
 	}
};

{% endhighlight %}