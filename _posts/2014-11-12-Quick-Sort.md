---
layout: post
title: Quick Sort
published: true
comments: true
category: Algorithms
tag: algorithm, quick sort
---


# Quick Sort

This is an easy implementation of quick sort, the worst case time complexity of which can be $$O(N^2)$$, when the array is already sorted. An improvement is to select the pivot randomly. However with a pivot positioned at some middle place in the array is inconvenient, so we can first exchange the pivot with the first element and the do the line search.

# Implementation

{% highlight c++%}
class QuickSort{
public:	
	void sort(vector<int>& number){
		sort_helper(number, 0, number.size()-1);
	}
	void sort_helper(vector<int>& number, int start, int end){
		if (start >= end)
			return;
		int pivot = number[start];
		int left = start + 1;
		int right = end;
		while(left <= right){
			while(left <= right && number[left] <= pivot)
				left ++;
			while(left <= right && number[right] >= pivot)
				right --;	

			if (left <= right){
				int tmp = number[left];
				number[left] = number[right];
				number[right] = tmp;				
			}

		}
		int tmp = number[right];
		number[right] = number[start];
		number[start] = tmp;

		sort_helper(number, start, right-1);
		sort_helper(number, right+1, end);
	}

};

{% endhighlight %}