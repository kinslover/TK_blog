---
layout: post
title: Generate Parentheses
published: true
comments: true
category: algorithms
tag: leetcode, recursive, algorithm
---

# Description

As long as you have gotten more left Parentheses in your string, you can put a right parenthesis in it.

# Analysis and solution

{% highlight c++%}
class Solution {
public:
 	vector<string> generateParenthesis(int n) {
 		vector<string>result;
 		string tmpStr;
 		generateParenthesis(n, 0, 0, tmpStr, result);
 		return result;
 	}
 	void generateParenthesis(int n, int nLeft, int nRight, string &str, vector<string> &result){
 		if (str.length() == 2 * n)
			result.push_back(str);
 		
		if (nLeft < n){
 			str += "(";
			generateParenthesis(n, nLeft+1, nRight, str, result);
			str.pop_back();
 		}
		if (nRight < nLeft){
 			str += ")";
			generateParenthesis(n, nLeft, nRight+1, str, result);
			str.pop_back();
 		}
 	}
};

{% endhighlight%}