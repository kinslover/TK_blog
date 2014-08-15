---
layout: post
title: Insert Interval
published: true
comments: true
category: algorithms
tag: leetcode
---

# Description

https://oj.leetcode.com/problems/insert-interval/

Difficulty: 2 Stars

# Analysis

All intervals can be divided as 

- intervals not overlapped with newInterval
    - on the left (interval[i].end < newInterval.start)
    - on the right (interval[i].start > newInterval.end)
- intervals overlapped with newInterval 

And all overlapping intervals appear consecutively in the vector. Thus we first insert all the non-overlapping intervals on the left into the result and then we deal with the overlapping interval.

If the interval.start < newInter.start, we set newInter.start = interval.start. If the interval.end > newInter.end, we set newInter.end = interval.end.

The only left work is to insert all the non-overlapping intervals on the right into the result;

# Solution

{% highlight c++%}
class Solution {
public:
    vector<Interval> insert(vector<Interval> &intervals, Interval newInterval) {
        vector<Interval> result;
        int i = 0;
        while (i < intervals.size() && intervals[i].end < newInterval.start)
            result.push_back(intervals[i++]);
        while (i < intervals.size() && intervals[i].start <= newInterval.end){
            if (intervals[i].start < newInterval.start)
                newInterval.start = intervals[i].start;
            if (intervals[i].end > newInterval.end)
                newInterval.end = intervals[i].end;
            i ++;
        }
        result.push_back(newInterval);
            
        while (i < intervals.size() && intervals[i].start > newInterval.end)
            result.push_back(intervals[i++]);
        return result;
    }
};
{% endhighlight %}
