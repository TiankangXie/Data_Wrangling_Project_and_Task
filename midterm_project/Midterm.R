library(SASxport)
setwd("F:\\Fall2018\\QBS DataWrangling\\Midterm")
datset <- read.xport("DIQ_I.xpt")
#write.csv(datset,"DIQ1.csv",row.names = F)
#apply(datset, 1, function(x) sum(is.na(datset))/nrow(datset))
#sort(apply(datset, 2, function(col)sum(is.na(col))/length(col)))

coltypesN <- c(1,3,33,38,39,42,44,45,46,47,48,49,50,51,54)
coltypesC <- c(2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
               ,32,34,35,36,37,40,41,43,52,53)
#datset$DID040[which(datset$DID040 == 999)] <- mean(na.omit(datset$DID040)[which(na.omit(datset$DID040) <= 80)])
#Assign Don't know people the average value for known values. This is because we assume that
#they forgot their ages. So missing by random
  
#datset$DID040[which(datset$DID040 == 666)] <- 0.5

#datset$DID040[is.na(datset$DID040)] <- -1
#We assume that missing are mostly those who do not have current diabetes

#DIQ010 & DID040 & DIQ160 will be processed later

#Checksum DIQ159

number01 <- which(datset$DIQ010 %in% c(2,3,7,9))
skipped <- 3
datset[number01,skipped] <- -1
#datsub proceed to check 

#sum(is.na(datset[-number01,skipped]))


number11 <- which((datset$DID040 < 12 & datset$DID040 >0) |datset$DIQ010 == 1)
skipped11 <- seq(from = 4, to = 31, by =1)
datset[number11,skipped11] <- -1

#Since these people were skipped to 050

number12 <- which(datset$DID040 >= 12 & datset$DIQ010 == 3)
skipped12 <- c(4)
datset[number12,skipped12] <- -1
#These people skipped DIQ160

#sum(is.na(datset$DIQ175E))

number13 <- which(datset$DIQ172 %in% c(2,7,9))
skipped13 <- seq(from = 7,to = 30,by = 1)
datset[number13,skipped13] <- -1
    
sum(is.na(datset$DIQ175E))

#CheckSum 065
number21 <- which(datset$DIQ010 ==1 | datset$DIQ010 ==3 | datset$DIQ160 == 1)
skipped21 <- seq(from = 35, to = 54, by = 1)
datset[-number21,skipped21] <- -1

#CheckSum 295
number31 <- which(datset$DID040 <12)
skipped31 <- seq(from = 44, to = 54, by =1)
datset[number31,skipped31] <- -1


#Safe to delete:
# 1. Polycystic ovarian syndrome: There is only 1 non-missing case here and it is possible to impute the rest with only one existing 
# 2.


#datset$DID040 = as.numeric(datset$DID040)
datset$DID040[which(datset$DID040 == 666)] <- 0.5
#rowStat1 <- which(is.na(datset$DID040) | datset$DID040 == 999 | datset$DID == -1)
datset$DID040[which(is.na(datset$DID040) | datset$DID040 == 999)] <-  mean(na.omit(datset$DID040)[which(na.omit(datset$DID040) >1 & na.omit(datset$DID040) < 90)])

sum(is.na(datset$DID040)) 


#For those who did not skip questions, Assign thme to 0 value

