genPattern_SKN_Poly <- function(theta, a, b, lambda, seed = NULL) {
  sample_size <- length(theta)

  # define IRT model to generate data from
  irf_SKN_Poly <- function(theta, a = 1, b = 0, lambda = 0) {
    # vectorize for multiple thetas
    theta_rep <- rep(theta, each = length(b))
    b_rep <- rep(b, length(theta))

    # SKN IRF
    probs <- sn::psn(a * (theta_rep - b_rep), xi = 0, omega = 1, alpha = lambda)

    P_left <- cbind(
      rep(1, length(theta)),
      matrix(probs, ncol = length(b), nrow = length(theta), byrow = TRUE)
    )
    P_right <- cbind(
      matrix(probs, ncol = length(b), nrow = length(theta), byrow = TRUE),
      rep(0, length(theta))
    )
    # calculate the difference between adjancet categories
    return(P_left - P_right)
  }

  response_mat <- matrix(NA, nrow = sample_size, ncol = nrow(b))

  set.seed(seed)

  # loop over items
  for (i in 1:nrow(b)) {
    P <- irf_SKN_Poly(
      theta,
      a = a[i],
      b = b[i, ],
      lambda = lambda[i]
    )

    response_mat[, i] <- apply(P, 1, function(p) {
      which(rmultinom(1, 1, p) == 1)
    })
  }

  return(data.frame(response_mat))
}

# set.seed(786432)

# I <- 30
# J <- 2000

# a <- exp(rnorm(I, mean = 0.25, sd = 0.5))
# lambda <- exp(rnorm(I, mean = 0, sd = 1))
# # 1 categories
# b <- cbind(runif(I, -2, 0), runif(I, 0, 2))
# theta <- rnorm(J)
# check <- genPattern_SKN_Poly(
#   theta = theta,
#   a = a,
#   b = b,
#   lambda = lambda,
#   seed = 546745
# )
