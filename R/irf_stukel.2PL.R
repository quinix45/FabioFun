irf_stukel.2PL <- function (theta, a = 1, b = 0, alpha1 = 0.00001, alpha2 = 0.00001)
{
  
  # Using the fact that TRUE and FALSE are 1 and 0 respectively to vectorize pice-wise function
  
  h <- ((theta - b) > 0)*
    (((alpha1 > 0) * alpha1^(-1) * (exp(alpha1 * a * (theta - b)) - 1)) +
       ((alpha1 == 0) * a * (theta - b)) +
       (alpha1 < 0) * -alpha1^(-1) * log(abs(1 - alpha1 * a * (theta - b)))) +
    
    ((theta - b) <= 0)*
    (((alpha2 > 0) * -alpha2^(-1) * (exp(alpha2 * a * ((b - theta))) - 1)) +
       ((alpha2 == 0) * a * (theta - b)) +
       (alpha2 < 0) * alpha2^(-1) * log(abs(1 - alpha2 * a * ((b - theta)))))
  
  # Make sure that h does not become too large for R to handle
  
  h <- ifelse(h > 601.7777, 601.7777, h)
  h <- ifelse(h < -601.7777, -601.7777, h)
  
  return(exp(h)/(1 + exp(h)))
}