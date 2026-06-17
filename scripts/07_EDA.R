# 07_EDA.R
# Análisis Exploratorio (EDA)

library(tidyverse)
library(lubridate)

# 1. Cargar datos limpios
source("scripts/01_import_clean_daily.R")
source("scripts/02_import_clean_sleep.R")
source("scripts/03_import_clean_hourlySteps.R")
source("scripts/04_import_clean_hourlyCalories.R")
source("scripts/05_import_clean_hourlyIntensities.R")
source("scripts/06_import_clean_heartrate.R")

# 2. Unión correcta daily + sleep
daily_sleep <- daily %>%
  inner_join(sleep, by = c("Id" = "Id", "ActivityDate" = "SleepDate"))

# 3. Comprobación básica de todos los datasets
glimpse(daily)
glimpse(sleep)
glimpse(hourly_steps)
glimpse(hourly_calories)
glimpse(hourly_intensities)
glimpse(heartrate)
glimpse(daily_sleep)

# 4. Estadísticos descriptivos
summary(daily)
summary(sleep)
summary(hourly_steps)
summary(hourly_calories)
summary(hourly_intensities)
summary(heartrate)
summary(daily_sleep)

# 5. Distribución de pasos diarios
daily %>%
  ggplot(aes(TotalSteps)) +
  geom_histogram(binwidth = 1000, fill = "steelblue") +
  labs(title = "Distribución de pasos diarios")

# 6. Relación sueño vs actividad
daily_sleep %>%
  ggplot(aes(TotalMinutesAsleep, TotalSteps)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm") +
  labs(title = "Relación entre minutos dormidos y pasos diarios")

# 7. Actividad por hora del día
hourly_steps %>%
  mutate(hour = hour(ActivityHour)) %>%
  group_by(hour) %>%
  summarise(mean_steps = mean(StepTotal)) %>%
  ggplot(aes(hour, mean_steps)) +
  geom_line() +
  labs(title = "Promedio de pasos por hora del día")