{datset$DIQ160[which(is.na(datset$DIQ160))] <- -2
datset$DIQ170[which(is.na(datset$DIQ170))] <- -2
datset$DIQ172[which(is.na(datset$DIQ172))] <- -2
datset$DIQ175A[which(is.na(datset$DIQ175A))] <- -2
datset$DIQ175B[which(is.na(datset$DIQ175B))] <- -2
datset$DIQ175C[which(is.na(datset$DIQ175C))] <- -2
datset$DIQ175D[which(is.na(datset$DIQ175D))] <- -2
datset$DIQ175E[which(is.na(datset$DIQ175E))] <- -2
datset$DIQ175F[which(is.na(datset$DIQ175F))] <- -2
datset$DIQ175G[which(is.na(datset$DIQ175G))] <- -2
datset$DIQ175H[which(is.na(datset$DIQ175H))] <- -2
datset$DIQ175I[which(is.na(datset$DIQ175I))] <- -2
datset$DIQ175J[which(is.na(datset$DIQ175J))] <- -2
datset$DIQ175K[which(is.na(datset$DIQ175K))] <- -2
datset$DIQ175L[which(is.na(datset$DIQ175L))] <- -2
datset$DIQ175M[which(is.na(datset$DIQ175M))] <- -2
datset$DIQ175N[which(is.na(datset$DIQ175N))] <- -2
datset$DIQ175O[which(is.na(datset$DIQ175O))] <- -2
datset$DIQ175P[which(is.na(datset$DIQ175P))] <- -2
datset$DIQ175Q[which(is.na(datset$DIQ175Q))] <- -2
datset$DIQ175R[which(is.na(datset$DIQ175R))] <- -2
datset$DIQ175S[which(is.na(datset$DIQ175S))] <- -2
datset$DIQ175T[which(is.na(datset$DIQ175T))] <- -2
datset$DIQ175U[which(is.na(datset$DIQ175U))] <- -2
datset$DIQ175V[which(is.na(datset$DIQ175V))] <- -2
datset$DIQ175W[which(is.na(datset$DIQ175W))] <- -2
datset$DIQ175X[which(is.na(datset$DIQ175X))] <- -2
datset$DIQ180[which(is.na(datset$DIQ180))] <- -2

datset$DID060[which(datset$DID060 == 666)] <- 0.5
}

datset$copy060 <- datset$DID060
for(i in 1:nrow(datset)){
  if(!is.na(datset$DID060[i]) & !is.na(datset$DIQ060U[i]) ){
    if(datset$DIQ060U[i] == 1){
      
    }else if(datset$DIQ060U[i] == 2){
      datset$copy060[i] <- datset$copy060[i] * 12
    }
  }
}


#datset$DID060[which(datset$DID060 == 999)] <-  mean(na.omit(datset$DID060)[which(na.omit(datset$DID060) >1 & na.omit(datset$DID060) < 90)])

datset$copy060[which((datset$copy060) == 999)] <-  mean(na.omit(datset$copy060)[which(na.omit(datset$copy060) >0 & na.omit(datset$copy060) < 900)])
datset$copy060[which(is.na(datset$copy060))] <- -2
datset$DID060[which(is.na(datset$DID060))] <- -2
datset$DIQ060U[which(is.na(datset$DIQ060U))] <- -2

#Combine them into one universal time with



#Because only 1 missing, we assign it to No

datset$DIQ070[which(is.na(datset$DIQ070))] <- 2



#Note that these are exactly the same two groups of people
datset$DIQ230[which(is.na(datset$DIQ230))] <- -2
datset$DIQ240[which(is.na(datset$DIQ240))] <- -2


#We assume that people don't fill in this column because they forgot
datset$DID250[which(datset$DID250 == 9999)] <- round(mean(na.omit(datset$DID250)[which(na.omit(datset$DID250) >= 0 & na.omit(datset$DID250) < 70)]))

datset$DID250[which(is.na(datset$DID250 ))] <- -2


datset$copy260 <- datset$DID260

for(i in 1:nrow(datset)){
  if(!is.na(datset$DID260[i]) & !is.na(datset$DIQ260U[i]) ){
    if(datset$DIQ260U[i] == 1){
      
    }else if(datset$DIQ260U[i] == 2){
      datset$copy260[i] <- datset$copy260[i] * 7
    }else if(datset$DIQ260U[i] == 3){
      datset$copy260[i] <- datset$copy260[i] * 30
    }else if(datset$DIQ260U[i] == 4){
      datset$copy260[i] <- datset$copy260[i] * 365
    }
  }
}

datset$copy260[which(is.na(datset$copy260))] <- -2

