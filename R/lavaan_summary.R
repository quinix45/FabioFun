
lavaan_summary <- function(lavaan_mod){
  
  require(tidyverse, quietly = TRUE)
  
  tab_sum <- lavaan::parameterestimates(lavaan_mod) |> 
    dplyr::filter(op %in% c("~", ":=")) |> 
    dplyr::select(any_of(c("lhs", "op", "rhs", "label", "est", "ci.lower", "ci.upper")))
  
  return(tab_sum)
}
