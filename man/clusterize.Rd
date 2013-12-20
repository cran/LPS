\name{clusterize}
\alias{clusterize}
\alias{hclust.ward}
\alias{dist.COR}
\title{
  Hierarchical clustering heat maps
}

\description{
  This function draws a heat map ordered according to hierarchical clusterings, similarly to \code{\link{heatmap}}. It offers more control on layout and allows multiple row annotations.
  
  \code{hclust.ward} is derivated from 'stats' package \code{\link{hclust}}, with an alternative default (as arguments can not be passed to it).
  
  \code{dist.COR} mimics 'stats' package \code{\link{dist}}, computing distances as 1 - Pearson's correlation coefficient.
}

\usage{
  clusterize(expr, customLayout = FALSE, cex.col = NA, cex.row = NA, mai.left = NA,
    mai.bottom = NA, mai.right = 0.1, side = NULL, side.height = 1, side.col = NULL,
    col.heatmap = heat(), zlim = "0 centered", norm = c("rows", "columns", "none"),
    norm.clust = TRUE, norm.robust = FALSE, plot = TRUE, widths = c(1, 4),
    heights = c(1, 4), order.genes = NULL, order.samples = NULL, fun.dist = dist.COR,
    fun.hclust = hclust.ward)
  dist.COR(input)
  hclust.ward(input)
}

\arguments{
  \item{expr}{
    A numeric matrix, holding features (genes) in columns and observations (samples) in rows. Rows and columns will be ordered according to hierarchical clustering results.
}
  \item{customLayout}{
    Single logical value, as \code{\link{layout}} does not allow nested calls, set this to TRUE to make your own call to layout and embed this plot in a wider one.
}
  \item{cex.col}{
    To be passed to \code{\link{heat.map}}.
}
  \item{cex.row}{
    To be passed to \code{\link{heat.map}}.
}
  \item{mai.left}{
    To be passed to \code{\link{heat.map}}.
}
  \item{mai.bottom}{
    To be passed to \code{\link{heat.map}}.
}
  \item{mai.right}{
    To be passed to \code{\link{heat.map}}.
}
  \item{side}{
    To be passed to \code{\link{heat.map}}.
}
  \item{side.height}{
    To be passed to \code{\link{heat.map}}.
}
  \item{side.col}{
    To be passed to \code{\link{heat.map}}.
}
  \item{col.heatmap}{
    To be passed to \code{\link{heat.map}}.
}
  \item{zlim}{
    To be passed to \code{\link{heat.map}}.
}
  \item{norm}{
    To be passed to \code{\link{heat.map}}.
}
  \item{norm.clust}{
    Single logical value, whether to apply normalization before clustering or after. Normalization applied depends on \code{norm}.
}
  \item{norm.robust}{
    To be passed to \code{\link{heat.map}}.
}
  \item{plot}{
    To be passed to \code{\link{heat.map}}.
}
  \item{widths}{
    To be passed to \code{\link{layout}}.
}
  \item{heights}{
    To be passed to \code{\link{layout}}.
}
  \item{order.genes}{
    A function taking the gene dendrogram and \code{expr} as arguments, and returning the same dendrogram ordered in a custom way.
}
  \item{order.samples}{
    A function taking the sample dendrogram and \code{expr} as arguments, and returning the same dendrogram ordered in a custom way.
}
  \item{fun.dist}{
    A function to be used for distance computation in clustering. Default value uses 1 - Pearson's correlation as distance. See \code{\link{dist}} for further details.
}
  \item{fun.hclust}{
    A function to be used for agglomeration in clustering. See \code{\link{hclust}} for further details.
}
  \item{input}{
    See \code{\link{hclust}} and \code{\link{dist}} respectively for further details.
}
}

\value{
  \code{clusterize} invisibly returns the same list as \code{\link{heat.map}}, plus :
  \item{genes}{The gene dendrogram.}
  \item{samples}{The sample dendrogram.}
  
  See \code{\link{hclust}} and \code{\link{dist}} respectively for the other functions.
}

\author{
  Sylvain Mareschal
}

\seealso{
  \code{\link{heat.map}}, \code{\link{heatmap}}, \code{\link{hclust}}, \code{\link{dist}}
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
  clusterize(expr)
  
  # With annotation (row named data.frame)
  side <- data.frame(group, row.names=rownames(expr))
  clusterize(expr, side=side)
}
