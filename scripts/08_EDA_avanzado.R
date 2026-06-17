# 08_EDA_avanzado.R
# EDA avanzado: correlaciones, patrones por usuario y análisis temporal

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
# 3. Correlaciones simples

# Pasos vs Calorías
cor_steps_calories <- cor(daily$TotalSteps, daily$Calories)
cor_steps_calories

# Pasos vs Minutos muy activos
cor_steps_active <- cor(daily$TotalSteps, daily$VeryActiveMinutes)
cor_steps_active

# Sueño vs Pasos
cor_sleep_steps <- cor(daily_sleep$TotalMinutesAsleep, daily_sleep$TotalSteps)
cor_sleep_steps
# 4. Análisis por usuario

# Promedio de pasos por usuario
steps_by_user <- daily %>%
  group_by(Id) %>%
  summarise(mean_steps = mean(TotalSteps))

# Promedio de sueño por usuario
sleep_by_user <- daily_sleep %>%
  group_by(Id) %>%
  summarise(mean_sleep = mean(TotalMinutesAsleep))
# 5. Patrones por día de la semana

daily <- daily %>%
  mutate(weekday = wday(ActivityDate, label = TRUE))

steps_by_weekday <- daily %>%
  group_by(weekday) %>%
  summarise(mean_steps = mean(TotalSteps))

steps_by_weekday

# 6. Visualización Promedio de pasos por día de la semana
steps_by_weekday %>%
  ggplot(aes(weekday, mean_steps)) +
  geom_col(fill = "steelblue") +
  labs(title = "Promedio de pasos por día de la semana")
