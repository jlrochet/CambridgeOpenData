## Created by Jean-Louis Rochet on 8-4-2016
## Data visualization for Cambridge parking tickets by meter
## CSV file downloaded from open data site and renamed "tickets.csv"

# Load libraries
library(magrittr)
library(dplyr)
library(readr)
library(leaflet)

# Set working directory
setwd("/Users/JLR/Documents/GitHub Repos/Cambridge Open Data")

# Read file
tickets <- read_csv("tickets.csv")

# Subset relevant columns and rows (meter expired violations only)

tickets %>%
        select(date = starts_with("Ticket"), time = starts_with("Issue"), location = Location, 
               violation = starts_with("Violation"), meter = Meter) -> ticketstable

ticketstable %>%
        mutate(location)

# Create lat and long columns

# Read lat and long into columns from Location column using metacharacters

# Create map widget using leaflet

# Host map widget using shiny
