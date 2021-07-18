########################
##     Libraries      ##
########################

library(MASS)
library(lars)
library(elasticnet)

########################
##     Functions      ##
########################

"pospart" <- function(a) {
if(a > 0) {return(a)} else {return(0)}
}

########################
##       Data         ##
########################

# Test Data #
tn <- 1000
tp <- 5
tb <- c()

for(i in 1:tp) {
	tb[i] <- ((-1)^i)*exp(-2*(i-1)/20)
}
k <- max(tb)*3
Z <- rnorm(tn)

rho <- 0.05
sigma <- matrix(rep(rho, tp^2),tp,tp)
diag(sigma) <- 1
X <- mvrnorm(n=tn, mu=rep(0,tp), Sigma=sigma)

Y <- X%*%tb + k*Z

# Diabetes Data #

data(diabetes)
X <- diabetes$x
Y <- diabetes$y

#diab <- data.frame(read.table("http://www-stat.stanford.edu/~hastie/Papers/LARS/diabetes.data", header=T))

#X <- diab[,1:10]
#Y <- diab[,11]

########################
##     Parameters     ##
########################

n <- dim(X)[1]
p <- dim(X)[2]

# Regularization and Convergence Params #

l1 <- 88
l2 <- 0
tol <- 10^-10

########################
##       LASSO        ##
########################

y <- matrix(Y)
y <- scale(y, center=T, scale=F)
X <- as.matrix(X)
X <- apply(X,2,scale)

# Initialize Betas #
b <- b_old <- c()
for(j in 1:p) {
	b[j] <- (1/n)*t(X[,j])%*%y
}

# Coordinate-wise Fit #
i <- 0
del = 1
#while(i < 1) {
while(abs(del) > tol) {
	i <- i+1
	b_old <- rbind(b_old, b)
	for(j in 1:p) {
		rj <- y - X[,-j]%*%b[-j]
		S <- t(X[,j])%*%rj
		b[j] <- (1/n)*(sign(S)*pospart(abs(S) - l1))
	}	
	del <- abs(sum(b-b_old[i,]))/length(b)
#	print(del)
}
print(i)
#larsfit <- lars(X,y,type="lasso")
#larscoefs <- predict(larsfit, s=l1, type="coefficients", mode="lambda")$coefficients

#matplot(b_old, type="l", xlab="iterations", ylab="coefficients")
#points(rep(i,p), larscoefs)

print(b)

