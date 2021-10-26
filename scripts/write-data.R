library(googledrive)
library(googlesheets4)

source("R/func_auth_google.R")

# Authenticate Google Service Account
auth_google(service = "tokencodr_google_demo",
            token_path = "resources/.secret/tokencodr_google_demo")

sheet_id <- googledrive::drive_find("tokencodr-google-demo")$id


# Write the current time info to the Google Sheet created in 'misc_setup.R'
current_time_info <- data.frame(date = Sys.Date(),
                           time = format(Sys.time(), "%H:%M:%S"))

googlesheets4::sheet_write(data = current_time_info,
                           ss = sheet_id)
