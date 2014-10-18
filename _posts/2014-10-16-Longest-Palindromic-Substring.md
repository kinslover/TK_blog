---
layout: post
title: Longest Palindromic Substring
comments: true
category: Algorithms
tag: algorithm, leetcode, DP, palindrome
---

# Description

Difficulty: 1.0-3.5/5.0 star

https://oj.leetcode.com/problems/longest-palindromic-substring/

# Solution

This is an interesting problem. There are five solutions: Brute force ($$O(N^3)$$ , $$O(1)$$), DP ($$O(N^2)$$ , $$O(N^2)$$), LCS-DP ($$O(N^2)$$ , $$O(N)$$), Center-oriented ($$O(N^2)$$ , $$O(1)$$), Manacher’s Algorithm ($$O(N)$$ , $$O(1)$$), where the first term in the bracket is the time complexity and the second term is the space complexity.

## Brute Force Solution

This is trivial. We enumerate each pair of indices and check if the substring is palindrome or not. The checking operation takes $$O(N)$$ time. So the total time complexity is $$O(N^3)$$.

## DP solution

In BF solution, we have lots of redundant checking involved. Obviously ``isPalin[i][j] = isPalin[i+1][j-1] && (s[i] == s[j])``. Utilizing this relationship, we can reduce the time complexity to $$O(N^2)$$. However, as we have to record ``isPalin[i][j]``, the space complexity of this algorithm is also $$O(N^2)$$.

{% highlight c++%}
class Solution {
public:
 	string longestPalindrome(string s) {
		if (s.size() <=1)
			return s;
		int finalLeft = 0;
		int mxLen = 1;
		bool isPalin[s.size()][s.size()];
		for (int i = 0; i < s.size(); ++ i)
			
		for (int i = 0; i < s.size()-1; ++ i){
			isPalin[i][i] = true;
			isPalin[i][i+1] = (s[i] == s[i+1]);
			if (isPalin[i][i+1]) mxLen = 2;
		}
 		for (int len = 3; len <= s.size(); ++ len){
			for (int left = 0; left + len - 1 < s.size(); ++ left){
				int right = left + len -1;
				isPalin[left][right] = (s[left] == s[right])?isPalin[left+1][right-1]: 0;
				if (isPalin[left][right]){
					mxLen = len;
					finalLeft = left;
 				}
					
			}
 		}
 		return s.substr(finalLeft, mxLen);
 	}
};
{% endhighlight%}

## Longest Common Substring Algorithm (LCS-DP)

LCS is a famous DP algorithm that whose time complexity is $$O(N^2)$$ and the space complexity is $$O(N)$$. The longest palindromic substring is just the LCS of ``s`` and the reverse string of ``s``. So the time and space complexity of solving the LPS problem are the same with that of LCS.

## Center-Oriented Solution

In this algorithm, we enumerate the possible center of the palindrome and try to expand the left and right boundaries of the palindrome at the same time. Thus for each center, finding the longest palindrome takes $$O(N)$$ time. Since we have $$2N-1$$ centers (\eg, in string "12", '1','2' and the gap between '1' and '2' are the three possible centers), the time complexity is $$O(N^2)$$. As we do not need any auxiliary array, the space complexity is only $$O(1)$$.


{% highlight c++%}
class Solution {
public:
 	string longestPalindrome(string s) {
		if (s.size() <= 1)
			return s;
		int mxLen = 1;
		int finalLeft = 0;
		for (int mid  = 0; mid < s.size(); ++ mid){
			int left = mid - 1, right = mid + 1;
			while(left >= 0 && right < s.size() && s[left] == s[right]){
				mxLen = max(mxLen, right - left+1);
				finalLeft = (mxLen == right - left+1)?left:finalLeft;
				left --, right ++;
 			}
			left = mid - 1, right = mid;
			while(left >= 0 && right < s.size() && s[left] == s[right]){
				mxLen = max(mxLen, right - left+1);
				finalLeft = (mxLen == right - left+1)?left:finalLeft;
				left --, right ++;
 			}
 		}
		return s.substr(finalLeft, mxLen);
 	}
};
{% endhighlight %}

## Manacher’s Algorithm

This is a ($$O(N), O(N)$$) tricky solution. Details can be found at http://leetcode.com/2011/11/longest-palindromic-substring-part-ii.html. 