datset$DID260 <- datset$copy260
datset$DIQ260U[which(is.na(datset$DIQ260U))] <- -2

datset$DIQ275[which(is.na(datset$DIQ275))] <- -2

#Since we are sure that doctors visted these 641 people before
datset$DIQ280[which(datset$DIQ280 == 777 | datset$DIQ280 == 999)] <-mean(na.omit(datset$DIQ280)[which(na.omit(datset$DIQ280) >= 0 & na.omit(datset$DIQ280) < 70)])

datset$DIQ280[which(is.na(datset$DIQ280))] <- -2

datset$DIQ291[which(is.na(datset$DIQ291))] <- -2

#SBP is not patient specific. I do not believe that a person will try to hide it intentionally.
#Also the missing values are few, so I impute everything
unique(datset$DIQ300S)

datset$DIQ300S[which(is.na(datset$DIQ300S) | datset$DIQ300S == 7777 | datset$DIQ300S == 9999)] <- mean(na.omit(datset$DIQ300S)[which(na.omit(datset$DIQ300S) >= 70 & na.omit(datset$DIQ300S) < 203)])

datset$DIQ300D[which(is.na(datset$DIQ300D) | datset$DIQ300D == 7777 | datset$DIQ300D == 9999)] <- mean(na.omit(datset$DIQ300D)[which(na.omit(datset$DIQ300D) >= 10 & na.omit(datset$DIQ300D) < 260)])

#We cannot impute what the doctors told them. In addition, this information will be useless if we impute it. If we want to see if their actual
#and recommended, imputing recommended will not achieve that goal.

summary(datset$DID310S)

datset$DID310S[which(is.na(datset$DID310S))] <- -2
datset$DID310D[which(is.na(datset$DID310D))] <- -2


#Check point
number51 <- which(datset$DID320 %in% c(5555,6666))
skipped51 <- c(49)

datset[number51,skipped51] <- -1

datset$DID320[which(is.na(datset$DID320))] <- -2

datset$DID330[which(is.na(datset$DID330))] <- -2


#Again,Since the number of missing or don't know is small, we can impute

datset$DID341[ which(datset$DID341 == 7777 | datset$DID341 == 9999)] <- mean(na.omit(datset$DID341)[which(na.omit(datset$DID341) >= 0 & na.omit(datset$DID341) < 40)])

datset$DID341[which(is.na(datset$DID341))] <- -2

datset$copy350 <- datset$DID350
for(i in 1:nrow(datset)){
  if(!is.na(datset$DID350[i]) & !is.na(datset$DID350[i]) ){
    if(datset$DID350[i] == 1){
      
    }else if(datset$DID350[i] == 2){
      datset$copy350[i] <- datset$copy350[i] * 7
    }else if(datset$DID350[i] == 3){
      datset$copy350[i] <- datset$copy350[i] * 30
    }else if(datset$DID350[i] == 4){
      datset$copy350[i] <- datset$copy350[i] * 365
    }
  }
}
datset$copy350[which(datset$copy350 == 7777 | datset$copy350 == 9999)] <- mean(na.omit(datset$copy350)[which(na.omit(datset$copy350) >= 0 & na.omit(datset$copy350) < 40)])

datset$copy350[which(is.na(datset$copy350) )] <- -2

datset$DID350 <- datset$copy350
datset$DIQ350U [which(is.na(datset$DIQ350U) )] <- -2

#datset$DIQ360[which(datset$DIQ360 == 5)] <- 0
datset$DIQ360[which(is.na(datset$DIQ360))] <- -2
datset$DIQ080[which(is.na(datset$DIQ080))] <- -2


Categorical <- c(2,4,5,6,31,32,35,37,41,54)

colnames(datset)[Categorical] 




