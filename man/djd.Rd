\name{djd}
\alias{djd}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function for Joint Diagonalization of k Square Matrices in a Deflation Based Manner  
}
\description{
This function jointly diagonalizes k real-valued square matrices by searching an orthogonal matrix in a deflation based manner.
}
\usage{
djd(X, G = "max", r = 2, eps = 1e-06, maxiter = 500)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{X}{
an array containing the k p times p real valued matrices of dimension  c(p, p, k).
}
  \item{G}{
criterion function used for the the algorithm. Options are \code{max}, \code{pow} and \code{log}. See details.
}
  \item{r}{
power value used if \code{G="pow"} or \code{G="max"}. 0 is not meaningful for this value. See details.
}
  \item{eps}{
convergence tolerance.
}
  \item{maxiter}{
maximum number of iterations.
}
}
\details{
Denote the square matrices as \eqn{A_i}{A_i}, \eqn{i=1,\ldots,k}{i=1,...,k}. This algorithm searches then an orthogonal matrix W
  so that  \eqn{D_i=W'A_iW}{D_i=W'A_iW} is diagonal for all \eqn{i}. If the \eqn{A_i}{A_i} commute then there is an exact solution. If not, the function
  will perform an approximate joint diagonalization by maximizing \eqn{\sum G(w_j' A_i w_j)}{sum G(w_j' A_i w_j)} where \eqn{w_j}{w_j} are the orthogonal vectors in W. 
  
  The function G can be choosen to be of the form \eqn{G(x) = |x|^r}{G(x) = |x|^r} or  \eqn{G(x) = log(x)}{G(x) = log(x)}. If \code{G="max"} is chosen, the function G is of the form \eqn{G(x) = |x|^r}{G(x) = |x|^r}, and the diagonalization criterion will be maximized globally at each stage by choosing an appropriate initial value from a set
of random vectors. If \code{G="pow"} or \code{G="log"} are chosen, the initial values are the eigenvectors of \eqn{A_1}{A_1} which plays hence a special role.

}
\value{
The matrix W
}
\references{
\cite{Nordhausen, K., Gutch, H. W., Oja, H. and Theis, F.J. (2012): Joint Diagonalization of Several Scatter Matrices for ICA, in \emph{LVA/ICA 2012}, LNCS 7191, pp. 172--179.}

\cite{Miettinen, J., Nordhausen, K., Oja, H. and Taskinen, S. (2014),  Deflation-based Separation of Uncorrelated Stationary Time Series, 
            \emph{Journal of Multivariate Analysis}, 123, 214--227.}

\cite{Miettinen, J., Nordhausen, K. and Taskinen, S. (2017), Blind Source Separation Based on Joint Diagonalization in R: The Packages JADE and BSSasymp, \emph{Journal of Statistical Software}, \bold{76}, 1--31, <doi:10.18637/jss.v076.i02>.}
}

\author{Klaus Nordhausen, Jari Miettinen}



\examples{
Z <- matrix(runif(9), ncol = 3)
U <- eigen(Z \%*\% t(Z))$vectors
D1 <- diag(runif(3))
D2 <- diag(runif(3))
D3 <- diag(runif(3))
D4 <- diag(runif(3))

X.matrix <- array(0, dim=c(3, 3, 4))
X.matrix[,,1] <- t(U) \%*\% D1 \%*\% U
X.matrix[,,2] <- t(U) \%*\% D2 \%*\% U
X.matrix[,,3] <- t(U) \%*\% D3 \%*\% U
X.matrix[,,4] <- t(U) \%*\% D4 \%*\% U

W1 <- djd(X.matrix)
round(U \%*\% W1, 4) # should be a signed permutation 
                     # matrix if W1 is correct.

W2 <- djd(X.matrix, r=1)
round(U \%*\% W2, 4) # should be a signed permutation 
                     # matrix if W2 is correct.

W3 <- djd(X.matrix, G="l")
round(U \%*\% W3, 4) # should be a signed permutation 
                     # matrix if W3 is correct.

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ array }

