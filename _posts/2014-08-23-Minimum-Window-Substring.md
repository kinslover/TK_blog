---
layout: post
title: Minimum Window Substring 
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode
---


# Description


## Solution

The time complexity of the naive solution is $$O(n^2)$$. We take each position as the start left boundary, do the line search to find the right boundary between which the sub string contains all the chars in ``T`` and record the minimum window.

A better solution is that we keep a left pointer ``left`` and right pointer ``right``, both initialized to 0. ``minWindow`` is initialzed to ``MAX_INT``.

- First, we increase the ``right`` pointer until ``S[left, right-1]`` contains all the chars in ``T``
- Second, check if (right - left) < minWindow
    - If so, record ``left`` and ``right``
- Third, we increase the ``left`` pointer by 1
- Forth, check if ``S[left, right-1]`` fails to contain all the chars in ``T``
    - If so, 
        - If ``right == S.size()``: END
        - Else go to First Step
    - Else, go to Second step

# Code

Running time on Leetcode OJ: 304 ms

{% highlight c++ linenos %}
string minWindow(string S, string T) {
    int left = 0, right = 0;
    unordered_map<char, int> checkTable;
    unordered_map<char, queue<int> > char2pos;

    for (int i = 0; i < T.size(); ++ i){
    	if (checkTable.find(T[i]) == checkTable.end()){
    		char2pos[T[i]] = queue<int>();
    		checkTable[T[i]] = 0;
    	}
    	checkTable[T[i]] ++;
    }
    
    int nSpan = 0;        
    int minWindow = 2100000000;
    int lBound = 0, rBound = 0;
    while(right < S.size()){
    	while(right < S.size() && nSpan != T.size()){
    		if (checkTable.find(S[right]) != checkTable.end()){
    			if (char2pos[S[right]].size() < checkTable[S[right]])
    				nSpan ++;
    			char2pos[S[right]].push(right);
    		}
    		right ++;    		
    	}
		
    	while(nSpan == T.size()){
    		if (right - left < minWindow){
    			minWindow = (right - left);
    			lBound = left;
    			rBound = right;
    		}
    		
    		if (checkTable.find(S[left]) != checkTable.end()){
    			char2pos[S[left]].pop();
    			if (char2pos[S[left]].size() < checkTable[S[left]])
    				nSpan --;
    		}
    		left ++;
    	}        	
    }

    return S.substr(lBound, rBound - lBound);
}

{% endhighlight%}