for(i in 1:length(Categorical)){
  for(j in 1:nrow(datset)){
    if(!is.na(datset[j,Categorical[i]])){
      if(datset[j,Categorical[i]] == 1){
        datset[j,Categorical[i]] = "Yes"
      }else if (datset[j,Categorical[i]] == 2){
        datset[j,Categorical[i]] = "No"
      }else if (datset[j,Categorical[i]] ==7){
        datset[j,Categorical[i]] = "Refused"
      }else if (datset[j,Categorical[i]] == 9){
        datset[j,Categorical[i]] = "Don't know"
      }else if (datset[j,Categorical[i]] == 3){
        datset[j,Categorical[i]] = "Borderline"
      }else if (datset[j,Categorical[i]] == -1){
        datset[j,Categorical[i]] = "Skipped due to checks"
      }else if (datset[j,Categorical[i]] == -2){
        datset[j,Categorical[i]] = "Missed for no reason"
      }
    }
  }
}


for(i in 1:nrow(datset)){
  if(!is.na(datset[i,7])){
    if(datset[i,7] == 10){
      datset[i,7] = "Family History"
    }else if (datset[i,7] == -1){
      datset[i,7] = "Skipped due to check" 
    }else if (datset[i,7] == -2){
      datset[i,7] = "Disagreed or Missed for no reason"
    }
  }
}

for(i in 1:nrow(datset)){
  if(!is.na(datset[i,8])){
    if(datset[i,8] == 11){
      datset[i,8] = "Overweight"
    }else if (datset[i,8] == -1){
      datset[i,8] = "Skipped due to check" 
    }else if (datset[i,8] == -2){
      datset[i,8] = "Disagreed or Missed for no reason"
    }
  }
}

for(i in 1:nrow(datset)){
  if(!is.na(datset[i,9])){
    if(datset[i,9] == 12){
      datset[i,9] = "Age"
    }else if (datset[i,9] == -1){
      datset[i,9] = "Skipped due to check" 
    }else if (datset[i,9] == -2){
      datset[i,9] = "Disagreed or Missed for no reason"
    }
  }
}

for(i in 1:nrow(datset)){
  if(!is.na(datset[i,10])){
    if(datset[i,10] == 13){
      datset[i,10] = "Poor diet"
    }else if (datset[i,10] == -1){
      datset[i,10] = "Skipped due to check" 
    }else if (datset[i,10] == -2){
      datset[i,10] = "Disagreed or Missed for no reason"
    }
  }
}

for(i in 1:nrow(datset)){
  if(!is.na(datset[i,11])){
    if(datset[i,11] == 14){
      datset[i,11] = "Race"
    }else if (datset[i,11] == -1){
      datset[i,11] = "Skipped due to check" 
    }else if (datset[i,11] == -2){
      datset[i,11] = "Disagreed or Missed for no reason"
    }
  }
}

for(i in 1:nrow(datset)){
  if(!is.na(datset[i,12])){
    if(datset[i,12] == 15){
      datset[i,12] = "Had a baby weighed over 9 lbs. at birth"
    }else if (datset[i,12] == -1){
      datset[i,12] = "Skipped due to check" 
    }else if (datset[i,12] == -2){
      datset[i,12] = "Disagreed or Missed for no reason"
    }
  }
}

for(i in 1:nrow(datset)){
  if(!is.na(datset[i,13])){
    if(datset[i,13] == 16){
      datset[i,13] = "Lack of physical activity"
    }else if (datset[i,13] == -1){
      datset[i,13] = "Skipped due to check" 
    }else if (datset[i,13] == -2){
      datset[i,13] = "Disagreed or Missed for no reason"
    }
  }
}

for(i in 1:nrow(datset)){
  if(!is.na(datset[i,14])){
    if(datset[i,14] == 17){
      datset[i,14] = "High blood pressure"
    }else if (datset[i,14] == -1){
      datset[i,14] = "Skipped due to check" 
    }else if (datset[i,14] == -2){
      datset[i,14] = "Disagreed or Missed for no reason"
    }
  }
}

