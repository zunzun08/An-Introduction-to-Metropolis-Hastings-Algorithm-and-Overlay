
# The Metropolis Hastings Algorithm

**Introduction:**
The Metropolis-Hastings (MH) algorithm is a Monte Carlo Markov Chain (MCMC) method that allows us to generate samples from a "target" distribution. A target distribution is a function whose form is known but whose constant of integration is unknown and/or cannot be calculated through traditional methods or numerical methods. Because the constant of integration cannot be calculated, traditional methods of smpling such as the inverse CDF method cannot be applied. Instead, we'll explore the Metropolis Hastings algorithm which works by an iterative process: it draws samples from a proposal probability density function and based on overlap, the probability a sample drawn from the proposal can replace a sample from the target subsequently, the sample is accepted or rejected. After a few thousand iterations, the MH algorithm simulates sampling from the target distribution, without ever calculating the constant of integration. 

**Example:**
Suppose $q(x) \sim N(0,1)$ and $p(x) \sim N(1,2)$ where $p(x)$ is a distribution that is easy to sample from and $q(x)$ is difficult to sample from. By applying the MH Algorithm 10,000 times, and only sampling from $p(x)$, we can achieve the following result:

![Alt Text](Animations/metropolis_hastings-ezgif.com-video-to-gif-converter.gif)

Effectively, we are taking samples from $p(x)$ and concluding that they are in fact coming from $q(x)$.

### Mathematical Background:
Before formally defining the Metropolis Hastings, I'd like to recall or introduce a few concepts the reader should be familiar with to understand the proof of the Metropolis-Hastings Algorithm.


**Monte Carlo**:

Monte Carlo methods are a class of computational techniques that use random sampling to approximate mathematical quantities, such as integrals. These methods are useful when analytical solutions are difficult or impossible to obtain.

Given a probability density function $f(x)$ and independently and identically distributed (i.i.d) samples $x_1, x_2, ..., x_n$ from $f(x)$, we can approximate the integral of a continuous function $a(x)$ with respect to $f(x)$:

$$
I = \int a(x)f(x)dx
$$

With the following estimation:

$$
\hat{I} = \frac{1}{n} \sum_{i=1}^{n} a(x_i)
$$


Where $\hat{I}$ is an unbiased estimator of $I$. By the law of large numbers $\hat{I} \rightarrow I$ and $E[\hat{I}] = I$

**Proof**:
It should be noted that by the Law of the Unconscious Statistician:

$$
I = \int a(x)f(x)dx = E[a(x)]
$$

By properties of expected value we apply the following:

$$
E[\hat{I}] = E[\frac{1}{n} \sum_{i=1}^n a(x_i)] = \frac{1}{n} \sum_{i=1}^n E[a(x_i)]
$$

Since $x_1, x_2, ..., x_n$ are i.i.d

$$
E[\hat{I}] = \frac{1}{n} (nI) = I = E[a(x)]
$$

We can also show that as the number of samples increase, our stimate approaches the true value.
Proof:

$$Var[\hat{I}] = Var[\frac{1}{n} \sum_{i=1}^na(x_i)] = \frac{1}{n^2}\sum_i Var[a(x_i)]$$

Since our samples are i.i.d:

$$=\frac{1}{n^2}(nVar[a(x_i)]) = \frac{1}{n}Var[a(x_i)]$$

Now applying the limit:

$$\lim_{n \rightarrow \infty} \frac{1}{n}Var[a(x_i)] = 0$$

**Markov Chain Stationarity Property:**

A Markov chain is a stochastic process where the future state depends only on the current state and not on the sequence of events that preceded it. A key concept in Markov chains is the **stationary distribution**, which is a probability distribution that remains unchanged as the chain evolves over time.

The MC Stationarity property requires the following:
1. A p.d.f: $f(x)$
2. An i.i.d sample $x_1, x_2, ..., x_n$ drawn from $\Pr(\cdot | x_{i-1})$, the transition kernel from the previous state, $x_{i-1}$.
3. The stationary distribution must satisfy the following process: 

$$
f(y) = \int \Pr(y | x) f(x) \text{dx}
$$

If all three conditions are met then the following is true:
If the initial state $`x_1`$,​ is drawn from the stationary distribution $`f(x)`$, and each subsequent state $`x_{i+1}`$ is drawn from $`\Pr⁡(⋅∣x_i)`$, then all states $`x_i`$ will also follow the stationary distribution $`f(x)`$. 

**Markov Chain Monte Carlo:**

Markov Chain Monte Carlo (MCMC) methods combine Monte Carlo sampling with Markov chains to generate samples from a target probability distribution $`f(x)`$.

Given a sequence of samples $x_1,x_2,…,x_n$​ generated by a Markov chain with stationary distribution $`f(x)`$, we can approximate expectations of a function $`a(x)`$ as follows:
Then:

$$
\Pr(\cdot | x_1) \approx \frac{1}{n} \sum_{i=1}^n a(x_i)
$$

