---
layout: post
title: Remove Element
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode
---

# Description

https://oj.leetcode.com/problems/remove-element/

Difficulty: 1.5/5.0 star



# Analysis and solution


{% highlight c++ %}

class Solution {
public:
 	int removeElement(int A[], int n, int elem) {
 		queue<int>emptySlot;
 		int numRemove = 0;
		for (int i = 0; i < n; ++ i){
			if (A[i] == elem){
				emptySlot.push(i);
				numRemove ++;
 			}
			else if (!emptySlot.empty()){
				A[emptySlot.front()] = A[i];	
				emptySlot.pop();
				emptySlot.push(i);
			}
		}
		return n - numRemove;
 	}
};

{% endhighlight %}


The time/space complexity of following solution are both $$O(n)$$. It also maintains the original order of elements in the arrray. However, as the problem does not require the order to be maintained, we can further reduce the space complexity to be constant.

{% highlight c++ %}
class Solution {
public:
 	int removeElement(int A[], int n, int elem) {
		int right = n - 1;
		for (int left = 0; left <= right; ++ left){
			if (A[left] == elem){
				while(left < right && A[right] == elem)
					right --;
				A[left] = A[right --];
			}
		}
		return right+1;
 	}
};
{% endhighlight %}