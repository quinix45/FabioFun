
reactbl_col.desc <- function(names, 
                            desc, 
                            style = "text-decoration: underline; text-decoration-style: solid;"){

library(reactable)
library(htmltools)
  
  list_res <- list()
  
  for(i in 1:length(names)){

   # turn into character and then html
    list_res[[i]] <- reactable::colDef(header  = 
     htmltools::tags$abbr(style = style,
                title = desc[i],
                names[i]))
  } 

  names(list_res) <- names
  
  return(list_res)

}

######## Example ########


# just needs a vector of column names and a vector of descriptions with the same length

# cols <- c("mpg",
#           "cyl",
#           "disp",
#           "hp")

# desc_vec <- c("Miles per Gallon", 
#               "Number of Cylinders",
#               "Displacement",
#               "Horsepower")



# col_labs <- reactbl_col.desc(names = cols,
#                              desc = desc_vec)


# library(tidyverse)

# mtcars %>% 
#   head() %>% 
#   dplyr::select(mpg:hp) %>% 
# reactable::reactable(
#   columns = col_labs
# )
