#' A package for on-the-fly creation and embedding of R animations in R Markdown files 
#' @name Rmdanimation
#' @importFrom animation ani.options saveGIF saveHTML

ani.options(autobrowse=FALSE, autoplay=FALSE, imgdir="animations")

#' Create an animated gif to be used for embedding in a Markdown file
#'
#' @return a Markdown/HTML snippet that can be used to embed the generated animation
#' @export
animatedGIF <- function(expr, filename, title=filename, allowHTML=TRUE, ...) {
  filename <- paste(ani.options("imgdir"), filename, ".gif", sep="")
  if (file.exists(filename))
    file.remove(filename)
  saveGIF(expr, movie.name=filename, title=title, ...)
  mdstring <- paste("![", title, "](", ani.options("imgdir"), filename, ")", sep="")
  if (allowHTML) {
    # add some limited navigatability to the gif by resetting the animation on click
    paste('<a onclick="this.children[0].src=this.children[0].src;">', mdstring, '</a>', sep='')
  } else {
    mdstring
  }
}

#' Creates an HTML file for displaying and navigating an animation
#'
#' @return an HTML-Iframe snippet that can be used to embed the generated animation
#' @export
animatedHTML <- function(expr, filename, title=filename, ani.width=ani.options("ani.width"), ani.height=ani.options("ani.height"), ...) {
  saveHTML(expr, img.name=filename, htmlfile=paste(filename, ".html", sep=""), ani.width=ani.width, ani.height=ani.height, ...) # single.opts=
  paste('<iframe src="', filename, '.html" width="', ani.width, '" height="', ani.height, '">Animation &quot;', title, "&quot;</iframe>", sep="")
}

