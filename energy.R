
## LOAD LIBRARIES INTO SESSION #################################################
pacman::p_load("tidyverse", "ggplot2", "ggpmisc", "gridExtra", "sf",
               "rnaturalearth", "rnaturalearthdata", "rworldmap", "rio")

options(scipen=999)
dataset <- import("energy-countries-with-nulls-2021.csv")
worldData <- ne_countries(scale = "medium", returnclass = "sf")
mapData <- map_data("world")

#
## LOAD RENEWABLE ENERGY MAP DATA ##############################################
#
windDataToMap <- data.frame(wind_usage = dataset$wind_usage, 
                            region = dataset$country)
windDataToMap <- windDataToMap %>%
  mutate(region = ifelse(region == "United States", "USA", region),
         region = ifelse(region == "Democratic Republic of Congo", 
                         "Democratic Republic of the Congo", region), 
         region = ifelse(region == "Congo", "Republic of Congo", region), 
         region = ifelse(region == "Cote d'Ivoire", "Ivory Coast", region), 
         region = ifelse(region == "Czechia", "Czech Republic", region), 
         region = ifelse(region == "Eswatini", "Swaziland", region))
solarDataToMap <- data.frame(solar_usage = dataset$solar_usage, 
                             region = dataset$country)
solarDataToMap <- solarDataToMap %>%
  mutate(region = ifelse(region == "United States", "USA", region),
         region = ifelse(region == "Democratic Republic of Congo", 
                         "Democratic Republic of the Congo", region), 
         region = ifelse(region == "Congo", "Republic of Congo", region), 
         region = ifelse(region == "Cote d'Ivoire", "Ivory Coast", region), 
         region = ifelse(region == "Czechia", "Czech Republic", region), 
         region = ifelse(region == "Eswatini", "Swaziland", region))
biofuelDataToMap <- data.frame(biofuel_usage = dataset$biofuel_usage, 
                               region = dataset$country)
biofuelDataToMap <- biofuelDataToMap %>%
  mutate(region = ifelse(region == "United States", "USA", region),
         region = ifelse(region == "Democratic Republic of Congo", 
                         "Democratic Republic of the Congo", region), 
         region = ifelse(region == "Congo", "Republic of Congo", region), 
         region = ifelse(region == "Cote d'Ivoire", "Ivory Coast", region), 
         region = ifelse(region == "Czechia", "Czech Republic", region), 
         region = ifelse(region == "Eswatini", "Swaziland", region))
hydroDataToMap <- data.frame(hydro_usage = dataset$hydro_usage, 
                             region = dataset$country)
hydroDataToMap <- hydroDataToMap %>%
  mutate(region = ifelse(region == "United States", "USA", region),
         region = ifelse(region == "Democratic Republic of Congo", 
                         "Democratic Republic of the Congo", region), 
         region = ifelse(region == "Congo", "Republic of Congo", region), 
         region = ifelse(region == "Cote d'Ivoire", "Ivory Coast", region), 
         region = ifelse(region == "Czechia", "Czech Republic", region), 
         region = ifelse(region == "Eswatini", "Swaziland", region))

#
## DRAW RENEWABLE ENERGY MAPS ##################################################
#

# Wind usage: Basic World Map
windMapPlot <- ggplot(worldData) + 
  geom_map(data = mapData, map = mapData, 
           aes(x = mapData$long, y = mapData$lat, group = mapData$group, 
               map_id = region),
           fill = "white", colour = "black", linewidth = 0.5) +
  
  # Plot wind data on World Map
  geom_map(data = filter(windDataToMap, !is.na(wind_usage)), map = mapData,
           aes(fill = wind_usage, map_id = region),
           color = "black", size = 0.5) +
  scale_fill_viridis_c(option = "turbo", trans = "sqrt") +
  xlab("") + ylab("") +
  ggtitle("Wind Power Usage Of Top Energy Consuming Countries In 2021", 
          subtitle="Usage In Terawatt Hours") + 
  theme(axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank())

# Solar usage: Basic World Map
solarMapPlot <- ggplot(worldData) + 
  geom_map(data = mapData, map = mapData, 
           aes(x = mapData$long, y = mapData$lat, group = mapData$group, map_id = region),
           fill = "white", colour = "black", linewidth = 0.5) +
  
  # Plot solar data on World Map
  geom_map(data = filter(solarDataToMap, !is.na(solar_usage)), map = mapData,
           aes(fill = solar_usage, map_id = region),
           color = "black", size = 0.5) +
  scale_fill_viridis_c(option = "turbo", trans = "sqrt") +
  xlab("") + ylab("") +
  ggtitle("Solar Power Usage Of Top Energy Consuming Countries In 2021", 
          subtitle="Usage In Terawatt Hours") + 
  theme(axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank())

