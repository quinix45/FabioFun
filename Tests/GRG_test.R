# install package
# pak::pak("quinix45/FabioFun")

set.seed(45687)

N <- 1000
J <- 30

# Latent trait
theta <- rnorm(N)

# Generate item parameters
pars <- cbind(
  # fix a to 1 (as it was fixed in the paper)
  a = rep(1, J),
  b = rnorm(J, mean = 0, sd = 1),
  omega = plogis(rnorm(J, mean = 0, sd = 2))
)

dat <- FabioFun::genPattern_GRG(
  th = theta,
  pars = pars,
  seed = 132168
)

## add mirt model
