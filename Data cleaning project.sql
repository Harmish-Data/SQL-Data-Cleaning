-- data cleaning project --

-- View Data --

SELECT *
FROM layoffs;

-- 1. Remove Duplicates --
-- 2. Standardize the Data --
-- 3. Null Values or blank values --
-- 4. Remove Any Columns --


-- Make Copy of Table --

CREATE TABLE layoffs_staging
LIKE layoffs;

-- Import data from original table --

INSERT layoffs_staging 
SELECT *
FROM layoffs;

-- view data --

SELECT *
FROM layoffs_staging;

-- create extra column for allocating number for unique values --

SELECT *,
row_number() over(partition by
 location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions) as row_num
FROM layoffs_staging;


-- appling cte for viewing duplicate values --

with duplicate_cte as
(SELECT *,
row_number() over(partition by location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions) as row_num
FROM layoffs_staging)
select *
from duplicate_cte 
where row_num >1;


-- create table --

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoffs_staging2;

-- put all the data into the new created table --
insert into layoffs_staging2
SELECT *,
row_number() over(partition by location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging;

-- view the updated data --
select *
from layoffs_staging2
where row_num > 1;

-- deleate duplicate values --

delete
from layoffs_staging2
where row_num > 1;

-- removed file --
select *
from layoffs_staging2
where row_num > 1;

-- staderdizing data -- 
SELECT * 
FROM layoffs_staging2;

select distinct industry
from layoffs_staging2
order by industry;

-- check null vaules in industry -- 
select * 
from layoffs_staging2
where industry is null
or industry = null
order by industry;

select *
from layoffs_staging2
where company like 'Bally%';

-- staderdaze table --

select *
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select industry, trim(industry)
from layoffs_staging2;

update layoffs_staging2
set industry = trim(industry);

select distinct industry
from layoffs_staging2
order by industry;

select distinct industry 
from layoffs_staging2
where industry like "crypto%";

update layoffs_staging2
set industry = 'crypto'
where industry like "crypto%";

-- now all the related things are removed -- 
select distinct industry 
from layoffs_staging2
where industry like "crypto%";

select distinct location 
from layoffs_staging2;

select distinct country 
from layoffs_staging2
where country like "united%";

select distinct country , trim(trailing '.' from country)
from layoffs_staging2;

-- update the country name with fullstop in the end and remove them -- 
update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

select distinct country 
from layoffs_staging2
where country like "united%";

-- date time correction -- 
select `date`,
str_to_date(`date` , '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date` , '%m/%d/%Y');

select `date`
from layoffs_staging2;

-- change data type to date format after setting the format set --
alter table layoffs_staging2
modify column `date` DATE;

-- working with null and blank dataset --

select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging2
where industry is null
or industry = '';

select *
from layoffs_staging2
where company = "Airbnb";

update layoffs_staging2
set industry = null
where industry = '';

select t1.company, t1.industry , t2.company, t2.industry
from layoffs_staging2 as t1
join layoffs_staging2 as t2
on t1.company = t2.company
and t1.location = t2.location
where (t1.industry is null or t1.industry = '')
and t2.industry is not null; 

-- updated all records using self join --

update layoffs_staging2 as t1
join layoffs_staging2 as t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null;

select *
from layoffs_staging2;

select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

-- deleate all the records with null values in the both columns --
delete
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging2;

-- remove no important column --
alter table layoffs_staging2
drop column row_num;

select *
from layoffs_staging2;