for(i in 1:nrow(datset)){
  if(!is.na(datset[i,15])){
    if(datset[i,15] == 18){
      datset[i,15] = "High blood sugar"
    }else if (datset[i,15] == -1){
      datset[i,15] = "Skipped due to check" 
    }else if (datset[i,15] == -2){
      datset[i,15] = "Disagreed or Missed for no reason"
    }
  }
}

for(i in 1:nrow(datset)){
  if(!is.na(datset[i,16])){
    if(datset[i,16] == 19){
      datset[i,16] = "High cholesterol"
    }else if (datset[i,16] == -1){
      datset[i,16] = "Skipped due to check" 
    }else if (datset[i,16] == -2){
      datset[i,16] = "Disagreed or Missed for no reason"
    }
  }
}

for(i in 1:nrow(datset)){
  if(!is.na(datset[i,17])){
    if(datset[i,17] == 20){
      datset[i,17] = "Hypoglycemic"
    }else if (datset[i,17] == -1){
      datset[i,17] = "Skipped due to check" 
    }else if (datset[i,17] == -2){
      datset[i,17] = "Disagreed or Missed for no reason"
    }
  }
}

for(i in 1:nrow(datset)){
  if(!is.na(datset[i,18])){
    if(datset[i,18] == 21){
      datset[i,18] = "Extreme hunger"
    }else if (datset[i,18] == -1){
      datset[i,18] = "Skipped due to check" 
    }else if (datset[i,18] == -2){
      datset[i,18] = "Disagreed or Missed for no reason"
    }
  }
}

for(i in 1:nrow(datset)){
  if(!is.na(datset[i,19])){
    if(datset[i,19] == 22){
      datset[i,19] = "Tingling/numbness in hands or feet"
    }else if (datset[i,19] == -1){
      datset[i,19] = "Skipped due to check" 
    }else if (datset[i,19] == -2){
      datset[i,19] = "Disagreed or Missed for no reason"
    }
  }
}

for(i in 1:nrow(datset)){
  if(!is.na(datset[i,20])){
    if(datset[i,20] == 23){
      datset[i,20] = "Blurred vision"
    }else if (datset[i,20] == -1){
      datset[i,20] = "Skipped due to check" 
    }else if (datset[i,20] == -2){
      datset[i,20] = "Disagreed or Missed for no reason"
    }
  }
}

for(i in 1:nrow(datset)){
  if(!is.na(datset[i,21])){
    if(datset[i,21] == 24){
      datset[i,21] = "Increased fatigue"
    }else if (datset[i,21] == -1){
      datset[i,21] = "Skipped due to check" 
    }else if (datset[i,21] == -2){
      datset[i,21] = "Disagreed or Missed for no reason"
    }
  }
}

for(i in 1:nrow(datset)){
  if(!is.na(datset[i,22])){
    if(datset[i,22] == 25){
      datset[i,22] = "Anyone could be at risk"
    }else if (datset[i,22] == -1){
      datset[i,22] = "Skipped due to check" 
    }else if (datset[i,22] == -2){
      datset[i,22] = "Disagreed or Missed for no reason"
    }
  }
}

for(i in 1:nrow(datset)){
  if(!is.na(datset[i,23])){
    if(datset[i,23] == 26){
      datset[i,23] = "Doctor warning"
    }else if (datset[i,23] == -1){
      datset[i,23] = "Skipped due to check" 
    }else if (datset[i,23] == -2){
      datset[i,23] = "Disagreed or Missed for no reason"
    }
  }
}

for(i in 1:nrow(datset)){
  if(!is.na(datset[i,24])){
    if(datset[i,24] == 27){
      datset[i,24] = "Other, specify"
    }else if (datset[i,24] == -1){
      datset[i,24] = "Skipped due to check" 
    }else if (datset[i,24] == -2){
      datset[i,24] = "Disagreed or Missed for no reason"
    }
  }
}

for(i in 1:nrow(datset)){
  if(!is.na(datset[i,25])){
    if(datset[i,25] == 28){
      datset[i,25] = "Gestational diabetes"
    }else if (datset[i,25] == -1){
      datset[i,25] = "Skipped due to check" 
    }else if (datset[i,25] == -2){
      datset[i,25] = "Disagreed or Missed for no reason"
    }
  }
}


