genPattern_LPE_Poly <- function(theta, a, b, ksi, seed = NULL) {
  sample_size <- length(theta)

  # define IRT model to generate data from
  irf_LPE_Poly <- function(theta, a = 1, b = 0, ksi = 1) {
    # vectorize for multiple thetas
    theta_rep <- rep(theta, each = length(b))
    b_rep <- rep(b, length(theta))

    # LPE IRF
    probs <- plogis(a * (theta_rep - b_rep))^ksi

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
    P <- irf_LPE_Poly(
      theta,
      a = a[i],
      b = b[i, ],
      ksi = ksi[i]
    )

    response_mat[, i] <- apply(P, 1, function(p) {
      which(rmultinom(1, 1, p) == 1)
    })
  }

  return(data.frame(response_mat))
}

# ## test

# set.seed(786432)

# I <- 30
# J <- 5000

# a <- exp(rnorm(I, mean = 0.25, sd = 0.5))
# ksi <- exp(rnorm(I, mean = 0.25, sd = 0.5))
# # 1 categories
# b <- cbind(runif(I, -2, 2))
# theta <- rnorm(J)
# check <- genPattern_LPE_Poly(
#   theta = theta,
#   a = a,
#   b = b,
#   ksi = ksi,
#   seed = 546745
# )

# # fit grm model in mirt

# library(mirt)

# # fix lower and upper asymptotes
# sv <- mirt(
#   data = check,
#   model = 1,
#   itemtype = "5PL",
#   pars = "values"
# )

# # Fix guessing
# sv[sv$name == "g", "est"] <- FALSE
# sv[sv$name == "g", "value"] <- 0

# # Fix slipping
# sv[sv$name == "u", "est"] <- FALSE
# sv[sv$name == "u", "value"] <- 1

# mirt_res <- mirt(
#   data = check,
#   model = 1,
#   itemtype = "5PL",
#   pars = sv,
#   verbose = TRUE,
#   SE = TRUE
# )

# # issues with information matrix but parameteres estimates seem reasonable (ish)
# coef(mirt_res, simplify = TRUE, IRTpars = TRUE)
