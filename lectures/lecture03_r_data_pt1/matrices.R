# --------------------
#       Matrices
# --------------------

# A matrix is a two-dimensional vector

y <- matrix(1:20, nrow=5, ncol=4)
y


cells <- c(1,24,13,11)
rnames <- c("R1", 'R2')
cnames <- c("C1", "C2")
myMatrix <- matrix(cells, nrow=2, ncol=2, byrow=TRUE, dimnames=list(rnames, cnames))
myMatrix
