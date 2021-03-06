---

layout: post
title:  Notes on Chapter 2 of ESL
date:   2013-11-18 09:47:35
published: true
comments: true

---

# 2.1 Instroduction

**Supervised Learning**: predict output values from input values.

Some equivalent terminologies:

- Input: predictors, independent variables, features
- Ouput: responses, dependent variables


# 2.2 Variable Types and Terminology

## Three variable types

- Quantitative (continuos)
  - ratio defined
  - ratio not defined
- Qualitative (discrete, categorical, factors)
- Ordered categorical

We usually do some coding to the qualitative variables

- target: for binary varibles, we use 0-1 or (-1)-(+1) coding
- dummy variables: for a variable with $$K$$ possible values, we use $$K$$ binary variables to code it

## Notations:
Generally, upper case letters represent the random variables, while lower case ones indicate some observed values, which are regarded as fixed or constant.

- $$X$$: input variable or vector, $$j_{th}$$ component of which is written as $$X_j$$, while $$i_{th}$$ observed value of $$X$$ is $$x_i$$
- $$Y, G$$: output varible. $$Y$$ for quantative and $$G$$ for qualitative 
- $$\mathbf{X}$$: $$N \times p$$ matrix, training data, consist of $$x_i^T$$, $$i = 1,...N$$. The $$j_{th}$$ component is $$\mathbf{x}_j$$


## learning task 
Given the value of an input vector $$X$$, make a good prediction of the output $$Y/G$$, denoted by $$\hat{Y}/\hat{G}$$

# Least Squares and Nearest Neighbors

- Linear model
  - huge assumptions about the structure 
  - stable but maybe not very accurate predictions
- $$k$$-nearest neighbor
  - few assumptions, if any, about the structure 
  - accurate but not stable predictions (sensitive to small changes in training dataset)
  
  
## Linear Models and Least Squares  

### Linear Models
Generally, we use "hat" over something to represent an estimate of it, such as, using $$\hat{X}$$ to estimate $$X$$.

Given a input vector $$X^T = (X_1,X_2,...,X_p)$$, we predict the output $$Y$$ via the model,

$$ \hat{Y} = \hat{\beta}_0 + \sum^p_{j = 1}X_j \hat{\beta_j}$$

$$\beta_0$$ is known as intercept or bias. If we include $$\mathbf{1}$$ as a feature, then 

$$ \hat{Y} = X^T\hat{\beta}$$

if the output $$Y$$ is scaler, then the dimension of $$\hat{\beta}$$ is $$1\times p$$. Generally, the output can be $$K$$-vector, then the dimension of $$\hat{\beta}$$ should be $$K \times p$$.

In the $$p+1$$ dimensional space, $$(X, \hat{Y})$$ is a hyperplane. If $$\mathbf{1}$$ is included, the hyperplane includes the origin and thus is a subspace.

### Least Squares

We write $$\hat{\beta}$$ instead of $$\beta$$, because we assume that there is a "perfect" $$\beta$$. Our task is to estimate the $$\beta$$ by fitting the data.

One way to do that is *least square fit*. Define

$$ RSS(\beta) = \sum_{i = 1}^{N} (y_i - x_i^T \beta) = (\mathbf{X}\beta - \mathbf{y})^T(\mathbf{X}\beta - \mathbf{y}) $$

Then we do the fit as follows

$$ \hat{\beta} = argmin_{\beta} RSS(\beta). $$

To get the solution, we take derivative of $$RSS(\beta)$$ w.r.t. $$\beta$$ and get

$$ \mathbf{X}^T(\mathbf{y} - \mathbf{X}\beta) $$

Then we set the derivate to zero, and if $$X^TX$$ is nonsingular, we have 

$$ \hat{\beta} = (\mathbf{X}^T\mathbf{X})^{-1}\mathbf{X}^T\mathbf{y}$$

And then we have the fitte value $$\mathbf{\hat{y}}$$ to be

$$ \mathbf{\hat{y}} = \mathbf{X} \hat{\beta}$$

So the fitted surface $$(X, \hat{y})$$ is actually $$(X, X \hat{\beta})$$, parameterized by $$\hat{\beta}$$.


## Simulation Experiment
The input $$X$$ is a two dimensional vector and the ouput variable $$G$$ is a binary variable. We make prediction $$\hat{G}$$ as

