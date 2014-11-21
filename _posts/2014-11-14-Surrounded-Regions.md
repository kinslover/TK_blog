---
layout: post
title: Surrounded Regions
comments: true
category: Algorithms
tag: algorithm, leetcode, BFS
---




# Description

Difficulty: 1.5/2.0
URL: https://oj.leetcode.com/problems/surrounded-regions/


# Solution

We BFS from each boundary position with 'O'. If a position with 'O' is visited in the BFS, it must be reachable from boundary position with 'O'. Then we keep it to 'O', while set the rest to 'X'.

{% highlight c++%}
class Solution {
	int dir[4][2] = { {0,1}, {0,-1}, {1,0}, {-1,0} };
	bool legal(const pair<int, int>& pos, const vector<vector<char>>&board) const{
		if (pos.first == -1 || pos.second == -1 || pos.first == board.size() || pos.second == board[0].size() || board[pos.first][pos.second] == 'X')
			return false;
		return true;
	}
public:
	void solve(vector<vector<char>> &board) {
		if (board.empty())
			return;
		vector<vector<bool>> visited(board.size(), vector<bool>(board[0].size(), false));

		for (int row = 0; row < board.size(); ++ row){
			BFS(row, 0, board, visited);
			BFS(row, board[0].size()-1, board, visited);
		}
		for (int col = 0; col < board[0].size(); ++ col){
			BFS(0, col, board, visited);
			BFS(board.size()-1, col, board, visited);
		}    	
		for (int row = 0; row < board.size(); ++ row){
			for (int col = 0; col < board[0].size(); ++ col){
				if (board[row][col] == 'O' && !visited[row][col])
					board[row][col] = 'X';    			
			}
		}
	}
	void BFS(int row, int col, vector<vector<char>>& board, vector<vector<bool>>& visited){
		pair<int,int> pos = pair<int,int>(row, col);
		if (visited[row][col] || board[row][col] == 'X')
			return;
		queue<pair<int,int>>bfs_q;
		bfs_q.push(pos);
		visited[row][col] = true;;
		while(!bfs_q.empty()){
			pos = bfs_q.front();
			bfs_q.pop();
			for (int i = 0; i < 4; ++ i){
				pair<int,int>new_pos(pos.first + dir[i][0], pos.second + dir[i][1]);
				if (!legal(new_pos, board) || visited[new_pos.first][new_pos.second])
					continue;
				bfs_q.push(new_pos);
				visited[new_pos.first][new_pos.second] = true;
			}
		}
	}
};
{% endhighlight %}