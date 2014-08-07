complete1 <- function(directory, id = 1:332) {

  specdata <-
    list.files("/home/jawara/Workspace/DataAnalytics/Coursera-DS/specdata/",
               full.names = TRUE, pattern = ".csv")

  #obs.id <- unique(spec.data$ID)
  id <- 1:332

  spec.data <- data.frame()
  completeCases <- complete.cases(spec.data)
  obs = data.frame(id , nobs)

  #for(i in 1:332){
  #  spec.data <- rbind(spec.data, read.csv(specdata[i]))
  #}
  #
  #for(i in 1:length(obs.id)) {
  #  obs[i, ] <- c(id = id[i] <- obs.id[i],
  #                nobs = nobs[i] <- length(spec.data[completeCases,]$ID[spec.data[completeCases,]$ID == i]))
  #}
  for (i in 1:length(id) {
    mydata <- read.csv(aq_data[i])
    nobs<-sum(complete.cases(mydata))
  }


  # return(subset(obs, "id" %in% id, select = c("id", "nobs")))
  return(obs[obs[, "id"] == id, ])

}

  ## Example
  #   files_list <- dir(directory, full.names=TRUE)
  # for (i in id) {
  #  nobs <- sum(complete.cases(read.csv(files_list[i])))
  # }
  # data.frame(id, nobs)
  # }


