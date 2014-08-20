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


## Solution 1 

The simplest method I can come up is that we enumerate each pair of start point and end point $$[i, j]$$ and compute the area of the rectangle between $$i$$ and $$j$$. The area only **depends on $$j-i+1$$ and the minimum bar height**.

{% highlight ruby %}
maxArea = 0
for i = 0..n-1
	for j = i..n-1
		curArea = min(height, i..j) * ( j - i + 1) /* O(n) operation */
		maxArea = max(curArea, maxArea);
{% endhighlight %}

Thus this is a naive $$O(n^3)$$ solution.

**Key Observation**: Given several consecutive bars, the bar with the mimimum height decides the area of the rectangle formed by those bars. 

## Solution 2

It is very easy to notice that there is lots of redundant computation involved in solution 1. When we compute the minimum height between bar $$i$$ and $$j$$, we do not need to iterate from $$i$$ to $$j$$ every time, if we record, e.g. the min height between $$i+1$$ and $$j$$ in some variable $$minHeight[i+1][j]$$. Then

$$minHeight[i][j] = min(height[i], minHeight[i+1][j])$$

This is a $$O(n^2)$$ solution.

## Solution 3

Let us look at this problem in a slightly different way. Still following the thought the minimum bar is the key bar that decides the area of a rectangle, what is the maximum rectangle that has $$i_{th}$$ bar as the minimum bar? 

The example below gives the answer

<p align="center">
<img src="{{ site.baseurl }}/images/LargestRectangleinHistogram2.png" height="260">
</p>

In this figure, all the bars on the left side (including) the $$1st$$ bar cannot be in the rectangle, because the $$1_{st}$$ bar is the first bar on the left side of $$i_{th}$$ bar $$s.t. height[j] < height[i]$$. Similarly, all the bars on the right side (including) the $$4_{th}$$ bar cannot be in the rectangle.

This is **how to locate the left and right boundaries of a rectangle taking $$i_{th}$$ bar as the shortest one**.

Then it is trivial to compute the area of the rectangle taking $$i_{th}$$ bar as the shortest one

$$area[i] = (right[i] - left[i] + 1) \times height[i]$$

and 

$$maxArea = \max_i area[i]$$

{% highlight ruby%}
maxArea = 0
for i = 0..n-1	
	for right = i..n-1 // find right boundary
		if height[i] > height[right]			
		  break
	for left = i..0  // find left boundary
		if height[i] > height[left]			
		  break
	right --; left ++;
	maxArea = max(maxArea, (right - left + 1) * height[i]));
{% endhighlight %}



The key idea here is that in each outer loop, **we take each bar as the shortest bar in the rectangle and find the left boundary and right boundary of the maximum rectangle that takes this bar as the shortest bar**. Then we compute the area and update $$maxArea$$. 

**NOTE: The following two more efficient algorithms are also doing the same thing, but in a smarter way.**

<p align="center">
<img src="{{ site.baseurl }}/images/LargestRectangleinHistogram1.png" height="260">
</p>

## Solution 4

We start from an example to show how to speed up solution 3

	bar height: 0, 1, 2, 3, 4, e.g. height[i] = i

In solution 3, when we compute the right boundary of $$height[1]$$, we have to iterate from 2 to 4. However an easy observation is that as $$height[2] >= height[1]$$, $$right[1] >= right[2]$$. 

In summary,

- $$right[i] >= right[i+1]$$, if $$height[i] <= height[i+1]$$
- $$right[i] = i, if $$height[i] <= height[i+1]$$

However until now we only know $$right[i] >= right[i+1]$$, if $$height[i] <= height[i+1]$$. What is exactly is $$right[i]$$?

Here comes the whole procedure of computing $$right[i]$$ based on previous observation

- Step1 initialize j = i + 1
- Step2 check if $$j >= n$$ or $$height[i] > height[j]$$,
    - 2.1 if so, $$right[i] = i$$ **END**
    - 2.2 if not, 
        - 2.2.1 j = right[j] + 1
        - 2.2.2 go back to Step2
- Step3 right[i] = j - 1

We use an example to illustrate how the algorithm goes

	bar height: 0, 1, 2, 3, 4, 2, 3
	right:      6, 6, 5, 4, 4, 6, 6

Suppose that we are trying to compute $$right[2]$$, 

- Step1: we find that $$height[3] >= height[2]$$, then we go to $$right[3] + 1 = 5$$. 
- Step2: We find that $$height[5] >= height[2]$$, then we got to $$right[5] + 1 = 6$$. 
- Step3: As $$height[6] >= height[2]$$ and 6 is the last element, 6 is the right boundary for 2, e.g. $$right[2] = 6$$.

It is the same procedure to find the left boundary and here is the code.

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

### Time complextiy

It is a little bit complicated (but not hard) to prove the time complexity is $$O(n)$$. I may try to write a formal proof later. Here is a simple example of how redundant computation is avoided and may give you some intuition.

<p align="center">
<img src="{{ site.baseurl }}/images/LargestRectangleinHistogram3.png" height="260">
</p>

In this example, it is pretty painful to compute $$right[2]$$, because we have to first go to 3, then 4, then 5, which is a $$O(n)$$ procedure. However, when it comes to the computation of $$right[1]$$ after $$right[2] = 5$$ is computed, life is much easier

- in (1), $$height[1] <= height[2]$$, then only 1 operation is enough
    - we go to $$right[2] + 1 = 6$$, but find $$6 == \#bars$$, DONE.
- in (2), $$height[1] > height[2]$$
    - $$height[1] = 1$$, DONE

Actually, after we go through 3, 4, 5 during the computation of $$right[2]$$ we will never have to go through 3, 4, 5 any more in our later computation of $$right[<2]$$. As the total number of bars we can go through is $$n$$, the algorithm is an $$O(n)$$ algorithm.

### More thoughts

The thought of solving this probelm is also kind of similar to Trapping Rain Water. In TRW, we consider about each bar and try to compute the number of units of the water this bar holds by locating the highest bar on both left side and right side respectively, while in this problem, for each bar, we are trying to locate left and right boundaries.


## Solution 5

Solution 5 still sticks on the key idea that we consider each bar as the minimum bar in a rectangle and try to compute the corresponding area by locating its left boundary and right boundary. It is easier to see the time complexity is $$O(n)$$ for this solution.

Solution 4 and 5 look very different from each other, but they are not.

In solution 4, we enumerate each bar as **the minimum bar** in a rectangle, compute the area, and then update the $$maxArea$$.

In solution 5, we enumerate each bar, and **check if this bar can be a right boundary for any bar on the left side of it**. If so, we go back to the stack to check which bars use this bar as right boundary. One brilliant thing about this solution is that we implictly save the information about their left boundaries of those bars in the stack. Then we can compute the area of maximum rectangle for each bar and find the maximum area.

Please refer to my following implementations to figure out the details of this algorithm.


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

## Solution 6

Solution 6 is an $$O(n log n)$$ divide-and-conquer algorithm, which can be found at http://www.geeksforgeeks.org/largest-rectangle-under-histogram/.