---
layout: post
title: Wildcard Matching
published: true
comments: true
category: algorithms
tag: leetcode, regular expression
---

# Solution: DFS with memorization

This is a similar problem to [Regular Expression Matching](http://leetcode.com/2011/09/regular-expression-matching.html). However, the test data on leetcode OJ here is much stronger. The length of string can be over 1000. For problem, Regular Expression Matching, I wrote a DFS with memorization [solution](), which solved the problem in 50ms. However that solution will explode the memory in this problem.

To solve this problem, I added more pruning into the search and finally avoided MLE and solved it on OJ in 528 ms (Not good!).

Anyway, here comes the code and the two prunings I used are explained in the comments.

The time complexity complexity is $$O(n^2)$$, as we use ``visited`` to record if a position pair is visited. The space complexity is also $$O(n^2)$$

## Code 

{% highlight c++ linenos%}

class Solution {
public:
    bool isMatch(const char *s, const char *t) {

    	// simplify pattern "a***b" into "a*b"
        int on_streak = 0;
        char tProxy[strlen(t)];
        int tLen = 0;
        for (int i = 0; t[i]; ++ i){
            if (on_streak && t[i] == '*')
                continue;
            on_streak = (t[i] == '*')?1:0;
            tProxy[tLen++] = t[i];            
        }
        tProxy[tLen] = 0;
        
        // record which pair of positions are visited, details go in dfs function
        unordered_set<int>visited;        

        // realNum[i]: number of non-"*" chars in tProxy[i..tLen], for pruning        
        int realNum[tLen+1]; 
        realNum[tLen] = 0;        
        for (int i = tLen-1; i >= 0; -- i)
            realNum[i] = (tProxy[i] == '*')?realNum[i+1]:realNum[i+1] + 1;

        bool re = dfs(0, 0, s, strlen(s), tProxy, tLen, visited, realNum);
        
        return re;  
    }
    
    bool dfs(int idx1, int idx2, const char s[], int sLen, char t[], int tLen, unordered_set<int >&visited, int num[]){
    	// case1: both reach ends, case2: s reach ends, t only has '*' remained
        if ((!s[idx1] && !t[idx2]) || (!s[idx1] && !num[idx2]) )
            return true;

        // PRUNING: ignore the visited pair of positions
        if (visited.count(idx1*(tLen+1) + idx2))
            return false;

        visited.insert(idx1*(tLen+1) + idx2);

        if ( (!s[idx1] && t[idx2]) || (s[idx1] && !t[idx2])  )
            return false;        
        //match
        if (s[idx1] == t[idx2] || t[idx2] == '?' || t[idx2] == '*'){
            if (dfs(idx1+1, idx2+1, s, sLen, t, tLen, visited, num))
                return true;
        }        
        // other two cases for '*'
        if (t[idx2] == '*'){ 
        	// PRUNING: numer of remaining chars in s should be greater or equal to non-"*" in t
        	// otherwise, impossible to match
        	// e.g. s = "aaab" t = "??bbb*"
            if (sLen - idx1 - 1 >= num[idx2] && dfs(idx1+1, idx2,  s, sLen, t, tLen, visited, num))
                return true; 
            if ( sLen - idx1 >= num[idx2+1] && dfs(idx1, idx2+1,  s, sLen, t, tLen, visited, num))
                return true; 
        }        
        
        return false;        
    }
};
{% endhighlight %}

# A DP solution

Let us define ``match[i][j]`` to indicate if string ``s[0...i-1]`` can match pattern ``t[0...j-1]`` or not. Then the state transition function is 

- if ``t[j-1] == '*'``, 
	- ``match[i][j] =`` $$\cup_{k \in \{0,...,i\}}$$ ``match[i-k][j-1]``
- if ``t[j-1] != '*'``, 
	- ``match[i][j] = (match[i-1][j-1]) && (s[i-1] == t[j-1] || t[j-1] == '?')``

As ``match[*][j]`` only relies on ``match[*][j-1]``, we can use 1-D array instead of 2-D array.

## Code

Unfortunately this code will lead to TLE. There is some SPECIAL test case that requires that you treat it special (if you paste this code into OJ, you will see that case). I really dislike this kind of requirement, as we already reached a solution with the best time complexity and neat code implementation.

{% highlight c++ linenos %}

class Solution{
public:
    bool isMatch(const char *s, const char *t) {
    	int sLen = strlen(s), tLen = strlen(t);
    	bool match[sLen+1];
    	memset(match, 0, sizeof(bool) * (sLen + 1));
    	match[0] = true;
    	int firstTruePos = 0;
    	for (int j = 1 ; j <= tLen; ++ j){    		    		
    	    if (t[j-1] != '*'){
    	    	firstTruePos = sLen+1;
    			for (int i = 1; i <= sLen; ++ i){
    				match[i] = (match[i-1]) && (s[i-1] == t[j-1] || t[j-1] == '?');
    				if (firstTruePos == sLen+1 && match[i]) firstTruePos = i;
    			}
    		}
    		else{
    			for (int i = 1; i <= sLen; ++ i)						
    				match[i] = (i < firstTruePos)? false: true;
    		}
    		match[0] = match[0] && (t[j-1] == '*');
    		if (match[0]) firstTruePos = 0;
    	}
    	return match[sLen];
	}	
};

{% endhighlight %}

# A Greedy Solution

The key thoughts of this greedy solution are

- we only care about the last asterik we met. 
- Every time a mismatch happens, one character in ``s`` will be absorbed by the the nearest asterik. 

The conditions for failure of match is
- if no asterik has been spotted before a mismatch happens
- if we find there is no chars left in ``s``, while we still have patterns (chars except asterisk) left in ``p``

The description above is too abstract, let me use a GIF to illustrate how this greedy algorithm works.

<p align="center">
<img src="{{ site.baseurl }}/images/WildcardMatching2.gif">
</p>

The time complexity of this algorithm is still $$O(nm)$$, but as it is pretty "aggressive", it only need linear time for some special cases and the average performance is better than the DP solution.

## Code

Here is my implementation.

{% highlight c++ linenos%}

class Solution {
public:
	bool isMatch(const char *s, const char *t){
		int i = 0, j = 0;
		int lastAsterPos = -1;
		int toAbsorb = -1;
		while(s[i]){
			if (t[j] == '*'){ // Asterisk
				lastAsterPos = j ++;
				toAbsorb = i;
			}
			else if (s[i] == t[j] || t[j] == '?') //match
				i++, j ++;
			else{ //mismatch
				if (lastAsterPos == -1) return false;
				j = lastAsterPos + 1;
				i = ++toAbsorb;
			}
		}
		while(t[j] == '*')
			j++;
		return (!t[j]);
	}
};

{%endhighlight%}
