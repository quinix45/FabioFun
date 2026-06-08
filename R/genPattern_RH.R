genPattern_RH <- function(th, pars, seed = NULL) {
  sample_size <- length(th)

  # Handle single-item case
  if (is.null(nrow(pars))) {
    items_n <- 1
    pars <- t(pars)
  } else {
    items_n <- nrow(pars)
  }

  # Expand parameters
  theta_rep <- rep(th, times = items_n)

  a <- rep(pars[, 1], each = sample_size)
  b <- rep(pars[, 2], each = sample_size)
  d <- rep(pars[, 3], each = sample_size)

  # RH response probability
  pp <- pnorm((a * theta + b) / (1 + exp(-d * theta))^(-1 / 2))

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
