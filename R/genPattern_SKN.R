genPattern_SKN <- function(th, pars, seed = NULL) {
  sample_size <- length(th)

  # Handle single-item case
  if (is.null(nrow(pars))) {
    items_n <- 1
    pars <- t(pars)
  } else {
    items_n <- nrow(pars)
  }

  # skew normal package
  require("sn")

  # Expand parameters
  theta_rep <- rep(th, times = items_n)

  a <- rep(pars[, 1], each = sample_size)
  b <- rep(pars[, 2], each = sample_size)
  lambda <- rep(pars[, 3], each = sample_size)

  # SKN response probability
  pp <- psn(a * (theta - b), xi = 0, omega = 1, alpha = lambda)

  set.seed(seed)

  response_vec <- rbinom(
    n = length(pp),
    size = 1,
    prob = pp
  )

  response_mat <- matrix(
    response_vec,
    ncol = items_n,
    byrow = FALSE
  )

  return(data.frame(response_mat))
}
