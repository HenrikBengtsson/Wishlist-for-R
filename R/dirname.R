dirname <- function(path, parent = 1L) {
  parent <- as.integer(parent)
  while (parent > 0L) {
    path <- .Internal(dirname(path))
    parent <- parent - 1L
  }
  path
}
