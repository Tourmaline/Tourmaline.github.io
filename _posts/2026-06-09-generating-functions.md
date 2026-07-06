---
layout: post
title: "Probability Generating Functions"
date: 2026-07-06
tags: [probability, generating-functions, random-variables, statistics]
math: true
---


Let $X$ is a random variable with the probability mass function (pmf) $P(X = n)$. We define a series $G(y)$ with coefficients given by the pmf of $X$ as follows:

$$
G(y) = \sum_{n=0}^{\infty} P(X = n) y^n = \mathbb{E}\left[y^X\right]
$$

This series $G(y)$ is known as the (probability) generating function of the random variable $X$. 


Note that 

$$
G(1) = \sum_{n=0}^{\infty} P(X = n) = 1,
$$

which is a consequence of the fact that the pmf sums to 1.

Then, taking the first and second derivatives of $G(y)$ with respect to $y$ we have:

$$
G'(y) = \sum_{n=0}^{\infty} n P(X = n) y^{n-1} = \mathbb{E}\left[X y^{X-1}\right]
$$

and 

$$
G''(y) = \sum_{n=0}^{\infty} n(n-1) P(X = n) y^{n-2} = \mathbb{E}\left[X(X-1) y^{X-2}\right].
$$

Substituting $y = 1$ into the above equations, we obtain the expected value and variance of the random variable $X$:

$$
G'(1) = \mathbb{E}[X] \quad \text{and} \quad G''(1) + G'(1) - (G'(1))^2 = \operatorname{Var}(X).
$$



### Example: geometric distribution

Let $X$ be a geometric random variable with success probability $p$, i.e.,

$$
P(X = n) = (1-p)^{n-1} p = q^{n-1} p, \quad n = 1, 2, 3, \dots, \quad \text{where } q = 1-p.
$$

The probability generating function of $X$ is

$$
G(y) = \sum_{n=1}^{\infty} q^{n-1} p y^n = \frac{p y}{1 - q y}.
$$

Taking the first and second derivatives of $G(y)$, we have

$$
G'(y) = \frac{p}{(1 - q y)^2} \quad \text{and} \quad G''(y) = \frac{2 p q}{(1 - q y)^3}.
$$

Then using the formulas for the expected value and variance, we obtain

$$
\mathbb{E}[X] = G'(1) = \frac{p}{(1 - q)^2} = \frac{1}{p} \quad \text{and} \quad \operatorname{Var}(X) = G''(1) + G'(1) - (G'(1))^2 = \frac{q}{p^2}.
$$



## Sum of independent random variables

Let $X$ and $Y$ be two **independent** random variables with generating functions $G_X(y)$ and $G_Y(y)$, respectively. Then the generating function of the sum $Z = X + Y$ is given by

$$
G_Z(y) = \sum_{n=0}^{\infty} P(Z = n) y^n = \sum_{n=0}^{\infty} \sum_{k=0}^{n} P(X = k) P(Y = n-k) y^n = G_X(y) G_Y(y).
$$



### Example: Bernoulli distribution

Let $X$ be a Bernoulli random variable with success probability $p$, i.e.,

$$
P(X = n) = \begin{cases}
1-p, & n = 0, \\
p, & n = 1.
\end{cases}
$$

The probability generating function of $X$ is

$$
G(y) = (1-p) + p y = q + p y, \quad \text{where } q = 1-p.
$$

If we repeat the experiment $k$ times independently, the probability generating function of the sum of $k$ independent Bernoulli random variables is given by

$$
G_k(y) = (q + p y)^k,
$$

which is the generating function of a binomial random variable with parameters $k$ and $p$.


Probability generating functions are built for non-negative integer-valued random variables. Coefficients of the generating function give you directly the probabilities.


# Moment generating functions

Extension of the probability generating function to real-valued random variables is called the moment generating function (mgf). It is defined as follows:

$$
M_X(t) = \mathbb{E}\left[e^{tX}\right] = \int_{-\infty}^{\infty} e^{tx} f_X(x) dx,
$$

where $f_X(x)$ is the probability density function (pdf) of the random variable $X$.

Moreover, we can expand the exponential function in a Taylor series and write the mgf as

$$
M_X(t) = \mathbb{E}\left[e^{tX}\right] = \mathbb{E}\left[\sum_{n=0}^{\infty} \frac{(tX)^n}{n!}\right] = \sum_{n=0}^{\infty} \frac{t^n}{n!} \mathbb{E}[X^n]
$$


Differentiating the mgf with respect to $t$ and evaluating at $t = 0$, we can obtain the moments of the random variable $X$:

$$
M_X^{(n)}(0) = \mathbb{E}[X^n].
$$

Very nice, but unfortunately, the mgf does not always exist. It happens when the tail decay is too slow, in particular, slower than exponential. 
In this case, the integral defining the mgf diverges for $t \neq 0$.  And even if the moments exist, the mgf does not exist for $t \neq 0$, and we cannot use it to compute the moments. Example of such a distribution is a log-normal distribution, which has all moments finite, but the mgf does not exist for $t \neq 0$. 



# Characteristic functions


To solve the problem of non-existence of the mgf, we can use the characteristic function (cf), which is defined as follows:



$$
\phi_X(t) = \mathbb{E}\left[e^{itX}\right] = \int_{-\infty}^{\infty} e^{itx} f_X(x) dx,
$$

where $i$ is the imaginary unit and $f_X(x)$ is the probability density function of $X$.

Expanding the exponential function in a Taylor series, we can write the characteristic function as:

$$
\phi_X(t) = \mathbb{E}\left[e^{itX}\right] = \mathbb{E}\left[\sum_{n=0}^{\infty} \frac{(itX)^n}{n!}\right] = \sum_{n=0}^{\infty} \frac{(it)^n}{n!} \mathbb{E}[X^n].
$$

Differentiating the characteristic function with respect to $t$ and evaluating at $t = 0$, we can obtain the moments of the random variable $X$:

$$
\phi_X^{(n)}(0) = i^n \mathbb{E}[X^n].
$$  

This formula is valid only up to the order of moments that actually exist. If a moment is infinite, for example the Cauchy mean, the characteristic function is not differentiable enough at $t = 0$ and the formula breaks down.

No matter how heavy the tail of the distribution is, even when no moments exist, the characteristic function always exists. The bound below needs no assumption about moments:

$$
|\phi_X(t)| = \left|\int_{-\infty}^{\infty} e^{itx} f_X(x) dx\right| \leq \int_{-\infty}^{\infty} |e^{itx}| f_X(x) dx = \int_{-\infty}^{\infty} f_X(x) dx = 1.
$$





