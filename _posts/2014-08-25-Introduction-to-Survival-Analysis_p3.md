---
layout: post
title: Introduction to Survival Analysis (Ch4)
published: true
comments: true
category: Survival Analysis
tag: Survival Analysis
---

This summarizes some very basic concepts in survival analysis from this amazing [tutorial](http://www.amstat.org/chapters/northeasternillinois/pastevents/presentations/summer05_Ibrahim_J.pdf), which helps me a lot.

# Chapter 4: Estimiating the Survival or Hazard Function (Non-Parametric)

If there is no censoring data, the empirical estimate of survival distribution is simply

$$
\hat{S}(t) = \frac{\text{ # People dying no earlier than } t}{ \text{# all people} }
$$

In practice, most software packages usually count individuals with $$T > t$$. We represent it as $$S(t^+) = Pr(T > t)$$.


There are three common non-parametric models to estimate survival function $$S(t)$$.

- (1) Kaplan-Meier
- (2) Life-table (Actuarial Estimator)
- (3) via Cumulative harzard estimator


## The Kaplan-Meier Estimator

Most popular, most famous one, which can be justified from three perspectives:

- Product limit estimator (conditional probability)
- maximum likelihood
- redistribute to the right estimator

As stated in previous section, if there is no censoring, calculating the empirical survival proportion is enough.

What about censoring data? Let us start from the conditional probability perspective.

### Perspective1: Conditional Probability

In previous section, we have shown the relationship between $$S(t)$$ and $$\lambda(t)$$ for discrete r.v. case, using conditional probability.

Suppose $$a_k < t \leq a_{k+1}$$, then 

$$
\begin{split}
S(t) 	&=  Pr(T \geq a_{k+1})\\
		&=  Pr(T \geq a_{1}) Pr(T \geq a_{2}\vert T \geq a_{1})...Pr(T \geq a_{k+1}\vert T \geq a_{k}) \\
	 	&= 1 \times \prod_{j=1}^k (1 - \lambda_j)
\end{split}
$$

Therefore,

$$
\begin{split}
\hat{S}(t) 	&= \prod_{j=1}^k (1 - \frac{d_j}{r_j})\\
			&= \prod_{\{j:a_j < t\}} (1 - \frac{d_j}{r_j})
\end{split}
$$

where $$d_j$$ is the number of deaths at tiem $$a_j$$ and $$r_j$$ is the number of individuals alive right before time $$a_j$$

**For censoring people, we remove them from $$r_{j}$$**, if he/she is censored before $$a_j$$.

For example, if a patient is censored between $$[a_j, a_{j+1})$$, then

- this patient is one member of $$r_j$$, as his/her survival time is **NOT** earlier than $$a_j$$
- this patient is **NOT** one member of $$r_{j+1}$$, as his/her survival time is earlier than $$a_{j+1}$$

### Formal Description os Kaplan-Meier estimator

$$
\begin{split}
\hat{S} 	&= \prod_{j:\tau_j < t} \frac{r_j - d_j}{r_j}
			&= \prod_{j:\tau_j < t} (1 - \frac{d_j}{r_j})
\end{split}
$$

where 

- $$\tau_1,...,\tau_K$$ is the set of $$K$$ distinct death times observed in sample
- $$d_j$$: number of deaths observed at time $$\tau_j$$
- $$r_j$$: number of individuals alive right before time $$\tau_j$$ (i.e. every one died or censored after $$\tau_j$$)
- $$c_j$$ is the number of censored observations between $$[\tau_j, \tau_{j+1})$$.


**Two useful formulas**:

- $$r_{j+1} = r_{j} - (d_{j} + c_{j})$$
- $$r_{j+1} = \sum_{i = j+1}^K (d_{i} + c_{i})$$ 

Some interesting facts

- $$\hat{S}(t^+)$$ only changes at death times
- $$\hat{S}(t^+)$$ is 1 until the first death happens
- $$\hat{S}(t^+)$$ goes to 0 if the last event is a death

### Perspective 2: Maximum Likelihood

For a discrete failure time variable, define

- $$d_j$$: number of failures at $$a_j$$
- $$r_j$$: number of individuals alive right before $$a_j$$
- $$\lambda_j$$: probability of dying in $$[a_j, a_{j+1})$$, given the fact alive before $$a_j$$

Supposed that there are $$K$$ distinct time points, then the likelihood of observing $$d_j, r_j, j = 1...K$$ is

$$
L(\lambda) = \prod_{j = 1}^K \lambda_j^{d_j} (1 - \lambda_j)^{r_j - d_j}
$$

which are just $$K$$ independent bernoulli trials.

Then it is pretty obvisous that the maximum likelihood estimator of $$\lambda_j$$ is

$$\hat{\lambda_j} = \frac{d_j}{r_j}$$

### Perspective 3: Redistribute to the Right Estimator

Please refer to p57-58 in the tutorial.


### Properties of KM estimator

If there is no censoring

$$\hat{S}(t) = \frac{\text{# of deaths at or greater than } t}{n}$$

This is like an estimated probability from a bionomial distribution, thus we know

$$
\hat{S}(t) \simeq \mathcal{N}(S(t), \frac{S(t)(1-S(t))}{n})
$$

and we know the **approximated variance**.

$$\simeq$$ means ["asymptotically equal"](http://access2science.com/latex/Binary.html).

How does censoring affect this?

- $$\hat{S}(t)$$ is still approximately normal
- The mean of $$\hat{S}(t)$$ converges to the true $$S(t)$$
- The variance is a bit more complicated

Once we get the variance, then we can construct  **(pointwise) $$(1-\alpha)\%$$ confidence intervals** (not bands) about $$\hat{S}(t)$$, by

$$
\hat{S}(t) \pm z_{1-\frac{\alpha}{2}} se[\hat{S}(t)]
$$

(More about pointwise confidence interval: to be continued..)
