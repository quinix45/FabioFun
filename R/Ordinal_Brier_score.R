Ordinal_Brier_score <- function(forecasts, outcome){
  
  return(sum((forecasts  - outcome)^2))
  
}

