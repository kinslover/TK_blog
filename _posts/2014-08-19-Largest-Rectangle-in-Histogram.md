---
layout: post
title: Largest Rectangle in Histogram 
published: true
comments: true
category: Algorithms
tag: algorithm, stack, leetcode
---

# Description

https://oj.leetcode.com/problems/largest-rectangle-in-histogram/

# Analysis

**Key Observation**: Given several consecutive bars, the bar with the mimimum height decides the area of the rectangle formed by those bars.


## Solution 1 

The simplest method I can come up is that we enumerate each pair of start point and end point $$[i, j]$$ and find the bar with minimum height in $$[i, j]$$ and then compute the area. Next we update the $$maxArea$$

{% highlight ruby %}
maxArea = 0
for i = 0..n-1
	for j = i..n-1
		curArea = min(height, i..j) * ( j - i + 1) /* O(n) operation */
		maxArea = max(curArea, maxArea);
{% endhighlight %}

Thus this is a naive $$O(n^3)$$ solution.

## Solution 2

It is very easy to notice that there is lots of redundant computation involved in solution 1. When we compute the minimum height between bar $$i$$ and $$j$$, we do not need to iterate from $$i$$ to $$j$$ every time, if we record, e.g. the min height between $$i+1$$ and $$j$$ in some variable $$minHeight[i+1][j]$$. Then

$$minHeight[i][j] = min(height[i], minHeight[i+1][j])$$

This is a $$O(n^2)$$ solution.

## Solution 3

Still following the thought the minimum bar is the key bar that decides the area of a rectangle, here I introduce another way of computing the $$maxArea$$. This solution is still $$O(n^2)$$, but a further improvement will be based on this one in solution 4.


{% highlight ruby%}
maxArea = 0
for i = 0..n-1
	curArea = height[i]
	for j = i+1..n-1 // find right boundary
		if height[i] <= height[j]
			curArea += height[j];
		else break
	for j = i-1..0  // find left boundary
		if height[i] <= height[j]
			curArea += height[j];
		else break
	maxArea = max(maxArea, curArea);
{% endhighlight %}


The key idea here is that in each outer loop, we take each bar as the minimum bar in the rectangle and find the left boundary and right boundary of the maximum rectangle that takes this bar as the mimimum bar. Then we compute the area and update $$maxArea$$. 



<p align="center">
<img src="{{ site.baseurl }}/images/LargestRectangleinHistogram1.png">
</p>

## Solution 4

Here is an example

	bar height: 0, 1, 2, 3, 4, e.g. height[i] = i

In solution 3, when we compute the right boundary of $$height[1]$$, we have to iterate from 2 to 4. However an easy observation is that $$right[1] >= right[2]$$, as $$height[2] >= height[1]$$. In summary,

$$right[i] >= right[i+1]$$, if and only if $$height[i] <= height[i+1]$$.

This observation will help us speed up the algorithm a lot.

Therefore once we find $$height[i] <= height[i+1]$$, we know that $$right[i] >= right[i+1]$$. Then we check if $$height[i] <= height[right[i+1]+1]$$ or not. If so right[i] >= right[right[i+1]+1]. So and so forth.

Here is an example

	bar height: 0, 1, 2, 3, 4, 2, 3
	right:      6, 6, 5, 4, 4, 6, 6

Suppose that we are trying to compute $$right[2]$$, 

- Step1: we find that $$height[3] >= height[2]$$, then we go to $$right[3]+1 = 5$$. 
- Step2: We find that $$height[5] >= height[2]$$, then we got to $$right[5] + 1 = 6$$. 
- Step3: As $$height[6] >= height[2]$$ and 6 is the last element, 6 is the right boundary for 2, e.g. $$right[2] = 6$$.


It is the same procedure to find the left boundary.

### Time complextiy

I am not quite sure about the time complexity of this algorithm. The way I boost the speed is similar to the thought of path compression in Union-Find set. I tried to come up with some example to screw up this algorithm but failed. Anyway, the average time complexity will be way better than $$O(n^2)$$ solution. The running time of it in leetcode is 64ms, which is not a bad result.

I strongly suspect this is a $$O(n)$$ solution. Solution 5, which will be discussed later is obviously a $$O(n)$$ solution. I run solution 4 and 5 on leetcode OJ for several times. The running time of S5 is usually higher than S4 (maybe it is because of the slow STL stack).

{% highlight c++ linenos %}

class Solution {
public:
    int largestRectangleArea(vector<int> &height) {
        int maxArea = 0;
        int n = height.size();
        
        int left[n]; // array of left boundary for each bar
        int right[n]; // array of right boundary for each bar
        
        //looking for the left boundary
        for (int i = 0; i < height.size(); ++ i){
            left[i] = i;
            int j = i-1;                       
            while(j >= 0 && height[j] >= height[i]){              
                left[i] = left[j];
                j = left[j]-1;
            }
        }
        //looking for the right boundary
        for (int i = n-1; i >= 0 ; -- i){
            right[i] = i;
            int j = i+1;
            
            while(j < n && height[j] >= height[i]){
                right[i] = right[j];
                j = right[j]+1;
            }
            maxArea = max(maxArea, (right[i] - left[i] + 1) * height[i]);
        }        

        return maxArea;
        
    }
};
{% endhighlight %}

## Solution 5 & 6

Solution 5 still sticks on the key idea that we consider each bar as the minimum bar in a rectangle and try to compute the corresponding area by locating its left boundary and right boundary, but this solution use some much trickier thought to do it. As a result, the time complexity is obviously $$O(n)$$.

The detailed explanation can be found in http://www.geeksforgeeks.org/largest-rectangle-under-histogram/. There you will also find the solution 6, which is a $$O(nlogn)$$ divide-and-conquer solution.

Below is my implementation of the $$O(n)$$ solution, where the comments may help you understand the algorithm. Bear in mind that the **key idea** used here will help you undertand it much faster.


{% highlight c++ linenos %}
class Solution {
public:
    int largestRectangleArea(vector<int> &height) {
        stack<int>stk;
        int maxArea = 0;        
        height.push_back(0);
        int n = height.size();
        for (int i  = 0; i < n; ++ i){            
            while (!stk.empty() && height[stk.top()] > height[i] ){
                // the index of minimum bar in the rectangle that we currently consider
                int curIdx = stk.top(); 
                stk.pop();
                int leftBoundary = (stk.empty())? 0 : stk.top()+1;
                // the right boundary is obviously i-1
                int curArea = (i - leftBoundary) * height[curIdx];
                maxArea = max(maxArea, curArea);
            }
            stk.push(i);            
        }           
        
        return maxArea;
    }
};
{% endhighlight %}


[pic1]: {{ site.url }}/images/LargestRectangleinHistogram1.png  "Example of left boundary and right boundary"
