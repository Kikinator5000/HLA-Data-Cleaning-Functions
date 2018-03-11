---
  title: "Writing functions for data cleaning"
output: html_document
---
  
  ```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## removeAmbiguity function
## eliminates bothersome designations and ambiguities
## examples include: G, P, N e, v designations and ambuities starting with "/"
## This code will remove everything after those designations, leaving the first (and most common) allele in the ## cell

```{r removeAmbiguity}
stupid_df <- read.csv("stupid_df.csv", header=TRUE, stringsAsFactors = FALSE)

#snippet works
#stupid_df[,1] <- gsub("/.*","",stupid_df[,1])

# WORKS!!!
resolveAmbiguity <- function(df){
  for(c in 1:length(colnames(df))){
    df[,c] <- gsub("/.*","", df[,c])
  }
  return(df)
}

#test
stupid_df <- resolveAmbiguity(stupid_df)

# Rewritten to allow you to specify starting column
resolveAmbiguity <- function(df,x=1){
  for(c in x:length(colnames(df))){
    df[,c] <- gsub("/.*","", df[,c])
  }
  return(df)
}

#test
stupid_df <- resolveAmbiguity(stupid_df,2)

# Same function, but you can specify the character to replace and the starting column
resolveAmbiguity <- function(df, x = 1, char){
  for(c in x:length(colnames(df))){
    df[,c] <- gsub(char,"", df[,c])
  }
  return(df)
}

#Test
stupid_df <- resolveAmbiguity(stupid_df, x = 2, char = "/.*")


```

## 



```{r copyHomozygous}
# Add some empty homozygous calls
stupid_df <- read.csv("stupid_df.csv", header=TRUE, stringsAsFactors = FALSE)

stupid_df[1,2] <- "-"
stupid_df[3,4] <- "-"
stupid_df[4,6] <- "-"

# Now it works
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

# assign the output of the function to a new data frame
stupid_df <- copyHomozygous(stupid_df)


```