irf_GRG <- function(theta, a = 1, b = 0, omega = 0.5) {
    # fmt:skip
    omega * exp(-exp(-a * (theta - b))) +
    (1 - omega) * (1 - exp(-exp(a * (theta - b))))
}
