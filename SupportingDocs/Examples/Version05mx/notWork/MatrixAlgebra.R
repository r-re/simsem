library(simsem)
library(OpenMx)

###########################

algebraExercises <- mxModel(
	mxMatrix(
    	type="Full", 
    	nrow=3, 
    	ncol=1, 
    	values=c(1,2,3), 
    	name='A'
	),
	mxMatrix(
    	type="Full", 
    	nrow=3, 
    	ncol=1, 
    	values=c(1,2,3), 
    	name='B'
	),
	mxAlgebra(
    	A + B, 
    	name='q1'		# addition
	),
	mxAlgebra(
    	A * A, 
    	name='q2'		# dot multiplication
	),
	mxAlgebra(
	    t(A), 
	    name='q3'		# transpose
	),
    mxAlgebra(
        A %*% t(A), 
        name='q4'		# inner product
    ),
    mxAlgebra(
        t(A) %*% A, 
        name='q5'		# outer product
    )
)
# Specify Model Matrices and Algebra
# -----------------------------------------------------------------------------


answers <- mxRun(algebraExercises)
answers@algebras

result <- mxEval(list(q1,q2,q3,q4,q5),answers)	
# Run Model and Generate Output
# -----------------------------------------------------------------------------
