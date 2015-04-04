# Wishlist for R

by Henrik Bengtsson.

List of features and modification I would love to see in R:

## Basic data types

* Generic support for _dimension-aware attributes_ that are acknowledged whenever the object is subsetted.  For vectors we have `names()`, for matrices and data frames we have `rownames()` and `colnames()`, and for arrays and other objects we have `dimnames()`.  Prototype:
```r
> x <- matrix(1:12, ncol=4)
> colnames(x) <- c("A", "B", "C", "D")
> colattr(x, 'gender') <- c("male", "male", "female", "male")
> x

     male male female male
        A    B      C    D
[1,]    1    4      7   10
[2,]    2    5      8   11
[3,]    3    6      9   12

> x[,2:3]
     male female
        B      C
[1,]    4      7
[2,]    5      8
[3,]    6      9
```

* Add support for `dim(x) <- dims`, where `dims` has _one_ `NA` value, which is then inferred from `length(x)` and `na.omit(dims)`.  If incompatible, then an error is given. For example,
```r
> x <- matrix(1:12, ncol=4)
> dim(x)
[1] 3 4
> dim(x) <- c(NA, 3)
> dim(x)
[1] 4 3
```
Note: The `R.utils::dimNA()` function implements this.

## Graphics
* _Support for one-sided plot limits_, e.g. `plot(5:10, xlim=c(0,+Inf))` where `xlim[2]` is inferred from data, cf. `xlim=NULL`.

* _Standardized graphics device settings and API_.  For instance, we have `ps.options()` but no `png.options()`.  For some devices we can set the default width and height, whereas for others the defaults are hardwired to the arguments of the device function.  Note: The `R.devices` package tries to work around this.


## R system and configuration

### Calling R

* _Support URLs_ in addition to local files when calling `R -f` or `Rscript`, e.g. `Rscript http://callr.org/install#MASS`.

* _Package scripts_ via `Rscript R.rsp::rfile`, which calls script `rfile.R` in `system.file("bin", package="R.rsp")` iff it exists.  Similarly for `R CMD`, e.g. `R CMD R.rsp::rfile`.  Also, if package is not explicitly specified, the `bin` directory of all packages should be scanned (only for `R CMD`), e.g. `R CMD rfile`. 


### Package and package libraries

* The _system-library directory should be read only_ after installing R and/or not accept installation of non-base packages.  If installation additional packages there, an end-user is forced to have those package on their library path.  Better is to install any additional site-wide packages in a site-wide library, cf. `.Library.site` and `R_LIBS_SITE`.  This way the user can choose to include the site-wide library/libraries or not.

* _One package library per repository_, e.g. `~/R/library/3.1/CRAN/`, `~/R/library/3.1/Bioconductor/`, and  `~/R/library/3.1/R-Forge/`.  This way it is easy to include/exclude complete sets of packages. `install.packages()` should install packages to the corresponding directory, cf. how `update.packages()` updates packages where they lives (I think).




