---
layout: post
title: Bias-Variance
comments: true
published: false

---
##Measurements of 
Leaner: Leaner is a map from datasets to hypothe

##Measurement of learners

In this article, we consider the problem of measuring the performance of a learner. Leaner is a mapping from training samples to hypothesis. And intuitively, we want a good generalization capability of our hypothesis on testing dataset, i.e. low test error. Thus the expectated error of a hypothesis over the distribution of input-output pairs would be a good measurement of the hypothesis and thus we can further compute the expected prediction error of the learnner over the distribution of different hypotheses, i.e over the distribution of training datasets.

For this measurement of error, we have a bias-variance tradeoff. About this topic, wikipedia superisingly gives a very brief and good exlanations:

> Main article: [Bias-variance dilemma](http://en.wikipedia.org/wiki/Bias-variance_dilemma)
> A first issue is the tradeoff between bias and variance.[2] Imagine that we have available several different, but equally good, training data sets. A learning algorithm is biased for a particular input x if, when trained on each of these data sets, it is systematically incorrect when predicting the correct output for x. A learning algorithm has high variance for a particular input x if it predicts different output values when trained on different training sets. The prediction error of a learned classifier is related to the sum of the bias and the variance of the learning algorithm.[3] Generally, there is a tradeoff between bias and variance. A learning algorithm with low bias must be "flexible" so that it can fit the data well. But if the learning algorithm is too flexible, it will fit each training data set differently, and hence have high variance. A key aspect of many supervised learning methods is that they are able to adjust this tradeoff between bias and variance (either automatically or by providing a bias/variance parameter that the user can adjust).


##Notations and assumptions

$$X$$: vector of input random variables

$$Y$$: single output random variable

$$P(X, Y)$$: joint distribution of $$(X, Y)$$ input-output pair, from which training and testing samples are drawn. All samples are i.i.d.

$$D$$: the training dataset

$$\hat{Y}(X \vert D)$$: prediction function learned from dataset $$D$$, given input vector $$X$$

$$h(x)$$: True hypothesis. We assume that $$Y = h(x) + \epsilon$$, where $$\epsilon \in N(0, \delta^2)$$

##Expected Error

According to the previous discussion, the measurement we adopt to evaludate a learner is 

$$\begin{equation}
	E_{D}[E_{P(X,Y)}[ERR(X)]] = E_{D}[E_{P(X,Y)}[ERR(X)]]
\end{equation}$$

First we look at the error function $$ERR(X)$$

$$\begin{equation}
	\begin{split}
		 ERR(X) &= (\hat{Y}(X \vert D) - Y)^2\\
		&= (\hat{Y}(X \vert D) -h(X) + h(X) - Y)^2\\
		&= (\hat{Y}(X \vert D) -h(X))^2 + (h(X) - Y)^2 + 2 (\hat{Y}(X \vert D) -h(X))(h(X) - Y)
	\end{split}
\end{equation}$$

Given any dataset $$D$$, the expected loss is

$$\begin{equation}
		 E_{P(X, Y)}[ERR(X)] = E_{P(X, Y)}[(\hat{Y}(X \vert D) -h(X))^2] + E_{P(X, Y)}[(h(X) - Y)^2] + 2 E_{P(X, Y)}[(\hat{Y}(X \vert D) -h(X))(h(X) - Y)]
\end{equation}$$

The third term can be proved to be zero as follows

$$\begin{equation}
	\begin{split}
		E_{P(X, Y)}[(\hat{Y}(X \vert D) -h(X))(h(X) - Y)] &= E_{X}[(\hat{Y}(X \vert D) -h(X))E_{Y|X}[(h(X) - Y)]]\\ 
		&= E_{X}[(\hat{Y}(X \vert D) -h(X))(h(X) - E_{Y|X}[Y])] 
	\end{split}
\end{equation}$$

Here we have 

$$\begin{equation}
h(X) - E_{Y|X}[Y] = 0
\end{equation}$$

Thus the third term is proved to be zero and we have 

$$\begin{equation}
	E_{P(X, Y)}[ERR] = E_{P(X, Y)}[(\hat{Y}(X \vert D) -h(X))^2] + E_{P(X, Y)}[(h(X) - Y)^2]
\end{equation}$$

The first term in this equation represents how well our prediction function approximates the hypothesis. The better we approximate it, the smaller the error is. The second term represents the random noise. Actually $$E_{P(X, Y)}[(h(X) - Y)^2] =$$ $$E_{P(X, Y)}[(h(X) - h(X) - \epsilon)^2]$$ $$= E_{P(X, Y)}[(\epsilon)^2] = \delta^2$$. This term is totally out of our control.

Then we take the expectation of the error function over the distribution of training datasets and get

$$\begin{equation}
	\begin{split}
		E_{D}[E_{P(X, Y)}[ERR]] &= E_{D}[E_{P(X, Y)}[(\hat{Y}(X \vert D) -h(X))^2]] + \delta^2\\
		&= E_{D}[E_{P(X, Y)}[(\hat{Y}(X \vert D) - E_{D}[\hat{Y}(X \vert D)] + E_{D}[\hat{Y}(X \vert D)] -h(X))^2]] + \delta^2\\
		&= E_{D}[E_{P(X, Y)}[(\hat{Y}(X \vert D) - E_{D}[\hat{Y}(X \vert D)])^2 + (E_{D}[\hat{Y}(X \vert D)] -h(X))^2 - 2(\hat{Y}(X \vert D) - E_{D}[\hat{Y}(X \vert D)])(E_{D}[\hat{Y}(X \vert D)] -h(X))]] + \delta^2\\
		&= E_{D}[E_{P(X, Y)}[(\hat{Y}(X \vert D) - E_{D}[\hat{Y}(X \vert D)])^2 + (E_{D}[\hat{Y}(X \vert D)] -h(X))^2 - 2\times 0 \times (E_{D}[\hat{Y}(X \vert D)] -h(X))]]] + \delta^2\\
		&= E_{D}[E_{P(X, Y)}[(\hat{Y}(X \vert D) - E_{D}[\hat{Y}(X \vert D)])^2]] + E_{P(X, Y)}[(E_{D}[\hat{Y}(X \vert D)] -h(X))^2]] + \delta^2\\
		&= E_{P(X, Y)}[E_{D}[(\hat{Y}(X \vert D) - E_{D}[\hat{Y}(X \vert D)])^2]] + E_{D}[(E_{D}[\hat{Y}(X \vert D)] -h(X))^2]] + \delta^2\\
		&= E_{P(X, Y)}[Var_{D}[(\hat{Y}(X \vert D)] + (E_{D}[\hat{Y}(X \vert D)] -h(X))^2] + \delta^2\\
		&= E_{P(X, Y)}[Var_{D}[(\hat{Y}(X \vert D)] + (Bias[\hat{Y}(X \vert D)])^2] + \delta^2\\
	\end{split}	
\end{equation}$$

Here the first term is the variance of our prediction, the second one is the bias of our prediction, and the third one is the random noise.


