\name{nice_3D_plot}
\alias{nice_3D_plot}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Interactive 3D scatterplot using `plotly`
}
\description{
Use this function to create an interactive 3D scatterplot. The function also allows to create a regression plane, as well as a regression plane with an interaction term. 
}
\usage{
nice_3D_plot(y, 
             x1, 
             x2, 
             axis_names = NULL, 
             dot_labels = NULL, 
             groups = NULL,  
             reg_plane = FALSE,
             interaction = FALSE, 
             plane_res = 50, 
             ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
\item{y}{The outcome varaible of the regression.} 
\item{x1}{First predictor variable of the regression.} 
\item{x2}{Second perdictor varaible of the regression.}
\item{axis_names}{A character vector of length 3 definig the labels of the 3 axes (y, x1, x2).} 
\item{dot_labels}{Labels for each of the scatterplot point. must be of the same length as supplied data.} 
\item{groups}{Grouping label foe each of the scatterplot points. must be of the same length as supplied data.}
\item{reg_plane}{Set to `TRUE` if regression plane is desired.}
\item{interaction}{Set to `TRUE` along with `reg_plane = TRUE` if regression plane with interaction is desired.} 
\item{plane_res}{Square root of the number of unique points calculated to draw the regression plane. Defaults to 50.}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Fabio Setti (fsetti@fordham.edu)
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{

## Without regression Plane

plot_iris <- nice_3D_plot(y = iris$Sepal.Length,
                          x1 = iris$Petal.Length,
                          x2 = iris$Petal.Width,
                          dot_labels = paste("row", 1:150),
                          groups = iris$Species,
                          axis_names = c("Sepal Length", "PL", "PW"),
                          reg_plane = FALSE)

plot_iris



## With regression plane


plot_iris_reg <- nice_3D_plot(y = iris$Sepal.Length,
                             x1 = iris$Petal.Length,
                             x2 = iris$Petal.Width,
                             groups = iris$Species,
                             axis_names = c("SL", "PL", "PW"),
                             reg_plane = TRUE)

plot_iris_reg


## With interaction

plot_iris_int <- nice_3D_plot(y = iris$Sepal.Length,
                              x1 = iris$Petal.Length,
                              x2 = iris$Petal.Width,
                              groups = iris$Species,
                              axis_names = c("SL", "PL", "PW"),
                              reg_plane = TRUE,
                              interaction = TRUE)

plot_iris_int

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
