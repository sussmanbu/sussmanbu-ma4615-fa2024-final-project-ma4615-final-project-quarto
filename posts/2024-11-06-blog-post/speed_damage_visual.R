crash_data <- read.csv("Crash_Reporting_-_Drivers_Data.csv")
library(tidyverse)
suppressPackageStartupMessages(library(tidyverse))
install.packages("tidymodels")



speed_damage = cleaned_dataset[c("Speed.Limit", "Vehicle.Damage.Extent")]
speed_damage = speed_damage[speed_damage$Vehicle.Damage.Extent != "UNKNOWN", ]

speed_damage_wide =  speed_damage |> 
  count(Speed.Limit, Vehicle.Damage.Extent) |>
  pivot_wider(
    names_from = Vehicle.Damage.Extent, 
    values_from = n, 
    values_fill = 0
  )

cleaned_dataset$Vehicle.Damage.Extent <- as.factor(cleaned_dataset$Vehicle.Damage.Extent)


speed_damage_model = lm(Speed.Limit ~ Vehicle.Damage.Extent, data = cleaned_dataset)
summary(speed_damage_model)


ggplot(speed_damage, aes(x = Vehicle.Damage.Extent, y = Speed.Limit, fill = Vehicle.Damage.Extent)) +
  geom_boxplot() +
  labs(title = "Relationship between Speed Limit and Vehicle Damage Extent",
     x = "Vehicle Damage Extent",
     y = "Speed Limit") +
  theme_minimal()
