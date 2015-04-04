# Wishlist for R

by Henrik Bengtsson.

List of features and modification I would love to see in R:

* The system library directory, `rev(.libPaths())[1]`, should be read only after installing R and/or not accept installation of non-base packages.  If installation additional packages there, an end-user is forced to have those package on their library path.  Better is to install any additional site-wide packages in a site-wide library, cf. `.Library.site` and `R_LIBS_SITE`.  This way the user can choose to include the site-wide library/libraries or not.


