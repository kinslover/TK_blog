---
layout: post
title: Clone Graph
comments: true
category: Algorithms
tag: algorithm, leetcode, hashtable
---



# Description

https://oj.leetcode.com/problems/clone-graph/

Difficulty: 1.5/5.0


# Solution


{% highlight c++%}
 class Solution {
 public:
 	UndirectedGraphNode *cloneGraph(UndirectedGraphNode *node) {
 		unordered_map<UndirectedGraphNode*, UndirectedGraphNode*>ht;
 		UndirectedGraphNode * newNode = traverse_copy(node, ht);
 		return newNode;
 	}
 	UndirectedGraphNode* traverse_copy(UndirectedGraphNode * node, unordered_map<UndirectedGraphNode*, UndirectedGraphNode*> &ht){
 		if (node == NULL) return NULL;
 		
 		if (ht.find(node) != ht.end())
 		    return ht[node];
 		
 		UndirectedGraphNode* newNode;
 		
 		newNode = new UndirectedGraphNode(node->label);
 		ht[node] = newNode;
 		
 		for (int i = 0; i < node->neighbors.size(); ++ i)
 			newNode->neighbors.push_back(traverse_copy(node->neighbors[i], ht));

 		return newNode;
 	}
 };
{% endhighlight%}

