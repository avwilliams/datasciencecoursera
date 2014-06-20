pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files

  specdata <-
    list.files("/home/jawara/Workspace/DataAnalytics/Coursera-DS/specdata/",
               pattern = ".csv")

  # Read the files into a list of data.frames
  specData.list <- lapply(specdata, read.csv)

  # concatenate into one big data.frame
  specData.cat <- do.call(rbind, specData.list)

  # Remove NAs - and make a logical
  # specDataCat <- complete.cases(specData.cat)

  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate"

  # pollutant <- c("sulfate", "nitrate")

  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used

  #id <- 1:332

  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)

  if(pollutant == "sulfate") {
    return(round(mean(specData.cat$sulfate[specData.cat$ID %in% id], na.rm = TRUE), 3))
  } else if(pollutant == "nitrate") {
    return(round(mean(specData.cat$nitrate[specData.cat$ID %in% id], na.rm = TRUE), 3))
  } else {
    return("No mean of pollutant")
  }
}
