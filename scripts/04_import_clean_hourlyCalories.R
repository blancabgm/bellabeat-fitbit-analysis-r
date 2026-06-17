# 04_import_clean_hourlyCalories.R
# Limpieza de hourlyCalories

library(tidyverse)
library(lubridate)

# Importar hourlyCalories forzando tipos
hourly_calories <- read_csv(
  "data/hourlyCalories_merged.csv",
  col_types = cols(
    Id = col_double(),
    ActivityHour = col_character(),
    Calories = col_double()
  )
)

# Convertir fecha-hora
hourly_calories <- hourly_calories %>%
  mutate(ActivityHour = mdy_hms(ActivityHour))

# Comprobar estructura
glimpse(hourly_calories)

# Buscar duplicados
hourly_calories %>%
  count(Id, ActivityHour) %>%
  filter(n > 1)

# Eliminar duplicados si los hubiera
hourly_calories <- hourly_calories %>%
  distinct(Id, ActivityHour, .keep_all = TRUE)

# Validación final
summary(hourly_calories)

