
reactbl_col.desc <- function(names, 
                            desc, 
                            style = "text-decoration: underline; text-decoration-style: solid;",
                            info_icon = TRUE,
                            info_color = "#007bff"){

library(reactable)
  library(htmltools)
  
  list_res <- list()
  
  for (i in seq_along(names)) {
    
    if (info_icon) {
      # Column name + info icon
      header_content <- div(
        style = "display: flex; align-items: center; gap: 4px;",
        title = desc[i],
        names[i],
        span( "\u2139",  # info symbol
              title = desc[i],
              style = paste("cursor: pointer; color:", info_color, ";")))
    } else {
      # no info icon 
      header_content <- tags$abbr(style = style, title = desc[i], names[i])
    }
    
    list_res[[i]] <- reactable::colDef(header = header_content)
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
#                              desc = desc_vec,
#                              info_color = "red")


# library(tidyverse)

# mtcars %>% 
#   head() %>% 
#   dplyr::select(mpg:hp) %>% 
# reactable::reactable(
#   columns = col_labs
# )