$$
\begin{equation}
  \hat{G} = 
  \left\{
    \begin{array}{r@{\;=\;}l}
    1 & \hat{Y} > 0.5\\
    0 & \hat{Y} \leq 0.5
    \end{array}
  \right.
\end{equation}
$$

where $$\hat{Y} = X \beta$$ and the *decision boundary* is $$\{x| x\beta = 0.5\}$$.

Let us consider about how the data is generated

- **Scenario 1**: The training data in each class were generated from bivariate Gaussian distributions with uncorrelated components and different means, i.e. several independent bivariate Gaussian distributions.

[put a figure here]

- **Scenario 2**: We have ten low-variance Gaussian distribution for each class respectively. Their means are distributed as Gaussian too. The way to generate a sample is to first select one Gaussian distribution out of the ten and then draw a point from that distribution.


For scenario 1, a linear boundary is the best we can do. For scenario 2, a nonlinear one is better.

## 2.3.2 Nearest-Neighbor Methods

$$
\hat{Y}(X) =\frac{1}{k} \sum_{x_i \in N_k(X)}(y_i)
$$

where $$N_k(X)$$ is the set of $$k$$ training samples that are nearest to $$X$$.

If the output variable is categorical, we can still put a threshold (decision boundary) on $$\hat{Y}$$ to decide $$\hat{G}$$. A majortiy vote is the case where the decision boundary is $$\{x| \hat{Y}(x) = 0.5\}$$. Usually the decision boundary of $$k$$NN is irregular.

Though it seems we only have one parameter $$k$$ in $$k$$NN instead of $$p$$ in Linear model. Actually the effective number of parameter in $$k$$NN is $$\frac{N}{k}$$, which is generally greater than $$p$$.


## 2.3.3 From Least Squares to Nearest Neighbors

Least Squares method has stronly replied the linear assumption, which makes it a simple model. This simplicity makes it less sensitive to the change of training dataset and thus enjoy a low variance, but potentially a high bias. For $$k$$NN, it hardly relies on any strict assumption, which makes it enjoy a low bias, but a high variance, i.e. quite sensitive to the change of training set (for small $$k$$).

For senario 1, linear model is more appropriate, while $$k$$NN works better for senario 2.

Many most popular techniques come from these two simple procedure. Below list some popular ways of enhancing these two methods:


> - Kernel methods use **weights that decrease smoothly to zero with distance** from the target point, rather than the effective 0/1 weights used by k-nearest neighbors.
- In high-dimensional spaces the distance kernels are modified to **emphasize some variable** more than others.
- Local regression fits linear models by **locally weighted least squares**, rather than fitting constants locally.
- Linear models fit to a **basis expansion** of the original inputs allow arbitrarily complex models.
- Projection pursuit and neural network models consist of sums of **non-linearly transformed** linear models.


# 2.4 Statistical Decision Theory

Let $$X \in \mathbb{R}^p$$ be the input vector, with real valued variables and $$Y\in \mathbb{R}$$. And the underlied joint distribution is $$Pr(X, Y)$$. Then suppose that our loss function is $$L(Y, f(X)) = (Y - f(x))^2$$, i.e. the squared loss. Then we have a measure for function $$f$$, which we can use as a criterion to selecte $$f$$,

$$
\begin{equation}
  \begin{split}
    EPE(f) &= E(Y - f(X))^2\\
    &= \int [y - f(x)]^2 Pr(dx, dy)
  \end{split}
\end{equation}
$$

Then we can condition it on $$X$$

$$
\begin{equation}
  \begin{split}
    EPE(f) &= E_{X}E_{Y|X}[(Y - f(X))^2|X]\\
  \end{split}
\end{equation}
$$

By minimizing it pointwisely, we get the solution

$$
f(x) = E(Y| X = x)
$$

This is also known as the *regression function*. It is the best prediction of $$Y$$ at any point $$X = x$$, given the perfect knowledge of $$Pr(X, Y)$$, w.r.t. the averaged squared error.

Note if we change the loss function, the solution is different. For example, if we use $$L(Y) = |Y-f(x)|$$, the solution will be the conditional median instead of the conditional mean. This is actually more robust than least squares, as it is much less sensitive to the outlier than least square fit. However, as the derivate of it is not continuos at zero, which makes it hard to optimize and lose the closed form solution.


### Nearest-Neighbor
The nearest-neighbor methods exactly follow this thought in an approximated way,

$$
\hat{f}(x) = Ave(y_i| x_i \in N_k(x)),
$$

And the two approximations used here are

>- expectation is approximated by averaging over **sample data**;
- conditioning at a point is **relaxed** to conditioning on some region
“close” to the target point.

It is easy to see that as $$N,K \to \infty, s.t. k/N \to 0$$, we have $$\hat{f}(x) \to E[Y|X = x]$$. But the problem is that we usually don't have that much data, i.e the first approximation is bad. Another problem is that as $$p$$ increases, the data samples we have will be scattered very sparsely in the space, which leads to fail of using nearest neighbor as a surrorgate for conditioning, i.e. the second approximation is not good. And the *convergence rate* also decreases.

### Linear regression

Linear regression is a *model-based* approach. It means that we have the belief/assumption that the regression function is approximately linear in its arguments:

$$
f(x) = E(Y| X = x) \approx x^T\beta
$$

If this assumption is satisfied, we have 

$$
\begin{equation}
  \begin{split}
    EPE(f) &= E[(Y - X^T\beta)^2]\\
  \end{split}
\end{equation}
$$

Then by differentiating it w.r.t $$\beta$$ and set the gradient to zero, we can get the closed form solution

$$
\beta = [E(XX^T)]^{-1}E(XY)
$$

Thus actually both nearest-neighbor and linear model are trying to approximate the condtional expectations by averages.




# 2.5 Local Methods in High Dimensions






