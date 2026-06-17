# 06_import_clean_heartrate.R
# Limpieza de heartrate_seconds

library(tidyverse)
library(lubridate)

# Importar heartrate_seconds forzando tipos
heartrate <- read_csv(
  "data/heartrate_seconds_merged.csv",
  col_types = cols(
    Id = col_double(),
    Time = col_character(),
    Value = col_double()
  )
)

# Convertir fecha-hora
heartrate <- heartrate %>%
  mutate(Time = mdy_hms(Time))

# Comprobar estructura
glimpse(heartrate)

# Buscar duplicados
heartrate %>%
  count(Id, Time) %>%
  filter(n > 1)

# Eliminar duplicados si los hubiera
heartrate <- heartrate %>%
  distinct(Id, Time, .keep_all = TRUE)

# Validación final
summary(heartrate)

