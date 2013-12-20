\name{heat.map}
\alias{heat.map}
\title{
  Enhanced heat map ploting
}

\description{
  This function draws a heatmap from a matrix, similarly to \code{\link{image}}. It also offers normalization and annotation features, with more control than \code{\link{heatmap}}.
}

\usage{
  heat.map(expr, customLayout = FALSE, cex.col = NA, cex.row = NA, mai.left = NA,
    mai.bottom = NA, mai.right = 0.1, side = NULL, side.height = 1, side.col = NULL,
    col.heatmap = heat(), zlim = "0 centered", norm = c("rows", "columns", "none"),
    norm.robust = FALSE, plot = TRUE)
}

\arguments{
  \item{expr}{
    A numeric matrix, holding features (genes) in columns and observations (samples) in rows. Column and row order will not be altered.
}
  \item{customLayout}{
    Single logical value, as \code{\link{layout}} does not allow nested calls, set this to TRUE to make your own call to layout and embed this plot in a wider one.
}
  \item{cex.col}{
    Single numeric value, character exapansion factor for column names. \code{NA} will compute a value from \code{expr} size, similarly to \code{\link{heatmap}}.
}
  \item{cex.row}{
    Single numeric value, character exapansion factor for row names. \code{NA} will compute a value from \code{expr} size, similarly to \code{\link{heatmap}}.
}
  \item{mai.left}{
    Single numeric value, left margin in inches (for row names). Use \code{NA} for an automatic value computed from row name lengths. See \code{\link{par}}.
}
  \item{mai.bottom}{
    Single numeric value, bottom margin in inches (for column names). Use \code{NA} for an automatic value computed from column name lengths. See \code{\link{par}}.
}
  \item{mai.right}{
    Single numeric value, right margin in inches (for higher level functions). See \code{\link{par}}.
}
  \item{side}{
    An annotation \code{data.frame} for \code{expr}, or \code{NULL}. Must contain at least a row for each \code{expr} row, and one or many annotation column. Merging is performed on row names, so rows must be named following the same conventions as \code{expr}. Hexadecimal color definitions will be used "as is", other values will be attributed colors according to \code{side.col}.
}
  \item{side.height}{
    Single numeric value, scaling factor for annotation track.
}
  \item{side.col}{
    A function returning as many colors as requested by its sole argument, defining the colors to be used for \code{side} legend. Default uses a custom palette for few values, and a derivative of \code{\link{rainbow}} if more than 8 colors are needed.
}
  \item{col.heatmap}{
    Character vector of colors, to be used for the cells of the heat map.
}
  \item{zlim}{
    Numeric vector of length two, defining minimal and maximal \code{expr} values that will be mapped to colors in \code{col.heatmap}. Values outside of this range will be rounded to the mearest boundary. Two special values are also allowed : "0 centered" to get a symetrical range around 0 (with the default palette, it enforces 0 as the center color), and "range" to get \code{expr} range after normalization.
}
  \item{norm}{
    Single character value, normalization to be performed (use "none" to perform no normalization). "rows" will center and scale genes, while "columns" will center and scale samples. The functions used depend on \code{norm.robust}.
}
  \item{norm.robust}{
    Single logical value, if \code{TRUE} \code{\link{median}} and \code{\link{mad}} will be used for centering and scaling, else \code{\link{mean}} and \code{\link{sd}}.
}
  \item{plot}{
    Single logical value, whether to plot the heat map or not. Mainly there for compatibility with higher level functions.
}
}

\value{
  Invisibly returns a named list :
  \item{zlim}{Final value of the \code{zlim} argument.}
  \item{col.heatmap}{Final value of the \code{col.heatmap} argument.}
  \item{legend}{If \code{side} is used, a named character vector of colors used for annotation.}
  \item{cex.col}{Final value of the \code{cex.col} argument.}
  \item{cex.row}{Final value of the \code{cex.row} argument.}
  \item{mai.left}{Final value of the \code{mai.left} argument.}
  \item{mai.bottom}{Final value of the \code{mai.bottom} argument.}
}

\author{
  Sylvain Mareschal
}

\seealso{
  \code{\link{clusterize}}, \code{\link{heatmap}}
}

\examples{
  # Data with features in columns
  data(rosenwald)
  group <- rosenwald.cli$group
  expr <- t(rosenwald.expr)[,1:100]
  
  # NA imputation (feature's mean to minimize impact)
  f <- function(x) { x[ is.na(x) ] <- round(mean(x, na.rm=TRUE), 3); x }
  expr <- apply(expr, 2, f)
  
  # Simple heat map
  heat.map(expr)
  
  # With annotation (row named data.frame)
  side <- data.frame(group, row.names=rownames(expr))
  heat.map(expr, side=side)
}
