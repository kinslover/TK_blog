---
layout: post
title: Maximal Rectangle 
published: true
comments: true
category: Algorithms
tag: algorithm, stack, leetcode
---

# Description

Given a 2D binary matrix filled with 0's and 1's, find the largest rectangle containing all ones and return its area.

# Analysis

This is an interesting problem. It is hard to come up with the best solution if you have not solved Largest Rectangle in Histogram.

The brute-force solution to this problem is very time consuming. The worst one could be $$O(n^3m^3)$$, by enumerate the pair of top-left corner and bottom-right corner, where $$n$$ is the number of rows and $$m$$ is the number of columns.

The interesting part is that we actually can use the solution of Largest Rectangle in Histogram as a sub-procedure to solve this problem in $$O(nm)$$ time, which is a great improvement compared with the bruteforce solution.

The way to do it is that we enumerate each row to find the largest rectangle that lies on this row (i.e. the bottom of the rectangle is on this row) and then identify the maximum one across rows. For each row, what we need to do is exactly what we do in Largest Rectangle in Histogram.

As we run the sub-procedure $$n$$ times, the time complexity of which is $$O(m)$$, the total time complexity of the algorithm is $$O(nm)$$.

The code below is pretty self-explained.

# Solution
{% highlight c++ linenos%}
class Solution {
public:
    int maximalRectangle(vector<vector<char> > &matrix) {
        if (!matrix.size()) return 0;
        
        vector<int>cur;
        for (int i = 0; i < matrix[0].size(); ++ i)
            cur.push_back(matrix[0][i]-'0');
        
        int maxArea = largestRectangleArea(cur);
        
        for (int i = 1; i < matrix.size(); ++ i){
            accumulate(matrix[i], cur);
            maxArea = max(maxArea, largestRectangleArea(cur));
        }
        return maxArea;
    }

    int largestRectangleArea(vector<int> &height) {
        // Solution to the Largest Rectangle in Histogram can be found at 
        // http://tkcrown.github.io/TK_blog/algorithms/2014/08/19/Largest-Rectangle-in-Histogram.html
    }

    void accumulate(vector<char> &source, vector<int> &target){
        int n = target.size();
        for (int i = 0; i < n; ++ i)
            target[i] = (source[i] == '1') ? target[i]+1 : 0;
    }
};

{% endhighlight %}