This approximation holds because, under certain conditions, the Markov chain will eventually produce samples that are distributed according to $`f(x)`$, even if the samples are not independent.

By the definition above and the description above, the MH algorithm is an MCMC method.


## The Algorithm
**Metropolis-Hastings Algorithm:**
1. Pick $p(x)$ and $q(x)$ where $p(x)$ is a distribution that can be easily sampled from.
2. Set an initial value of $x$ (could be anything, keep it reasonable)
3. Take $x'$ from $p(x)$
4. Evaluate $q(x')$
5. Compute 
$\alpha(x', x) = \min(1, \frac{p(x')q(x|x')}{p(x)q(x'|x)})$

6. Draw a random sample $u$ from $\text{Uniform}[0,1]$
7. Accept or reject: 
   If $u < \alpha(x',x)$:
	$x_2 = x'$
	else:
		$x_2 = x_1$

## Proof of Metropolis Hastings Algorithm
From the algorithm we know applying the MH Algorithm does the following:

![Alt Text](Animations/MH Movement.png)

This implies that for any $X_i$ and $X_{i+1}$ for $1 \leq i \leq n$ there must be a density $\text{Pr}(X_{i+1} | X_i)$ that facilitates the movement of random variables.


We also wish to prove $q(y) = \int \Pr(y | x) q(x) dx$, the stationarity condition for our target distribution.
However, we first need to find what $Pr(x_{n+1} | x_n)$ is before we can show the stationary condition holds.

#### Finding $\Pr(X_{n+1} | X_n)$:
$X_{n+1}$ can take on two values. Either $X_{n+1}$ takes on the values of $x'$ with some probability w(x) or the sample is rejected in which case $X_{n+1} = x_n$ with praobability 1-w(x). 
We can represent this as:

$$
X_{n+1} = \begin{cases}
x' \text{ determined by w(x)} \\
x_n \text{ 1- w(x)}
\end{cases}
$$

Since we are looking to determine $\Pr(X_{n+1} | X_n)$, using the Law of Total Probability, we get:

$$
\Pr(X_{n+1} | X_n) = \text{Pr}(X_{n+1} = x' | X_{n} = x_{n} ) + (1- \text{Pr}(X_{n+1} = x' | X_{n} = x_{n} )) \cdot 1(X_{n+1} = X_n)
$$

Where $1(X_{n+1} = X_n)$ is an indicator variable that tells us our sample was rejected. Let's take  $\Pr(X_{n+1} = x' | X_{n} = x_n)$, the probability we move from one state to the next apart and quantify the result.

$$
\Pr(X_{n+1} = x' | X_{n} = x_n) = \Pr(X' | X_n = x_n) \cdot \Pr(U \leq \alpha(x', x_n) | X' = x', X_n =x_n) =q(x' | x_n) \alpha(x', x_n) 
$$

Since our outcomes are binary, $X_{n+1}$ either takes on $x'$ or $X_n$, we can directly construct our density function:

$$
\text{Pr}(X_{n+1} | X_{n}) = w(x)f(x_{n+1} | x_n) + (1-w(x))1(X_{n+1} = X_n)
$$

where $w(x)$ is:

$$
w(x_n) = \int q(x_{n+1} | x_n) \alpha(x_{n+1}, x_n)dx_{n+1}
$$

and $f(x_{n+1} | x_n)$ is:

$$
f(x_{n+1} | x_n) = \frac{q(x_{n+1} | x_n) \alpha(x_{n+1}, x_n)}{\int q(x_{n+1}|x_n)\alpha(x_{n+1} , x_n) dx_{n+1}
}
$$

#### Proving $q(x_{n+1}) = \int \Pr(X_{n+1} | X_n)q(x_n)\text{dx}$:
We'd like to show the density kernel we just constructed converges to the target distribution. Here we assume our density is egodic where detailed balance is a sufficient condition to show there exists a stationary distribution.
Detailed Balance tells us the rate of transition given we start at $x'$ and move to $x_n$ must be equal to the rate of transition given we start at $x_n$ and move to $x'$. For the Metropolis Hastings, this looks like:

$$q(x')\Pr(X_{n+1} = x'| X_n = x_n) = q(x_n)$$


Claim: The Metropolis Hastings algorithm satisfies detailed balance.
We know the probability of accepting a sample is:

$$\Pr(X_{n+1} = x'| X_n = x_n) = p(x'|x_n)\alpha(x',x_n) =p(x'|x_n) \min \{ 1, \frac{q(x')p(x_n|x')}{q(x_n)p(x'|x_n)} \}$$

We can expand the RHS further:

$$=\min\{p(x'|x_n), \frac{q(x')p(x_n|x')}{q(x_n)}\}$$

If we multiply both sides by $q(x_n)$, we get:

$$\Pr(x'|x_n)q(x_n)= \min ( q(x_n)p(x'|x_n),q(x')p(x_n|x'))$$

$$\Rightarrow \Pr(x'|x_n)q(x_n) = \Pr(x_n|x')q(x')$$

Thus, the Metropolis Hastings Algorithm satisfies detailed balance.

