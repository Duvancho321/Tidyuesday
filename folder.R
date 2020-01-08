library(tidyverse)
library(usethis)


dates <- as.Date("2020_01_07", format="%Y_%m_%d") +seq(0,359,by=7) 

for (i in 1:52){
  setwd("/home/duvan/Documentos/gitpush/Tidyuesday/Folder/2020")
  dates[i] %>% 
    as.character() %>% 
    dir.create()
  paste("/home/duvan/Documentos/gitpush/Tidyuesday/Folder/2020",dates[i],sep="/") %>% 
    setwd()
}

setwd("/home/duvan/Documentos/gitpush/Tidyuesday")