for(i in 1:nrow(datset)){
  if(!is.na(datset[i,26])){
    if(datset[i,26] == 29){
      datset[i,26] = "Frequent urination"
    }else if (datset[i,26] == -1){
      datset[i,26] = "Skipped due to check" 
    }else if (datset[i,26] == -2){
      datset[i,26] = "Disagreed or Missed for no reason"
    }
  }
}


for(i in 1:nrow(datset)){
  if(!is.na(datset[i,27])){
    if(datset[i,27] == 30){
      datset[i,27] = "Thirst"
    }else if (datset[i,27] == -1){
      datset[i,27] = "Skipped due to check" 
    }else if (datset[i,27] == -2){
      datset[i,27] = "Disagreed or Missed for no reason"
    }
  }
}


for(i in 1:nrow(datset)){
  if(!is.na(datset[i,28])){
    if(datset[i,28] == 31){
      datset[i,28] = "Craving for sweet/eating a lot of sugar"
    }else if (datset[i,28] == -1){
      datset[i,28] = "Skipped due to check" 
    }else if (datset[i,28] == -2){
      datset[i,28] = "Disagreed or Missed for no reason"
    }
  }
}


for(i in 1:nrow(datset)){
  if(!is.na(datset[i,29])){
    if(datset[i,29] == 32){
      datset[i,29] = "Medication"
    }else if (datset[i,29] == -1){
      datset[i,29] = "Skipped due to check" 
    }else if (datset[i,29] == -2){
      datset[i,29] = "Disagreed or Missed for no reason"
    }
  }
}

for(i in 1:nrow(datset)){
  if(!is.na(datset[i,30])){
    if(datset[i,30] == 33){
      datset[i,30] = "Polycystic ovarian syndrome	"
    }else if (datset[i,30] == -1){
      datset[i,30] = "Skipped due to check" 
    }else if (datset[i,30] == -2){
      datset[i,30] = "Disagreed or Missed for no reason"
    }
  }
}

Continuous <- c(1,3,33,38,39,42,44,45,46,47,48,49,50,51)

#Unit_measures <- c(34,40,52)

specialNotice <- c(36,43,53)

for(i in 1:nrow(datset)){
  if(!is.na(datset[i,34])){
    if(datset[i,34] == 1){
      datset[i,34] = "Months"
    }else if (dataset[i,34] == 2){
      datset[i,34] = "Years"
    }
    else if (datset[i,34] == -1){
      datset[i,34] = "Skipped due to check" 
    }else if (datset[i,34] == -2){
      datset[i,34] = "Missed for no reason"
    }
  }
}

unitMeasure2 <- c(40,52)
for(i in 1:length(unitMeasure2)){
  for(j in 1:nrow(datset)){
    if(!is.na(datset[j,unitMeasure2[i]])){
      if(datset[j,unitMeasure2[i]] == 1){
        datset[j,unitMeasure2[i]] = "Per Day"
      }else if (datset[j,unitMeasure2[i]] == 2){
        datset[j,unitMeasure2[i]] = "Per Week"
      }else if (datset[j,unitMeasure2[i]] == 3){
        datset[j,unitMeasure2[i]] = "Per Month"
      }else if (datset[j,unitMeasure2[i]] == 4){
        datset[j,unitMeasure2[i]] = "Per Year"
      }else if (datset[j,unitMeasure2[i]] == -1){
        datset[j,unitMeasure2[i]] = "Skipped due to checks"
      }else if (datset[j,unitMeasure2[i]] == -2){
        datset[j,unitMeasure2[i]] = "Missing due to no reason"
      }
    }
  }
}


