use covid_deaths;



-- most covid cases & percentage of most covid cases by country

select  location, population, max(total_cases) as total_cases,
max(total_cases/population)*100 as percentage_total_cases
from covid_death
where continent is not null
group by location, population
order by location, total_cases ;




-- most covid deaths & percentage of covid deaths by country

select  location, population, max(cast(total_deaths as int)) as total_death, 
max(cast(total_deaths as int) /population)*100 as percentage_total_deaths
from covid_death
where continent is not null
group by location, population
order by location, total_death ;



-- most covid vaccination & percentage of vaccination by country

select location, population, max(cast(total_vaccinations as numeric)) as total_vaccination,
max(cast(total_vaccinations as numeric)/population)*100 as percentage_of_vaccination
from covid_vaccination
where continent is not null
group by location, population
order by location, total_vaccination desc



-- looking at total cases vs total deaths in India

select location, date, population, total_cases, total_deaths, 
(total_deaths/total_cases)*100 as percentage_deaths
from covid_death
where location = 'india'
order by location, date
;



-- looking at total cases vs the population in India

select location, date, population, total_cases, (total_cases/population)*100 as percentage_total_cases
from covid_death
where location = 'india'
order by location, date
;




-- looking at continent with highest death count 

select location, max(cast(total_deaths as int)) as [total deaths count]
from covid_death
where continent is  null
group by location
order by [total deaths count] desc



-- looking at continent with highest covid cases

select location, max(total_cases) as [total covid cases]
from covid_death
where continent is  null
group by location
order by [total covid cases] desc




-- Global Total cases, Total death, Death Percentage  

select  sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_death, 
sum(CAST(new_deaths as int))/sum(new_cases)*100 as [percentage by death]
from covid_death
where continent is not null
order by 1, 2
;




-- Top 10 country with covid cases, deaths & vaccination

select top 10 d.continent, d.location, d.population, max(d.total_cases) as total_cases,
max(cast(d.total_deaths as int)) as total_deaths,
max(cast(v.total_vaccinations as float)) as total_vaccination
from covid_death as d
join covid_vaccination as v
on d.location = v.location
where d.continent is not null
group by d.continent, d.location, d.population
order by total_cases desc 
;