# Biofuel usage: Basic World Map
biofuelMapPlot <- ggplot(worldData) + 
  geom_map(data = mapData, map = mapData, 
           aes(x = mapData$long, y = mapData$lat, group = mapData$group, map_id = region),
           fill = "white", colour = "black", linewidth = 0.5) +
  
  # Plot biofuel data on World Map
  geom_map(data = filter(biofuelDataToMap, !is.na(biofuel_usage)), map = mapData,
           aes(fill = biofuel_usage, map_id = region),
           color = "black", size = 0.5) +
  scale_fill_viridis_c(option = "turbo", trans = "sqrt") +
  xlab("") + ylab("") +
  ggtitle("Biofuel Power Usage Of Top Energy Consuming Countries In 2021", 
          subtitle="Usage In Terawatt Hours") + 
  theme(axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank())

# Hydro usage: Basic World Map
hydroMapPlot <- ggplot(worldData) + 
  geom_map(data = mapData, map = mapData, 
           aes(x = mapData$long, y = mapData$lat, group = mapData$group, map_id = region),
           fill = "white", colour = "black", linewidth = 0.5) +
  
  # Plot hydro data on World Map
  geom_map(data = filter(hydroDataToMap, !is.na(hydro_usage)), map = mapData,
           aes(fill = hydro_usage, map_id = region),
           color = "black", size = 0.5) +
  scale_fill_viridis_c(option = "turbo", trans = "sqrt") +
  xlab("") + ylab("") +
  ggtitle("Hydro Power Usage Of Top Energy Consuming Countries In 2021", 
          subtitle="Usage In Terawatt Hours") + 
  theme(axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank())

#
## SAVE RENEWABLE MAPS TO IMAGE FILE ###########################################
#
ggsave("wind-map.png", plot = windMapPlot, width = 8, height = 5)
ggsave("solar-map.png", plot = solarMapPlot, width = 8, height = 5)
ggsave("biofuel-map.png", plot = biofuelMapPlot, width = 8, height = 5)
ggsave("hydro-map.png", plot = hydroMapPlot, width = 8, height = 5)

#
## LOAD NON-RENEWABLE ENERGY MAP DATA ##########################################
#
gasDataToMap <- data.frame(gas_usage = dataset$gas_usage, 
                           region = dataset$country)
gasDataToMap <- gasDataToMap %>%
  mutate(region = ifelse(region == "United States", "USA", region),
         region = ifelse(region == "Democratic Republic of Congo", 
                         "Democratic Republic of the Congo", region), 
         region = ifelse(region == "Congo", "Republic of Congo", region), 
         region = ifelse(region == "Cote d'Ivoire", "Ivory Coast", region), 
         region = ifelse(region == "Czechia", "Czech Republic", region), 
         region = ifelse(region == "Eswatini", "Swaziland", region))

oilDataToMap <- data.frame(oil_usage = dataset$oil_usage, 
                           region = dataset$country)
oilDataToMap <- oilDataToMap %>%
  mutate(region = ifelse(region == "United States", "USA", region),
         region = ifelse(region == "Democratic Republic of Congo", 
                         "Democratic Republic of the Congo", region), 
         region = ifelse(region == "Congo", "Republic of Congo", region), 
         region = ifelse(region == "Cote d'Ivoire", "Ivory Coast", region), 
         region = ifelse(region == "Czechia", "Czech Republic", region), 
         region = ifelse(region == "Eswatini", "Swaziland", region))

coalDataToMap <- data.frame(coal_usage = dataset$coal_usage, 
                            region = dataset$country)
coalDataToMap <- coalDataToMap %>%
  mutate(region = ifelse(region == "United States", "USA", region),
         region = ifelse(region == "Democratic Republic of Congo", 
                         "Democratic Republic of the Congo", region), 
         region = ifelse(region == "Congo", "Republic of Congo", region), 
         region = ifelse(region == "Cote d'Ivoire", "Ivory Coast", region), 
         region = ifelse(region == "Czechia", "Czech Republic", region), 
         region = ifelse(region == "Eswatini", "Swaziland", region))

