###### Features
featData <- read.table("/home/jawara/Workspace/DataAnalytics/Coursera-DS/003-projdata/UCI-HAR-Data/features.txt")
featData

### Substitutions
featData.1 <- gsub("\\(\\)", "", featData$V2)
featData.1
featData.1[1]
featData.2 <- gsub("\\(", "-", featData.1)
featData.2
featData.2[1]
featData.3 <- gsub("\\)", "", featData.2)
featData.3
featData.3[1]
# Domain t = time and f = frequency
featData.4 <- gsub("tBody", "t-Body", featData.3)
featData.4
featData.4[1]
featData.5 <- gsub("fBody", "f-Body", featData.4)
featData.5
featData.5[551]
featData.6 <- gsub("tGravity", "t-Gravity", featData.5)
featData.6
featData.6[43]
featData.7 <- gsub("-bands", "_bands", featData.6)
featData.7
featData.7[303]
featData.8 <- gsub("BodyBody", "Body", featData.7)
featData.8
featData.8[516]
featData.9 <- gsub(",", " and ", featData.8)
featData.9
featData.9[516]

# Split features list for re-use as variable names in long data
featData.10 <- str_split_fixed(featData.9, "-", 4)

# re-sub of elements with bands after splitting
featData.11 <- gsub("_bands", "-bands", featData.10)

# Domain t = time and f = frequency
featData.12 <- data.frame(domain = featData.11[,1], signal = featData.11[,2], measurement =featData.11[,3], direction = featData.11[,4])
is.data.frame(featData.12)

###
getwd()
write.table(featData.12, "003-projdata/UCI-HAR-Data/features.csv", sep = ",",
          col.names = TRUE, na = "NA", quote = FALSE)
