# Random Sampling

We face a scenario in which we need to sample from an inaccessible probability distribution for our analysis. Although we cannot directly observe or sample from this target distribution, we can use statistical and probability theory to approximate it using other accessible distributions. By sampling from these proxy distributions, we can infer properties of the underlying population and assess whether samples from the two distributions could be interchangeable.

Our exploration begins with Rejection Sampling, where we examine:

-Why and when this algorithm is useful

-How it works from a mathematical perspective

-Practical examples of its application

-Its key limitations

From there, we delve into Markov Chain Monte Carlo (MCMC) methods, a broader class of sampling techniques. Within this framework, we focus on the Metropolis-Hastings Algorithm, one of the most fundamental MCMC methods. We analyze:

-The conditions under which it succeeds

-Its underlying mathematical mechanics

-Its advantages over alternative approaches

Throughout this analysis, we place special emphasis on a concept called "overlap", which quantifies the similarity between two probability distributions. Overlap helps determine how likely it is that samples from one distribution could substitute for samples from another. We investigate how overlap influences the performance of the algorithms discussed and why it is a critical consideration in statistical sampling.

Finally, we conclude with a real-world economic application of the Metropolis-Hastings algorithm and overlap. We compare the interpretability of overlap with traditional p-values, arguing that overlap provides a more intuitive and meaningful measure of distributional similarity in many cases.
