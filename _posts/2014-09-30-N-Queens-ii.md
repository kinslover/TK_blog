---
layout: post
title: N-Queens i and ii
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, recursion, DFS
---

# Analysis and solution

The solutions to question i and question ii are almost the same. We iterate through each row, by filling one 'Q' to each row without more than on 'Q' being on the same column and any diagonal direction.

{% highlight c++ %}

// Solution to N-Queens i
class Solution {
public:
    vector<vector<string> > solveNQueens(int n) {
        vector<vector<string> > result;
        vector<string> tmp;
        bool diag[4][n], * diagProxy[4];
        bool col[n];
        for (int i = 0; i < 4; ++ i){
            memset(diag[i], 0, sizeof(bool) * n);
            diagProxy[i] = diag[i];
        }
        memset(col, 0, sizeof(bool) * n);
        nQueenSolver(result, tmp, n, diagProxy, col);
        return result;
    }
    void nQueenSolver(vector<vector<string> > & result, vector<string> & tmp, int n, bool * diagProxy[] , bool col[]){    
        if (tmp.size() == n){
            result.push_back(tmp);
            return;
        }
        int x = tmp.size();
        tmp.push_back(string(n, '.'));
        
        for (int y = 0 ; y < n; ++ y){
            if (illegal(x, y, diagProxy, col, n))                
                continue;
            
            tmp[x].replace(y, 1, "Q");
            setQueen(x, y, diagProxy, col, true, n);
            nQueenSolver(result, tmp, n, diagProxy, col);
            setQueen(x, y, diagProxy, col, false, n);
            tmp[x].replace(y, 1, ".");
        }
        tmp.pop_back();
    }
    void setQueen(int x, int y, bool * diag[], bool col[], bool val, int n){
        diag[(y-x) > 0][abs(y-x)] = val;
        diag[((x-(n-1-y)) > 0) + 2][abs(x-(n-1-y))] = val;
        col[y] = val;
    }
    bool illegal(int x, int y, bool * diag[], bool col[], int n){
        return (diag[(y-x) > 0][abs(y-x)] || diag[((x-(n-1-y)) > 0) + 2][abs(x-(n-1-y))] || col[y]);
    }       
};

{% endhighlight%}



{% highlight c++ %}

// Solution to N-Queens ii
class Solution {
public:
    int totalNQueens(int n) {
        
        bool diag[4][n], * diagProxy[4];
        bool col[n];
        for (int i = 0; i < 4; ++ i){
            memset(diag[i], 0, sizeof(bool) * n);
            diagProxy[i] = diag[i];
        }
        memset(col, 0, sizeof(bool) * n);
        
        return nQueenSolver(n, 0, diagProxy, col);
    }
    int nQueenSolver(int n, int x, bool * diagProxy[] , bool col[]){    

        if (x == n)
            return 1;
        int nWays = 0;
        for (int y = 0 ; y < n; ++ y){
            if (illegal(x, y, diagProxy, col, n))                
                continue;
            setQueen(x, y, diagProxy, col, true, n);
            nWays += nQueenSolver(n, x+1, diagProxy, col);
            setQueen(x, y, diagProxy, col, false, n);
        }
        return nWays;

    }
    void setQueen(int x, int y, bool * diag[], bool col[], bool val, int n){
        diag[(y-x) > 0][abs(y-x)] = val;
        diag[((x-(n-1-y)) > 0) + 2][abs(x-(n-1-y))] = val;
        col[y] = val;
    }
    bool illegal(int x, int y, bool * diag[], bool col[], int n){
        return (diag[(y-x) > 0][abs(y-x)] || diag[((x-(n-1-y)) > 0) + 2][abs(x-(n-1-y))] || col[y]);
    }       
};


{% endhighlight%}