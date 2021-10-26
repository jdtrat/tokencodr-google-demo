# remotes::install_github("jdtrat/tokencodr")
library(tokencodr)
library(googlesheets4)
library(googledrive)

# Run once and copy password to .Renviron
# For this demo I used "tokencodr_demo_google"
# Make sure you add this to your repository secrets (I forgot originally)
tokencodr::create_env_pw("description-of-service")

# Assumes the JSON file is a Google Service Account as described here:
# https://gargle.r-lib.org/articles/get-api-credentials.html#service-account-token
tokencodr::encrypt_token("description-of-service", # "tokencodr_demo_google"
                         input = "path-to-your-secret-json-file",
                         destination = "path-to-save-encrypted-json-file") # here I used "resources/"

# Locally Authenticate Google Sheets & Google Drive
googlesheets4::gs4_auth(path = tokencodr::decrypt_token(service = "description-of-service",
                                                        # here, the path is "resources/.secret/tokencodr_demo_google"
                                                         path = "path-to-your-encrypted-json-file",
                                                         complete = TRUE))


googledrive::drive_auth(path = tokencodr::decrypt_token(service = "tokencodr_google_demo",
                                                        # here, the path is "resources/.secret/tokencodr_demo_google"
                                                        path = "path-to-your-encrypted-json-file",
                                                        complete = TRUE))

# Create a new sheet
# here, I used "tokencodr-google-demo"
new_sheet <- googlesheets4::gs4_create(name = "your-sheet-name")

# Choose to share with your personal Google Account
googledrive::drive_share(new_sheet,
                         role = "writer",
                         type = "user",
                         emailAddress = "your-personal-google-email")

