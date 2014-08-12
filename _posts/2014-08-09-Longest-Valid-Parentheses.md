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

# Analysis

We maintain a stack which contains some positive number and -1 (representing '(').

First, I will use the example "())(())" of how this algorithm works.

1. S[0] = '(': pushing -1 into the stack  (stk = "(" )
2. S[1] = ')': As stk is not empty and stk.top() = '(' we pop the top and then push 2 into the stack. the maximum variable is updated to 2. (stk = "2" )
3. S[2] = ')': As stk.top() == a number, we pop the number. Then the stk is empty. (stk = "" )
4. S[3] = '(': pushing -1 into the stack  (stk = "(" )
5. S[4] = '(': pushing -1 into the stack  (stk = "((" )
6. S[5] = ')': As stk.top() == '(', we pop the top and push 2. (stk = "(2" )
7. S[6] = ')': As stk.top() == a number, we pop the number 2. Then the stk is NOT empty and the current top is '('. So we pop '(' and push the sum (2+2=4) into the stk. (stk = "4" ) we update the maximum variable to be 4. (stk = "4" )

This procedure of stk's changing shows the algorithm more clearly. Some of the states of the stack below will not appear during the real execution of the program, for example ")" will never be pushed into the stack, but to make things clear, I include these "hidden" steps here.

["(" => "()" => "2" => "2)" => "" => "(" => "((" => "(()" => "(2" => "(2)" => "4"  ]

In summary, if 

- S[i] = '(': we push -1 into the stk.
- S[i] = ')': we check if the stk is empty. 
	- if not, we check the top element
		- if a number, we cache it and pop the top
	- then we check the top again, if a '(', we know we have got a valid pair and then pop the top
		- As it is possible that the second top now is also a number of valid length (ex. stk = "2()"), we check it and pop it if it is a number.
		- we push the sum of the above three into the stk

## About time complexity,

- the number of times "-1" is pushed into the stack equals the number of "(" in the string.
- The maximum number that can appear in the stack is less or equal to n (the length of the strings), thus the number of pushes when s[i] = ')' must be less than n.

Thus it is a $$O(n)$$ solution.
