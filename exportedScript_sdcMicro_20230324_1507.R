# created using sdcMicro 5.7.5
library(sdcMicro)

obj <- NULL
if (!exists("newdataset")) {
  stop('object "newdataset" is missing; make sure it exists.`', call. = FALSE)
}
obj$inputdata <- readMicrodata(path="newdataset", type="rdf", convertCharToFac=FALSE, drop_all_missings=FALSE)
inputdataB <- obj$inputdata

## Convert a numeric variable to factor (each distinct value becomes a factor level)
inputdata <- varToFactor(obj=inputdata, var=c("REGION"))
## Convert a numeric variable to factor (each distinct value becomes a factor level)
inputdata <- varToFactor(obj=inputdata, var=c("SEX"))
## Convert a numeric variable to factor (each distinct value becomes a factor level)
inputdata <- varToFactor(obj=inputdata, var=c("AGE"))
## Convert a numeric variable to factor (each distinct value becomes a factor level)
inputdata <- varToFactor(obj=inputdata, var=c("MARSTAT"))
## Set up sdcMicro object
sdcObj <- createSdcObj(dat=inputdata,
	keyVars=c("REGION","SEX","AGE"), 
	numVars=NULL, 
	weightVar=NULL, 
	hhId=NULL, 
	strataVar=NULL, 
	pramVars=c("MARSTAT"), 
	excludeVars=NULL, 
	seed=500, 
	randomizeRecords=FALSE, 
	alpha=c(1))

## Store name of uploaded file
opts <- get.sdcMicroObj(sdcObj, type="options")
opts$filename <- "newdataset"
sdcObj <- set.sdcMicroObj(sdcObj, type="options", input=list(opts))


## Postrandomization (using a transition matrix)
mat <- matrix(c(0.5,0.1,0.1,0,0.4,0.6,0.3,0.1,0.1,0.2,0.6,0.2,0,0.1,0,0.7),ncol=4); 
rownames(mat) <- colnames(mat) <- c("1","2","3","4");
sdcObj <- pram(sdcObj, variables="MARSTAT", pd=mat)
sdcObj <- undolast(sdcObj)
## Postrandomization (using a invariant, randomly generated transition matrix)
sdcObj <- pram(sdcObj, variables=c("MARSTAT"), pd=0.8, alpha=0.5)