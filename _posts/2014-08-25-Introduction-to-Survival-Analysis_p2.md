---
layout: post
title: Introduction to Survival Analysis (Ch3)
published: true
comments: true
category: Survival Analysis
tag: Survival Analysis
---

This summarizes some very basic concepts in survival analysis from this amazing [tutorial](http://www.amstat.org/chapters/northeasternillinois/pastevents/presentations/summer05_Ibrahim_J.pdf), which helps me a lot.

# Chapter 3: Estimiating the Survival or Hazard Function (Parametric)

There are two ways of estimating survival/hazard functions

- parametric model for $$\lambda(t)$$ based on a particular density function
- empirical estimate of survival function (non-parametric)

If without censoring, the emperical $$\hat{S}(t)$$ is simply the proportion of people dying no earlier that time $$t$$. It is censoring patients that complicates this problem.

## Some Parametric Survival Distribution (Continuos)

### The **exponential** distribution 

This is a constant hazard model, with only one parameter.

- $$f(t) = \lambda e^{-\lambda t} \text{ for } t \geq 0$$
- $$S(t) = e^{-\lambda  t}$$
- $$\lambda(t) = \lambda$$
- $$\Lambda(t) = \lambda t$$

### The **Weibull** distribution 

It is a generalization of exponential model

- $$S(t) = e^{-\lambda  t^\mathcal{k}}$$
- $$f(t) = \mathcal{k} \lambda t^{\mathcal{k}  -1} e^{-\lambda t^{\mathcal{k}}}$$
- $$\lambda(t) = \mathcal{k} \lambda t^{\mathcal{k} - 1}$$
- $$\Lambda(t) = \lambda t^\mathcal{k}$$

where $$\lambda$$ os the **scale** parameter and $$\mathcal{k}$$ is the **shape** parameter.

- $$\mathcal{k} = 1$$: constant hazard
- $$ 0 < \mathcal{k} < 1$$: decreasing hazard
- $$ \mathcal{k} > 1$$: increasing hazard

### The **Rayleigh** distribution 

Another 2-parameter generalization of exponential.

$$\lambda(t) = \lambda_0 + \lambda_1 t$$

### Other models

Compound exponential, log-normal, log-logistic

### Summary of Parametric Model

Good sides of parametric model

- easy to estimate and inference
- simple forms of $$f(t)$$, $$S(t)$$, and $$\lambda(t)$$
- qualitative shape of hazard function

Other tips

- With adequacy of fit to a dataset, one can usually distinguish one-parameter and two-parameter models
- Without a lot of data, hard to distinguish between the fits of 2-par models



