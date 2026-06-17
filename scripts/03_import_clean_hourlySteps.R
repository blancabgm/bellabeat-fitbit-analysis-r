# 03_import_clean_hourlySteps.R
# Limpieza de hourlySteps

library(tidyverse)
library(lubridate)

# Importar hourlySteps forzando tipos
hourly_steps <- read_csv(
  "data/hourlySteps_merged.csv",
  col_types = cols(
    Id = col_double(),
    ActivityHour = col_character(),
    StepTotal = col_double()
  )
)

# Convertir fecha-hora
hourly_steps <- hourly_steps %>%
  mutate(ActivityHour = mdy_hms(ActivityHour))

# Comprobar estructura
glimpse(hourly_steps)

# Buscar duplicados
hourly_steps %>%
  count(Id, ActivityHour) %>%
  filter(n > 1)

# (Opcional) Eliminar duplicados si los hubiera
hourly_steps <- hourly_steps %>%
  distinct(Id, ActivityHour, .keep_all = TRUE)

# Validación final
summary(hourly_steps)

