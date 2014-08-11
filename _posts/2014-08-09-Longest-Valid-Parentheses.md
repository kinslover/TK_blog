---
layout: post
title: Longest Valid Parentheses
published: true
comments: true
category: Algorithms
tag: algorithm, stack, leetcode

---

# Description

Given a string containing just the characters '(' and ')', find the length of the longest valid (well-formed) parentheses substring.

For "(()", the longest valid parentheses substring is "()", which has length = 2.

Another example is ")()())", where the longest valid parentheses substring is "()()", which has length = 4.

# Solution

{% highlight c++ %}
class Solution {
public:
    int longestValidParentheses(string s) {
		int n = s.size();
		int mx = 0;
		stack<int>stk;
		for (int i = 0; i < n; ++ i){
			if (s[i] == '(')
				stk.push(-1);
			else{
				if(stk.empty())
					continue;
				int to_push = 0;
				if (stk.top() > 0){
					to_push = stk.top();
					stk.pop();
				}

				if (!stk.empty() && stk.top() == -1){
					stk.pop();
					to_push += 2;
					if (!stk.empty() && stk.top() > 0){
						to_push += stk.top();
						stk.pop();
					}
					stk.push(to_push);
					mx = max(mx, to_push);
				}

			}	
		}
		return mx;
	}
};
{% endhighlight %}

We maintain a stack
