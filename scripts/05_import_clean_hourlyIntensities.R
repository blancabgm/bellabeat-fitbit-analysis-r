# 05_import_clean_hourlyIntensities.R
# Limpieza de hourlyIntensities

library(tidyverse)
library(lubridate)

# Importar hourlyIntensities forzando tipos
hourly_intensities <- read_csv(
  "data/hourlyIntensities_merged.csv",
  col_types = cols(
    Id = col_double(),
    ActivityHour = col_character(),
    TotalIntensity = col_double(),
    AverageIntensity = col_double()
  )
)

# Convertir fecha-hora
hourly_intensities <- hourly_intensities %>%
  mutate(ActivityHour = mdy_hms(ActivityHour))

# Comprobar estructura
glimpse(hourly_intensities)

# Buscar duplicados
hourly_intensities %>%
  count(Id, ActivityHour) %>%
  filter(n > 1)

# Eliminar duplicados si los hubiera
hourly_intensities <- hourly_intensities %>%
  distinct(Id, ActivityHour, .keep_all = TRUE)

# Validación final
summary(hourly_intensities)

