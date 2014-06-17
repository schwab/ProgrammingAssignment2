## create a matrix suitable for caching using makeCachMatrix
## matrix can be initialized like this : 
## N <- 4
## M <- 4
## z<-makeCacheMatrix(matrix(rnorm(N*M,mean=0,sd=1),N,M))
## z$get()  
## [,1]       [,2]       [,3]        [,4]
## [1,]  0.6119969  0.8217731  1.3911105 -1.45921400
## [2,] -0.2171398  1.3921164 -1.1107889  0.07998255
## ...
## use cachesolve to calculate the inverse, subsequent calls are cached
## cacheSolve(z)
## [,1]       [,2]       [,3]       [,4]
## [1,] -0.08888858 -0.1350184  0.5573521  0.1092431
## [2,]  3.49290875 -0.6790095 -2.1971898  0.4033497
## ...
## cacheSolve(z)
## getting cached data
## [,1]       [,2]       [,3]       [,4]
## [1,] -0.08888858 -0.1350184  0.5573521  0.1092431
## [2,]  3.49290875 -0.6790095 -2.1971898  0.4033497


## creates a special "matrix", which is really a list containing a function to
## set the value of the matrix
## get the value of the matrix
## set the value of the mean
## get the value of the mean
makeCacheMatrix <- function(x = matrix()) {
    i <- NULL
    set <- function(y) {
        x <<- y
        i <<- NULL
    }
    get <- function() x
    setinverse <- function(inverse) i <<- inverse
    getinverse <- function() i
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)

}


## calculates the inverse of the special matrix object
## uses cache when the value has already been calculated
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
    m <- x$getinverse()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- solve(data, ...)
    x$setinverse(m)
    m
}
