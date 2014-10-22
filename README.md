# Rmdanimation

This package provides on-the-fly creation and embedding of R animations in R Markdown files.

It currently consists of two basic wrapper functions around R's [animation](http://cran.r-project.org/web/packages/animation/index.html) package which export animations to files and return a Markdown or HTML snippet to embed those animations in place.

## Installation

    devtools::install_github("kevinstadler/Rmdanimation")

## Usage

Since the functions are just a thin wrapper around the *animation* package, all [ani.options](http://cran.r-project.org/web/packages/animation/animation.pdf#ani.options) can be passed as extra arguments to control animation creation.

    ````{r someanimation, echo=F, display='asis'}
    library(Rmdanimation)
    cat(animatedGIF({for (i in 0:10) plot(i, i, xlim=c(0,10), ylim=c(0,10))}, "myfirstanimation", interval=0.1))
    ````
