select * from covidvaccinations;

select * from coviddeaths;

select location, date,new_cases, total_deaths, population 
from coviddeaths order by 1,2;

-- Looking at new cases vs total death
 
select location, date,population,new_cases,total_deaths,(new_cases/total_deaths)*100 as death_percent 
from coviddeaths 
where location Like '%states%' 
order by 1,2 DESC;

-- Looking at new cases vs population
-- Showing what percentage of people got covid 

select location, date,population,new_cases,total_deaths,(new_cases/population)*100 as covid_percent 
from coviddeaths 
where location Like '%states%' 
order by 1,2 DESC;


-- Looking At Countires With Highest Infection rate. 

select location,population,MAX(new_cases) as HighestInfectionCount,MAX((new_cases/population))*100 as PercentPopulationInfected
from coviddeaths 
-- where location Like '%states%' 
group by location,population
order by PercentPopulationInfected DESC;


-- Showing Countries with Highest Death Count Per Population

select location, population, MAX(total_deaths) as TotalDeathsCount from coviddeaths
group by location,population
order by TotalDeathsCount desc;

-- Let's Break Things By Continent

select continent, MAX(total_deaths) as TotalDeathsCount from coviddeaths
group by continent
order by TotalDeathsCount desc;


-- Global Numbers

SELECT date, SUM(new_cases) as TotalNewCases, SUM(CAST(new_deaths AS SIGNED)) as TotalNewDeaths
FROM coviddeaths 
GROUP BY date 
ORDER BY date desc;


-- Looking At Total Populstion vs Total Vaccation

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from coviddeaths dea
join covidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date
