---
layout: post
title: Word Ladder 
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, BFS
---


# Description

Difficulty: 2.0/5.0

URL: https://oj.leetcode.com/problems/word-ladder/


# Solution

This problem requires us to find the shortest path to transform from string ``s1`` to ``s2``. The intermediate string must belong to a dictionary. So this problem can be solved by BFS.

We have two ways to generate the next candidate. 

- Try to change each character in the source string and check if this string is both in the dictionary and not visited yet. If the length of string is $$L$$, the time complexity of this step would be $$26 * L$$.
- Try to compute the adjacent matrix first. If two strings in the dictionary has only one different character, then these two strings are adjacent. The total time complexity of this computation is $$N^2$$, where $$N$$ is the number of elements in the dictionary.

Either to use the first or the second way depends on the relationship between $$L$$ and $$N$$.

{% highlight c++%}
class Solution {
public:
    int ladderLength(string s1, string s2, unordered_set<string> &dict) {
    	int str_len = s1.length();

    	queue<pair<string,int>>bfs_que;
    	unordered_set<string>visited;
    	visited.insert(s1);
    	bfs_que.push(pair<string,int>(s1, 0));

    	while(!bfs_que.empty()){
    		pair<string, int> candi = bfs_que.front();
    		bfs_que.pop();
    		if (candi.first == s2)
    			return candi.second+1;
    		for (int i = 0; i < str_len; ++ i){
    			for (char c = 'a'; c <= 'z'; ++ c){
    				if (candi.first[i] == c)
    					continue;
    				pair<string, int> new_candi(candi.first, candi.second+1);
    				new_candi.first[i] = c;
    				if (visited.count(new_candi.first) || !dict.count(new_candi.first))
    					continue;
    				bfs_que.push(new_candi);
    				visited.insert(new_candi.first);
    			}
    		}
    	}
    	return 0;
    }
};
{% endhighlight %}