genPattern_GRM <- function(theta, a, b, seed = NULL) {
  sample_size <- length(theta)

  # define IRT model to generate data from

  irf_GRM <- function(theta, a = 1, b = 0) {
    # vectorize for multiple thetas
    theta_rep <- rep(theta, each = length(b))
    b_rep <- rep(b, length(theta))

    # 2PL IRF
    probs <- plogis(a * (theta_rep - b_rep))

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
    P <- irf_GRM(
      theta,
      a = a[i],
      b = b[i, ]
    )

    response_mat[, i] <- apply(P, 1, function(p) {
      which(rmultinom(1, 1, p) == 1)
    })
  }

  return(data.frame(response_mat))
}

# ## test

# I <- 20
# J <- 500

# a <- exp(rnorm(I, mean = 0.25, sd = 0.5))

# # 4 categories
# b <- cbind(runif(I, -3, -1), runif(I, -1, 1), runif(I, 1, 3))

# theta <- rnorm(J)

# check <- genPattern_GRM(theta = theta, a = a, b = b, seed = 546745)

# # fit grm model in mirt

# library(mirt)

# mirt_res <- mirt(
#   data = check,
#   model = 1,
#   itemtype = "graded",
#   verbose = TRUE,
#   SE = TRUE
# )

# coef(mirt_res, simplify = TRUE, IRTpars = TRUE)
