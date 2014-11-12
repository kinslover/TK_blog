---
layout: post
title: Letter Combinations of a Phone Number
comments: true
category: Algorithms
tag: algorithm, leetcode
---

# Description

https://oj.leetcode.com/problems/letter-combinations-of-a-phone-number/

Difficulty: 1.5/5.0

# Solution

The DFS solution would be more clear, but a worse solution. It is common that the length of the string is more than several thousands.

{% highlight c++%}
class Solution {
public:
	vector<string> letterCombinations(string digits) {
		string str[] = {" ", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"};
		vector<string>result;
		result.push_back("");
		for(int i = 0; i < digits.size(); ++ i){
			int rSize = result.size();
			for (int j = 0; j < str[digits[i]-'0'].size()-1; ++ j)
				for (int k = 0; k < rSize; ++ k)
					result.push_back(result[k]);
			
			for (int j = 0; j < str[digits[i]-'0'].size(); ++ j)
				for (int k = 0; k < rSize; ++ k)
					result[rSize * (j) + k] += str[digits[i]-'0'][j];
			
		}
		return result;
		
	}
};

{% endhighlight c++%}