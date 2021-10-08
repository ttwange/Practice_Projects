SELECT *
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
order by 3,4

--SELECT *
--FROM PortfolioProject.dbo.CovidVaccinations
--order by 3,4

--SELECT DATA TO USE
SELECT location,date,total_cases,new_cases,total_deaths,population
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
order by 1,2

--Delete duplicate null total_cases 

delete from PortfolioProject..CovidDeaths
where total_cases is null
and continent is not null

select *
--Total Cases vs total deaths
SELECT location,date,total_cases,total_deaths, (total_deaths/total_cases) * 100 DeathPercentage
FROM PortfolioProject..CovidDeaths 
WHERE location like '%Africa%'
and continent is not null
order by 1,2


--Population affected by covidio at total_case vs population
SELECT location,date,total_cases,population, (total_cases/population) * 100 CasePercentage
FROM PortfolioProject..CovidDeaths 
--WHERE location like '%Africa%'
WHERE continent is not null
order by 1,2

--Countries with highest infection rate compared to population
SELECT location,MAX(total_cases) as HighestInfectionRate,population,MAX((total_cases/population)) * 100 PopulationPercentageInfected
FROM PortfolioProject..CovidDeaths 
--WHERE location like '%Africa%'
WHERE continent is not null
GROUP BY location,population
order by PopulationPercentageInfected desc

--Countries with highest death rate compared to population
SELECT location,MAX(cast(total_deaths as int)) as TotalDeathtCount
FROM PortfolioProject..CovidDeaths 
--WHERE location like '%Africa%'
WHERE continent is not null
GROUP BY location
order by TotalDeathtCount desc


--Continental with highest deathcount
SELECT continent,MAX(cast(total_deaths as int)) as TotalDeathtCount
FROM PortfolioProject..CovidDeaths 
--WHERE location like '%Africa%'
WHERE continent is not null
GROUP BY continent
order by TotalDeathtCount desc


--Global numbers by date
SELECT date,SUM(new_cases) as TotalCase, Sum(cast(new_deaths as int)) as Totaldeath,SUM(cast(new_deaths as int))/SUM(new_cases) * 100 CasePercentage
FROM PortfolioProject..CovidDeaths 
--WHERE location like '%Africa%'
WHERE continent is not null
GROUP BY date
order by 1,2


--Global number summation
SELECT SUM(new_cases) as TotalCase, Sum(cast(new_deaths as int)) as Totaldeath,SUM(cast(new_deaths as int))/SUM(new_cases) * 100 CasePercentage
FROM PortfolioProject..CovidDeaths 
--WHERE location like '%Africa%'
WHERE continent is not null
order by 1,2

--View join table, total population vs vaccination

SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccination
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date =vac.date
WHERE dea.continent is not null
order by 2,3

--use CTE

with PopvsVac(Continent, Location,Date,Population,New_Vaccinations,RollingPeoplevaccinated)
as
(
SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date =vac.date
WHERE dea.continent is not null
--order by 2,3
)
SELECT *,(RollingPeoplevaccinated/Population) * 100
FROM PopvsVac

--TEMP TABLE
Drop Table if exists #PercentPopulaionVaccinated
Create Table #PercentPopulaionVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulaionVaccinated
SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date =vac.date
	WHERE dea.continent is not null
--order by 2,3

SELECT *,(RollingPeoplevaccinated/Population) * 100
FROM #PercentPopulaionVaccinated

--Creating view for later vizualisation

create view PercentPopulaionVaccinated as
SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date =vac.date
	WHERE dea.continent is not null
--order by 2,3
