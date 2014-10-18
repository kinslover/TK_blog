class Solution {
public:
	bool isValidSudoku(vector<vector<char> > &board) {
		unordered_set<int> columnCheck[9];
		unordered_set<int> rowCheck[9];
		unordered_set<int> blockCheck[9];
		for (int i = 0; i < 9; ++ i){
			for (int j = 0; j < 9; ++ j){
				if (rowCheck[i].count(board[i][j]))
					return false;
				if (columnCheck[j].count(board[i][j]))
					return false;
				if (blockCheck[(i-1) * 3 + j].count(board[i][j]))
					return false;
				rowCheck[i].insert(board[i][j]));
				columnCheck[j].insert(board[i][j]));
				blockCheck[(i-1) * 3 + j].insert(board[i][j]);
			}
		}
		return true;
    }
};