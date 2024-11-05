
#Our dataset was fairly clean when we found it, making it relatively easy to interpret and work with. 
#However, our “Race” variable is given by letters - A, W, H, B, N, and O - so are making an extra column “Race_Full” that has the full names of these variables such as “Asian” instead of “A” and “Native American” instead of “N”.

library(dplyr) 
library(readr)  

data <- read_csv("dataset/fatal-police-shootings-data.csv")

data <- data |>
  mutate(Race_Full = recode(race,
                            "W" = "White, non-Hispanic",
                            "B" = "Black, non-Hispanic",
                            "A" = "Asian",
                            "N" = "Native American",
                            "H" = "Hispanic",
                            "O" = "Other",
                            .default = "Unknown"))

save(data, file = "cleaned_fatal_police_shootings.RData") 
write_csv(data, "cleaned_fatal_police_shootings.csv")      