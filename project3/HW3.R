library(dplyr)
library(tidyr)
library(lubridate)
library(stringr)
library(reshape)
setwd("F:\\Fall2018\\QBS DataWrangling")
#Q1---------------------------------------------------------------------------------
#1
table2 %>% 
  spread(key=type,value=count) %>% 
  select(country,year,cases)

table2 %>% 
  spread(key=type,value=count) %>% 
  select(country,year,cases,population)

table2Data <- table2 %>% 
  spread(key=type,value=count) %>% 
  mutate(rate=cases/population *10000)

#It is too easy to do it step by step so I integrated all parts to get a single answer.
table4Data <- table4a %>% 
  gather(`1999`,`2000`,key="year",value="cases") %>%
  inner_join(table4b%>%gather(`1999`,`2000`,key="year",value="population") ,'country') %>% 
  filter(year.x == year.y) %>% 
  mutate(rate=cases/population * 10000) %>% 
  arrange(country)

#-----------------------------------------------------------------------------------





library(nycflights13)
#Q3a
#--------------------------------------------------
by_day <- group_by(nycflights13::flights,year,month,day)
by_day2 <- summarize(by_day,air_time=mean(air_time,na.rm=TRUE))
by_day2$Num <- seq(1,nrow(by_day2),by = 1)
plot(by_day2$Num,by_day2$air_time,xlab = "day in a year", ylab = "average travel time",bty = "l")
#bty = "l"
#bty = "n"
#------------------------------------------------------


#Q3b
#----------------------------------------------------
Q3b <- flights %>% select(dep_time,sched_dep_time,dep_delay)
RealDep = addTime(Q3b$sched_dep_time,Q3b$dep_delay)

#A function that adds time.
addTime<- function (Time1,TimeAdd){
  vector <- rep(0,length(Time1))
  
  for(i in 1:length(Time1)){
    if(!is.na(Time1[i]) & !is.na(TimeAdd[i])){
      H1 <- Time1[i] %/% 100
      R1 <- Time1[i] %% 100
      if(TimeAdd[i] >= 0){
        
        H2 <- TimeAdd[i] %/% 60
        R2 <- TimeAdd[i] %% 60
      }else if(TimeAdd[i] <0){
        H2 <- TimeAdd[i] %/% -60
        R2 <- TimeAdd[i] %% -60
      }
      A1Res = H1 + H2
      A2Res = R1 + R2
      
      if(A2Res >= 60){
        A1Res = A1Res + 1
        A2Res = A2Res - 60
      }
      else if(A2Res < 0){
        A1Res = A1Res - 1
        A2Res = A2Res + 60
      }
      
      if(A1Res >= 24){
        A1Res = A1Res -24
      }
      
      val = 100*A1Res + A2Res
      if(val == 0){
        val = 2400
      }else{
        val = 100*A1Res + A2Res
      }
      vector[i] = val  
    }
    else{
      vector[i] = NA
    }
  }
  return(vector)
}

which(!na.omit(RealDep) == na.omit(Q3b$dep_time))
#-------------------------------------------------------


#Q3c
#------------------------------------------
Binary <- rep(0,nrow(flights))
for(i in 1:nrow(flights)){
  if(!is.na(flights$dep_delay[i])){
    if(flights$dep_delay[i] < 0){
      Binary[i] = 1
    } 
  }
}

subsetfl <- flights[which(Binary == 1),]
plot(subsetfl$dep_delay,subsetfl$dep_time%%100)

a = subsetfl$dep_time %% 100
a1<-melt(table(cut(a,breaks=c(0,10,19.999,30.01,40,49.9999,60))))

a2<-data.frame(sapply(a1,function(x) gsub("\\(|\\]","",gsub("\\,","-",x))))

colnames(a2)<-c("Departure minutes","Frequency")

a21 = as.data.frame(species = a2$`Departure minutes`,number = a2$Frequency)
barplot(a2$Frequency,a2$`Departure minutes`)

hist(a, breaks = c(0,10,20,30,40,50,60), freq = TRUE,
     main = "Frequency Plot for early departure", xlab = "Minutes", ylab = "frequency") # and warning


#----------------------------------------------------------------------------




#Q4
#-----------------------------------------------------------------------------
library(rvest)
scraping_wiki <-  read_html("https://geiselmed.dartmouth.edu/qbs/")
head(scraping_wiki)

h1_text <- scraping_wiki %>% html_nodes("h1") %>%html_text()
length(h1_text)

h2_text <- scraping_wiki %>% html_nodes("h2") %>%html_text()
length(h2_text)

h3_text <- scraping_wiki %>% html_nodes("h3") %>%html_text()
length(h3_text)
h4_text <- scraping_wiki %>% html_nodes("h4") %>%html_text()
length(h4_text)

p_text <- scraping_wiki %>% html_nodes("p") %>%html_text()
length(p_text)

ul_text <- scraping_wiki %>% html_nodes("ul") %>%html_text()
length(ul_text)

li_text <- scraping_wiki %>% html_nodes("li") %>%html_text()
length(li_text)


Scrap <- list(h1text = h1_text, h2text = h2_text, h3text = h3_text, h4text = h4_text, ptext = p_text, ultext = ul_text,litext = li_text)

grep("Epidemiology",Scrap$litext)
grep("Epidemiology",Scrap$ultext)
grep("Epidemiology",Scrap$ptext)

grep("biostatistics",Scrap$litext)
grep("Biostatistics",Scrap$ultext)
grep("Biostatistics",Scrap$ptext)

grep("Bioinformatics",Scrap$litext)
grep("Bioinformatics",Scrap$ultext)
grep("Bioinformatics",Scrap$ptext)


