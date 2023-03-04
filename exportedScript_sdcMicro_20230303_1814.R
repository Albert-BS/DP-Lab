# created using sdcMicro 5.7.5
library(sdcMicro)

obj <- NULL
if (!exists("newdataset")) {
  stop('object "newdataset" is missing; make sure it exists.`', call. = FALSE)
}
obj$inputdata <- readMicrodata(path="newdataset", type="rdf", convertCharToFac=FALSE, drop_all_missings=FALSE)
inputdataB <- obj$inputdata

## Set up sdcMicro object
sdcObj <- createSdcObj(dat=inputdata,
	keyVars=c("REGION","SEX","AGE","MARSTAT"), 
	numVars=c("KINDPERS","NUMYOUNG","NUMOLD","AGEYOUNG","EDUC1","EDUC2","ETNI","PRIOCCU","POSLABM","REGJOBC","RECBEN","RECUNBEN","RECODBEN","RECBILL","RECSOSEC","RECPENS","POSLABLY","POSFACT","COMPCODE","OCCUCODE","KINDFACT","TENURE","FTPTIME","ADDJOB","JOBFIND","WEIGHT","INCOME","MONEY","ASSETS","DEBTS"), 
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
opts$filename <- "newdataset"
sdcObj <- set.sdcMicroObj(sdcObj, type="options", input=list(opts))

