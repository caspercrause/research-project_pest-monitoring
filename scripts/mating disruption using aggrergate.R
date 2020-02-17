# Libraries----
library(tidyverse)
library(readxl)

path <- 'data/mating.disrupt.test.xlsx'

(x <- readxl::read_xlsx(path,range = 'A4:F29',col_names = T)) 

(y <- readxl::read_xlsx(path,range = "I4:K9",col_names = T ))






(x %>% 
    mutate(Date = lubridate::ymd(Date)) -> block_data)

(y %>% 
    mutate_at(vars(matches('Start|End')), ~ lubridate::ymd(.)) %>% 
    rename_all(~ str_replace_all(.," ",".")) -> lookup_table)





d = '19 jan 19' %>% lubridate::dmy()

mating_disruption <- function(d){
    
    # create a dataframe with all start and end dates and all input dates to handle multiple dates at once
    input_df <- merge(d, lookup_table)
    
    # use logical indexing and vectorized form for calculating all disrupt logical values in one go for speed
    input_df$disrupt <- input_df$x >= input_df$Mating.Disrupt.Start & input_df$x <= input_df$Mating.Disrupt.End
    
    # for each date and block, check if any value was TRUE, if so, return TRUE, otherwise return FALSE
    output_df <- aggregate(input_df["disrupt"], by = list(date = input_df$x, block = input_df$Block), FUN = any)
    
  

}

# Doesn't work----
dt<-  c('1 jan 19', '22 jan 19','7 may 19') %>% lubridate::dmy()
dt %>% mating_disruption() -> result

# Test on new data
(new_data_set <- block_data %>% 
        select(-`Mating Disrup`) %>% 
        slice(10:15) %>% 
        mutate_at(vars(Trap:Block), ~ str_replace_all(.,"A 1", replacement = "B 1") ) %>%
        bind_rows(block_data[,setdiff(names(block_data),'Mating Disrup')]))




(new_data_set$Date %>% mating_disruption() -> new_table)

x
