# Libraries----
library(tidyverse)
library(readxl)

path <- 'data/mating.disrupt.test.xlsx'

(x <- readxl::read_xlsx(path,range = 'A4:F29',col_names = T)) 

(y <- readxl::read_xlsx(path,range = "I4:L9",col_names = T ))






x %>% 
    mutate(Date = lubridate::ymd(Date)) -> block_data

y %>% 
    mutate_at(vars(matches('Start|End')), ~ lubridate::ymd(.)) %>% 
    rename_all(~ str_replace_all(.," ",".")) -> lookup_table




# I can only use tis function for a single block -  in this case A 1
# To demonstrate I will only use the first two rows of the lookup_table

lookup_table <- head(lookup_table,2)


mating_disruption <- function(d){
    # Start with an empty data frame
    tbl <- tibble::tibble(Date = as.Date(character(0)) , disrupt = logical(0))
    
    # Prepend a row to the inital tbl and inspect whether the date falls between the mating disrupt start or end
    for(i in 1:nrow(lookup_table)){
        
        
        
        tbl <- tibble::add_row(tbl,
                               Date    = d,
                               disrupt = (between(d,lookup_table$Mating.Disrupt.Start[[i]],lookup_table$Mating.Disrupt.End[[i]]) ))
        
        
    } 
    
    tbl %>% filter(disrupt) -> subset
    
    if(nrow(subset) == 0){
        return(FALSE)
    } else return(TRUE)
    
    
}

# Works----
d <- lubridate::dmy('8jan19')
d %>% mating_disruption()
# Doesn't work----
dt<-  c('1 jan 19', '22 jan 19','7 may 19') %>% lubridate::dmy()
dt %>% mating_disruption()
# Fix ----
map_lgl(dt,mating_disruption)


# Test on data set ----
block_data %>% 
    mutate(disrupt = unlist(map(block_data$Date,mating_disruption))) 


block_data %>% 
    mutate(disrupt1 = map_lgl(Date,mating_disruption))


# How to do this for multiple blocknames?

(new_data_set <- block_data %>% 
    select(-`Mating Disrup`) %>% 
    slice(10:15) %>% 
    mutate_at(vars(Trap:Block), ~ str_replace_all(.,"A 1", replacement = "B 1") ) %>%
    bind_rows(block_data[,setdiff(names(block_data),'Mating Disrup')]))


new_data_set


