
## removeAmbiguity function
## eliminates bothersome designations and ambiguities
## examples include: G, P, N e, v designations and ambuities starting with "/"
## This code will remove everything after those designations, leaving the first (and most common) allele in the ## cell


stupid_df <- read.csv("stupid_df.csv", header=TRUE, stringsAsFactors = FALSE)

# Same function, but you can specify the character to replace and the starting column
resolveAmbiguity <- function(df, x = 1, char){
  for(c in x:length(colnames(df))){
    df[,c] <- gsub(char,"", df[,c])
  }
  return(df)
}

# Example
stupid_df <- resolveAmbiguity(stupid_df, x = 2, char = "/.*")

# When a cell contains a "-" it indicates homozygosity. 
# This function replaces the "-" with the allele designated in the column to it's left

copyHomozygous <- function (df){
  for(i in 1:length(row.names(df))){
    for(c in 1:length(colnames(df))){
      element <- df[i,c]
      
      if (is.na(element) == FALSE){
        if(element == "-") {
          df[i,c] <- df[i,c-1]
        }
      }
      
    }  
  }
  return(df)
}



