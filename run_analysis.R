TIDYDATA="tidy.RData"

ACTIVITIES = 
  c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")

ACTIVITY = "activity"
SOURCE_URL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
ZIP = "dataset.zip"
RAW_DIR = "UCI HAR Dataset"
TRAIN = "train"
TEST = "test"
XPRE = "/X_"
YPRE = "/y_"
TXT ="txt"
NXYZ = c("meanx","meany","meanz","sdx","sdy","sdz")
N = c("mean","std")
CTBODYACC= c(1,2,3,4,5,6)
CTGRAVITYACC = c(41,42,43,44,45,46)
CTBODYACCJERK = c(81,82,83,84,85,86)
CTBODYGYRO = c(121,122,123,124,125,126)
CTBODYGYROJERK = c(161,162,163,164,165,166)
CTBODYACCMAG = c(201,202)
CTGRAVITYACCMAG = c(214,215)
CTBODYACCJERKMAG = c(227,228)
CTBODYGYROMAG = c(240,241)
CTBODYGYROJERKMAG = c(253,254)
CFBODYACC = c(266,267,268,269,270,271)
CFBODYACCJERK = c(345,346,347,348,349,350)
CFBODYGYRO = c(424,425,426,427,428,429)
CFBODYACCMAG = c(503,504)
CFBODYACCJERKMAG = c(516,517)
CFBODYGYROMAG = c(529,530)
CFBODYGYROJERKMAG = c(542,543)

library(dplyr)

# getdate - get X, y data from path
# path is expected to be either TRAIN or TEST
# pre is expected to be XPRE or YPRE
getdata <- function(path,pre){
  dirname <- paste(RAW_DIR,path,sep="/")
  filename <- paste(dirname,path,sep= pre)
  filename <- paste(filename,TXT,sep= ".")
  data <- read.table(filename)
  return(data)
}

# getxyz - get X, y, z mean and sd data from columns
getxyz <- function(columns,x){
  data <- x[,columns]
  colnames(data) <- NXYZ
  return(data)
}

# getsingle - get mean and sd data from columns
getsingle <- function(columns,x){
  data <- x[,columns]
  colnames(data) <- N
  return(data)
}

# getsummary - get tidy summary
getsummary <- function(table,y){
  xxx<-cbind(table,y)
  by_xxx <- group_by(xxx,V1)
  summary <- summarise_each(by_xxx,funs(mean))
  summary$V1[]<-ACTIVITIES[summary$V1]
  colnames(summary)[1] <- ACTIVITY
  return(summary)
}

# Print working directory
getwd()

# read zip file
if (!file.exists(RAW_DIR)){
  if (!file.exists(ZIP)){
      download.file(SOURCE_URL,destfile = ZIP, mode = "wb")
  }
  unzip (ZIP)
}

#read train data
xtrain <- getdata(TRAIN,XPRE)
ytrain <- getdata(TRAIN,YPRE)
xtest <- getdata(TEST,XPRE)
ytest <- getdata(TEST,YPRE)
x <- rbind(xtrain,xtest)
y <- rbind(ytrain,ytest)
str(x)
str(y)
# generate tidy objects
tbodyacc <- getxyz(CTBODYACC,x)
tgravityacc <- getxyz(CTGRAVITYACC,x)
tbodyaccjerk <- getxyz(CTBODYACCJERK,x)
tbodygyro <- getxyz(CTBODYGYRO,x)
tbodygyrojerk <- getxyz(CTBODYGYROJERK,x)
tbodyaccmag <- getsingle(CTBODYACCMAG,x)
tgravityaccmag <- getsingle(CTGRAVITYACCMAG,x)
tbodyaccjerkmag <- getsingle(CTBODYACCJERKMAG,x)
tbodygyromag <- getsingle(CTBODYGYROMAG,x)
tbodygyrojerkmag <- getsingle(CTBODYGYROJERKMAG,x)
fbodyacc <- getxyz(CFBODYACC,x)
fbodyaccjerk <- getxyz(CFBODYACCJERK,x)
fbodygyro <- getxyz(CFBODYGYRO,x)
fbodyaccmag <- getsingle(CFBODYACCMAG,x)
fbodyaccjerkmag <- getsingle(CFBODYACCJERKMAG,x)
fbodygyromag <- getsingle(CFBODYGYROMAG,x)
fbodygyrojerkmag <- getsingle(CFBODYGYROJERKMAG,x)

# generate tidy summaries

tbodyaccmean <- getsummary(tbodyacc,y)

