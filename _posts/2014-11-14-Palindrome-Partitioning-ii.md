---
layout: post
title: Palindrome Partitioning ii 
comments: true
category: Algorithms
tag: algorithm, leetcode, DP
---

# Description

URL: https://oj.leetcode.com/problems/palindrome-partitioning-ii/

Difficulty: 3.0/5.0


# Solution


$$min\_cut[i] = min_{j \in A(i)} \{ min\_cut[j-1]\} + 1$$, where $$A(i) = \{j \ \vert \ s[j][i] \hbox{ is palindrome}\}$$. Here $$i$$$ starts from 1 and ``min_cut[0] = -1``.

The key is that when we use $$min\_cut[j-1]$$ to update $$min\_cut[i]$$, the $$min\_cut[j-1]$$ must already be computed.

The intuitive solution is to first use a 2-D array ``isPalin[i][j]`` to record the if $$S[i..j]$$ is a palindrome, which is $$O(N^2)$$ in both time and space complexity. Then we compute the ``min_cut[i]`` sequentially, the time complexity of which is $$O(N^2)$$. So this is a solution with $$O(N^2)$$ time complexity and $$O(N^2)$$ space complexity.


{% highlight c++ %}

class Solution{
private:
	void palinSolver(const string &s, vector<vector<int>>& palin){
		// char as the mid		
		for (int mid = 0, s_end = s.length(); mid < s_end; ++mid){
			int right = mid + 1;
			for (int left = mid -1; left >= 0 && right < s_end; left --, right ++){
				if (s[left] != s[right])
					break;
				palin[right+1].push_back(left+1);
			}
		}
		// gap as the mid
		for (int mid = 1, s_end = s.length(); mid < s_end; ++mid){
			int right = mid;
			for (int left = mid -1; left >= 0 && right < s_end; left --, right ++){
				if (s[left] != s[right])
					break;
				palin[right+1].push_back(left+1);
			}
		}

	}
public:
	int minCut(string s) {
		int num_char = s.length();

		// compute the adjacent list of palindrome
		vector<vector<int>> palin_adj(num_char+1, vector<int>());		
		for (int i = 0; i < num_char+1; ++ i)
			palin_adj[i].push_back(i);
		palinSolver(s, palin_adj);

		vector<int>min_cut(num_char + 1, INT_MAX);
		min_cut[0] = -1;
		for (int i = 1; i < num_char + 1; ++ i){			
			for (int j = 0, end = palin_adj[i].size(); j < end; j ++){				
				if (min_cut[palin_adj[i][j]-1] != INT_MAX)
					min_cut[i] = min(min_cut[i], min_cut[palin_adj[i][j]-1] + 1);
			}
		}
		return min_cut[num_char];

	}
};

{% endhighlight %}





Note that instead of using the DP thought ``isPalin[i][j] = isPalin[i+1][j-1] && (S[i] == S[j])``. We can also enumerate the centering position and go to both ends, while checking if ``S[left] == S[right]``. By checking palindrome in this way, we can check if  $$S[i][j]$$ is palindrome for every pair of $$(i, j)$$ in $$O(N^2)$$ time without extra space. The question is: can we embed the ``min_cut[]`` computation in this procedure.

In the following code, in the iteration of ``mid``, we only use ``min_cut[< mid]`` to update ``min_cut[>= mid]``, and after iteration of ``mid``, we will never update ``min_cut[<= mid]``. This guarantees that our computation is right.

This solution is $$O(N^2)$$ in time complexity and $$O(N)$$ in space complexity.



{% highlight c++%}
class Solution {
public:
	int minCut(string s){
		// char as the mid		
		int n_char = s.size();
		vector<int>min_cut(n_char+1, n_char + 1);
		min_cut[0] = -1;

		for (int mid = 0, s_end = s.length(); mid < s_end; ++mid){
			//odd number of chars
			for (int left = mid, right = mid; left >= 0 && right < s_end; left --, right ++){
				if (s[left] != s[right])
					break;				
				//is palin
				min_cut[right+1] = min(min_cut[left]+1, min_cut[right+1]);
			}

			//even number of chars
			for (int left = mid, right = mid+1; left >= 0 && right < s_end; left --, right ++){
				if (s[left] != s[right])
					break;
				//is palin
				min_cut[right+1] = min(min_cut[left]+1, min_cut[right+1]);
			}			
		}
		return min_cut[n_char];

	}
};
{% endhighlight%}