nuclearDataToMap <- data.frame(nuclear_usage = dataset$nuclear_usage, 
                            region = dataset$country)
nuclearDataToMap <- nuclearDataToMap %>%
  mutate(region = ifelse(region == "United States", "USA", region),
         region = ifelse(region == "Democratic Republic of Congo", 
                         "Democratic Republic of the Congo", region), 
         region = ifelse(region == "Congo", "Republic of Congo", region), 
         region = ifelse(region == "Cote d'Ivoire", "Ivory Coast", region), 
         region = ifelse(region == "Czechia", "Czech Republic", region), 
         region = ifelse(region == "Eswatini", "Swaziland", region))

electricDataToMap <- data.frame(electric_usage = dataset$electric_usage, 
                               region = dataset$country)
electricDataToMap <- electricDataToMap %>%
  mutate(region = ifelse(region == "United States", "USA", region),
         region = ifelse(region == "Democratic Republic of Congo", 
                         "Democratic Republic of the Congo", region), 
         region = ifelse(region == "Congo", "Republic of Congo", region), 
         region = ifelse(region == "Cote d'Ivoire", "Ivory Coast", region), 
         region = ifelse(region == "Czechia", "Czech Republic", region), 
         region = ifelse(region == "Eswatini", "Swaziland", region))

# Natural gas usage: Basic World Map
gasMapPlot <- ggplot(worldData) + 
  geom_map(data = mapData, map = mapData, 
           aes(x = mapData$long, y = mapData$lat, 
               group = mapData$group, map_id = region),
           fill = "white", colour = "black", linewidth = 0.5) +
  
  # Plot gas data on World Map
  geom_map(data = filter(gasDataToMap, !is.na(gas_usage)), map = mapData,
           aes(fill = gas_usage, map_id = region),
           color = "black", size = 0.5) +
  scale_fill_viridis_c(option = "turbo", trans = "sqrt") +
  xlab("") + ylab("") +
  ggtitle("Gas Power Usage Of Top Energy Consuming Countries In 2021", 
          subtitle="Usage In Terawatt Hours") + 
  theme(axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank())

# Oil usage: Basic World Map
oilMapPlot <- ggplot(worldData) + 
  geom_map(data = mapData, map = mapData, 
           aes(x = mapData$long, y = mapData$lat, 
               group = mapData$group, map_id = region),
           fill = "white", colour = "black", linewidth = 0.5) +
  
  # Plot oil data on World Map
  geom_map(data = filter(oilDataToMap, !is.na(oil_usage)), map = mapData,
           aes(fill = oil_usage, map_id = region),
           color = "black", size = 0.5) +
  scale_fill_viridis_c(option = "turbo", trans = "sqrt") +
  xlab("") + ylab("") +
  ggtitle("Oil Power Usage Of Top Energy Consuming Countries In 2021", 
          subtitle="Usage In Terawatt Hours") + 
  theme(axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank())

# Coal usage: Basic World Map
coalMapPlot <- ggplot(worldData) + 
  geom_map(data = mapData, map = mapData, 
           aes(x = mapData$long, y = mapData$lat, 
               group = mapData$group, map_id = region),
           fill = "white", colour = "black", linewidth = 0.5) +
  
  # Plot coal data on World Map
  geom_map(data = filter(coalDataToMap, !is.na(coal_usage)), map = mapData,
           aes(fill = coal_usage, map_id = region),
           color = "black", size = 0.5) +
  scale_fill_viridis_c(option = "turbo", trans = "sqrt") +
  xlab("") + ylab("") +
  ggtitle("Coal Power Usage Of Top Energy Consuming Countries In 2021", 
          subtitle="Usage In Terawatt Hours") + 
  theme(axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank())

# Nuclear usage: Basic World Map
nuclearMapPlot <- ggplot(worldData) + 
  geom_map(data = mapData, map = mapData, 
           aes(x = mapData$long, y = mapData$lat, 
               group = mapData$group, map_id = region),
           fill = "white", colour = "black", linewidth = 0.5) +
  
  # Plot coal data on World Map
  geom_map(data = filter(nuclearDataToMap, !is.na(nuclear_usage)), map = mapData,
           aes(fill = nuclear_usage, map_id = region),
           color = "black", size = 0.5) +
  scale_fill_viridis_c(option = "turbo", trans = "sqrt") +
  xlab("") + ylab("") +
  ggtitle("Nuclear Power Usage Of Top Energy Consuming Countries In 2021", 
          subtitle="Usage In Terawatt Hours") + 
  theme(axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank())

