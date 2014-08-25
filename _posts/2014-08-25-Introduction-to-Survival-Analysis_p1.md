---
layout: post
title: Introduction to Survival Analysis (Ch1 & Ch2)
published: true
comments: true
category: Survival Analysis
tag: Survival Analysis
---

This summarizes some very basic concepts in survival analysis from this amazing [tutorial](http://www.amstat.org/chapters/northeasternillinois/pastevents/presentations/summer05_Ibrahim_J.pdf), which helps me a lot.

# Chapter 1: Basic Knowledge and Survival Data

## Basic Definitions

**Failure/Event time random variables** $$T > 0$$. T can be both **discrete** or **continuos**.

**Censored random variables** $$U$$ is a non-negative variable indicating the censored time.

**Censored failure/event time random variable**  $$X$$ is defined as 

$$X = \min(T, U)$$

## Issues with Survival Data

- **staggered entry**: 
	- people do not attend the study at the same time
- **censoring**
	- people may experience no event until the end of study
	- people may drop out in the middle of the study

Censoring is the main problem we care about.

## Tyeps of Censoring

There are two ways of categorizing censoring.

The first way is

- Right censoring
- Left censoring
- Interval censoring

The second way is

- Independent censoring
- Informative censoring

### Right Censoring

This is the most common type of censorng.

Only $$X_i = \min(T_i, U_i)$$ is observed.

In addition the $$X_i$$, we also know the **failure indicator** $$\delta_i$$ 

$$
    \delta_i = 
\begin{cases}
    1,& \text{if } T_i\leq U_i \text{ failure }\\
    0,       & \text{if } T_i > U_i \text{ censored }
\end{cases}
$$


### Left Censoring

Only $$X_i = \max(T_i, U_i)$$ is observed and the failure indicater is defined as

$$
    \delta_i = 
\begin{cases}
    1,& \text{if } U_i \leq T_i \text{ failure }\\
    0,       & \text{if } U_i > T_i \text{ censored }
\end{cases}
$$

That is, we know the event happens before a certain time point, but have no idea of the exact event time.



### Interval Censoring

$$(L_i, R_i)$$ is observed, where $$T_i \in (L_i, R_i)$$.


### Independent Censoring

Censoring is independent if **$$U_i$$ is independent o $$T_i$$**.

### Informative Censoring

Distrobution of $$U_i$$ caontains information about the parameters characterizing the distribution of $$T_i$$.

# Chapter 2 Survival Distribution 

## Definitions

These four terms below are the keys in survival analysis.

- density function: $$f(t)$$
- survival function: $$S(t)$$
- hazard function: $$\lambda(t)$$
- cumulative hazard function: $$\Lambda(t)$$

### Density Function $$f(t)$$

#### For Discrete R.V.

Suppose $$T \in \{a_1, a_2,...,a_n\}$$

$$
f(t) = Pr(T=t) = 
\begin{cases}
    f_j,& \text{if } t = a_j, j = 1,2,..,n \\
    0,& \text{if } t \neq a_j, j = 1,2,..,n \\
\end{cases}
$$

#### For Continuos R.V.

$$ f(t) = \lim_{t\rightarrow0} \frac{Pr(t \leq T \leq t + \Delta t)}{\Delta t} $$


### Survival Function $$S(t)$$

$$S(t) = Pr(T \geq t) = 1 - F(t)$$.

#### For Discrete R.V.

$$ S(t) = \int_{t}^{\infty} f(u) du $$

#### For Continuos R.V.

We have

$$ S(t) = \sum_{\{j\vert a_j \geq t\}} f_j $$


### Hazard Function $$\delta(t)$$


Hazard function is sometimes called [instantaneous failure rate](http://en.wikipedia.org/wiki/Failure_rate). **It represents the probability of some event's happening right now, given the fact that the event has not happened yet**. The hazard function is restricted to be **non-negative** $$\delta(t) \geq 0$$.


It is define as

#### For Continuos R.V.

$$
\begin{split}
\lambda(t) & = \lim_{\Delta t \rightarrow 0} \frac{1}{\Delta t} Pr(t \leq T < t + Delta t \vert T \geq t) \\
& = \lim_{\Delta t \rightarrow 0} \frac{1}{\Delta t} \frac{Pr(t \leq T < t + Delta t \cap T \geq t)}{Pr(T \geq t)} \\
& = \frac{f(t)}{S(t)}
\end{split}
$$

#### For Discrete R.V.

$$
\begin{split}
\lambda(a_j) & = Pr(T = a_j|T \geq a_j) \\
& = \frac{Pr(T = a_j)}{T \geq a_j} \\
& = \frac{f(a_j)}{S(a_j)}
\end{split}
$$

#### Some example hazard shapes

- Increasing: age after 65
- Decreasing: after effective treatment
- Bathtub: age-specific mortality
- Constant: patients with advanced chronic disease


### Cumulative Hazard Function $$\Delta(t)$$

As time $$t \rightarrow$$, $$\Delta(t) \rightarrow \infty$$.

#### For Continuos R.V.

$$\Lambda(t) = \int_{0}^t \lambda(u) du$$

#### For Discrete R.V.

$$\Lambda(t) = \sum_{\{j \vert a_j \leq t\}} \lambda_j $$

## Relationship: $$(S(t), \lambda(t))$$ and $$(S(t), \Lambda(t))$$

### $$S(t)$$ and $$\lambda(t)$$

For continuos r.v., We know that 

- $$\lambda(t) = \frac{f(t)}{S(t)}$$.
- for left-continuos survival function $$S(t)$$, $$f(t) = - S'(t)$$

Then it is easy to show that

$$
- \frac{d (log S(t)) }{d t}  = \frac{f(t)}{S(t)} = \lambda{t}
$$ 

That is, 
$$
\lambda{t} = - \frac{d (log S(t)) }{d t}  
$$ 

For discrete r.v., 

$$\lambda_j = \frac{f(a_j)}{S(a_j)} = \frac{S(a_j) - S(a_{j+1})}{S(a_j)}$$

### $$S(t)$$ and $$\Lambda(t)$$

#### Continuous case

$$
\begin{split}
\Lambda(t) 	& = \int_{0}^t \lambda(u) du\\
			& = \int_{0}^t \frac{f(u)}{S(u)} du\\
			& = \int_{0}^t - \frac{d(log S(u))}{du} du \\
			& = -log S(t) + log S(0) \\
			& = -log S(t)
\end{split}
$$

That is 

$$S(t) = e^{-\Lambda(t)}$$.

Remember that we require that $$\Lambda(t \rightarrow \infty) = \infty$$, then we can guanrantee that $$S(t \rightarrow \infty) = e^{-\Lambda(t \rightarrow \infty)} \rightarrow 0$$. This makes lots of sense, as people cannot live forever.

In summary, **More hazard cumulative, less chance of survival**.

#### Discrete case

Suppose that $$a_j < t \leq a_{j+1}$$

$$
\begin{split}
S(t)	& = Pr(T \geq a_{j+1}) \\
		& = Pr(T \geq a_{1}, T \geq a_{2}... T \geq a_{j+1}) \\
		& = Pr(T \geq a_{1}) Pr(T \geq a_{2}\vert \geq a_{1})... Pr(T \geq a_{j+1} \vert \geq a_{j}) \\
		& = 1 \times \prod_{k=1...j} (1 - \lambda_{k})\\
		& = \prod_{\{k\vert a_k < t \}} (1 - \lambda_{k})
\end{split}
$$

The equations for discrete case and continuos case here are different. Therefore, instead of using the definition that $$\Lambda(t) = \sum_{\{j \vert a_j \leq t\}} \lambda_j$$, Cox defines that 

$$\Lambda(t) = \sum_{\{j\vert a_j < t\}} log(1-\lambda_k)$$

so that $$S(t) = e^{-\Lambda(t)}$$ holds for discrete case too.



# Reference

[1] http://www.amstat.org/chapters/northeasternillinois/pastevents/presentations/summer05_Ibrahim_J.pdf
[2] http://en.wikipedia.org/wiki/Failure_rate


