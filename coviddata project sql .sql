use coviddata;
Select * from coviddeath
Select location, max(total_deaths) as deaths , continent
from coviddeath 
where continent is not null
Group by location, continent
order by deaths desc

#select the data we are going to use 

select location, cast(Date as Datetime), total_cases, new_cases, total_deaths, population 
from coviddeath
order by 1,2

#check total cases vs. total deaths 

select Location, population, Total_cases, Total_deaths
, (total_deaths/total_cases)*100 as Deathpercentage
from coviddeath
where continent is not null
order by 1,2

# how to check infectionrate in united states

select Location, population
,Total_cases,  (total_cases/population)*100 as infectionrate
from coviddeath
where location like "%states%"
order by infectionrate

#looking at countries with highest infection rate compared to population

select Location, population
,max(Total_cases) as highestinfectioncount,  
max((total_cases/population))*100 as highestinfectionrate
from coviddeath 
Group by location, population
order by highestinfectioncount desc

#showing countries with highest death count per population

select Location ,max(Total_deaths) as highestdeathcount
from coviddeath 
where continent is not null
Group by location
order by highestdeathcount desc

# showing the continent with the highest death count

select continent ,max(Total_deaths) as highestdeathcount
from coviddeath 
where continent is not null
Group by continent
order by highestdeathcount desc

# global no. by date

select Date  , sum(new_cases) as totalcases, sum(new_deaths)as totaldeath,
 (sum(new_deaths)/sum(new_cases))*100 as totaldeathpercentage
 from coviddeath
 group by Date
 order by totaldeathpercentage desc
 
 #looking at total population vs. vaccinations
 
 with popvsvac (continent, location, date, population
 , new_vacinations, rollingpeoplevaccinated)as
 (
 select death.continent, death.location, 
 death.date, death.population, vacc.new_vaccinations,
 sum(vacc.new_vaccinations)  
 over (partition by death.location order by death.location, death.date) as rollingpeoplevaccinated
 from coviddeath death
 join covidvaccination vacc
 on death.location= vacc.location
 and death.date= vacc.date
 where death.continent is not null

 )
 select * ,
 (rollingpeoplevaccinated/population)
 from popvsvac
 
 #temp Table
 
 create Table percentpopulationvaccinated
 (continent varchar(255),
 location varchar(255),
 Date datetime,
 population numeric, 
 new_vaccinations text,
 rollingpeoplevaccinated numeric
 );
 
 insert into percentpopulationvaccinated
  (
  select death.continent, death.location, 
 death.date, death.population, vacc.new_vaccinations,
 sum(vacc.new_vaccinations)  
 over (partition by death.location order by death.location, death.date) as rollingpeoplevaccinated
 from coviddeath death
 join covidvaccination vacc
 on death.location= vacc.location
 and death.date= vacc.date
 where death.continent is not null)
 
 select * , (rollingpeoplevaccinated/population)*100 
 from percentpopulationvaccinated 
 
 create view percentpopulationvaccinated1 as
 select death.continent, death.location, 
 death.date, death.population, vacc.new_vaccinations,
 sum(vacc.new_vaccinations)  
 over (partition by death.location order by death.location, death.date) as rollingpeoplevaccinated
 from coviddeath death
 join covidvaccination vacc
 on death.location= vacc.location
 and death.date= vacc.date
 where death.continent is not null
 
 # to check View
 select * from percentpopulationvaccinated1
  
 

