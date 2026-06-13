irf_SKN <- function(
  theta,
  a = 1,
  b = 0,
  lambda = 0
) {
  # fmt: skip

  require("sn")
  # SKN response probability
  pp <- psn(a * (theta - b), xi = 0, omega = 1, alpha = lambda)

  return(pp)
}