for(i in 1:nrow(datset)){
  if(!is.na(datset[i,36])){
    if(datset[i,36] == 1){
      datset[i,36] = "1 year ago or less"
    }else if(datset[i,36] == 2){
      datset[i,36] = "More than 1 year ago but no more than 2 years ago"
    }else if (datset[i,36] == 3){
      datset[i,36] = "More than 2 years ago but no more than 5 years ago"
    }else if (datset[i,36] == 4){
      datset[i,36] = "More than 5 years ago	"
    }else if (datset[i,36] == 5){
      datset[i,36] = "Never"
    }else if (datset[i,36] == 9){
      datset[i,36] = "Don't Know"
    }else if (datset[i,36] == -1){
      datset[i,36] = "Skipped due to checks"
    }else if (datset[i,36] == -2){
      datset[i,36] = "Missing for no reason"
    }
  }
}


for(i in 1:nrow(datset)){
  if(!is.na(datset[i,43])){
    if(datset[i,43] == 1){
      datset[i,43] = "Less than 6"
    }else if(datset[i,43] == 2){
      datset[i,43] = "Less than 7"
    }else if (datset[i,43] == 3){
      datset[i,43] = "Less than 8"
    }else if (datset[i,43] == 4){
      datset[i,43] = "Less than 9"
    }else if (datset[i,43] == 5){
      datset[i,43] = "Less than 10"
    }else if (datset[i,43] == 6){
      datset[i,43] = "Provider did not specify goal"
    }else if (datset[i,43] == 77){
      datset[i,43] = "Refused"
    }else if (datset[i,43] == 99){
      datset[i,43] = "Don't know"
    }else if (datset[i,43] == -1){
      datset[i,43] = "Skipped due to checks"
    }else if (datset[i,43] == -2){
      datset[i,43] = "Missing for no reason"
    }
  }
}


for(i in 1:nrow(datset)){
  if(!is.na(datset[i,53])){
    if(datset[i,53] == 1){
      datset[i,53] = "Less than 1 month	"
    }else if(datset[i,53] == 2){
      datset[i,53] = "1-12 months"
    }else if (datset[i,53] == 3){
      datset[i,53] = "13-24 months"
    }else if (datset[i,53] == 4){
      datset[i,53] = "Greater than 2 years"
    }else if (datset[i,53] == 5){
      datset[i,53] = "Never"
    }else if (datset[i,53] == 9){
      datset[i,53] = "Don't Know"
    }else if (datset[i,53] == -1){
      datset[i,53] = "Skipped due to checks"
    }else if (datset[i,53] == -2){
      datset[i,53] = "Missing for no reason"
    }
  }
}

library(purrr)
#n <- ncol(datset)
labels_list <- map(1:n, function(x) attr(datset[[x]], "label") )
# if a vector of character strings is preferable
labels_vector <- map_chr(1:n, function(x) attr(datset[[x]], "label") )
colnames(datset) <- labels_vector

Maks <- colnames(datset)
Maks2 <- colnames(datset)

MK1<-map_dbl(datset, ~sum(is.na(.)))

summary(datset$DIQ360)




made <- colnames(datset)[4:31]


Allsentence <- c()
for(i in 1:length(made)){
  sentence1 <- paste("Update txie.DI SET _", made[i] ,"_ = -1 WHERE (_DID040_ < 12 AND _DID040_ >0) OR _DIQ010_ = 1",sep = "")
  #sentence2 <- paste("Update txie.DI SET _", made[i],"_=-1 WHERE _DIQ172_ = 2 OR _DIQ172_ = 7 OR _DIQ172_ = 9;" , sep = "")
  Allsentence <- c(Allsentence,sentence1)
}

MK3 <- paste(Allsentence,collapse = ";")
MK4 <- paste(Allsentence, collapse = "")



made2 <- colnames(datset)
Allsentence2 <- c()
Allsentence3 <- c()
for(i in 1:length(made2)){
  sentence <- paste("ALTER TABLE txie.DI ALTER COLUMN _", made2[i] ,"_ NVARCHAR(50) NULL;", sep = "")
  
  sentence12 <- paste("UPDATE txie.DI SET _",made2[i],"_ = NULL WHERE _",made2[i],"_ = 'NA';",sep = "")
  
  Allsentence2 <- c(Allsentence2,sentence)
  Allsentence3 <- c(Allsentence3,sentence12)
}