tgravityaccmean <- getsummary(tgravityacc,y)
tbodyaccjerkmean <- getsummary(tbodyaccjerk,y)
tbodygyromean <- getsummary(tbodygyro,y)
tbodygyrojerkmean <- getsummary(tbodygyrojerk,y)
tbodyaccmagmean <- getsummary(tbodyaccmag,y)
tgravityaccmagmean <- getsummary(tgravityaccmag,y)
tbodyaccjerkmagmean <- getsummary(tbodyaccjerkmag,y)
tbodygyromagmean <- getsummary(tbodygyromag,y)
tbodygyrojerkmagmean <- getsummary(tbodygyrojerkmag,y)
fbodyaccmean <- getsummary(fbodyacc,y)
fbodyaccjerkmean <- getsummary(fbodyaccjerk,y)
fbodygyromean <- getsummary(fbodygyro,y)
fbodyaccmagmean <- getsummary(fbodyaccmag,y)
fbodyaccjerkmagmean <- getsummary(fbodyaccjerkmag,y)
fbodygyromagmean <- getsummary(fbodygyromag,y)
fbodygyrojerkmagmean <- getsummary(fbodygyrojerkmag,y)

list_of_tidy = c(tbodyaccmean,
                 tgravityaccmean,
                 tbodyaccjerkmean,
                 tbodygyromean,
                 tbodygyrojerkmean,
                 tbodyaccmagmean,
                 tgravityaccmagmean,
                 tbodyaccjerkmagmean,
                 tbodygyromagmean,
                 tbodygyrojerkmagmean,
                 fbodyaccmean,
                 fbodyaccjerkmean,
                 fbodygyromean,
                 fbodyaccmagmean,
                 fbodyaccjerkmagmean,
                 fbodygyromagmean,
                 fbodygyrojerkmagmean)

save(list_of_tidy, file = TIDYDATA )
df <-data.frame(list_of_tidy)
drops <- c("activity.1","activity.2","activity.3","activity.4",
           "activity.5","activity.6","activity.7","activity.8",
           "activity.9","activity.10","activity.11","activity.12",
           "activity.13","activity.14","activity.15","activity.16")
df <- df[,!(names(df) %in% drops)]
dfcols = c("activity","tbodyaccmeanx","tbodyaccsdx",
           "tbodyaccmeany","tbodyaccsdy",
           "tbodyaccmeanz","tbodyaccsdz",
                 "tgravityaccmeanx","tgravityaccsdx",
           "tgravityaccmeany","tgravityaccsdy",
           "tgravityaccmeanz","tgravityaccsdz",
                 "tbodyaccjerkmeanx","tbodyaccjerksdx",
           "tbodyaccjerkmeany","tbodyaccjerksdy",
           "tbodyaccjerkmeanz","tbodyaccjerksdz",
                 "tbodygyromeanx","tbodygyrosdx",
           "tbodygyromeany","tbodygyrosdy",
           "tbodygyromeanz","tbodygyrosdz",
                 "tbodygyrojerkmeanx","tbodygyrojerksdx",
           "tbodygyrojerkmeany","tbodygyrojerksdy",
           "tbodygyrojerkmeanz","tbodygyrojerksdz",
           
                 "tbodyaccmagmean","tbodyaccmagsd",
                 "tgravityaccmagmean","tgravityaccmagsd",
                 "tbodyaccjerkmagmean","tbodyaccjerkmagsd",
                 "tbodygyromagmean","tbodygyromagsd",
                 "tbodygyrojerkmagmean","tbodygyrojerkmagsd",
           
                 "fbodyaccmeanx","fbodyaccsdx",
           "fbodyaccmeany","fbodyaccsdy",
           "fbodyaccmeanz","fbodyaccsdz",
                 "fbodyaccjerkmeanx","fbodyaccjerksdx",
           "fbodyaccjerkmeany","fbodyaccjerksdy",
           "fbodyaccjerkmeanz","fbodyaccjerksdz",
                 "fbodygyromeanx","fbodygyrosdx",
           "fbodygyromeany","fbodygyrosdy",
           "fbodygyromeanz","fbodygyrosdz",
           
                 "fbodyaccmagmean","fbodyaccmagsd",
                 "fbodyaccjerkmagmean","fbodyaccjerkmagsd",
                 "fbodygyromagmean","fbodygyromagsd",
                 "fbodygyrojerkmagmean","fbodygyrojerkmagmean")
colnames(df) <- dfcols

write.table(df, file = "tidyData.txt", row.names = FALSE)
