irf_CLL <- function(theta, a = 1, b = 0) {
  1 - exp(-exp(a * (theta - b)))
}
