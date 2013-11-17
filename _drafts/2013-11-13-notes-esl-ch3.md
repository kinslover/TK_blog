---
layout: post
title: [notes][ESL] Chapter 3: Overview of Supervised Learning
comments: true
published: false

---


Linear method for regression
========================================================

# 3.1 Introduction

Assumption: the regression function $E[Y|X]$ is linear in the input vector $X_1,...,X_p$.

Linear model is simple, but often provide **adequate** and **interpretable** description of how inputs affect the ouput.

For scenarios, where

- small number of training samples
- low signal-to-noise ratio
- sparse data

linear methods can outperform fancier non-linear methods.

And we can this non-linear transformation, basis expansion or some other techniques to extend its scope of applications.

# 3.2 Linear Regression Models and Least Squares

The linear regression model has the form

$$
f(X) = \beta_0 + \sum_{j = 1}^p X_j\beta_j
$$

Variables $X_j$ come from various sources:

> - quantitative inputs;
- **transformations** of quantitative inputs, such as log, square-root or square
- **basis expansions**, such as X_2 = X_1^2, X_3 = X_1^3, leading to a polynomial representation;
- **numeric or "dummy" coding** of the levels of qualitative inputs. 
- **interactions** between variables, for example, $X_3 = X_1 X_2$.

$Least squares$ is a popular way of estimating $\beta$. First the residual sum of squares is defined

$$
RSS(\beta) = \sum_{i = 1}^N(f(x_i) - y_i)
$$

And we want the $\beta$ that minimize $RSS(\beta)$, i.e. $\hat{\beta} = argmin_{\beta}RSS(\beta)$.

Note that *least squares* does not assume that our model is linear. It is a general way of estimation.

For linear models, we have 

$$
\begin{equation}
  \begin{split}
    RSS(\beta) &= \sum_{i = 1}^N(f(x_i) - y_i)
    &= \sum_{i = 1}^N(\sum_{j}^px_{ij}\beta_j - y_i)
  \end{split}
\end{equation}
$$

Assume that we have added a $\mathbf{1}$ vector to the input vector, then we can rewrite the $RSS(\beta)$ as 

$$
RSS(\beta) = (\mathbf{y} - \mathbf{X}\beta)^T(\mathbf{y} - \mathbf{X}\beta)
$$

Differentiate it w.r.t $\beta$ and we get 

$$
\frac{\partial RSS}{\partial \beta} = -2 \mathbf{X}^T(\mathbf{y} - \mathbf{X}\beta)
$$

Assuming that $X$ is full column rank, thus $X^TX$ is positive definite and hence it is invertible, we set the derivate above to zero and get the **unique** solution

$$
\hat{\beta} = (\mathbf{X}^T\mathbf{X})^{-1}\mathbf{X}^T\mathbf{y}
$$

Then the predicted values at the training samples are

$$
\begin{equation}
  \begin{split}
  \hat{\mathbf{y}} = \mathbf{X}\hat{\beta} = \mathbf{X}(\mathbf{X}^T\mathbf{X})\mathbf{X}^T\mathbf{y}
  \end{split}
\end{equation}
$$

The matrix $H = \mathbf{X}(\mathbf{X}^T\mathbf{X})\mathbf{X}^T$ is called "hat" matrix as it puts a hat on $y$.

The geometrical explanation about how we estimate is as follows. Our target is to minimize $RSS(\beta) = \| \mathbf{y} - \mathbf{\hat{y}}\|_2^2$. Then $\mathbf{y} - \mathbf{\hat{y}}$ is orthogonal to the column space of $\mathbf{X}$.

$$
X^T(\hat{\mathbf{y}} - \mathbf{y}) = 0
$$

Then

$$
X^T(X\beta - \mathbf{y}) = 0
$$

What is interesting here is that it seems that we rediscover $\frac{\partial RSS(\beta)}{\partial \beta} = 0$ from a different point of view. Here $H$ can be called *projection matrix*, as it projects $\mathbf{y}$ on to the column space of $\mathbf{X}$.

When $\mathbf{X}$ contains linear dependent variables, $X^TX$ is singular. But $\hat{\mathbf{y}}$ are still projection of $\mathbf{y}$ on the column space. The difference is that we have multiple(infinite?) representations of $\hat{\mathbf{y}}$ now.

## Sampling properties of $\hat{\beta}$

Assuming that $y_i$ are uncorrelated and have constant $\sigma^2$. $x_i$ are fixed(not random). Then as $\hat{\beta} = (\mathbf{X}^T\mathbf{X})\mathbf{X}^T\mathbf{y}$, the variance-covariance matrix of the least squares estimates is

$$
Var(\hat{\beta}) = (\mathbf{X}^T\mathbf{X})^{-1}\sigma^2
$$

$\sigma^2$ can be estimated by

$$
\hat{\sigma^2} = \frac{1}{N-p-1} \sum_{i = 1}^N(y_i - \hat{y_i})^2,
$$

which is an unbiased estimate of $\sigma^2$.

Now we assume that linear model is the right model for the regression function and the way $Y$ is generated from $X$ is

$$
\begin{equation}
  \begin{split}
  Y &= E[Y|X] + \epsilon\\
  &=X\beta + \epsilon,
  \end{split}
\end{equation}
$$

