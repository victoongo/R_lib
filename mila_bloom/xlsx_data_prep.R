library(dplyr)
library(readxl)
library(ggplot2)
library(lubridate)
setwd('~/Dropbox/Projects/R_lib/mila_bloom/data/')

files <- list.files()
txt.names <- sub('.xlsx$', '', files)
for (i in 1:length(txt.names)) {
  txt.names[i] <- strsplit(txt.names[i], " ")[[1]][1]
}

for (i in 1:length(files)) {
  # x <- read.xlsx(files[i])
  x <- read_excel(files[i])
  assign(txt.names[i], x)
  rm(x)
}
Steps <- Steps[,-length(names(Steps))]
names(Fuel) <- gsub(" ", "_", names(Fuel))

# dailySteps <-aggregate(Steps, by=list('PID', 'Date_steps'), FUN=sum, na.rm=TRUE)
dailySteps <-aggregate(cbind(total_steps) ~ PID + Date_steps + week_steps, FUN=sum, data=Steps, na.rm=TRUE)

FD <- c(paste0(c('Green', 'Yellow', 'Red'), "_", "Foods"), paste0(c('Green', 'Yellow', 'Red'), "_", "Drinks"))

color <- c('Green', 'Yellow', 'Red')
type <- c('Foods', 'Drinks')
FD <- NULL
for (c in color) {
  for (t in type) {
    FD <- c(FD, paste0(c, "_", t))
  }
}
fmla <- paste0("cbind(", paste(FD, collapse=", "), ") ~ PID + Date + WEEK")

dailyFuel <-aggregate(as.formula(fmla), data=Fuel, FUN=sum, na.rm=TRUE)

dailySum <- merge(dailySteps, dailyFuel, by.x=c('PID', 'Date_steps'), by.y=c('PID', 'Date'))
dailySum <- dailySum %>% select(-WEEK) %>% rename(DATE = Date_steps, WEEK = week_steps) %>%
  filter(WEEK < 10)

daily <- group_by(dailySum, PID)
firstd <- daily %>% summarise(
               firstday = min(DATE),
               count = n()) %>% filter(count >= 7)
dailySum <- merge(dailySum, firstd, by='PID')

dailySum <- mutate(dailySum, DATED = as.numeric(difftime(dailySum$DATE, dailySum$firstday, unit="days")))

qplot(DATED, total_steps, data=dailySum, geom='line', colour=factor(PID))

ggplot(dailySum, aes(x=DATED, y = total_steps)) +
  geom_line() +
  facet_wrap(~ PID, ncol = 2)

write.csv(dailySum, file='dailySum.CSV')
rmarkdown::render('~/Dropbox/Projects/R_lib/mila_bloom/graphs.Rmd', "html_document")


# ggplot(dailySum, aes(x=DATE)) +
#   geom_line(aes(y = total_steps), colour = 'blue') +
#   geom_line(aes(y = Green_Foods), colour = 'red') +
#   facet_wrap(~ PID, ncol = 2)