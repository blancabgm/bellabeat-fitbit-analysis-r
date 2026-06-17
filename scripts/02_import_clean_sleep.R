# 02_import_clean_sleep.R
# Limpieza de sleepDay

library(tidyverse)
library(lubridate)

# Importar sleepDay forzando tipos
sleep <- read_csv(
  "data/sleepDay_merged.csv",
  col_types = cols(
    Id = col_double(),
    SleepDay = col_character(),
    TotalSleepRecords = col_double(),
    TotalMinutesAsleep = col_double(),
    TotalTimeInBed = col_double()
  )
)

# Convertir fecha-hora
sleep <- sleep %>%
  mutate(SleepDay = mdy_hms(SleepDay))

sleep <- sleep %>%
  mutate(SleepDate = as_date(SleepDay))

# Comprobar estructura
glimpse(sleep)

# Buscar duplicados
sleep %>%
  count(Id, SleepDay) %>%
  filter(n > 1)

# Eliminar duplicados si los hubiera
sleep <- sleep %>%
  distinct(Id, SleepDay, .keep_all = TRUE)

# Validación final
summary(sleep)

