
---
layout: post
title: Restore IP Addresses
comments: true
category: Algorithms
tag: algorithm, leetcode, DFS
---

One thing worth noting is that ``"0.1.001.0"`` is not a legal IP. The time complexity of this algorithm is $$O(N^4)$$ as we have four partition points to choose.

{% highlight c++%}
class Solution {
public:
	vector<string> restoreIpAddresses(string s) {
		vector<string> result;
		restore_helper(s, 0, 0, "", result);
		return result;
	}
	void restore_helper(string s, int start, int nIP, string currentIP, vector<string>&result){
		if (start == s.size() && nIP == 4){
			result.push_back(currentIP.substr(1, currentIP.size()-1));
			return;
		}
		if (nIP == 4 || start == s.size()) return; // pruning
		string nextIP = "";
		for (int i =  start; i < s.size() && i < start + 3; ++ i){
			nextIP += s[i];
			if (legalIP(nextIP))
				restore_helper(s, i+1, nIP+1, currentIP +"."+nextIP, result);
		}
	}
	bool legalIP(string &str){
		if (str.size() > 3) return false;
		if (str[0] == '0' && str.size() > 1 ) return false;
		int ip = 0;
		for (int i = 0 ;i  < str.size(); ++ i)
			ip = ip * 10 + (str[i]-'0');
		return (ip < 256);
	}
};
{% endhighlight %}

