url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
myData <- download.file(url,destfile="quiz1data.csv")
myData <- read.csv("quiz1data.csv")
list.files()
propValData <- myData[,c("SERIALNO","VAL")]
head(dim(propValData[propValData$VAL>23,]))
head(propValData[propValData$VAL>23,])
table(propValData$VAL)

library(xlsx)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(url,destfile="ngap1.xlsx")
fileName <- "ngap1.xlsx"
rowIndex <- 18:23
colIndex <- 7:15

dat <- read.xlsx(fileName,sheetIndex=1, colIndex=colIndex, rowIndex=rowIndex)
sum(dat$Zip*dat$Ext,na.rm=T)


library(XML)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse("restaurants.xml",useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)

How many restaurants have zipcode 21231?
temp <- xpathSApply(rootNode,"//zipcode[",xmlValue)
table(temp)

library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url,destfile="fss06pid.csv")
fileName <- "fss06pid.csv"
DT <- fread(fileName)

system.time(DT[,mean(pwgtp15),by=SEX])
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]})
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time({mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})
