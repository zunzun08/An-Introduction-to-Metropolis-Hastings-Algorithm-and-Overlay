Rejection sampling works in the following way:
$\space$

Our goal is to show X $\sim$ p(x).

Background: When we pull a random sample from q(x) theres a chance we accept or reject the sample. This chance is a r.v that we call $Z$. $Z$ can take on values 1 or 0, either accept or reject the condition. This makes $Z$ $\sim$ $Bernoulli(\frac{f(x)}{Mg(x)})$. Here, we'll call the r.v we pull from our proposed distribution, $q(x)$ $K$. It follows that $K \sim q(x)$. We're intersted in the following result:

$$K | Z=1$$

Essentially, what is the distribution of K given we accept the condition? By doing so, we bound our r.v and can show K comes from the same distribution as $X$. The motivation comes from:
$$Pr(X \in A) = \int_{A} f(x),dx = F(A)$$

over some sample space A.
\space
If X and K share the same sample space after the accepting the condition then it follows:
$$
Pr(X \in A) = Pr((K | Z=1) \in  A ) = Pr(K \in A | Z=1) 
$$

Using Bayes' Theorem:
\[
Pr(K \in A \mid Z=1) = \frac{Pr(Z = 1 \mid K \in A) \cdot Pr(K \in A)}{Pr(Z=1)}
\]

Focus on \( Pr(Z = 1 \mid K \in A) \):
\[
Pr(Z = 1 \mid K \in A) = \frac{Pr(Z=1 \cap K \in A)}{Pr(K \in A)}
\]

Plugging this back into \( Pr(K \in A \mid Z=1) \):
\[
Pr(K \in A \mid Z=1) = \frac{Pr(Z=1 \cap K \in A)}{Pr(Z=1)}
\]

Looking deeper into \( Pr(Z=1 \cap K \in A) \):
By the law of Total Probability,
\[
Pr(Z=1 \cap K \in A) = \int_{A} f_{Z,K}(1,k) \, dx = \int_{A} f_{Z|K}(1|k) \cdot f_K(k) \, dx
\]
Assuming \( f_{Z|K}(1|k) = \frac{f(x)}{M g(x)} \) and \( f_K(k) = g(x) \), we have:
\[
Pr(Z=1 \cap K \in A) = \int_{A} \frac{f(x)}{M g(x)} \cdot g(x) \, dx = \frac{1}{M} \int_{A} f(x) \, dx = \frac{1}{M} Pr(X \in A)
\]

Now we turn our focus to \( Pr(Z=1) \), the probability of acceptance:
\[
Pr(Z=1) = \int_{D} \int_{0}^{1} f_{Z,K}(z,k) \, dz \, dx = \int_{D} \frac{f(x)}{M g(x)} \, dx = \frac{1}{M} \int_{D} \frac{f(x)}{g(x)} \, dx = \frac{1}{M}
\]

Finishing up:
\[
Pr(K \in A \mid Z=1) = \frac{\frac{1}{M} Pr(X \in A)}{\frac{1}{M}} = Pr(X \in A)
\]
