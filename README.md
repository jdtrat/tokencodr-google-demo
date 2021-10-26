# tokencodr-google-demo

This repo is a demo of how to use [tokencodr](https://tokencodr.jdtrat.com/) to automate the use of Google's services from R with GitHub Actions, [googledrive](https://googledrive.tidyverse.org) and [googlesheets4](https://googlesheets4.tidyverse.org). To begin, check out the [setup script](https://github.com/jdtrat/tokencodr-google-demo/blob/master/scripts/misc_setup.R) and the [tokencodr vignette](https://tokencodr.jdtrat.com/articles/tokencodr.html).

I'll be writing a blog post on this soon, but in the meantime, a short-walkthrough:

-   Create an RStudio Project with a `R/` directory, `scripts/` directory, and `DESCRIPTION` file (similar format to an [R Package](https://r-pkgs.org/package-structure-state.html#package-structure-state)). Take a look at this repo's structure as an example, and feel free to clone it if that's easier. You want to make sure the `DESCRIPTION` file has a valid package name, e.g. 'tokencodr.demo' or 'this.is.valid'.

    -   Call `usethis::use_package()` for all packages you use in your script to automate. At a minimum, you need to call the following:

        -   `usethis::use_dev_package("jdtrat/tokencodr")`

        -   `usethis::use_package("googledrive")`

        -   `usethis::use_package("googlesheets4")`

-   Follow the [setup script](https://github.com/jdtrat/tokencodr-google-demo/blob/master/scripts/misc_setup.R) to encode a JSON file with credentials for your Google Service Account [check out this link to get one](https://gargle.r-lib.org/articles/get-api-credentials.html#service-account-token).

    -   Be sure to copy the password from `tokencodr::create_env_pw()` to your [repository's secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets). As an example, if you call `tokencodr::create_env_pw("tokencodr_demo")`, you should create a repository secret with the name `TOKENCODR_DEMO_PASSWORD`.

-   Create a file to be automated within your `scripts/` directory (mine is called ['write-data.R'](https://github.com/jdtrat/tokencodr-google-demo/blob/master/scripts/write-data.R)). The top of this file should call the authorization functions for googledrive and googlesheets4. I've wrapped mine in this [`auth_google()` function](https://github.com/jdtrat/tokencodr-google-demo/blob/master/R/func_auth_google.R) to make it easier for using tokencodr.

-   Call `usethis::use_build_ignore(c("scripts", "resources"))` to prevent these files from being sourced when the package dependencies are installed with GitHub Actions.

-   Call `usethis::use_github_action("https://raw.githubusercontent.com/jdtrat/tokencodr-google-demo/master/.github/workflows/write-data-google.yaml?token=AMIJBLRTR7ZMB4RCVCGOM3TBQF4XO")` to copy the GitHub Action to your R Studio Project but be sure to update the password name 'TOKENCODR_GOOGLE_DEMO_PASSWORD' to reflect your service and, if desired, change the file name from 'write-data-google.yaml'.

    -   Also change the CRON schedule as desired to schedule your script.
