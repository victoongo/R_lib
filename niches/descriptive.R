paks <- c('dplyr', 'ggplot2', 'ggvis')
lapply(paks, library, character.only=T)

setwd("~/Projects/R_lib/niches/data")
reg <- read.csv("FBFF68E1-8148-4D5E-AF5D-DB04E3C4FDF2_RegistrationData.csv", as.is=TRUE, skip=2)
adata<-read.csv("FBFF68E1-8148-4D5E-AF5D-DB04E3C4FDF2_AssessmentData.csv", skip=2, as.is=TRUE)
ascores<-read.csv("FBFF68E1-8148-4D5E-AF5D-DB04E3C4FDF2_AssessmentScores.csv", skip=2, as.is=TRUE)
names(reg)
str(unique(reg$CustomNumberField))
str(unique(reg$stcode))
str(unique(reg$Column1))
# count(unique(bmi$nestid)[1:100])

niches <- select(niches, CustomNumberField, Age, Baseline)
names(niches)[1] <- 'id'
niches <- filter(niches, Age<7)
niches$Baseline <- as.Date(niches$Baseline, "%m/%d/%Y %H:%M")
niches <- arrange(niches, Baseline)

niches_nodup <- distinct(niches, id)
mean(niches_nodup[1:19, 2])

plot(Age~Baseline, data=niches_nodup)

### interactive Scatterplot
# what to do on hover
on_hover <- function(x) {
  if(is.null(x)) return(NULL)
  mgi_symbol <- x$id
#   mgi_symbol <- niches_nodup$id[x$id]
  mgi_symbol
}

# what to do on click
# on_click <- function(x) {
#   if(is.null(x)) return(NULL)
#   ensid <- dataset$Ensembl.Gene.ID[x$id]
#   ensembl_url <- paste0("http://useast.ensembl.org/Mus_musculus/Gene/Summary?db=core;g=", ensid)
#   browseURL(ensembl_url)
#   NULL
# }

# start ggvis
point_size = 100 # if dots are too big/small, adjust this parameter
niches_nodup %>% 
  ggvis(~Age, ~Baseline, key := ~id) %>% 
  layer_points(size := point_size) %>%
  add_tooltip(on_hover, "hover") 
#   add_tooltip(on_click, "click") %>% set_options(width=600, height=600)