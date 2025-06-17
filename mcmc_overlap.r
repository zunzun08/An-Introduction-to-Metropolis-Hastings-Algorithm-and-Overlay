# For reproducibility
set.seed(42)

# Create sequence of means
means <- seq(0, 2, by = 0.01)

# Generate random normal data
x <- rnorm(50)
y <- rnorm(50)

# Fit KDE for x (fixed)
fx_hat <- density(x)
fx_s <- sample(x, 1000, replace = TRUE) # Bootstrap resampling as an alternative

overlaps <- c()
p_values <- c()

for (mu in means) {
    y_mu <- y + mu

    # Fit KDE for shifted y
    fy_hat <- density(y_mu)
    fy_s <- sample(y_mu, 1000, replace = TRUE)

    # Two-sample t-test (two-sided by default)
    t_test <- t.test(x, y_mu, var.equal = FALSE) # Welch's t-test
    p_values <- c(p_values, t_test$p.value)

    # Monte Carlo overlap estimation
    eps <- 1e-10 # Small constant to avoid division by zero

    # Get density values at the sampled points
    fx_at_fy_s <- approx(fx_hat$x, fx_hat$y, xout = fy_s, rule = 2)$y
    fy_at_fx_s <- approx(fy_hat$x, fy_hat$y, xout = fx_s, rule = 2)$y
    fx_at_fx_s <- approx(fx_hat$x, fx_hat$y, xout = fx_s, rule = 2)$y
    fy_at_fy_s <- approx(fy_hat$x, fy_hat$y, xout = fy_s, rule = 2)$y

    numerator <- fx_at_fy_s * fy_at_fx_s
    denom <- fx_at_fx_s * fy_at_fy_s
    alpha <- pmin(1, (numerator / denom))
    overlaps <- c(overlaps, mean(alpha, na.rm = TRUE))
}

# Store results
df <- data.frame(mu = means, Overlap = overlaps, p_value = p_values)

# Plot
library(ggplot2)

ggplot(df, aes(x = mu)) +
    geom_line(aes(y = Overlap, color = "Overlap")) +
    geom_line(aes(y = p_value, color = "p-value")) +
    geom_hline(yintercept = 0.05, linetype = "dashed", color = "gray") +
    scale_color_manual(values = c("Overlap" = "red", "p-value" = "blue")) +
    labs(
        title = expression(paste("Overlap vs. P-value for Normal Distribution (", mu, " ∈ [0, 2])")),
        x = expression(mu),
        y = "Coefficient",
        color = "Measure"
    ) +
    theme_minimal() +
    theme(legend.position = "bottom")
