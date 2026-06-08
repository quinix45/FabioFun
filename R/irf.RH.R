irf.RH <- function(
  theta,
  a = 1,
  b = 0,
  d = 1
) {
  # fmt: skip

  # RH response probability
  pp <- pnorm((a * theta + b) /(1 + exp(-d*theta))^(-1/2))

  return(pp)
}
