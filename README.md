# Rmdanimation

This package provides on-the-fly creation and embedding of R animations in R Markdown files.

It currently consists of two basic wrapper functions around R's [animation](http://cran.r-project.org/web/packages/animation/index.html) package which export animations to files and return a Markdown or HTML snippet to embed those animations in place.

## Installation

    devtools::install_github("kevinstadler/Rmdanimation")

If you don't have the `devtools` package installed you can also simply download and `source()` [Rmdanimation.R](R/Rmdanimation.R).

## Dependencies

The only external dependencies are those required by `animation`, in particular [ImageMagick](http://www.imagemagick.org/script/binary-releases.php) if you want to create gifs. `animatedHTML()` works without any dependencies.

## Usage

Since the functions are just a thin wrapper around the `animation` package, all [ani.options](http://cran.r-project.org/web/packages/animation/animation.pdf#ani.options) can be passed as extra arguments to control the details of the animation. The animations are saved to external files and the functions return a Markdown/HTML snippet that, when printed to the output, embed the animation in your document. There are two ways to embed animations:

1. in a normal R code chunk, use the `results='asis'` option and call `cat()` to print the Markdown snippet (otherwise you'll end up with superfluous line numbering added by `print()`). This way multiple animations can be output by one code chunk.

````
```{r someanimations, results='asis'}
library(Rmdanimation)
cat(animatedGIF({for (i in 0:10) plot(i, i, xlim=c(0,10), ylim=c(0,10))}, "myfirstanimation"))

# when passed to animatedGIF(), the `loop` argument specifies how many times the
# animation should be repeated before stopping
cat(animatedGIF({for (i in 0:10) plot(i, i, xlim=c(0,10), ylim=c(0,10))}, "stoppinganimation", loop=1))```
````

2. alternatively, if you don't want your R code to be printed anyway, you can simply use the inline code chunk syntax:

    `` `r library(Rmdanimation); animatedGIF({for (i in 0:10) plot(i, i, xlim=c(0,10), ylim=c(0,10))}, "myfirstanimation")` ``

## Navigation

Only `animatedGIF()` called with `allowHTML=FALSE` will return a pure Markdown image snippet. Any other call will also return some HTML decoration to aid in controlling the animation when embedded in a website, which is particularly useful if you want semi-interactive animations in an [Rmarkdown-based reveal.js slideshow](https://github.com/jjallaire/revealjs) or the like.

`animatedHTML()` in particular will create a separate HTML file with your animation using [SciAnimator](https://github.com/brentertz/scianimator) which comes with fully configurable frame-by-frame navigation tools. The HTML snippet returned by the function is simply an Iframe displaying this page.

```
`r animatedHTML({for (i in 0:10) plot(i, i, xlim=c(0,10), ylim=c(0,10))}, "navigableanimation")`
```

SciAnimator allows fine-grained control over which navigation elements are shown by passing a config string as its `single.opts` parameter. Also note how for `animatedHTML()` the `loop` parameter is boolean:

```
`r animatedHTML({for (i in 0:10) plot(i, i, xlim=c(0,10), ylim=c(0,10))}, "navigableanimation", loop=FALSE, single.opts="'controls': ['first', 'play', 'loop', 'speed']")`
```

For the full list of options see the [SciAnimator reference](https://github.com/brentertz/scianimator#settingsoptions).

See [revealjs.Rmd](examples/revealjs.Rmd) for an example using animations in a reveal.js slideshow.
