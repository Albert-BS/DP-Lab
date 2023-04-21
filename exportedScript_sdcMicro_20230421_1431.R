# created using sdcMicro 5.7.5
library(sdcMicro)

obj <- NULL
if (!exists("testdata")) {
  stop('object "testdata" is missing; make sure it exists.`', call. = FALSE)
}
obj$inputdata <- readMicrodata(path="testdata", type="rdf", convertCharToFac=FALSE, drop_all_missings=FALSE)
inputdataB <- obj$inputdata

inputdata <- varToFactor(obj=inputdata, var="urbrur")
inputdata <- varToFactor(obj=inputdata, var="roof")
inputdata <- varToFactor(obj=inputdata, var="walls")
inputdata <- varToFactor(obj=inputdata, var="water")
inputdata <- varToFactor(obj=inputdata, var="electcon")
inputdata <- varToFactor(obj=inputdata, var="relat")
inputdata <- varToFactor(obj=inputdata, var="sex")
inputdata <- varToFactor(obj=inputdata, var="age")
inputdata <- varToFactor(obj=inputdata, var="hhcivil")
## Set up sdcMicro object
sdcObj <- createSdcObj(dat=inputdata,
	keyVars=c("urbrur","roof","walls","water","electcon","relat","sex","age","hhcivil"), 
	numVars=NULL, 
	weightVar=NULL, 
	hhId=NULL, 
	strataVar=NULL, 
	pramVars=NULL, 
	excludeVars=NULL, 
	seed=0, 
	randomizeRecords=FALSE, 
	alpha=c(1))

## Store name of uploaded file
opts <- get.sdcMicroObj(sdcObj, type="options")
opts$filename <- "testdata"
sdcObj <- set.sdcMicroObj(sdcObj, type="options", input=list(opts))


## Local suppression to obtain k-anonymity
sdcObj <- kAnon(sdcObj, importance=c(1,6,3,7,4,8,2,9,5), combs=NULL, k=c(5))