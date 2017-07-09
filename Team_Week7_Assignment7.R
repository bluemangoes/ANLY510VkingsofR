setwd("~/Desktop")
ddata = read.csv("dirty_data.csv")

str(ddata)
install.packages("zoo")
library(zoo)
library(stringr)
ddata$Area[ddata$Area == ""]<- NA

ddata$Area <- na.locf(ddata$Area)

ddata3 = gsub("[^[:alnum:][:blank:]+?&/\\-]", " ", ddata[,3])
ddata4 = gsub("[^[:alnum:][:blank:]+?&/\\-]", " ", ddata[,4])

ddata33 = gsub("[Ss]treet", " str.", ddata3)
cdata33 = gsub("[Aa]venue", " ave.",ddata33)
cdata3 = gsub("(^|[[:space:]])([[:alpha:]])", "\\1\\U\\2", trimws(tolower(cdata33), which = "left"), perl=TRUE)

ddata44 = gsub("[Ss]treet", " str.", ddata4)
cdata44 = gsub("[Aa]venue", " ave.", ddata44)
cdata4 = gsub("(^|[[:space:]])([[:alpha:]])", "\\1\\U\\2", trimws(tolower(cdata44), which which = "left"), perl=TRUE)
dataa55 <- gsub("Ì", "", cdata4)
dataa55

ddata$Street <- as.character(dataa55)
ddata$Street.2 <- as.character(ddata$Street.2)

# Remove dublicate data from the street
# add a col temp col street 3 dublication of street and remove "." as well inorder to make comparisoin 

ddata$Street.2[ddata$Street.2 %in% ddata$Street] <- ""

# remove comma to better match the result

ddata$Street.2 <- gsub(",", "", ddata$Street.2)

ddata$Street.2 <- gsub(".", "", ddata$Street.2) 

ddata$Street.2[ddata$Street.2 %in% ddata$Street] <- ""

cdata = cbind.data.frame(ddata[,1],ddata$Area, cdata3, ddata$Street.2)
names(cdata) = c("Year", "Area", "Street", "Street 2")
write.csv(cdata, file = "clean_data.csv")