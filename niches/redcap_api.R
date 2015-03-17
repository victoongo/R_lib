# Load needed libraries
# --> NOTE: RCurl is dependent on bitops
library(bitops)
library(RCurl)
library(Hmisc)
library(xtable)

setwd('~/Dropbox/Projects/R_lib/niches/data')
source('../redcap_api_token.R')

# Set the url to the api (ex. https://YOUR_REDCAP_INSTALLATION/api/)
api_url = 'https://redcap.dtmi.duke.edu/api/'
y <- postForm(api_url, token = secret_token, content = 'metadata', format = 'csv', .opts=curlOptions(ssl.verifyhost=2))

## If in R for Linux
## --> NOTE: need to additionally install the Curl C libraries --- not installed on default (like on a Mac)
## --> NOTE: To install RCurl on a Linux machine
## From terminal command line:
# sudo apt-get install libcurl4-openssl-dev
## Then
# sudo R
## Then from within R
# install.packages("RCurl")
# --> Code to "export" data from REDCap
# y <- postForm(api_url, token = secret_token, content = 'record', format = 'csv', type = 'flat')

# Use the output from postForm() to create a data frame of the exported data
x <- read.table(file = textConnection(y), header = TRUE, sep = ",", na.strings = "",
                stringsAsFactors = FALSE)
rm(secret_token, y)

## Alternative code:
#write(y, file = "data_file.csv");
#x <- read.table("data_file.csv", sep = ",", header = TRUE, na.strings = "")