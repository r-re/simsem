library(simsem)
library(semTools)
library(OpenMx)

############################ Fitting uniRegFit

myRegDataCov <- matrix(
    c(0.808,-0.110, 0.089, 0.361,
     -0.110, 1.116, 0.539, 0.289,
      0.089, 0.539, 0.933, 0.312,
      0.361, 0.289, 0.312, 0.836),
    nrow=4,
    dimnames=list(
        c("w","x","y","z"),
        c("w","x","y","z"))
)
 
SimpleDataCov <- myRegDataCov[c("x","y"),c("x","y")]	 
myRegDataMeans <- c(2.582, 0.054, 2.574, 4.061)
names(myRegDataMeans) <- c("w","x","y","z")

SimpleDataMeans <- myRegDataMeans[c(2,3)]
	
uniRegModel <- mxModel("Simple Regression Matrix Specification", 
    mxData(
      observed=SimpleDataCov, 
      type="cov", 
      numObs=100,
      means=SimpleDataMeans
    ),
    mxMatrix(
        type="Full", 
        nrow=2, 
        ncol=2,
        free=c(F, F,
               T, F),
        values=c(0, 0,
                 1, 0),
        labels=c(NA,     NA,
                "beta1", NA),
        byrow=TRUE,
        name="A"
    ),
    mxMatrix(
        type="Symm", 
        nrow=2, 
        ncol=2, 
        values=c(1, 0,
                 0, 1),
        free=c(T, F,
               F, T),
        labels=c("varx", NA,
                  NA,    "residual"),
        byrow=TRUE,
        name="S"
    ),
    mxMatrix(
        type="Iden",  
        nrow=2, 
        ncol=2,
        name="F"
    ),
    mxMatrix(
        type="Full", 
        nrow=1, 
        ncol=2,
        free=c(T, T),
        values=c(0, 0),
        labels=c("meanx", "beta0"),
        name="M"),
    mxRAMObjective("A", "S", "F", "M", dimnames = c("x", "y"))
)
  
uniRegFit <- mxRun(uniRegModel)
fitMeasuresMx(uniRegFit)
uniRegFitSim <- sim(10, uniRegFit, n = 200)
summary(uniRegFitSim)
