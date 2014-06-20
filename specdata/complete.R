complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files

  specdata <-
    list.files("/home/jawara/Workspace/DataAnalytics/Coursera-DS/specdata/",
               full.names = TRUE, pattern = ".csv")

  # Read the files into a list of data.frames
  specdata.df <- NULL
  obs <- NULL
  #id <- NULL
  nobs <- NULL

  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  #id <- 1:332

  # concatenate into one big data.frame
  for(i in 1:length(id)) {
    specdata.df <- rbind(specdata.df, read.csv(specdata[i]))
    completeCases <- complete.cases(specdata.df$sulfate, specdata.df$nitrate)
    obs$id[i] <- id[i]
    obs$nobs[i] <- length(specdata.df[completeCases,]$ID[specdata.df[completeCases,]$ID == i])
  }

  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases

  obs <- as.data.frame(obs)

    #return(#obs[obs$id %in% id, ])
    #return(obs[obs[, "id"] %in% id, ])
    return(obs)
    #return(data.frame(id = obs$id, nobs = obs$nobs))
    #return(obs[obs$id %in% id && obs$nobs[obs$id %in% id]])
    #return(subset(obs, id %in% id, select = c("id", "nobs")))

}