# Electricity usage: Basic World Map
electricMapPlot <- ggplot(worldData) + 
  geom_map(data = mapData, map = mapData, 
           aes(x = mapData$long, y = mapData$lat, 
               group = mapData$group, map_id = region),
           fill = "white", colour = "black", linewidth = 0.5) +
  
  # Plot electric data on World Map
  geom_map(data = filter(electricDataToMap, !is.na(electric_usage)), map = mapData,
           aes(fill = electric_usage, map_id = region),
           color = "black", size = 0.5) +
  scale_fill_viridis_c(option = "turbo", trans = "sqrt") +
  xlab("") + ylab("") +
  ggtitle("Electric Demand Of Top Energy Consuming Countries In 2021", 
          subtitle="Usage In Terawatt Hours") + 
  theme(axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank())
#
## SAVE NON-RENEWABLE ENERGY MAPS TO IMAGE FILE ################################
#
ggsave("gas-map.png", plot = gasMapPlot, width = 8, height = 5)
ggsave("coal-map.png", plot = coalMapPlot, width = 8, height = 5)
ggsave("oil-map.png", plot = oilMapPlot, width = 8, height = 5)
ggsave("nuclear-map.png", plot = nuclearMapPlot, width = 8, height = 5)
ggsave("electric-map.png", plot = electricMapPlot, width = 8, height = 5)

## RENEWABLE ENERGY SOURCES DATA TABLES ############################################

# Plot wind data to bar chart
df1 <- dataset %>%
  filter(!is.na(electric_usage), electric_usage > 0, 
         !is.na(nuclear_usage), nuclear_usage > 0, 
         !is.na(wind_usage), wind_usage > 0,
         !is.na(solar_usage), solar_usage > 0, 
         !is.na(hydro_usage), hydro_usage > 0, 
         !is.na(biofuel_usage), biofuel_usage > 0,
         !is.na(coal_usage), coal_usage > 0, 
         !is.na(oil_usage), oil_usage > 0, 
         !is.na(gas_usage), gas_usage > 0)

wind_dataset <- df1 %>%
  select(country, wind_usage) %>%
  arrange(desc(wind_usage))
wind_plot <- ggplot(wind_dataset, aes(x = country, y = wind_usage)) + 
  geom_col() +
  xlab("") + ylab("Terawatt Hours") + 
  ggtitle("Wind Power Usage Of The Top Energy Consuming Countries", 
          subtitle="In 2021") + 
  theme(axis.text.x = element_text(angle = 90),
        legend.position = "None") + 
  annotate(geom = "table",
           x = 15,
           y = 750,
           label = head(wind_dataset, 5))

# Plot solar data to bar chart
solar_dataset <- df1 %>%
  select(country, solar_usage) %>%
  arrange(desc(solar_usage))
solar_plot <- ggplot(solar_dataset, aes(x = country, y = solar_usage)) + 
  geom_col() +
  xlab("") + ylab("Terawatt Hours") + 
  ggtitle("Solar Power Usage Of The Top Energy Consuming Countries", 
          subtitle="In 2021") + 
  theme(axis.text.x = element_text(angle = 90),
        legend.position = "None") + 
  annotate(geom = "table",
           x = 15,
           y = 300,
           label = head(solar_dataset, 5))

# Plot biofuel data to bar chart
biofuel_dataset <- df1 %>%
  select(country, biofuel_usage) %>%
  arrange(desc(biofuel_usage))
biofuel_plot <- ggplot(biofuel_dataset, aes(x = country, y = biofuel_usage)) + 
  geom_col() +
  xlab("") + ylab("Terawatt Hours") + 
  ggtitle("Biofuel Power Usage Of The Top Energy Consuming Countries", 
          subtitle="In 2021") + 
  theme(axis.text.x = element_text(angle = 90),
        legend.position = "None") + 
  annotate(geom = "table",
           x = 15,
           y = 200,
           label = head(biofuel_dataset, 5))

# Plot hydro data the bar chart
hydro_dataset <- df1 %>%
  select(country, hydro_usage) %>%
  arrange(desc(hydro_usage))
