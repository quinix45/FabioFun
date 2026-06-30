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