where $\epsilon \sim N(0, \sigma^2)$.

Then 

$$
\begin{equation}
  \begin{split}
  E[\hat{\beta}] &= E[(\mathbf{X}^T\mathbf{X})\mathbf{X}^T\mathbf{y}] \\
  &=E[(\mathbf{X}^T\mathbf{X})\mathbf{X}^T(X\beta + \epsilon)]\\
  &=(\mathbf{X}^T\mathbf{X})^{-1}\mathbf{X}^T\mathbf{X}\beta\\
  &=\mathbf{I}\beta = \beta
  \end{split}
\end{equation}
$$

Thus we have 

$$
\hat{\beta} \sim N(\beta, (\mathbf{X}^T\mathbf{X})^{-1}\sigma^2)
$$

Also,

$$
(N-p-1)\hat{\sigma}^2 =\sum_{i = 1}^N(y_i - \hat{y_i})^2 = \sigma^2\sum_{i = 1}^N(\frac{y_i - x_i^T\hat{\beta}}{\sigma})^2 \sim \sigma^2 \chi^2_{N-p-1}
$$

Note that the two estimations $\hat{sigma}$ and $\hat{\beta}$ are statistically independent and thus we can construct the $Z-score$ to test the hypothesis that a particular coefficient $\beta_j = 0$

$$
z_j  = \frac{\hat{\beta}_j}{\hat{\sigma}\sqrt{(\mathbf{X}^T\mathbf{X})_{jj}^{-1}}} = \frac{\hat{\beta}_j}{\sqrt{(\mathbf{X}^T\mathbf{X})_{jj}^{-1}\sigma^2\frac{\hat{\sigma}^2}{(N-p-1)\sigma^2}}} = \frac{(\hat{\beta}_j)/(\sqrt{(\mathbf{X}^T\mathbf{X})_{jj}^{-1}\sigma^2})}{\sqrt{\frac{\hat{\sigma}^2}{(N-p-1)\sigma^2}}} 
$$

Thus under the null hypothesis $\beta_j = 0$,

- $z_j$ is distributed as $t_{N - p - 1}$.(If it can be zero, we can exclude this feature) 
- A large value of $\hat{\beta_j}$ would reject the null hypothesis. 
- If we use the true variance $\sigma$ instead of the $\hat{\sigma}$, this would turn into a standard normal distribution.
- As $N$ increases, the quantiles of a t-distribution approaches $N(0, 1)$.

To test the significance of a group of coefficients simultaneously, e.g. a group of dummy variables generated from a single categorical variable, we need to test whether it is ok to set the coefficients of all these features to zero. *Here we use F statistic*,

$$
F = \frac{(RSS_0 - RSS_1)/(p_1 - p_0)}{RSS_1/(N - p_1 - 1)}
$$

where

- $RSS_1$: the residual sum of squares for the least squares fit with the tested features, $RSS_0$ for the same without tested features.
- $p_1$: number of features with tested features, $p_0$ is the number without tested features.

> The F statistic measures the change in residual sum-of-squares per additional parameter in the bigger model, and it is normalized by an esti- mate of $\sigma^2$

With the Gaussian assumption and the null hypothesis that the model with less coefficients is correct,

- $F \sim F_{p_1 - p_0, N-p_1-1}$.
- For dropping single coefficient, $z_j$ is equivalent to $F$ statistic.
- For large $N$, the quantiles of $F_{p_1-p_0, N-p_1 - 1}$ approaches $\chi^2_{p_1 - p_0}/(p_1 - p_0)$.


*In summary, we use Z-score to see if a feature is significant and F-stat to see if a group of features are significant.*

**Problem:** If two features are very correlated, then inclusion of one will make the other not significant. As a result, we may exclude both of them if we purely follow the independently computed $Z-score$.

### The Gauss-Markove Theorem

The *least squares estimates* $\hat{\beta}$ of $\beta$ have the *smallest* variance among all *linear unbiased estimates*.

However, unbiased assumption may be unnecessary, we could sacrifice some bias for even lower variance, which results in a lower expected generalization error.

Now we try to prove that it is a unbised estimates and has the lowest variance

**Unbiased estimates**

Consider the case that we are estimating the linear combinations of the parameters $\theta = \alpha^T\beta$, then the least squares estimates of $\alpha^T\beta$ is

$$
\theta = \alpha \hat{\beta} = 
$$




## 3.3 Subset Selection

Two problems with least squares estimates:

- Prediction accuracy: low bias, but high variance. We may trade some bias for less variance.
- Interpretation: When faced with numerous features, we would like to see the "big picture" of what is important.

In subset selection, we only keep a subset of the variables in the model. *Least squares regression* is used to estimate the coefficients of the remained inputs.

### 3.3.1 Bes-subset selection


>Best subset regression finds for each $k \in \{0, 1, 2, . . . , p\}$ the subset of size $k$ that gives smallest residual sum of squares.

The problem of choosing $k$ involves the tradeoff between bias and variance, and the way we do that is to measure the expected prediction error with the help of cross validation.

Some algorithms, such as leaps and bounds, can solve this problem up to $p = 30 or 40$.

### 3.3.2 Forward and Backward-Stepwise Selection

Instead of searching all possible subsets, we can seek a good path through them.

*Forward and Backward-Stepwise Selection* 
