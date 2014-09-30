---
layout: post
title: Spiral Matrix I and II
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode
---



# Description


https://oj.leetcode.com/problems/spiral-matrix/

https://oj.leetcode.com/problems/spiral-matrix-ii/

Difficulty: 1.5/5.0 star

# Analysis

The solution to these two problems are almost the same. 


{% highlight c++ %}
class Solution {
public:
    vector<int> spiralOrder(vector<vector<int> > &matrix) {
        vector<int> result;
        if (!matrix.size()) return result;
        int boundary[4];
        //x boundary
        boundary[0] = 0; boundary[2] = matrix.size()-1;
        //y boundary
        boundary[1] = matrix[0].size()-1; boundary[3] = 0;
        
        
        int direction[4][2] = { {0,1},{1,0},{0,-1},{-1,0} };
        int x = 0, y = 0;
        int n = matrix.size() * matrix[0].size();
        int dir = 0;
        while(n--){
            result.push_back(matrix[x][y]);
            if (x + direction[dir][0] > boundary[2] || x + direction[dir][0] < boundary[0] || y + direction[dir][1] > boundary[1] || y + direction[dir][1] < boundary[3]){
                boundary[dir] += (dir==1 || dir == 2)?-1:1;
                dir = (dir + 1) % 4;
            }
            x += direction[dir][0];
            y += direction[dir][1];
        }        
        return result;        
    }
};

{% endhighlight%}
