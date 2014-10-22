#' A package for on-the-fly creation and embedding of R animations in R Markdown files 
#' @name Rmdanimation
#' @importFrom animation ani.options saveGIF saveHTML

ani.options(autobrowse=FALSE, autoplay=FALSE, imgdir="animations")

#' Create an animated gif
#'
#' @return a Markdown snippet that can be used to embed the generated animation
#' @export
animatedGIF <- function(expr, filename, title=filename,...) {
  filename <- paste(filename, 'gif', sep='.')
  saveGIF(expr, filename, title=title, ...)
  return(paste("![", title, "](", ani.options("imgdir"), filename, ")", sep=""))
}

