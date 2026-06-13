irf_NLL <- function(theta, a = 1, b = 0) {
  exp(-exp(-a * (theta - b)))
}
