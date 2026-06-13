genPattern_GRG <- function(th, pars, seed = NULL) {
  sample_size <- length(th)

  # 1st part of if statement to produce results for single item

  if (class(nrow(pars)) == "NULL") {
    items_n <- 1
    pars <- t(pars)
  } else {
    items_n <- nrow(pars)
  }

  irf_GRG <- function(theta, a, b, omega) {
    # fmt:skip
    omega * exp(-exp(-a * (theta - b))) +
    (1 - omega) * (1 - exp(-exp(a * (theta - b))))
  }

  pp <- irf_GRG(
    theta = th,
    a = rep(pars[, 1], each = sample_size),
    b = rep(pars[, 2], each = sample_size),
    omega = rep(pars[, 3], each = sample_size)
  )

  set.seed(seed)

  response_vec <- rbinom(n = length(pp), size = 1, prob = pp)

  # reshape vector to get a matrix of n_sample BY n_items

  response_mat <- matrix(response_vec, ncol = items_n, byrow = FALSE)

  return(data.frame(response_mat))
}
