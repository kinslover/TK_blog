---
layout: post
title: Permutations
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, recursion
---


# Description

https://oj.leetcode.com/problems/permutations/

Difficulty: 0.5 or 3.0/5.0 star



# Analysis and solution

The first solution is failry easy to come up with. It is a DFS solution with a ``visited`` array for checking if a number is used or not.

{% highlight c++ %}

class Solution {
public:
	vector<vector<int> > permute(vector<int> &num) {
		vector<vector<int> > permVec;
		if (!num.size())
			return permVec;
		vector<int>tmpPerm;
		bool visited[num.size()];
		memset(visited, 0, sizeof(bool) * num.size());
		generatePermutation(permVec, tmpPerm, num, visited);
		return permVec;
	}
	void generatePermutation(vector<vector<int> >& permVec, vector<int>& tmpPerm, vector<int>& num, bool visited[]){
		if (tmpPerm.size() == num.size()){
			permVec.push_back(tmpPerm);
			return;
		}
		for (int i = 0; i <num.size(); ++i){
			if (visited[i])
				continue;
			tmpPerm.push_back(num[i]); 
			visited[i] = true;
			generatePermutation(permVec, tmpPerm, num, visited);
	 		visited[i] = false;
			tmpPerm.pop_back();
		}
	}
};

{% endhighlight %}


The second solution is much more concise and tricky, which is a more interesting solution.

{% highlight c++ %}

class Solution {
public:
    vector<vector<int> > result;
    vector<vector<int> > permute(vector<int> &num) {
        
        permute(num, 0);
        return result;
    }
    void permute(vector<int> &num, int start)
    {
        if(start == num.size())
            result.push_back(num);
        
        for(int i = start; i < num.size(); ++i)
        {
     
            my_swap(i, start, num);
            permute(num, start+1);
            my_swap(i, start, num);
        }
    }
};

{% endhighlight %}