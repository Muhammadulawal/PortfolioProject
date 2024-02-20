--------------------------------------------------------
-- Executive Summary--	                               
--------------------------------------------------------

-- Coronavirus  (COVID-19) is an infectious disease caused by the SAR-CoV-2 virus. People infected with the virus experienced
-- mild to moderate respiratory illness and recovered without requiring special treatment, some became seriously ill and required medical
-- attention, Older people and those with underlying medical conditions are more likely to develop serious illness or die at any age.
-- This analysis study the impacts of COVID - 19 in Africa, reviewing how it affected the populations with Africa from January 2020 to December 2023

----------------------------------------------------------------------------------------------------
-- Total Population in Africa | 1,426,736,614, and is the second most populated continent after Asia
----------------------------------------------------------------------------------------------------

SELECT SUM(DISTINCT CONVERT(BIGINT, population)) Total_Population FROM PortfolioProject.dbo.CovidImpact
	WHERE continent = 'Africa';

----------------------------------------------------------------------------------------------
-- Total Number of COVID - 19 cases recorded in Africa | 13,134,519 cases were recorded
----------------------------------------------------------------------------------------------

SELECT SUM(Total_Cases) Total_Cases FROM 		
	(SELECT location, MAX(CONVERT(BIGINT, total_cases)) Total_Cases FROM PortfolioProject.dbo.CovidImpact
	WHERE continent = 'Africa'
	GROUP BY location) as TC;
		
----------------------------------------------------------------------------------------------
-- Total Number of death in Africa due to  COVID - 19 | 259,074 deaths recorded
----------------------------------------------------------------------------------------------

SELECT SUM(total_deaths) Total_Deaths FROM 		
	(SELECT location, MAX(CONVERT(BIGINT, total_deaths)) total_deaths FROM PortfolioProject.dbo.CovidImpact
	WHERE continent = 'Africa'
	GROUP BY location) as TD;
	
--------------------------------------------------------
-- 5 Most affected countries in Africa
--------------------------------------------------------

SELECT TOP 5 location as Country, MAX(CONVERT(BIGINT, total_cases)) as Total_Cases, 
	MAX(CONVERT(BIGINT, total_deaths)) as Total_Deaths FROM PortfolioProject.dbo.CovidImpact
	WHERE continent = 'Africa'
	GROUP BY location
	ORDER BY total_cases DESC;
	
--------------------------------------------------------
-- Percentage of cases to country's population
--------------------------------------------------------

SELECT location as Country, MAX(CONVERT(FLOAT, total_cases))  Total_Cases, MAX(CONVERT(FLOAT, population)) Population,  
	ROUND(MAX(CONVERT(FLOAT, total_cases)) / MAX(CONVERT(FLOAT, population)) * 100, 2) as PercentageByCases 
	FROM PortfolioProject.dbo.CovidImpact
	WHERE continent = 'Africa' 
	GROUP BY location
	ORDER BY PercentageByCases DESC;	

--------------------------------------------------------
-- Percentage of death to country's population
--------------------------------------------------------

SELECT location as Country, MAX(CONVERT(FLOAT, total_deaths))  Total_Deaths, MAX(CONVERT(FLOAT, population)) Population,  
	ROUND(MAX(CONVERT(FLOAT, total_deaths)) / MAX(CONVERT(FLOAT, population)) * 100, 2) as PercentageByPopulation 
	FROM PortfolioProject.dbo.CovidImpact
	WHERE continent = 'Africa' 
	GROUP BY location
	ORDER BY PercentageByPopulation DESC;	
	
--------------------------------------------------------
-- Percentage of death to cases recorded
--------------------------------------------------------

SELECT location as Country, total_deaths as Total_Deaths, total_cases as Total_Cases,  
	ROUND(CONVERT(FLOAT, total_deaths / cast(total_cases as float)) * 100, 2) as PercentageDeathtoCases FROM PortfolioProject.dbo.CovidImpact
	WHERE continent = 'Africa' AND date = '2023/12/31'
	ORDER BY PercentageDeathtoCases DESC;

--------------------------------------------------------
--Total vaccination administered in Africa
--------------------------------------------------------

SELECT SUM(Total_vaccinations) as Total_vaccinations, SUM(Total_People_vaccinated) AS Total_People_vaccinated, 
ROUND(SUM(Total_People_vaccinated)/SUM(Total_vaccinations)* 100,2) AS PercentageOfPeopleVaccinated
	FROM
	(SELECT location, MAX(CONVERT(FLOAT, total_vaccinations)) AS Total_vaccinations, MAX(CONVERT(FLOAT, people_vaccinated))
	 AS Total_People_vaccinated FROM PortfolioProject.dbo.CovidVaccination 
		where continent = 'Africa'
		Group by location) AS a;
	
--------------------------------------------------------
--Total vaccination administered in Africa countries
--------------------------------------------------------

SELECT 
	 location AS Country, MAX(population) AS Total_Population, MAX(CONVERT(INT, total_vaccinations)) AS Total_vaccinations,
	ROUND((MAX(CONVERT(FLOAT, total_vaccinations))/MAX(population)),2) AS PercentageOfVaccination
	FROM PortfolioProject.dbo.CovidVaccination 
	WHERE continent = 'Africa'
	GROUP BY location
	ORDER BY Total_Population DESC;


--------------------------------------------------------
--Total People vaccinated in Africa countries
--------------------------------------------------------

SELECT 
	location AS Country, MAX(population) as Total_Population, MAX(CONVERT(FLOAT, people_vaccinated)) AS Total_People_vaccinated,
	ROUND((MAX(CONVERT(FLOAT, people_vaccinated))/MAX(population)),2) AS PercentageOfPeopleVaccinated
	FROM PortfolioProject.dbo.CovidVaccination 
	WHERE continent = 'Africa'
	GROUP BY location
	ORDER BY Total_Population DESC;

	
--------------------------------------------------------
--	Total People fully vaccinated in Africa countries
--------------------------------------------------------

SELECT 
	 location AS Country, MAX(population) as Total_Population, MAX(CONVERT(INT, people_fully_vaccinated)) AS Total_People_Fully_Vaccinated
	FROM PortfolioProject.dbo.CovidVaccination 
	WHERE continent = 'Africa'
	GROUP BY location
	ORDER BY Total_Population DESC;

--------------------------------------------------------
--	Rate of vaccinations in Africa countries
--------------------------------------------------------

SELECT 
	 location, COUNT(date) as Rate_of_vaccination
	FROM PortfolioProject.dbo.CovidVaccination 
	WHERE continent = 'Africa' AND people_vaccinated <> 0
	GROUP BY location
	ORDER BY Rate_of_vaccination DESC;

