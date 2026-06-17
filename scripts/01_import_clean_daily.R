# 01_import_clean_daily.R
# Limpieza de dailyActivity

library(tidyverse)
library(lubridate)

# Importar dailyActivity forzando tipos
daily <- read_csv(
  "data/dailyActivity_merged.csv",
  col_types = cols(
    Id = col_double(),
    ActivityDate = col_character(),
    TotalSteps = col_double(),
    TotalDistance = col_double(),
    TrackerDistance = col_double(),
    LoggedActivitiesDistance = col_double(),
    VeryActiveDistance = col_double(),
    ModeratelyActiveDistance = col_double(),
    LightActiveDistance = col_double(),
    SedentaryActiveDistance = col_double(),
    VeryActiveMinutes = col_double(),
    FairlyActiveMinutes = col_double(),
    LightlyActiveMinutes = col_double(),
    SedentaryMinutes = col_double(),
    Calories = col_double()
  )
)

# Convertir fecha
daily <- daily %>%
  mutate(ActivityDate = mdy(ActivityDate))

# Comprobar estructura y calidad
glimpse(daily)

daily %>%
  count(Id, ActivityDate) %>%
  filter(n > 1)

summary(daily)