hydro_plot <- ggplot(hydro_dataset, aes(x = country, y = hydro_usage)) + 
  geom_col() +
  xlab("") + ylab("Terawatt Hours") + 
  ggtitle("Hydro Power Usage Of The Top Energy Consuming Countries", 
          subtitle="For 2021") + 
  theme(axis.text.x = element_text(angle = 90),
        legend.position = "None") + 
  annotate(geom = "table",
           x = 15,
           y = 2500,
           label = head(hydro_dataset, 5))

# Plot gas data to bar chart
gas_dataset <- df1 %>%
  select(country, gas_usage) %>%
  arrange(desc(gas_usage))
gas_plot <- ggplot(gas_dataset, aes(x = country, y = gas_usage)) + 
  geom_col() +
  xlab("") + ylab("Terawatt Hours") + 
  ggtitle("Gas Power Usage Of The Top Energy Consuming Countries", 
          subtitle="In 2021") + 
  theme(axis.text.x = element_text(angle = 90),
        legend.position = "None") + 
  annotate(geom = "table",
           x = 15,
           y = 4000,
           label = head(gas_dataset, 5))

# Plot coal data to bar chart
coal_dataset <- df1 %>%
  select(country, coal_usage) %>%
  arrange(desc(coal_usage))
coal_plot <- ggplot(coal_dataset, aes(x = country, y = coal_usage)) + 
  geom_col() +
  xlab("") + ylab("Terawatt Hours") + 
  ggtitle("Coal Power Usage Of The Top Energy Consuming Countries", 
          subtitle="In 2021") + 
  theme(axis.text.x = element_text(angle = 90),
        legend.position = "None") + 
  annotate(geom = "table",
           x = 15,
           y = 15000,
           label = head(coal_dataset, 5))

# Plot oil data to bar chart
oil_dataset <- df1 %>%
  select(country, oil_usage) %>%
  arrange(desc(oil_usage))
oil_plot <- ggplot(oil_dataset, aes(x = country, y = oil_usage)) + 
  geom_col() +
  xlab("") + ylab("Terawatt Hours") + 
  ggtitle("Oil Power Usage Of The Top Energy Consuming Countries", 
          subtitle="In 2021") + 
  theme(axis.text.x = element_text(angle = 90),
        legend.position = "None") +
  annotate(geom = "table",
           x = 15,
           y = 8000,
           label = head(oil_dataset, 5))

# Plot nuclear data to bar chart
nuclear_dataset <- df1 %>%
  select(country, nuclear_usage) %>%
  arrange(desc(nuclear_usage))
nuclear_plot <- ggplot(nuclear_dataset, aes(x = country, y = nuclear_usage)) + 
  geom_col() +
  xlab("") + ylab("Terawatt Hours") + 
  ggtitle("Nuclear Power Usage Of The Top Energy Consuming Countries", 
          subtitle="For 2021") + 
  theme(axis.text.x = element_text(angle = 90),
        legend.position = "None") + 
  annotate(geom = "table",
           x = 15,
           y = 1800,
           label = head(nuclear_dataset, 5))

# Plot electric data to bar plot
electric_dataset <- df1 %>%
  select(country, electric_usage) %>%
  arrange(desc(electric_usage))
electric_plot <- ggplot(electric_dataset, aes(x = country, y = electric_usage)) + 
  geom_col() +
  xlab("") + ylab("Terawatt Hours") + 
  ggtitle("Nuclear Power Usage Of The Top Energy Consuming Countries", 
          subtitle="For 2021") + 
  theme(axis.text.x = element_text(angle = 90),
        legend.position = "None") + 
  annotate(geom = "table",
           x = 15,
           y = 1800,
           label = head(electric_dataset, 5))

# Save plot to image
ggsave("hydro-by-country.png", plot = hydro_plot, width = 8, height = 5)
ggsave("nuclear-by-country.png", plot = nuclear_plot, width = 8, height = 5)
ggsave("electric-by-country.png", plot = electric_plot, width = 8, height = 5)
ggsave("wind-by-country.png", plot = wind_plot, width = 8, height = 5)
ggsave("solar-by-country.png", plot = solar_plot, width = 8, height = 5)
ggsave("biofuel-by-country.png", plot = biofuel_plot, width = 8, height = 5)
ggsave("gas-by-country.png", plot = gas_plot, width = 8, height = 5)
ggsave("coal-by-country.png", plot = coal_plot, width = 8, height = 5)
ggsave("oil-by-country.png", plot = oil_plot, width = 8, height = 5)

#
## CLEAN UP ####################################################################
#
rm(list = ls())
pacman::p_unload(all)
cat("\014")
