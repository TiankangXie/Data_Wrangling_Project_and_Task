library(RODBC)
library(dplyr)
myconn <- odbcConnect("dartmouth","txie","txie@qbs181")
demo<-sqlQuery(myconn,"select * from Demographics")
chro <- sqlQuery(myconn, "select * from ChronicConditions")
textMe <- sqlQuery(myconn, "select * from Text")
colnames(demo)[1] = "ID"
colnames(chro)[1] = "ID"
colnames(textMe)[1] = "ID"

datSet21 <- demo %>% merge(chro,by = "ID") %>% merge(textMe,by = "ID")

datSet21$TextSentDate[1]
datSet22 <- datSet21 %>% group_by(ID) %>% slice(which.max(TextSentDate))

datSet22

#This is not pertinent to the question asked. It is just for fun.
#-------------------------------------------
setwd("F:\\Fall2018\\QBS DataWrangling\\Final")
#save.image(file = "Datasets.Rdata")
d1 <- sqlQuery(myconn,"select * from Demographics")
d2 <- sqlQuery(myconn,"select * from txie.ICBP")
colnames(d1)[1] = "ID"
colnames(d2)[1] = "ID"
d <- merge(d2,d1, by= "ID")
length(unique(d$ID))
#write.csv(datSet22,"newSet.csv")
