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

# irf_GRM(theta = c(-5, 5), a = 1, b = c(0, 5, 6))
