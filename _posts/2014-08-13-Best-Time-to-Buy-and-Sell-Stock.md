---
layout: post
title: Best Time to Buy and Sell Stock I, II and III
published: true
comments: true
category: algorithms
tag: leetcode, recursive, algorithm
---

# Description

I: https://oj.leetcode.com/problems/best-time-to-buy-and-sell-stock/

The first problem requires that we compute the possible maximum profit for at most one transaction.

II: https://oj.leetcode.com/problems/best-time-to-buy-and-sell-stock-ii/

The first problem requires that we compute the possible maximum profit for at any number of transactions.

III: https://oj.leetcode.com/problems/best-time-to-buy-and-sell-stock-iii/

The first problem requires that we compute the possible maximum profit for two transactions.

# Analysis

## Problem I
It is easy to solve the first problem by iterating the price vector just once. We keep the currently smallest stock price during the iteration and we update the maximum profit iteratively by 

$$maxProfitLeft[t] = max(maxProfitLeft[t-1], price[t] - currentMinimum),$$

where  $$maxProfitLeft[t]$$ is the possible maximum profit during $$[0,t]$$ and $$maxProfitLeft[0] = 0$$.

## Problem II
It is even easier to solve the second problem. As long as price[t] > price[t-1], we make a transaction. This strategdy will lead to maximum profit.

## Problem III

For the third question, the trivial thought would be that we enumerate the seperate time point of the two transactions and use the solution in problem I as subprocess to find the best separate point and thus the maximum profit. In this case, the time complexity is $$O(n^2)$$. Then we notice that there exists redundant computation in this procedure. There is a better way to avoid the redundant computation.

We compute $$maxProfitLeft[t]$$ as we did in problem I.

Then we define $$maxProfitRight[t]$$ indicating the maximum profit we can get from one transaction during the time $$[t, T]$$, where $$T$$ is the total number of time points, or the size of array $$prices[]$$. The way to compute it is

$$maxProfitRight[t] = max(maxProfitLeft[t+1], currentMaximum - price[t]), $$

where $$maxProfitLeft[T+1] = 0$$.

Then the maximum profit for two non-overlapping transactions is 

$$maxProfit = \max_{t = 1..n} maxProfitLeft[t] + maxProfitRight[t]$$

Thus the time complexity of this solution is $$O(n)$$.


# Solution

The implementations are slightly different from the algorithm descriptions out of efficiency and convenience reasons.

## Problem I

{%highlight c++ linenos %}
class Solution {
public:
    int maxProfit(vector<int> &prices) {
      int minPrice = INT_MAX;
      int maxProfit = 0;
      for (int i = 0; i < prices.size(); ++ i){
        minPrice = min(minPrice, prices[i]);
        maxProfit = max(prices[i] - minPrice, maxProfit);
      }
      return maxProfit;
    }
};
{%endhighlight%}

## Problem II

{%highlight c++ linenos %}
class Solution {
public:
    int maxProfit(vector<int> &prices) {
    	int profit = 0;    	    	
    	//size_t is unsigned and thus tranformed into int, in case of prices.size()=0
  		for (int i = 0; i < (int)prices.size()-1; ++ i)    		
			profit += (prices[i+1] > prices[i])? (prices[i+1] - prices[i]):0;
  		return profit;   
    }
};
{%endhighlight%}

## Problem III

{%highlight c++ linenos %}
class Solution {
public:
    int maxProfit(vector<int> &prices) {
        int nPrice = prices.size();
        int curMin = INT_MAX;
        int maxProfitFromLeft[nPrice+1];
        maxProfitFromLeft[0] = 0;
        for (int i = 0; i < nPrice; ++ i){
            curMin = min(prices[i], curMin);
            maxProfitFromLeft[i] = max(prices[i] - curMin, maxProfitFromLeft[i]);
            maxProfitFromLeft[i+1] = maxProfitFromLeft[i];
        }
        int totalMaxProfit = 0;
        int curMax = INT_MIN;
        for (int i = nPrice-1; i >= 0; i --){
            curMax = max(prices[i], curMax);
            totalMaxProfit = max(maxProfitFromLeft[i] + curMax - prices[i], totalMaxProfit);                
        }
        return totalMaxProfit;
    }
};
{%endhighlight%}
