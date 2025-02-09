
nice_3D_plot <- function(y, 
                         x1, 
                         x2, 
                         axis_names = NULL, 
                         dot_labels = NULL, 
                         groups = NULL,  
                         reg_plane = FALSE,
                         interaction = FALSE, 
                         plane_res = 50, ...){
  
  require(plotly, quietly = TRUE)
  require(tidyverse, quietly = TRUE)
  
  plot_dat <- data.frame(y, x1, x2)
  
  
  if(!is.null(axis_names)){
    
    axz <- list(title = axis_names[1])
    axx <- list(title = axis_names[2])
    axy <- list(title = axis_names[3])
    
  }else{
    axz <- list(title = "Y")
    axx <- list(title = "X1")
    axy <- list(title = "X2")
  }
  
  
  if(is.null(dot_labels)){
    
    dot_labels <- paste("Row", 1:nrow(plot_dat))
  }
  
  
  p <- plot_ly(plot_dat,
               z = ~ plot_dat[,1],
               x = ~ plot_dat[,2],
               y = ~ plot_dat[,3],
               text = dot_labels,
               hoverinfo = "text",
               color = ~groups,
               hovertemplate = paste0("%{text} <br>" ,
                                      axx[[1]], ": %{x:0.} <br>",
                                      axy[[1]], ": %{y:0.} <br>",
                                      axz[[1]], ": %{z:0.}"),
               type = "scatter3d",
               mode = 'markers',
               showlegend = !is.null(groups)
               
  ) %>%
    layout(scene = list(xaxis= axx,yaxis= axy,zaxis= axz))
  
  if(isFALSE(reg_plane))
  {
    
    # plot without regression plane
    return(p)
    
  }
  else if(isTRUE(reg_plane) & isFALSE(interaction))
  {
    # add regression plane
    
    
    # regression model
    
    lm_mod <- lm(y ~ x1 + x2, data = plot_dat)
    
    # Values to calculate grid over
    X1_grid <- seq(min(x1), max(x1), by = (max(x1) - min(x1))/plane_res)
    X2_grid <- seq(min(x2), max(x2), by = (max(x2) - min(x2))/plane_res)
    
    
    lm_surface <- expand.grid(x1 = X1_grid, x2 = X2_grid)
    lm_surface$y <- predict.lm(lm_mod, newdata = lm_surface)
    
    require(reshape2, quietly = TRUE)
    lm_surface <- acast(lm_surface, x2 ~ x1, value.var = "y") 
    
    
    p_reg <- add_trace(p = p,
                       z = round(lm_surface, 3),
                       x = round(X1_grid, 3),
                       y = round(X2_grid, 3),
                       hovertemplate = paste0(axx[[1]], ": %{x:0.} <br>",
                                              axy[[1]], ": %{y:0.} <br>",
                                              axz[[1]], ": %{z:0.}"),
                       type = "surface",
                       colorscale = "Viridis",
                       inherit = FALSE,
                       showlegend = FALSE,
                       name = paste("Predicted", axz[[1]]),
                       colorbar = list(title = paste(axz[[1]]),
                                       len = 0.5)) 
    # plot with regression plane  
    return(p_reg)
  }
  else if(isTRUE(reg_plane) & isTRUE(interaction))
  {
    # add regression plane
    
    
    # regression model
    
    lm_mod <- lm(y ~ x1*x2 , data = plot_dat)
    
    # Values to calculate grid over
    X1_grid <- seq(min(x1), max(x1), by = (max(x1) - min(x1))/plane_res)
    X2_grid <- seq(min(x2), max(x2), by = (max(x2) - min(x2))/plane_res)
    
    
    lm_surface <- expand.grid(x1 = X1_grid, x2 = X2_grid)
    lm_surface$y <- predict.lm(lm_mod, newdata = lm_surface)
    
    require(reshape2, quietly = TRUE)
    lm_surface <- acast(lm_surface, x2 ~ x1, value.var = "y") 
    
    
    p_reg_int <- add_trace(p = p,
                           z = round(lm_surface, 3),
                           x = round(X1_grid, 3),
                           y = round(X2_grid, 3),
                           hovertemplate = paste0(axx[[1]], ": %{x:0.} <br>",
                                                  axy[[1]], ": %{y:0.} <br>",
                                                  axz[[1]], ": %{z:0.}"),
                           type = "surface",
                           colorscale = "Viridis",
                           inherit = FALSE,
                           showlegend = FALSE,
                           name = paste("Predicted", axz[[1]]),
                           colorbar = list(title = paste(axz[[1]]),
                                           len = 0.5)) 
    # plot with regression plane  
    return(p_reg_int)
  }
  
}




### Example


## Without regression Plane

# plot_iris <- nice_3D_plot(y = iris$Sepal.Length,
#                           x1 = iris$Petal.Length,
#                           x2 = iris$Petal.Width,
#                           dot_labels = paste("row", 1:150),
#                           groups = iris$Species,
#                           axis_names = c("Sepal Length", "PL", "PW"),
#                           reg_plane = FALSE)
# 
# plot_iris
# 


## With regression plane


# plot_iris_reg <- nice_3D_plot(y = iris$Sepal.Length,
#                               x1 = iris$Petal.Length,
#                               x2 = iris$Petal.Width,
#                               groups = iris$Species,
#                               axis_names = c("SL", "PL", "PW"),
#                               reg_plane = TRUE)
# 
# plot_iris_reg


## With interaction
# 
# plot_iris_int <- nice_3D_plot(y = iris$Sepal.Length,
#                               x1 = iris$Petal.Length,
#                               x2 = iris$Petal.Width,
#                               groups = iris$Species,
#                               axis_names = c("SL", "PL", "PW"),
#                               reg_plane = TRUE,
#                               interaction = TRUE)
# 
# plot_iris_int
# 
