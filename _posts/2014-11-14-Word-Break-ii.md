---
layout: post
title: Word Break ii 
comments: true
category: Algorithms
tag: algorithm, leetcode, DP, DFS
---

# Description

URL: https://oj.leetcode.com/problems/word-break-ii/

Difficulty: 3.0/5.0


# Solution

We use DFS to enumerate each possible separation of the string. To avoid some of the redundant computation, we use an unordered set ``not_possible`` to record the position $$j$$ that already has been visited and found that $$S[j..end]$$ cannot be separated into valid words. Here, we can also use $$DP[j]$$ to record the valid separations for $$S[j..end]$$ to further avoid redundant computation, but it will use more space.

{% highlight c++%}
// Solution 1
class Solution {
public:
    vector<string> wordBreak(string s, unordered_set<string> &dict) {
		vector<string>result;
		unordered_set<int>not_possible;		
		if (!s.length())
			return result;
		wordBreakHelper(s, 0, dict, result, not_possible, "");
		return result;        
    }
    bool wordBreakHelper(const string& s, int start, const unordered_set<string> dict,
    					vector<string>& result, unordered_set<int>& not_possible, string current){
    	if (start == s.size()){
    		current.pop_back();
    		result.push_back(current);
    		return true;
    	}
    	if (not_possible.count(start))
    		return false;
    	bool flg = false;
    	for (int end = start; end < s.size(); ++ end){
    		string sub_str = s.substr(start, end- start + 1);
    		if (dict.count(sub_str))
    			flg = wordBreakHelper(s, end+1, dict, result, not_possible, current + sub_str + " ") || flg;    		
    	}
    	if (!flg)
    		not_possible.insert(start);
    	return flg;
    }
};

// Solution 2
class Solution {
public:
    vector<string> wordBreak(string s, unordered_set<string> &dict) {		
		vector<vector<string>>DP(s.length()+1, vector<string>());		
		unordered_set<int>not_possible;		
		if (!s.length())
			return result;
		wordBreakHelper(s, 0, dict, result, not_possible, "");
		return DP[0];        
    }
    bool wordBreakHelper(const string& s, int start, const unordered_set<string> dict,
    					vector<vector<string>>&DP, unordered_set<int>& not_possible, string current){
    	if (start == s.size()){
    		return true;
    	}
    	if (not_possible.count(start))
    		return false;
    	bool flg = false;
    	for (int end = start; end < s.size(); ++ end){
    		string sub_str = s.substr(start, end- start + 1);
    		if (dict.count(sub_str)){
    			bool tp_flg = wordBreakHelper(s, end+1, dict, DP, not_possible, current + sub_str + " ");
    			if (tp_flg){
    				if (end+1 == s.length())
    					DP[start].push_back(sub_str);
    				else
    					for (int i = 0; i < DP[end+1].size(); ++ i)
    						DP[start].push_back(sub_str + " " + DP[end+1]);    				
    			}
    			flg ||=  tp_flg;    		
    		}
    	}
    	if (!flg)
    		not_possible.insert(start);
    	return flg;
    }
};
{% endhighlight%}