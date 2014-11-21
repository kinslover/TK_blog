---
layout: post
title: Binary Indexed Tree
published: true
comments: true
category: Algorithms
tag: algorithm, leetcode, data structure
---


# Introduction

A good tutorial is here: http://community.topcoder.com/tc?module=Static&d1=tutorials&d2=binaryIndexedTrees


Imagine that we have an array ``A[N]``, where we do lots of interval sum operations $$A[1...i]$$ but only a few modifications $$A[i] = v$$. Then it is too costy to do a $$O(N)$$ sweep through the array for sum. 

The binary indexed tree ``c[N]`` is designed for this scenario, where we can enjoy a $$O(log N)$$ summation. However, the tradeoff is that the time complexity of modification increases from $$O(1)$$ to $$O(logN)$$.

## Interval Summation

We use ``c[i]`` keeps the sum $$A[j+1...i]$$, where $$j = i-lowbit(i)$$. So for example, ``A[1...1101] = c[1101] + c[1100] + c[1000]``. Here the summation operations only require the number of '1's in the binary representation of ``i``, which is $$O(logN)$$.

## Update

However, if we want to add a value to some postion ``i``, we have to update all ``c[k]``, where $$i \in [lowbit(k)+1, k]$$. As $$lowbit(k)+1 \leq i$$, the binary representation of $$k$$ cannot have any postions to be 1 below bit ``lowbit(i)``. Combined with the fact $$k \geq i$$, after updating ``c[i]`` itself, the next postion we have to update is ``i + lowbit(i)``, which is greater than $$i$$ and has no bits being 1 below lowbit(i). Then we repeat this procedure, until $$k$$ reach beyond the maximum number of elements $$N$$.

## Query

Query of a single element at a certain postion ``i`` can be done by ``sum(i) - sum(i-1)``, which is $$O(logN)$$.


# Code

{% highlight c++%}
class BinaryIndexedTree{
public:
    vector<int>c;
    int n;
    BinaryIndexedTree(int n){
        this->n = n;
        c.resize(n + 2, 0);
    }    
    
    int lowbit(int k){
        return k & (-k);
    }

    void modify(int pos, int v){
        while(pos <= n){
            c[pos] += v;
            pos += lowbit(pos);   
        }
    }

    int sum(int pos){
           int ans = 0;
           while(pos > 0){
                  ans += c[pos];
                  pos -= lowbit(pos);
           }
           return ans;
    }
};
{% endhighlight %}

