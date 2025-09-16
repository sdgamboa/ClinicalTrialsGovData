library(vroom)
library(dplyr)
library(stringr)
library(purrr)
library(ggplot2)

selectCols <- c(
    "NCT Number",
    "Study Title", "Study Status", "Study Results",
    "Conditions", "Interventions",
    "Sponsor", "Collaborators",
    "Sex", "Age",
    "Phases", "Enrollment",
    "Funder Type",
    # "Study Design", 
    "Study Type",
    "Start Date", "Completion Date",
    "Locations"
)

dat <- vroom("ctg-studies_2025-08-09.csv") |> 
    select(all_of(selectCols))

colnames(dat) <- colnames(dat) |> 
    str_replace_all(" ", "_") |>
    str_to_lower()

dat <- dat |> 
    mutate(intervention_type = str_extract(interventions, "^\\w+:")) |> 
    mutate(intervention_type = sub(":", "", intervention_type)) |> 
    relocate(intervention_type, .before = interventions)

count(dat, study_status)

mkDat <- dat |> 
    filter(study_status == "APPROVED_FOR_MARKETING")
    
mkDat |>
    count(sponsor) |> 
    View()
    



