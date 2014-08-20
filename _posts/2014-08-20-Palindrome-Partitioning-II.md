---
layout: post
title: Palindrome Partitioning II 
published: true
comments: true
category: algorithms
tag: leetcode, DP, matrix multiplication
---

# Solution & Analysis

## Analysis

The Solution 1 is a $$O(n^3)$$ solution which is almost the same with the standard solution of Matrix Multiplication. $$num[i][j]$$ records the minimum number of cuts between $$i$$ and $$j$$, which can be calculated by

$$num[i][j] = \min_{k \in i,...j-1} (num[i][k] + num[k+1][j] + 1)$$.

However, there are some redundant and unnecessary operations involved. Instead of computing $$num[i][j]$$ all possible pair $$(i, j)$$, can we find a solution that reduces the amount of computation? The answer is yes.

Let us define a new variable $$minCut[i] = num[0][i]$$. Now I am introducting Solution 2, which only computes $$minCut[i]$$, i.e. $$num[0][i]$$.

For the substring $$str[0...i]$$, we define $$D(i)$$ to be the set of indices less than $$i$$ $$s.t.$$

$$\forall j \in D, str[j+1, i] \mbox{ is Palindrome }$$

then 

- $$minCut[i] = \min_{j \in D(i)} (minCut[j] + 1)$$, if $$str[0,i]$$ is NOT a palindrome
- $$minCut[i] = 0$$, if $$str[0,i]$$ is a palindrome

Below is the pseudo code of the algorithm. In this algorithm, $$is_palindrome[][]$$ can be precomputed in $$O(n^2)$$ time. Therefore, it is a $$O(n^2)$$ solution.

{% highlight c++ linenos%}
	//pseudo code in mixed C++-Python style
	for (int i = 0; i < n; ++ i)
		if (is_palindrome[0][i])
			minCut[i] = 0
		else
			minCut[i] = MAX_INT
			for (int j = 0; j < i; ++ j)
				if (is_palindrome[j+1][i])
					minCut[i] = min(minCut[i], minCut[j] + 1);
	return minCut[n-1]

{% endhighlight %}

# Solution

## $$O(n^3)$$ solution

If you run this code in leetcode OJ, you will get runtime error, as there is a test case where the length of the string is more than 1400. Allocating a 2-D int array with $$1400 \times 1400$$ elements leads to runtime error.

You can replace ``int num[n][n]`` with ``unsigned char num[n][n]``, but it is still a nasty solution.

{% highlight c++ linenos%}
class Solution {
public:
    int minCut(string s) {
        int n  = s.size();
        if (!n) return 0;
        int num[n][n];
        for (int i = 0; i < n; ++ i)
            memset(num[i], 0, sizeof(int) * n);
        
        for (int i = 0; i < n - 1; ++ i)
            num[i][i+1] = (s[i] != s[i+1]);
        
        for (int len = 3; len <= n; ++ len){    
            for (int start = 0; start < n - len + 1; ++ start){
                int end = start + len - 1;
                if (num[start+1][end-1] == 0 && s[start] == s[end])
                    num[start][end] = 0;
                else{
                    num[start][end] = 2100000000;
                    for (int k = start; k < end; ++ k)
                        num[start][end] = min(num[start][k]+num[k+1][end]+1, num[start][end]);
                }
            }
        }
        return num[0][n-1];
    }
};

{% endhighlight %}


## $$O(n^2)$$ solution

{% highlight c++ linenos%}

class Solution{
public:
	int minCut(string s) {
		int n = s.size();
		if (!n) return 0;
		
		// palindrome judgement
		bool isPal[n][n];
		for (int i = 0; i < n - 1; ++ i)
			isPal[i][i] = true, isPal[i][i+1] = (s[i] == s[i+1]);		
		isPal[n-1][n-1] = true;			

		for (int len = 3; len <= n; ++ len){
			for (int start = 0; start < n - len + 1; ++ start){
				int end = start + len - 1;
				isPal[start][end] = (s[start] == s[end]) && isPal[start+1][end-1];
			}			
		}
		
		//calculate minimum number of cut
		int minCutArray[n];
		minCutArray[0] = 0;
		for (int i = 1; i < n; ++ i){
		    if (isPal[0][i]){
		        minCutArray[i] = 0;
		        continue;
		    }
			minCutArray[i] = 2100000000;
			for (int j = 0; j < i; ++ j ){
				if (isPal[j+1][i])
					minCutArray[i] = min(minCutArray[i], minCutArray[j] + 1);
			}
		}
		return minCutArray[n-1];
	} 
};

{% endhighlight %}
