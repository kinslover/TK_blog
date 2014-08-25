---
layout: post
title: Simplify Path
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode
---

# Description

Simplify Path Total Accepted: 10702 Total Submissions: 53877 My Submissions
Given an absolute path for a file (Unix-style), simplify it.

For example,

- path = "/home/", => "/home"
- path = "/a/./b/../../c/", => "/c"


Corner Cases:

- Did you consider the case where path = "/../"?
	- In this case, you should return "/".
- Another corner case is the path might contain multiple slashes '/' together, such as "/home//foo/".
	- In this case, you should ignore redundant slashes and return "/home/foo".



# Solution

The code with comments is quite self-explainable.

One thing worth noticing is that the "folder/file name" can have dot ".", e.g.

``\home\my.file\...``



## Code

Running Time: 72 ms

{% highlight c++ linenos %}
string simplifyPath(string path) {

	vector<string>result_vec;

	string tp = "";
	for (int i  = 0; i < path.size(); ++ i){
		if (path[i] == '/'){ 	// slash
			if (tp == ".." && result_vec.size())
				result_vec.pop_back();				
			else if (tp.size() && tp != "." && tp != "..")
				result_vec.push_back(tp);			
			tp = "";
		}
		else						// letter or dot
			tp += path[i];
	}
	
	if (tp == ".." && result_vec.size())
		result_vec.pop_back();
	else if (tp.size() && tp != "." && tp != "..")
		result_vec.push_back(tp);

	string result_str = (path[0] == '/')?"/":"";
	
	for (int i = 0; i < result_vec.size(); ++ i)
		result_str += result_vec[i] + "/";
	cout << result_vec.size() << endl;
	if (result_vec.size()) result_str.pop_back();
	return result_str;
}

{% endhighlight %}