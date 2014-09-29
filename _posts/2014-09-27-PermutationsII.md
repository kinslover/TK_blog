---
layout: post
title: Permutations II
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, recursion, permutation
---

# Description

https://oj.leetcode.com/problems/permutations-ii/

Difficulty: 3.0/5.0 star

Related: https://oj.leetcode.com/problems/permutations/

# Analaysis

There are at least three solutions to this prolem, corresponding to the three solutions to Permutations I respectively. The first one is still the DFS, with a redundancy elimination step.

{% highlight c++ %}
class Solution {
public:
	vector<vector<int> > permuteUnique(vector<int> &num) {
		vector<vector<int> > permVec;
		if (!num.size())
			return permVec;
		vector<int>tmpPerm;
		bool visited[num.size()];
		memset(visited, 0, sizeof(bool) * num.size());
		sort(num.begin(), num.end());
		generatePermutation(permVec, tmpPerm, num, visited);
		return permVec;
	}
	void generatePermutation(vector<vector<int> >& permVec, vector<int>& tmpPerm, vector<int>& num, bool visited[]){
		if (tmpPerm.size() == num.size()){
			permVec.push_back(tmpPerm);
			return;
		}
		for (int i = 0; i < num.size(); ++i){
			if (visited[i])
				continue;
			if (i && !visited[i-1] && num[i-1] == num[i])
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

The second solution comes out of the swap solution to Permutation I. If you do not understand the solution to Permutation I, it is hard to come up with the redundancy elimination step.

**elimination step**: The ``permute`` function compute all passoble permutations for numbers in ``num[start..end]``, supposed that ``num[start...end] = {2,0,2, 3,4}`` and we have ``num[i] = 1``, where ``i < start``, then swapping ``num[i]`` and ``num[start]`` and swapping ``num[i]`` and ``num[start+2]`` will yield the same permutations, as ``num[start] == num[start+2]``, which is redundant.


{% highlight c++ %}

class Solution {
public:
    vector<vector<int> > result;
    vector<vector<int> > permuteUnique(vector<int> &num) {
        sort(num.begin(), num.end());
        permute(num, 0);
        return result;
    }
    void permute(vector<int> &num, int start)
    {
        if(start == num.size())
            result.push_back(num);
        
        for(int i = start; i < num.size(); ++i)
        {
        	bool flg = false;
        	for (int j = start; j < i; ++ j)
        		if (i - start && num[i] == num[j]){
        			flg = true;
        			break;
        		}
        	if (flg) continue;
        	
     
            swap(num[i], num[start]);
            permute(num, start+1);
            swap(num[i], num[start]);
        }
    }
};
{% endhighlight %}




The third one is to use nextPermutation.