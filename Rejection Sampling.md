## Background:
Rejection Sampling provides us an introduction into using  it means to sample values from one distribution and say these samples come from a targeted distribution of interest.

 assumes we have two probability densities $p(x)$ and $q(x)$ where $q(x)$ is our "target" distribution, i.e, the distribution we wish to sample from. We also have $p(x)$, our proposal distribution, which should be a distribution we can sample from.

From our two densities, we construct the following constant M:
$$M = \max_{x} \frac{q(x)}{p(x)}$$
This constant M makes rejection sampling unique. M introduces a sense of likelihood between our pdfs and becomes the basis of what is called "acceptance-rejection" methods as we'll see when we write the algorithm and the proof of the algorithm.

Once M has been constructed, we use the following algorithm to show that all r.v., $X$, sampled from $p(x)$ come from our target distribution, $q(x)$.

## The algorithm:

1. Draw a sample $X \sim p(x)$
2. Draw a sample $u \sim U[0,1]$
3. Test
	If: 
		$U < \frac{q(x)}{M*p(x)}$
	then:
		$X \sim q$
	else:
		Discard $X$ and $u$
4. Repeat
## Example

## Proof of Rejection Sampling
Our goal is to show once we follow the rejection sample algorithm, the random variable we drew $X \sim q(x)$. Probability theory tells us that if  $X \sim q(x)$, the following are equivalent:
$$\Pr(X \in A) = \int_A q(x)\text{dx} = Q(x)$$
Where $A$ is sample space of $q(x)$. This will be the idea we wish to follow for proof of the rejection sampling algorithm.

When we run the rejection sampling algorithm, theres a chance we accept or reject the sample. This chance is random before the algorithm begins and know the outcome is binary. Whether or not the outcome occurs for every iteration of the algorithm is a random variable (r.v) that we call $Z$ where $Z$ take on values 1 or 0, either the algorithm accepts or rejects the sample. We've defined the conditions when this sample is accepted rejected in the algorithm and it is based on the inequality:
$U < \frac{q(x)}{M*p(x)}$ 

It follows that since M is the supremum of $\frac{q(x)}{p(x)}$, $\frac{q(x)}{M*p(x)}$ is bounded on the interval of $[0,1]$ for all x in the support of $p(x)$ and $q(x)$.This is perfect for us because we can now assign the probability the event occurs to our new random variable $Z$ as:
$Z \sim  \text{Bernoulli}(\frac{q(x)}{Mp(x)})$


Now that $Z$ is well defined, we turn our attention to the following:

$$X | Z=1$$

Essentially, what is the distribution of $X$ after we've accepted the sample? We want to show that given we've accepted our sample, we can say $X|Z=1 \sim q(x)$. To do so we'll need the following:
$$\Pr(X \in A | Z=1) = Q(x)$$
where $A$ is the sample space of $q(x)$.
Using Bayes' Theorem we can rewrite $\Pr(X \in A | Z=1)$ as:
$$
\Pr(X \in A | Z=1) = \frac{\Pr(Z = 1 | X \in A) \cdot \Pr(X \in A)}{\Pr(Z=1)}
$$

Lets turn our attention to the numerator. Since we have a conditional probability, we can make the following observation:

$$
\Pr(Z = 1 | X \in A) = \frac{\Pr(Z=1 \cap X \in A)}{\Pr(X \in A)}
$$

By multiplying both sides by $\Pr(X \in A)$ and plugging the right hand side into the numerator we arrive at:
$$
\Pr(X \in A | Z=1) = \frac{\Pr(Z=1 \cap X \in A)}{\Pr(Z=1)}
$$

Looking deeper into $\Pr(Z=1 \cap K \in A)$, this is something we can evaluate:
By the law of Total Probability:

$$
\Pr(Z=1 \cap K \in A) = \int_{A} (U < \frac{q(x)}{Mp(x)}) \cdot p(x)\text{dx} = \iint_{0}^{1} (U < \frac{q(x)}{Mp(x)}) \cdot p(x) \text{dx} = \int_{-\infty}^{a} \frac{q(x)}{Mp(x)}\cdot p(x) \text{dx}
$$

$$
\Rightarrow \int_{-\infty}^{a} \frac{q(x)}{M}\text{dx} = \frac{1}{M} \int_{-\infty}^{a}q(x)\text{dx} = \frac{1}{M} \Pr(X \in A) = \frac{1}{M} \cdot Q(x)
$$
Now we turn our focus to the denominator $\Pr(Z=1)$. 
$$
\Pr(Z=1) = \int_{-\infty}^{\infty} 1(U < \frac{q(x)}{Mp(x)}) p(x) \text{dx} = \int_{-\infty}^{\infty} \frac{q(x)}{Mp(x)}p(x) \text{dx} = \frac{1}{M} \int_{-\infty}^{\infty} q(x)\text{dx} = \frac{1}{M} (1) = \frac{1}{M}
$$
The key step here is $1$ which is an indicator variable that tells us if the condition: $U < \frac{p(x)}{Mq(x)}$ 
is met or not.

Finishing up we arrive at out final result:
$$
\Pr(X \in A | Z=1) = \frac{\frac{1}{M} \Pr(X \in A)}{\frac{1}{M}} = \Pr(X \in A) = Q(x)
$$
Therefore, given we accept the random variable we sampled, We can say $X \sim q(x)$
