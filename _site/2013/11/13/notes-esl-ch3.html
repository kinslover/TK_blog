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

And the two estimations $\hat{sigma}$ and $\hat{\beta}$ are statistically independent.



