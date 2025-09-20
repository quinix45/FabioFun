S_score <- function(forecast, truth, prob = .5){
  
  return(prob * pmax(truth - forecast, 0) + (1 - prob)*pmax(forecast - truth, 0))
  
}


# plot S-score function at different quantiles

#library(tidyverse)
#
#ggplot() +
#  geom_function(fun = S_score, args = list(truth = 0, prob = .05)) +
#  xlim(-10, 10)
#
#ggplot() +
#  geom_function(fun = S_score, args = list(truth = 0, prob = .25)) +
#  xlim(-10, 10)
#
#ggplot() +
#  geom_function(fun = S_score, args = list(truth = 0, prob = .5)) +
#  xlim(-10, 10)
#
#ggplot() +
#  geom_function(fun = S_score, args = list(truth = 0, prob = .75)) +
#  xlim(-10, 10)
#
#ggplot() +
#  geom_function(fun = S_score, args = list(truth = 0, prob = .95)) +
#  xlim(-10, 10)
