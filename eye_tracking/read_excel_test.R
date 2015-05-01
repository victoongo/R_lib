
library(readxl)

setwd("~/Dropbox/Projects/R_lib/eye_tracking/data")
et <- read_excel("Eye_Tracking_Test.xlsx") # this file is not comtable, due to not created correctly by tobii

et <- import.xls("Eye_Tracking_Test.xlsx", as.is=TRUE)

options(java.parameters = "-Xmx1024m")
require(xlsx)
read.xlsx("Eye_Tracking_Test.xlsx", sheetName = "Data")
read.xlsx2("Eye_Tracking_Test.xlsx", sheetName = "Data")

require(XLConnect)
wb = loadWorkbook("Eye_Tracking_Test.xlsx")
df = readWorksheet(wb, sheet = "Data", header = TRUE)

require(gdata)
df = read.xls("Eye_Tracking_Test.xlsx", sheet = 1, header = TRUE)


library("openxlsx")
mydf <- read.xlsx("Eye_Tracking_Test.xlsx")
, sheet = 'data', startRow = 2, colNames = TRUE)



# SOURCE: http://www.r-bloggers.com/read-excel-files-from-r/

# ODBC connection
# For many years this was the easiest solutions based on R code for Windows users.
# Nowadays it still support only 32 bit versions of R and this limit discourage the use of this package.
# Besides Microsoft Windows and 32-bit R, it requires the Excel ODBC driver installed.
require(RODBC)
conn = odbcConnectExcel("myfile.xlsx") # open a connection to the Excel file
sqlTables(conn)$TABLE_NAME # show all sheets
df = sqlFetch(conn, "Sheet1") # read a sheet
df = sqlQuery(conn, "select * from [Sheet1 $]") # read a sheet (alternative SQL sintax)
close(conn) # close the connection to the file

# gdata package
# In my experience the function provided by gdata package provides a good cross platform solutions.
# It is available for Windows, Mac or Linux. gdata requires you to install additional Perl libraries.
# Perl is usually already installed in Linux and Mac, but sometimes require more effort in Windows platforms.

require(gdata)
df = read.xls ("myfile.xlsx"), sheet = 1, header = TRUE)

# xlsReadWrite package
# xlsReadWrite is reported here for didactically purposes only although it is very fast:
# it doesn't support .xlsx files and this is not acceptable nowadays. Furthermore, it uses
# proprietary third party code and it should be downloaded from GitHub, CRAN cannot host it.
# It is available for Windows only.
if (FALSE) {
  require(xlsReadWrite)
  xls.getshlib()
  df = read.xls("myfile.xls", sheet = 1)
}
# XLConnect package
# XLConnect is a Java-based solution, so it is cross platform and returns satisfactory results.
# For large data sets it may be very slow.

require(XLConnect)
wb = loadWorkbook("myfile.xlsx")
df = readWorksheet(wb, sheet = "Sheet1", header = TRUE)

# xlsx package
# xlsx package read (and write) .xlsx and .xls files using Java. It is cross platform
# and uses rJava to deal with Java. Comments and examples below are taken from a stackoverflow answer.
# It probably returns the best results but requires some more options.
#
# However, read.xlsx() function may be slow, when opening large Excel files.
# read.xlsx2() function is considerably faster, but does not quess the vector class of data.frame columns.
# You have to use colClasses() command to specify desired column classes, if you use read.xlsx2() function:
#
# read.xlsx("filename.xlsx", 1) reads your file and makes the data.frame column classes nearly useful,
# but is very slow for large data sets.
# read.xlsx2("filename.xlsx", 1) is faster, but you will have to define column classes manually.
# A shortcut is to run the command twice. character specification converts your columns to factors.
# Use Date and POSIXct options for time.

require(xlsx)
read.xlsx("myfile.xlsx", sheetName = "Sheet1")
read.xlsx2("myfile.xlsx", sheetName = "Sheet1")
require(xlsx)
coln = function(x) { # A function to see column numbers
  y = rbind(seq(1, ncol(x)))
  colnames(y) = colnames(x)
  rownames(y) = "col.number"
  return(y)
}
data = read.xlsx2("myfile.xlsx", 1) # open the file
coln(data) # check the column numbers you want to have as factors
x = 3 # Say you want columns 1-3 as factors, the rest numeric
data = read.xlsx2("myfile.xlsx", 1,
  colClasses = c(rep("character", x), rep("numeric", ncol(data)-x+1))
)