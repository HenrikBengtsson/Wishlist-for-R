# Wishlist for R

by Henrik Bengtsson.

List of features and modification I would love to see in R:

## Basic data types

* Internal _`HASNA(x)` flag_ indicating whether `x` has missing values (`HASNA=1`) or not (`HASNA=0`), or it is unknown (`HASNA=2`).  This flag can be set by any function that have scanned `x` for missing values.  This would allow functions to skip expensive testing for missing values whenever `HASNA=0`.  (Now it is up to the user to keep track and use na.rm=FALSE, iff supported)

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
Comment: The `R.utils::dimNA()` function implements this.


## Evaluation

* `value <- sandbox(...)` which analogously to `evalq(local(...))` evaluates an R expression but without leaving any side effects and preserving all options, environments, connections sinks, graphics devices, etc.  The effect should be as evalutating the expression in a separate R processing (after importing global variables and loading packages) and returning the value to the calling R process.

## Graphics
* _Support for one-sided plot limits_, e.g. `plot(5:10, xlim=c(0,+Inf))` where `xlim[2]` is inferred from data, cf. `xlim=NULL`.

* _Standardized graphics device settings and API_.  For instance, we have `ps.options()` but no `png.options()`.  For some devices we can set the default width and height, whereas for others the defaults are hardwired to the arguments of the device function.  Comment: The `R.devices` package tries to work around this.


## Files
* _Atomic writing to file_ to avoid incomplete/corrupt files being written.  This can be achieved by writing to a temporary file/directory and the renaming when writing/saving is complete.  This can be made optional, e.g. `saveRDS(x, file="foo.rds", atomic=TRUE)`.

## R system and configuration

### Calling R

* _Support URLs_ in addition to local files when calling `R -f` or `Rscript`, e.g. `Rscript http://callr.org/install#MASS`.

* _Package scripts_ via `Rscript R.rsp::rfile`, which calls script `rfile.R` in `system.file("exec", package="R.rsp")` iff it exists.  Similarly for `R CMD`, e.g. `R CMD R.rsp::rfile`.  Also, if package is not explicitly specified, the `exec` directory of all packages should be scanned (only for `R CMD`), e.g. `R CMD rfile`. 
 
* `R CMD check --flavor=<flavor>`: Instead of hard-coded tests as in `R CMD check --as-cran`, support for custom test suits, which themselves could be R packages, e.g. `R CMD check --flavor=CRAN` (R package `check.CRAN`) and `R CMD check --flavor=Bioconductor` `check.Bioconductor`).  In the bigger picture, this will separate R core and CRAN.

### Exception handling and core dumps

* Use `An unexpected error occurred that could not be recovered from. R session is aborting ...` instead of just `aborting ...`, because from the latter it is [not always clear](https://github.com/HenrikBengtsson/R.devices/issues/7) where that messages comes from, i.e. it could have been outputted by something else.

### Packages, libraries and repositories

* The _system-library directory should be read only_ after installing R and/or not accept installation of non-base packages.  If installation additional packages there, an end-user is forced to have those package on their library path.  Better is to install any additional site-wide packages in a site-wide library, cf. `.Library.site` and `R_LIBS_SITE`.  This way the user can choose to include the site-wide library/libraries or not.

* _One package library per repository_, e.g. `~/R/library/3.1/CRAN/`, `~/R/library/3.1/Bioconductor/`, and  `~/R/library/3.1/R-Forge/`.  This way it is easy to include/exclude complete sets of packages. `install.packages()` should install packages to the corresponding directory, cf. how `update.packages()` updates packages where they lives (I think).

* _Repository metadata_ that provides information about a repository.  This can be provide as a DCF file `REPOSITORY` in the root of the repository URL, e.g. `http://cran.r-project.org/REPOSITORY` and `http://www.bioconductor.org/packages/release/bioc/REPOSITORY`.  The content of `REPOSITORY` could be:
```
Repository: BioCsoft_3.1
Title: Bioconductor release Software repository
Depends: R (>= 3.2.0)
Description: R package repository for Bioconductor release 3.1 branch.
Maintainer: Bioconductor Webmaster <webmaster@bioconductor.org>
URL: http://www.bioconductor.org/packages/release/bioc
SeeAlso: http://www.bioconductor.org/about/mirrors/mirror-how-to/
IsMirror: TRUE
```





