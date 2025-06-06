# Random Sampling

We face a scenario in which we need to sample from a known probability distribution with an unknown constant of proportionality. Although we cannot directly sample from this target distribution through typical methods (i.e. inverse CDF method), we can use statistical and probability theory to approximate the sampling process of the target distributino distributions from which we can directly sample from. By sampling from "surrogate" distributions, we can then learn properties of the target population and assess whether samples from the two distributions are interchangeable.

Our exploration begins with Rejection Sampling, where we examine:

-Why and when this algorithm is useful

-How it works from a mathematical perspective

-Practical examples of its application

-Its key limitations

From there, we delve into Markov Chain Monte Carlo (MCMC) methods, a broader class of sampling techniques. Within this framework, we focus on the Metropolis-Hastings Algorithm, one of the most fundamental MCMC methods where we'll analyze:

-The conditions under which it succeeds

-Its underlying mathematical mechanics

-Its advantages over alternative approaches

Throughout this analysis, we place special emphasis on a concept called "overlap", which quantifies the similarity between two probability distributions. Overlap helps determine how likely it is samples from one distribution could substitute samples from another. We investigate how overlap influences the performance of the algorithms we'll discuss and why it is a critical consideration in statistical sampling.

Finally, we'll conclude with a real-world economic application of overlap. We compare the interpretability of overlap with traditional p-values, arguing that overlap provides a more intuitive and meaningful measure of distributional similarity in many cases.

# Table of Contents:
### ![Rejection Sampling](https://github.com/zunzun08/zunzun08.github.io/blob/5f740ba5e37a88169aa036eab65586c04a98524a/Rejection%20Sampling%20Algorithm.md)
### ![Markov Chains, Monte Carlo Simulations, and Monte Carlo Markov Chains]
### ![The Metropolis Hastings Algorithm](https://github.com/zunzun08/An-Introduction-to-Metropolis-Hastings-Algorithm-and-Overlay/blob/main/Metropolis%20Hastings%20Algorithm.md)