MK5 <- paste(Allsentence2,collapse = "")
MK6 <- paste(Allsentence3,collapse = "")


made3 <- colnames(datset)[44:54]
Allsentence21 <- c()
for(i in 1:length(made3)){
  sentence <- paste("update txie.DI SET _",made3[i],"_ = -1 where _DID040_ < 12;", sep = "")
  Allsentence21 <- c(Allsentence21,sentence)
}
MK7 <- paste(Allsentence21,collapse = "")


made4 <- colnames(datset)
Allsentence22 <- c()
for(i in 1:length(made4)){
  #sentence <- paste("alter table txie.DI alter column _",made4[i],"_ NVARCHAR(50) DEFAULT NULL;",sep = "")
  #Allsentence22 <- c(Allsentence22,sentence)
  sentence <- paste("ALTER TABLE txie.DI ALTER COLUMN _",made4[i],"_ NVARCHAR(50);",sep = "")
  Allsentence22 <- c(Allsentence22,sentence)
}
MK8 <- paste(Allsentence22,collapse = "")


#exec sp_rename 'txie.Demo1.tri_age','Age';



Allsentence23 <- c()
for(i in 1:length(made5)){
  sentence <- paste("update txie.DI set _",made5[i],"_ = 0 where _",made5[i],"_ is NULL;",sep = "")
  Allsentence23 <- c(Allsentence23,sentence) 
}
MK9 <- paste(Allsentence23,collapse = "")


made6 <- colnames(datset)
Allsentences33 <- c()
for(i in 1:length(made6)){
  sentence <- paste("exec sp_rename 'txie.DI._",Maks2[i],"_','",Maks[i],"';", sep = "")
  Allsentences33 <- c(Allsentences33,sentence)
}

MK10 <- paste(Allsentences33,collapse = "")





list11 <- c(1,2,7,9,-1,-2)
list22 <- c("Yes","No","Refused","Don''t know","Skipped due to checks","Missed for no reason")
AllinOne <-c()
for(i in 2:length(Categorical)){
  for(j in 1:length(list11)){
   sentence <- paste("update txie.DI set _",colnames(datset)[Categorical[i]],"_ = '",list22[j],"' where _",colnames(datset)[Categorical[i]], "_ = '",list11[j],"';" , sep = "")
   AllinOne <- c(AllinOne,sentence)
    }
  }
MK11 <- paste(AllinOne,collapse = "")






Categorical2 <- 



Func1 <- seq(from = 7 , to = 30)
Category3 <- Func1+3
Words11<- c("Family History","Overweight","Age","Poor diet","Race","Had a baby weighed over 9 lbs. at birth","Lack of physical activity","High blood pressure","High blood sugar","High cholesterol","Hypoglycemic","Extreme hunger","Tingling/numbness in hands or feet","Blurred vision","Increased fatigue","Anyone could be at risk","Doctor warning","Other, specify","Gestational diabetes","Frequent urination","Thirst","Craving for sweet/eating a lot of sugar","Medication","Polycystic ovarian syndrome")

AllinOne2 <- c()
for(i in 1:length(Func1)){
  sentence <- paste("update txie.DI set _",colnames(datset)[Func1[i]],"_ = \'",Words11[i],"\' where _",colnames(datset)[Func1[i]],"_ = \'",Category3[i],"\';",
                    "update txie.DI set _",colnames(datset)[Func1[i]],"_ = 'Skipped due to check' where _",colnames(datset)[Func1[i]],"_ = '-1'; update txie.DI set _",colnames(datset)[Func1[i]],"_ = 'Disagreed or Missed for no reason' where _",colnames(datset)[Func1[i]],"_ = '-2';" , sep="")

  AllinOne2 <- c(AllinOne2,sentence)
  }

MK11 <- paste(AllinOne2,collapse = "")




