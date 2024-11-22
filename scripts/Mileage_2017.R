Police_Reports <- read.csv("dataset-ignore/Police_Dispatched_Incidents.csv")


Police_Reports <- df_Police |>
  slice(1:1000) 

saveRDS(Police_Reports,"dataset/Police_Reports.rds")


