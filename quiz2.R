url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
acs <- read.csv(url)
install.packages("sqldf")
library(sqldf)
Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?
temp <- sqldf("select * from acs")
temp <- sqldf("select * from acs where AGEP < 50 and pwgtp1")
temp <- sqldf("select pwgtp1 from acs where AGEP < 50")
sqldf("select pwgtp1 from acs")

Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)
temp <- sqldf("select distinct AGEP from acs")
temp <- sqldf("select unique * from acs")
sqldf("select AGEP where unique from acs")
sqldf("select distinct pwgtp1 from acs")

read from the web
url1 <- "http://biostat.jhsph.edu/~jleek/contact.html"
con <- url(url1)
htmlCode <- readLines(con)
close(con)


url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
x1 <- readLines(url)
x2 <- x1[5] # one line of data
library(stringr) #grep doesn't work for some reason
str_locate_all(x2," ") # where all the spaces are
str_sub(x2,2,10) # first column - week number
str_sub(x2,16,19) # second column - data
str_sub(x2,20,23) # second column - data, could be negative
etc...

x <- read.fwf(file=url(url),skip=4, widths=c(12, 7,4, 9,4, 9,4, 9,4))
