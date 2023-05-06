-- Create view to examine countries that use all energy sources: 
--  biofuel, solar, gas, oil, hydro, nuclear, wind
DROP VIEW IF EXISTS All_Energy_Countries;
CREATE VIEW All_Energy_Countries AS
SELECT country,
	CAST(hydro_consumption as REAL) AS hydro_usage, 
	CAST(nuclear_consumption as REAL) AS nuclear_usage, 
	CAST(wind_consumption as REAL) AS wind_usage,
	CAST(solar_consumption as REAL) AS solar_usage,
	CAST(biofuel_consumption as REAL) AS biofuel_usage,
	CAST(gas_consumption as REAL) AS gas_usage,
	CAST(coal_consumption as REAL) AS coal_usage, 
	CAST(oil_consumption as REAL) AS oil_usage
FROM energy_data
WHERE year == 2021
	AND iso_code IS NOT NULL
	AND biofuel_consumption IS NOT NULL
	AND solar_consumption IS NOT NULL
	AND gas_consumption IS NOT NULL
	AND coal_consumption IS NOT NULL
	AND oil_consumption IS NOT NULL
	AND hydro_consumption IS NOT NULL
	AND nuclear_consumption IS NOT NULL
	AND wind_consumption IS NOT NULL
GROUP BY country;

-- Examine which countries have highest hydro usage
-- Shows Canada, United States, and China have highest 
--  usage
SELECT country,
	hydro_usage
FROM All_Energy_Countries
ORDER BY hydro_usage DESC;

-- Examine which countries have highest nuclear usage
-- Shows United States, France, Germany have highest 
--  usage
SELECT country,
	nuclear_usage
FROM All_Energy_Countries
ORDER BY nuclear_usage DESC;

-- Examine which countries have highest wind usage
SELECT country,
	wind_usage
FROM All_Energy_Countries
ORDER BY wind_usage DESC;

-- Examine which countries have highest solar usage
SELECT country,
	solar_usage
FROM All_Energy_Countries
ORDER BY solar_usage DESC;

-- Examine which countries have highest biofuel usage
SELECT country,
	biofuel_usage
FROM All_Energy_Countries
ORDER BY biofuel_usage DESC;

-- Examine which countries have highest gas usage
SELECT country,
	gas_usage
FROM All_Energy_Countries
ORDER BY gas_usage DESC;

-- Examine which countries have highest coal usage
SELECT country,
	coal_usage
FROM All_Energy_Countries
ORDER BY coal_usage DESC;

-- Examine which countries have highest oil usage
SELECT country,
	oil_usage
FROM All_Energy_Countries
ORDER BY oil_usage DESC;

-- Examine which countries have highest gdp
DROP VIEW IF EXISTS All_Energy_Countries;
CREATE VIEW All_Energy_Countries AS
SELECT country,
	CAST(hydro_consumption as REAL) AS hydro_usage, 
	CAST(nuclear_consumption as REAL) AS nuclear_usage, 
	CAST(wind_consumption as REAL) AS wind_usage,
	CAST(solar_consumption as REAL) AS solar_usage,
	CAST(biofuel_consumption as REAL) AS biofuel_usage,
	CAST(gas_consumption as REAL) AS gas_usage,
	CAST(coal_consumption as REAL) AS coal_usage, 
	CAST(oil_consumption as REAL) AS oil_usage
FROM energy_data
WHERE year == 2018
	AND iso_code IS NOT NULL
	AND biofuel_consumption IS NOT NULL
	AND solar_consumption IS NOT NULL
	AND gas_consumption IS NOT NULL
	AND coal_consumption IS NOT NULL
	AND oil_consumption IS NOT NULL
	AND hydro_consumption IS NOT NULL
	AND nuclear_consumption IS NOT NULL
	AND wind_consumption IS NOT NULL
GROUP BY country

DROP VIEW IF EXISTS All_GDP_Countries;
CREATE VIEW All_GDP_Countries AS
SELECT country,
	CAST(gdp as REAL) AS GDP
FROM energy_data
WHERE year = 2018
	AND iso_code IS NOT NULL
ORDER BY GDP DESC

SELECT _gdp.country,
	_gdp.GDP,
	energy.solar_usage,
	energy.wind_usage
FROM All_GDP_Countries _gdp
JOIN All_Energy_Countries energy
	ON _gdp.country = energy.country
WHERE GDP IS NOT NULL
