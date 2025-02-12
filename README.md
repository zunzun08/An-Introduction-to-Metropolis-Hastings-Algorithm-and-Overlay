## Conference Course: Monte Carlo Simulations

<script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>

Rejection sampling works in the following way: $\space$

Our goal is to show $X \sim p(x)$.

Background: When we pull a random sample from $q(x)$, there's a chance we accept or reject the sample. This chance is a r.v that we call $Z$. $Z$ can take on values 1 or 0, either accept or reject the condition. This makes $Z \sim \text{Bernoulli}\left(\frac{f(x)}{Mg(x)}\right)$. Here, we'll call the R.V we pull from our proposed distribution, $q(x)$, $K$. It follows that $K \sim q(x)$. We're interested in the following result:

\[
K | Z=1
\]

Essentially, what is the distribution of $K$ given we accept the condition? By doing so, we bound our r.v and can show $K$ comes from the same distribution as $X$. The motivation comes from:
\[
Pr(X \in A) = \int_{A} f(x)\,dx = F(A)
\]

over some sample space $A$.
<br>
If $X$ and $K$ share the same sample space after accepting the condition then it follows:
\[
Pr(X \in A) = Pr((K | Z=1) \in  A ) = Pr(K \in A | Z=1)
\]

Using Bayes Theorem:
\[
Pr(K \in A | Z=1) = \frac{Pr(Z = 1 | K \in A) \cdot Pr(K \in A)}{Pr(Z=1)}
\]

Focus on $Pr(Z = 1 | K \in A)$:
\[
Pr(Z = 1 | K \in A) = \frac{Pr(Z=1 \cap K \in A)}{Pr(Z=1)}
\]

Plugging this back into $Pr(K \in A | Z=1)$:
\[
Pr(K \in A | Z=1) = \frac{Pr(Z=1 \cap K \in A)}{Pr(Z=1)}
\]

Looking deeper into $Pr(Z=1 \cap K \in A)$:
By the law of Total Probability:
\[
Pr(Z=1 \cap K \in A) = \iint_{0}^{\frac{f(x)}{Mg(x)}}(U \leq \frac{f(x)}{Mg(x)}) \, g(x) \, du \, dx = \int_{-\infty}^{a} \frac{f(x)}{Mg(x)} \, g(x)dx = \int_{-\infty}^{a} \frac{f(x)}{M} \, dx = \frac{1}{M} \, F(a)
\]

\[
\Rightarrow \int_{A} \frac{f(x)}{M} dx = \frac{1}{M} \int_{A}f(x) dx = \frac{1}{M} Pr(X \in A) = \frac{1}{M} \cdot F(A)
\]

Now we turn our focus to $Pr(Z=1)$, the probability of acceptance:
\[
Pr(Z=1) = \int Pr(Z = 1 | X=x)Pr(X =x)dx = \iint_{0}^{\frac{f(x)}{Mg(x)}} g(x)dydx = \int_{-\infty}^{\infty} \frac{f(x)}{Mg(x)}g(x)dx
\]

\[
\Rightarrow \frac{1}{M} \int_{-\infty}^{\infty}f(x)dx = \frac{1}{M} \cdot (1) = \frac{1}{M}
\]
