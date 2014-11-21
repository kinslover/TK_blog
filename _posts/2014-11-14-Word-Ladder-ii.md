---
layout: post
title: Word Ladder ii
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, BFS
---


# Description

Difficulty: 4.0/5.0

URL: https://oj.leetcode.com/problems/word-ladder-ii/

# Solution

We have to use DFS to find all shortest paths. One possible pruning is that we use  ``earliest_visit[str]`` to record the currently earlist time to reach ``str`` for each valid word ``str`` in the dictionary. If we reach ``str`` later than this time, we prune it; if we reach earlier, then we update it with the earlier time. However, this solution is still TLE.



{% highlight c++%}
class Solution {
public:
    vector<vector<string>> findLadders(string s1, string s2, unordered_set<string> &dict) {
    	vector<vector<string>>result;
    	vector<string>cur_strvec;    	
    	unordered_map<string, int> earliest_visit;
    	for (auto &str : dict)
    		earliest_visit[str] = INT_MAX;
    	int shortest_len = INT_MAX;
    	findLaddersHelper(shortest_len, dict, s1, s2, result, cur_strvec, earliest_visit);
    	return result;
	}
	void findLaddersHelper(int& shortest_len, unordered_set<string>&dict, string& s1, string& s2, vector<vector<string>>&result, vector<string>&cur_strvec, unordered_map<string, int>& earliest_visit){
		if (!dict.count(s1) || cur_strvec.size() == shortest_len)//invalid word or reach the shortest length
			return;
		if (cur_strvec.size() >= earliest_visit[s1])
			return;

		earliest_visit[s1] = cur_strvec.size() + 1;
		cur_strvec.push_back(s1);
		if (s1 == s2){   // target!
			if (cur_strvec.size() < shortest_len ){ //shorter length!
				result.clear();
				shortest_len = cur_strvec.size();
			}
			result.push_back(cur_strvec);
			cur_strvec.pop_back();
			return;
		}
				
		//find next word in the path
		for (int i = 0, str_len = s1.size(); i < str_len; ++ i){
			for (char c = 'a'; c <= 'z'; ++ c){
				if (c == s1[i]) continue;
				char tpc = s1[i]; s1[i] = c;
				findLaddersHelper(shortest_len, dict, s1, s2, result, cur_strvec, earliest_visit);
				s1[i] = tpc;
			}
		}
		cur_strvec.pop_back();		
	}
};
{% endhighlight%}

Here we add a new step to avoid redundant computation, which is 

- precompute the (distance-1) adjacency of words in the dictionary

What is really annoying is that the time limit is really tight. If we use the function ``constructAdjList_back`` to compute the adj_list, we still get TLE. With function ``constructAdjList``, we can get it accepted in 1220s, which is still slow.



{% highlight c++%}


class Solution {
public:
    vector<vector<string>> findLadders(string s1, string s2, unordered_set<string> &dict) {
    	vector<vector<string>>result;
    	unordered_map<string, vector<string>> adj_list;
    	unordered_map<string, int> earliest_visit;
    	for (auto &str : dict)
    		earliest_visit[str] = INT_MAX;
    	

    	constructAdjList(adj_list, dict);
    	int shortest_len = findShortestLen(s1, s2, adj_list, earliest_visit);
    	vector<string>cur_path;
    	findShortestPaths(shortest_len, s1, s2, result, cur_path, adj_list, earliest_visit);
    	return result;
	}
	bool isAdj(string &s1, string &s2){
		int n_diff = 0;
		for (int i = 0, str_len = s1.size(); i < str_len; ++ i){
			if (s1[i] != s2[i]) n_diff ++;
			if (n_diff == 2) return false;
		}
		return (n_diff == 1);
	}
	void constructAdjList_back(unordered_map<string, vector<string>>& adj_list, unordered_set<string> & dict){
		vector<string>str_list;
		for (const auto & it : dict) // nlogn
			str_list.push_back(it);
		for (auto it1 = str_list.begin(); it1 < str_list.end(); ++ it1){
			auto it2 = it1;
			for (++it2; it2 < str_list.end(); ++ it2){
				if (isAdj(*it1, *it2)){
					adj_list[*it1].push_back(*it2);
					adj_list[*it2].push_back(*it1);
				}
			}
		}
	}
	void constructAdjList(unordered_map<string, vector<string>>& adj_list, unordered_set<string> & dict){
		for (auto str : dict){
			for (int i = 0, str_len = str.length(); i < str_len; ++ i){
				string tp_str(str);
				for (char c = 'a'; c <= 'z'; ++ c){
					if (c == str[i]) continue;					
					tp_str[i]= c;
					if (dict.count(tp_str))
						adj_list[str].push_back(tp_str);
				}
			}
		}
	}	
	void findShortestPaths(int shortest_len, const string & s1, const string & s2, vector<vector<string>>&result, vector<string>&cur_path, unordered_map<string, vector<string>>& adj_list, unordered_map<string, int> &earliest_visit){
		if (cur_path.size() >= earliest_visit[s1])
			return;	
		earliest_visit[s1] = cur_path.size()+1;

		if (cur_path.size() == shortest_len)
			return;
		cur_path.push_back(s1);
		if (s1 == s2){
			result.push_back(cur_path);
			cur_path.pop_back();
			return;
		}		
		for (const auto &next_str : adj_list[s1])
				findShortestPaths(shortest_len, next_str, s2, result, cur_path, adj_list, earliest_visit);				
		cur_path.pop_back();		
	}

	int findShortestLen(string& s1, string& s2, unordered_map<string, vector<string>>& adj_list, unordered_map<string, int>& earliest_visit){
    	int str_len = s1.length();

    	queue<pair<string,int>>bfs_que;
    	unordered_set<string>visited;
    	visited.insert(s1);
    	bfs_que.push(pair<string,int>(s1, 0));

    	while(!bfs_que.empty()){
    		pair<string, int> candi = bfs_que.front();
    		bfs_que.pop();
    		earliest_visit[candi.first] = candi.second+1;
    		if (candi.first == s2)
    			return candi.second+1;
    		for (const auto& next_str : adj_list[candi.first]){
				pair<string, int> new_candi(next_str, candi.second+1);
				if (visited.count(next_str))
					continue;
				bfs_que.push(new_candi);
				visited.insert(new_candi.first);
    		}
    	}
    	return INT_MAX;
	}
};
{% endhighlight%}