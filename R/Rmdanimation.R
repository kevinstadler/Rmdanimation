#' A package for on-the-fly creation and embedding of R animations in R Markdown files 
#' @name Rmdanimation
#' @importFrom animation ani.options saveGIF saveHTML

ani.options(autobrowse=FALSE, autoplay=FALSE, imgdir="animations/")

#' Create an animated gif to be used for embedding in a Markdown file
#'
#' @param expr an R expression to be evaluated to create a sequence of images
#' @param filename unique filename to be used for the saved image file (without extension)
#' @param title animation title, used as Alt text
#' @param allowHTML logical: if TRUE (the default), decorate the return value with some HTML to allow basic navigation/restarting of the animation on click
#' @param ... other arguments passed to \code{\link{ani.options}}
#' @return a Markdown/HTML snippet that can be used to embed the generated animation
#' @seealso \code{\link{saveGIF}}
#' @export
animatedGIF <- function(expr, filename, title=filename, allowHTML=TRUE, ...) {
  filename <- paste(filename, ".gif", sep="")
  if (file.exists(filename))
    file.remove(filename)
  suppressMessages(saveGIF(expr, movie.name=filename, title=title, ...))
  mdstring <- paste("![", title, "](", filename, ")", sep="")
  if (allowHTML) {
    # add some limited navigatability to the gif by resetting the animation on click
    paste('<a onclick="this.children[0].src=this.children[0].src;">', mdstring, '</a>', sep='')
  } else {
    mdstring
  }
}

#' Create an HTML file for displaying and navigating an animation
#'
#' @param expr an R expression to be evaluated to create a sequence of images
#' @param filename unique filename to be used for the saved image files (without extension)
#' @param title animation title, used for the animation page as well as Alt text for the Iframe
#' @param ... other arguments passed to \code{\link{ani.options}}
#' @return an HTML-Iframe snippet that can be used to embed the generated animation
#' @seealso \code{\link{saveHTML}}
#' @export
animatedHTML <- function(expr, filename, title=filename, ani.width=ani.options("ani.width"), ani.height=ani.options("ani.height"), ...) {
  suppressMessages(saveHTML(expr, img.name=filename, htmlfile=paste(filename, ".html", sep=""), verbose=FALSE, ani.width=ani.width, ani.height=ani.height, ...)) # single.opts=
  paste('<iframe src="', filename, '.html" width="', ani.width+150, '" height="', ani.height+150, '">Animation &quot;', title, "&quot;</iframe>", sep="")
}
