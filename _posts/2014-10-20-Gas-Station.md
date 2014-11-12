
---
layout: post
title: Gas Station
comments: true
category: Algorithms
tag: algorithm, leetcode, greedy
---

# Description

https://oj.leetcode.com/problems/gas-station/

Difficulty: 4.0/5.0


# Solution

This is not a easy problem. First thing to clarify is that we can only go from $$i$_th$ station to $$(i+1)_{th}$$ station. 

Then we can prove (details omitted) that 

*If $$\forall k \in [i, j-1]$$, $$S_{i,k} >= 0$$, but $$S_{i,j} < 0$$, then we cannot reach the  $$(j-1)_{th}$$ station from any station in $$[i,j]$$ (i.e., $$S_{k, j} < 0, \forall k \in [i,j]$$).* This means that we cannot travel around starting from stations in $$[i,j]$$

Here $$S_{i,j} = \sum_{k=i}^j (gas[k] - cost[k])$$.

Therefore, the algorithm is that we start from gas station $$k = 0$$ and we keep the current net gas in the tank $$sum$$, once the $$sum < 0$$, we know that the stations that we have been before cannot be the starting stations. Then we clear the net gas $$sum$$ and move to the next station and check.

If the total net gas is negative, then we do not have a solution, otherwise, we are guaranteed to be able to find a solution.


{% highlight c++ %}
class Solution {
public:
	int canCompleteCircuit(vector<int> &gas, vector<int> &cost) {
		int sum = 0, totalSum = 0;
		int result = 0;
		for (int i = 0; i < gas.size(); ++ i){
			sum += gas[i] - cost[i];
			if (sum < 0){
				result = i+1;
				sum = 0;
			}
			totalSum += gas[i] - cost[i];
		}
		if (totalSum < 0)
			return - 1;
		return result;
	}
};
{% endhighlight %}