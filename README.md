# Wishlist for R

by Henrik Bengtsson.

List of features and modification I would love to see in R:

## Basic data types

* Generic support for _dimension-aware attributes_ that are acknowledged whenever the object is subsetted.  For vectors we have `names()`, for matrices and data frames we have `rownames()` and `colnames()`, and for arrays and other objects we have `dimnames()`.  Prototype:
```r
> x <- matrix(1:12, ncol=4)
> colnames(x) <- c("A", "B", "C", "D")
> colattr(x, 'gender') <- c("male", "male",  "female", "male")
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
* Add support for

## R system and configuration

### Calling R

* _Support URLs_ in addition to local files when calling `R -f` or `Rscript`, e.g. `Rscript http://callr.org/install#MASS`.

### Package and package libraries

* The _system-library directory should be read only_ after installing R and/or not accept installation of non-base packages.  If installation additional packages there, an end-user is forced to have those package on their library path.  Better is to install any additional site-wide packages in a site-wide library, cf. `.Library.site` and `R_LIBS_SITE`.  This way the user can choose to include the site-wide library/libraries or not.



