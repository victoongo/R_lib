# Load needed libraries
# --> NOTE: RCurl is dependent on bitops
library(bitops)
library(RCurl)
library(Hmisc)
library(xtable)

setwd('~/Dropbox/Projects/R_lib/niches/data')
source('../redcap_api_token.R')

# Set the url to the api (ex. https://YOUR_REDCAP_INSTALLATION/api/)
api_url <- 'https://redcap.dtmi.duke.edu/api/api/'
# api_url <- 'https://redcap.dtmi.duke.edu/api/api/'
y <- postForm(uri = api_url, token = secret_token, content = 'record', format = 'csv', type = 'flat',
              rawOrLabel = 'label', # doens't make a difference
              exportDataAccessGroups = 'true',
              .opts = RCurl::curlOptions(ssl.verifypeer=FALSE))

x <- read.table(file = textConnection(y), header = TRUE, sep = ",", na.strings = "",
                stringsAsFactors = FALSE)
rm(secret_token, y)

## Alternative code:
#write(y, file = "data_file.csv");
#x <- read.table("data_file.csv", sep = ",", header = TRUE, na.strings = "")

table(x$nestid)[table(x$nestid)>1]

namelist <- names(x)
agenamelist <- namelist[grep('age$', namelist)]
datenamelist <- namelist[grep('dat', namelist)]
dobnamelist <- namelist[grep('dob', namelist)]

summary(x[,agenamelist])
dim(x)

agevars <- x[,c('nestid', agenamelist, 'date', 'child_dob', 'mom_dob')]

noage <- agevars[is.na(agevars$age), c('nestid')]
write.csv(noage, file='noage.csv')
