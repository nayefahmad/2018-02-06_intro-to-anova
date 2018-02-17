
#******************************
# IMPORT AND CLEAN ED DATA   
#******************************

library("dplyr")
library("lubridate")
library("here")
library("readr")

# rm(list=ls())
# getwd()

# read data from csv file: ---------
visits <- read_csv(here("data", "2017-10-24_vgh-ed-visits.csv"))


# data wrangling: ---------------
visits <- mutate(visits, 
                 StartDate=ymd(StartDate), 
                 StartdateFiscalPeriodLong = as.factor(StartdateFiscalPeriodLong), 
                 StartDateFiscalYear=as.factor(StartDateFiscalYear)) %>% 
      rename(date=StartDate,
             fperiod=StartdateFiscalPeriodLong, 
             fyear=StartDateFiscalYear, 
             num.visits = `num visits`) %>%
      mutate(day.of.week=weekdays(date), 
             isweekend= ifelse (day.of.week %in% c("Saturday", 
                                                   "Sunday"),
                                1,0), 
             month=month(date, label=TRUE, abbr=TRUE),
             month.fyear=month(date, label=TRUE, abbr=TRUE) %>% 
                   paste(fyear, sep="-") %>% 
                   as.factor) %>% 
      filter(month %in% c("Oct", "Nov", "Dec", "Jan", "Feb"))

str(visits)
summary(visits)

