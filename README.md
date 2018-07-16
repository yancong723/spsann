# Optimization of Sample Configurations using Spatial Simulated Annealing

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![packageversion](https://img.shields.io/badge/devel%20version-2.1.0.9000-firebrick.svg?style=flat-square)](commits/master)
[![Build Status](https://travis-ci.org/samuel-rosa/spsann.svg?branch=master)](https://travis-ci.org/samuel-rosa/spsann)
[![CRAN](https://www.r-pkg.org/badges/version/spsann)](https://cran.r-project.org/package=spsann)
[![Rdoc](http://www.rdocumentation.org/badges/version/spsann)](http://www.rdocumentation.org/packages/spsann)
[![Downloads](http://cranlogs.r-pkg.org/badges/spsann?color=brightgreen)](http://www.r-pkg.org/pkg/spsann)

## Installation

The `spsann` package was created to help you creating optimum spatial sample configurations using the power
of spatial simulated annealing. It can be downloaded from [CRAN][cran] using:

```R
install.packages(pkgs = "spsann")
```

The development version of `spsann`, available at [GitHub][github], can be downloaded -- using the `devtools` package -- with:

[cran]: https://CRAN.R-project.org/package=spsann
[github]: https://github.com/samuel-rosa/spsann

```R
if (!require(devtools)) {
  install.packages(pkgs = "devtools")
}
devtools::install_github("samuel-rosa/spsann")
```

## How to collaborate

We use the *fork & pull* collaborative development model. This means that you are free to make a parallel copy 
of this repository, change the source code as you see fit, and then *push* the changes to your personal copy of
this repository. All this without requiring any authorization. If the changes you've made to your personal copy
of this repository are interesting and you're willing to share them with us, then just have them pulled -- 
*pull request* -- to this repository. After reviewing the changes, we will decide whether they can be merged --
*merge* -- with the source code of this repository.
