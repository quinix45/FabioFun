# install package
# devtools::install_github("quinix45/FabioFun")

set.seed(123)

N <- 1000
J <- 30

# Latent trait
theta <- rnorm(N)

# Generate item parameters
pars <- cbind(
  a = rlnorm(J, meanlog = 0, sdlog = 0.2),
  b = rnorm(J, mean = 0, sd = 1),
  d = rnorm(J, mean = 0, sd = 0.5)
)

dat <- FabioFun::genPattern_RH(
  th = theta,
  pars = pars,
  seed = 346536
)
