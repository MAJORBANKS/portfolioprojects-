/*DATA ANALYTICS PROJECT ON WORLD COVID DATA*/

/*SQL DATA EXPLORATION*/

select* 
from coviddeaths
where continent is not null

/*Totalcovid confirmend cases in Africa by date*/
SELECT continent,date,SUM(new_cases) AS TOTALCOVIDCASES
FROM coviddeaths
WHERE continent = 'Africa'
GROUP BY continent,date

/*Looking at totalcases vs totaldeaths in Africa*/
/*its showing the likelihood of people who where prone to contract covid in Africa*/
Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from coviddeaths
where location = 'africa'
order by 1,2

/*Looking at Total Cases vs Population in Africa*/
/*shows what percentage of population got covid*/
Select Location, date, total_cases,Population, (total_cases/population)*100 as TotalPopulationInfected
from coviddeaths
where location = 'africa'

/*Looking at Countries with highest infection rate compared to population*/
Select Location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 as TotalPopulationInfected
from coviddeaths
/*where location = 'africa'*/
group by location,population
order by 1,2

/*Showing countries with the highest Death count per population*/
Select Location, MAX(TOTAL_deaths) as TotalDeathCount
from coviddeaths
/*where location = 'africa'*/
where continent is not null
group by location
order by 1,2

/*LETS BREAK THINGS DOWN BY CONTINENT*/
/*Showing countries with the highest Death count per population*/
Select continent, MAX(TOTAL_deaths) as TotalDeathCount
from coviddeaths
/*where location = 'africa'*/
where continent is not null
group by continent
order by TotalDeathCount desc

/*GLOBAL NUMBER*/
select date, SUM(new_cases) as TOTALCASES,SUM(new_deaths) as TOTALDEATHS,SUM(new_deaths/new_cases)*100 as DeathPercentage
from coviddeaths
where continent is not null 
group by date
order by 1,2

/*OVERAL TOTAL CASES AND TOTALDEATHS*/
select SUM(new_cases) as TOTALCASES,SUM(new_deaths) as TOTALDEATHS,SUM(new_deaths/new_cases)*100 as DeathPercentage
from coviddeaths
where continent is not null 
order by 1,2

/*looking at total population vs vaccinations*/

select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations,
SUM(vac.new_vaccinations) OVER (Partition by dea.location) as RollingPeopleVaccinated
from coviddeaths dea 
join covidvaccinations vac 
     on dea.location = vac.location
     and dea.date = vac.date
where dea.continent is not null 
order by 2,3

/*USE CTE*/

WITH PopvsVac AS (
    SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
           SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location) AS RollingPeopleVaccinated
    FROM coviddeaths dea
    JOIN covidvaccinations vac
        ON dea.location = vac.location
        AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
    /* order by 2,3 */
)
SELECT *, (RollingPeopleVaccinated/Population)*100
FROM PopvsVac;

/*TEMP TABLE*/

DROP Table if exists #Percentpopulationvaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar (255),
location nvarchar(255),
date datetime,
population numeric
new_vaccinations numeric,
rollingpeoplevaccinated numeric
)

Insert into #PercentPopulationVaccinated
 SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
           SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location) AS RollingPeopleVaccinated
    FROM coviddeaths dea
    JOIN covidvaccinations vac
        ON dea.location = vac.location
        AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL

SELECT *, (RollingPeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinated

DROP Table if exists #Percentpopulationvaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar (255),
location nvarchar(255),
date datetime,
population numeric
new_vaccinations numeric,
rollingpeoplevaccinated numeric
)

Insert into #PercentPopulationVaccinated
 SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
           SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location) AS RollingPeopleVaccinated
    FROM coviddeaths dea
    JOIN covidvaccinations vac
        ON dea.location = vac.location
        AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL

SELECT *, (RollingPeopleVaccinated / Population) * 100 AS PercentPopulationVaccinated
FROM #PercentPopulationVaccinated;


/*CREATING VIEW TO STORE DATA FOR LATER VISUALIZATIONS*/

Create View PercentPopulationVaccinated as 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
           SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location) AS RollingPeopleVaccinated
    FROM coviddeaths dea
    JOIN covidvaccinations vac
        ON dea.location = vac.location
        AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
    /*order by 2,3*/

Select *
from percentpopulationvaccinated

SELECT *, (RollingPeopleVaccinated / Population) * 100 AS PercentPopulationVaccinated
FROM #PercentPopulationVaccinated;








SELECT * 
FROM portfolioproject.covidvaccinations
order by 3,4

/*Selecting data we are about to use*/
SELECT location,date,total_cases,new_cases,total_deaths,population
FROM portfolioproject.coviddeaths
order by 1,2 

/*Shows likelihood of dying if you contract virus*/
/*Looking at Total Cases vs Total Deaths*/
SELECT location,date,total_cases,new_cases,total_deaths,population,(total_deaths/total_cases)*100 as DeathPercentage
FROM portfolioproject.coviddeaths
order by 1,2 

/*Looking at Coountries with Highest infection rate compared to population*/

Select location,population,max(total_cases) as HighestInfectionCount,max((total_cases/population))*100 as percentpopulationinfected 
from portfolioproject.coviddeaths
Group by location,population
order by percentpopulationinfected desc  

select * 
FROM portfolioproject.coviddeaths dea 
Join portfolioproject.covidvaccinations vac 
    on dea.location = vac.location 
    and dea.date = vac.date 
order by 1,2,3







SELECT location,population,max(total_cases) as HighestInfectionCount,max((total_cases/population)) * 100 as percentpopulationinfected
FROM portfolioproject.coviddeaths
GROUP by location, population 
order by percentpopulationinfected desc



SELECT * 
FROM coviddeaths dea 
Joined covidvaccinations vac 
    on dea.location = vac.location 
    and dea.date =, vac.date
    order by 1,2,3 