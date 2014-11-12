---
layout: post
title: Word Search
comments: true
category: Algorithms
tag: algorithm, leetcode, DFS
---

# Description

Difficulty: 1.5/5.0

URL: https://oj.leetcode.com/problems/word-search/


# Solution

This is a simple problem that can be solved by DFS. The time complexity can be exponential, for example search the word ``aaaaab`` in the matrix shown in the figure.

<p align="center">
<img src="{{ site.baseurl }}/images/WordSearch.png" height="260">
</p>

{% highlight c++ %}
class Solution {
private:
	int dir[4][2] = { {0,1},{0,-1},{1,0},{-1,0} };
	bool exist_helper(const string & word, int pos, const vector<vector<char>>& board, int row, int col,
						vector<vector<bool>>&visited){
		if (pos == word.size())
			return true;
		if (!legal(row, col, board)|| visited[row][col] || word[pos] != board[row][col])
			return false;
		visited[row][col] = true;
		for (int idx_dir = 0; idx_dir < 4; ++ idx_dir){
			if (exist_helper(word, pos+1, board, row+dir[idx_dir][0], col+dir[idx_dir][1], visited))
				return true;
		}
		visited[row][col] = false;
		return false;
	}
	bool legal(int row, int col, const vector<vector<char>>& board) const{
		return (row < board.size() && row >= 0 && col < board[0].size() && col >= 0 );	
	}
public:
	bool exist(vector<vector<char> > &board, string word) {
		if (word.size() > board.size() * board[0].size())
			return false;
			
		vector<vector<bool>>visited(board.size(), vector<bool>(board[0].size(), 0));
		for (int i = 0, nRow = board.size() ; i < nRow; ++ i){
			for (int j = 0, nCol = board[i].size(); j < nCol; ++ j){
				if (exist_helper(word, 0 ,board, i, j, visited))
					return true;
			}
		}
		return false;
	}

};
{% endhighlight %}