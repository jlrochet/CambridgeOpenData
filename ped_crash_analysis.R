## Created by Jean-Louis Rochet on 2-9-2017
## Analysis of Cambridge PD geocoded crash data involving pedestrians (2010-14 only)

# Load packages
library(tidyverse)
library(lubridate)
library(magrittr)

# Set working directory
setwd("/Users/JLR/Documents/GitHub Repos/Cambridge Open Data")

# Read csv
crashes <- read_csv("Cambridge PD Geocoded Crashes 2010 - 2014.csv")

# Transform date time column with lubridate
crashes$`Date Time` <- mdy_hm(crashes$`Date Time`, tz = "America/New_York")

# Rename columns
crashes %>% select(crash_id = `Crash Number`,
                   date_time = `Date Time`,
                   day_of_week = `Day Of Week`,
                   object_1 = `Object 1`,
                   object_2 = `Object 2`,
                   street_number = `Street Number`,
                   street_name = `Steet Name`,
                   cross_street = `Cross Street`,
                   location = Location,
                   latitude = Latitude,
                   longitude = Longitude) -> crashes

# Create accurate weekday column (NAs in original data)
crashes <- mutate(crashes, weekday = weekdays(crashes$date_time))

# Remove innacurate weekday column
crashes <- select(crashes, -day_of_week)

# Create separate hour column
crashes <- mutate(crashes, hour = hour(date_time))

# Summary histograms
qplot(crashes$weekday) # crashes by weekday (days of the week are out of order)

qplot(crashes$object_1) # almost all crashes caused by Auto

qplot(crashes$hour) # distribution of crashes by time of day (graph looks terrible)

# Analysis: difference in pedestrian hits by weekday?
weekday_tbl <- table(crashes$weekday)
chisq.test(weekday_tbl) # yes, highly significant difference in crashes by weekday

# Analysis: difference in pedestrian hits by time of day?
hour_tbl <- table(crashes$hour)
chisq.test(hour_tbl) # yes, highly significant difference in crashes by time of day
