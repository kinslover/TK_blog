---
layout: post
title: Substring with Concatenation of All Words
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode
---



# Description

You are given a string, S, and a list of words, L, that are all of the same length. Find all starting indices of substring(s) in S that is a concatenation of each word in L exactly once and without any intervening characters.

For example, given:

``S: "barfoothefoobarman"``

``L: ["foo", "bar"]``

You should return the indices: ``[0,9]``.
(order does not matter).

# Solution

This is an another window-moving problem that can be solved in linear time (not very exactly), which is similar to [Minimum Window Substring]({{site.baseurl}}/algorithms/Minimum-Window-Substring/).

We keep two pointers ``left`` and ``right`` and ``lLen`` is the length of the word in ``L``.

- Step1: We keep increasing ``right += lLen`` and check if we find a valid Concatenation until we find
    - CASE1: ``right`` exceeds the length of ``S``
    - CASE2: [Partial Overflow] for some string ``str`` in ``L`` we have spotted more than expected number of ``str`` in ``S[left, right+lLen-1]``
    - CASE3: we find ``S[right, right+len-1]`` is not a word in ``L``
- Step2: 
    - For CASE1 and CASE2, go to step 3
    - For CASE3
        - move ``left = right+len`` and  ``right = right+len``
- Step3: We keep increasing ``left += lLen``, until we find
    - CASE1: left == right
    - CASE2: no Partial OVERFLOW exists in S[left, right+len-1] anymore
- Go back to Step 1, if ``right`` does not reach the end

We have to repeat the above procedure for ``lLen`` times by initializing ``left = right = i, i = 0...lLen-1``. As we increase ``left, right`` by ``lLen`` in each iteration, the total time complexity is still $$O(sLen)$$, where $$sLen$$ is the length of ``S``. Rigorously speaking, we have to extract a substring whose length is ``lLen`` in each iteration, thus the time complexity is $$O(sLen \times lLen)$$


## Code

Running Time: 968ms

{% highlight c++ linenos%}
class Solution {
public:
    vector<int> findSubstring(string S, vector<string> &L) {
        vector<int> result;
        if (!S.size() || !L.size())
            return result;
        unordered_map<string, int>expectedCount;
        for (int i  = 0; i < L.size(); ++ i)
            expectedCount[L[i]] = (expectedCount.find(L[i]) == expectedCount.end())?1:expectedCount[L[i]]+1;    
                
        for (int left_start  = 0; left_start < L[0].size(); ++ left_start)
            subLeft(result, left_start, S, L, expectedCount);
        
                
        return result;
    }

    void subLeft(vector<int>&result, int left, string &S, vector<string> &L, unordered_map<string, int> & expectedCount){
        int nSat = 0;
        int lLen = L[0].size();
        unordered_map<string, int>realCount;
        for (int i = 0 ; i < L.size(); ++ i)
            realCount[L[i]] = 0;
        
        int right = left;
        while(right < S.size()-lLen + 1){
            string str;
            // increas pointer right until OVERFLOW.
            while(right < S.size()-lLen + 1){            
                str = S.substr(right, lLen);
                
                right += lLen;
                if (expectedCount.find(str) == expectedCount.end()){ // not a word
                    for (unordered_map<string, int>::iterator it = realCount.begin(); it != realCount.end(); ++ it)
                        it->second = 0;                    
                    nSat = 0;                    
                    left = right;
                }
                else{ // a legal word
                    realCount[str] += 1;
                    if (realCount[str] > expectedCount[str]) {// overflow
                        nSat--;
                        break;
                    }
                    else if (realCount[str] == expectedCount[str]){                     
                        nSat ++;                     
                        if (nSat == realCount.size())
                            result.push_back(left);                        
                    }                    
                }                                               
            }
            // increas pointer left until OVERFLOW disappears.
            while(left < right){
                str = S.substr(left, lLen);                
                left += lLen; 

                realCount[str] -= 1;
                if (realCount[str] == expectedCount[str]){ // overflow disappears
                    nSat ++;
                    if (nSat == realCount.size())
                        result.push_back(left);
                    break;
                }
                else if (realCount[str] == expectedCount[str] - 1)
                    nSat --;                                
            };
        }
    }
};
{% endhighlight%}