Title
========================================================

## Gamma函数 $\Gamma(x)$

$$
\Gamma(x) = \int_{0}^{\infty} e^{-t}t^{x - 1} dt
$$

其中，$x > 0$。

$$
\Gamma(1) = \int_{0}^{\infty} e^{-t} dt = 1
$$

$$
\Gamma(\frac{1}{2}) = \sqrt{\pi}
$$

$\Gamma$函数有地推公式

$$
\Gamma(x+1) = x\Gamma(x)
$$

则，当$n$为正整数时

$$
\Gamma(n) = (n-1)!
$$

当$n$为奇数时，
$$
\Gamma(\frac{n}{2}) = 1 \times 3 \times 5 ...(n - 2)2^{-\frac{n-1}{2}}\sqrt{\pi}
$$



## Beta函数 $\beta(x)$

$$
\beta(x, y) = \int_{0}^1 t^{x-1}(1-t)^{y-1} dt
$$
其中 $x, y > 0$。


## Gamma函数与Beta函数的关系

$$
\beta(x, y) = \frac{\Gamma(x) \Gamma(y)}{\Gamma(x + y)}
$$

## $\chi^2$分布

下面利用$\chi^2$来构造一个函数

$$
\begin{equation}
  k_n(x) = 
  \left\{
    \begin{array}{r@{\;=\;}l}
    \frac{e^{-x/2}x^{(n-1)/2}}{\Gamma(\frac{n}{2})2^{n/2}} & x > 0\\
    0 & x \leq 0
    \end{array}
  \right.
\end{equation}
$$

我们可以对该函数做积分验证其积分和为1，且处处不为负，进而证明这是一个概率密度函数。该函数被称为**自由度为n的皮尔逊卡方密度**。

假设$X_1$,...,$X_n$相互独立，且服从标准正态分布$N(0,1)$，则$Y = X_1^2+...+X_n^2$服从自由度为$n$的卡方分布$\chi^2_n$。证明使用数学归纳法。定义中的“自由度$n$”也可以由此解释，即$n$个独立变量的平方和，每个变量都可以独立随意变化，所以说有一个自由度。不过对于$n$不为正整数的时候，这个解释就失效了。

### 重要性质

- 若$X_1 \sim \chi^2_m, X_2 \sim \chi_n^2$，且两变量独立，则$X_1 + X_2 \sim \chi^2_{m+n}$。显然。
- 若$X_1, ..., X_n$独立，且都服从指数分布，则
$$
X = 2\lambda(X_1 + ... + X_n) \sim \chi^2_{2n}
$$


## $t$分布

设$X_1, X_2$独立，$X_1 \sim \chi_n^2, X_2 \sim N(0, 1)$，同时

$$
Y = \frac{X_2}{\sqrt{X_1/n}}
$$

则其概率密度函数为

$$
t_n(y) = \frac{\Gamma((n+1)/2)}{\sqrt{n\pi}\Gamma(n/2)}(1 + \frac{y^2}{n})^{-(n+1)/2}
$$

此为**自由度为$n$的$t$分布**的概率密度函数。$Y \sim t_n$。当自由度很大时，其接近标准正态分布。

## F分布

设$X_1, X_2$独立，$X_1 \sim \chi^2_n, X_2 \sim \chi^2_m$，同时

$$
Y = \frac{X_2/m}{X_1/n}
$$

则其概率密度函数为，当$y>0$时，

$$
f_{mn}(y) = m^{m/2}n^{n/2}\frac{\Gamma(\frac{m+n}{2})}{\Gamma(\frac{m}{2})\Gamma(\frac{n}{2})}y^{m/2 - 1}(my + n)^{-(m+n)/2};
$$

当$y \leq 0$时，

$$
f_{mn}(y) = 0.
$$

这个分布称为“自由度$m$，$n$的$F$分布”。

## $\chi^2, t, F$

$\chi^2, t, F$被称为统计三大分布，其原因是以下几条重要性质。

### 性质

- 设$X_1, ..., X_n$为$i.i.d$，服从$N(\mu, \sigma^2)$。记

$$
\bar{X} = (X_1 +...+X_n)/n
$$

$$
S^2 = \sum_{i=1}^n(X_i - \bar{X})^2/(n-1)
$$

则有

$$
(n-1)\frac{S^2}{\sigma^2} = \sum_{i = 1}^n \frac{(X_i - \bar{X})^2}{\sigma^2} \sim \chi^2_{n-1}
$$

- 设$X_1, ..., X_n$为$i.i.d$，服从$N(\mu, \sigma^2)$。则

$$
\frac{\sqrt{n}(\bar{X} - \mu)}{S} \sim t_{n-1}
$$

- 设$X_1, ..., X_n, Y_1,...,Y_m$独立，$X_i$分布$N(\mu_1, \sigma_1^2)$，$Y_j$分布$N(\mu_2, \sigma_2^2)$，则有

$$
a. \frac{\sum_{j = 1}^m(Y_j - \bar{Y})^2/(\sigma_2^2(m-1))}{\sum_{i = 1}^n(X_i - \bar{X})^2/(\sigma_1^2(n-1))} \sim F_{m-1, n - 1}
$$

若$\sigma_1^2 = \sigma_2^2$，则有

$$
\frac{\sqrt{\frac{nm(n+m-2)}{n+m}}[(\bar{X} - \bar{Y}) - (\mu_1 - \mu_2)]}{[\sum_{i=1}^n(X_i - \bar{X})^2 + \sum_{j = 1}^m(Y_j - \bar{Y})^2]^{1/2}} ~ t_{n+m-2}
$$

