
gt_col.desc <- function(names, 
                        desc, 
                        style = "text-decoration: underline; text-decoration-style: solid; color: blue")
{
  library(htmltools)
  library(gt)

  list_res <- list()
  
  for(i in 1:length(names)){

   # turn into character and then html
    list_res[[i]] <- gt::html(as.character(
     htmltools::tags$abbr(style = style,
                title = desc[i],
                names[i])))
  } 

  names(list_res) <- names
  
  return(list_res)
}




######## Example ########

# library(htmltools)
# library(tidyverse)
# library(gt)


# cols <- c("mpg",
#           "cyl",
#           "disp",
#           "hp")

# desc_vec <- c("Miles per Gallon", 
#               "Number of Cylinders",
#               "Displacement",
#               "Horsepower")



# col_labs <- gt_col.desc(names = cols,
#                      desc = desc_vec)


# mtcars %>% 
#   head() %>% 
#   select(mpg:hp) %>% 
#   gt() %>% 
#    cols_label(
#     .list = col_labs)


