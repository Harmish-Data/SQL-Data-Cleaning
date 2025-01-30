# Data Cleaning Project: Layoffs Dataset

This project focuses on cleaning and preparing a dataset related to company layoffs. The dataset contains information about companies, their locations, industries, the number of employees laid off, the percentage of layoffs, dates, stages of the company, countries, and funds raised. The goal of this project is to clean the dataset by removing duplicates, standardizing data, handling null or blank values, and removing unnecessary columns.

## Dataset Overview
The dataset used in this project is `layoffs.csv`, which contains the following columns:
- `company`: Name of the company.
- `location`: Location of the company.
- `industry`: Industry of the company.
- `total_laid_off`: Total number of employees laid off.
- `percentage_laid_off`: Percentage of employees laid off.
- `date`: Date of the layoff.
- `stage`: Stage of the company (e.g., Post-IPO, Series B, etc.).
- `country`: Country where the company is located.
- `funds_raised_millions`: Funds raised by the company in millions.

## Project Steps

### 1. **View the Data**
The first step was to view the raw data to understand its structure and identify potential issues.

```sql
SELECT *
FROM layoffs;
```

### 2. **Remove Duplicates**
To ensure data integrity, duplicates were removed. A staging table (`layoffs_staging`) was created to work on the data without affecting the original dataset.

```sql
CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT layoffs_staging 
SELECT *
FROM layoffs;
```

A new column (`row_num`) was added to identify duplicate rows using the `ROW_NUMBER()` window function.

```sql
SELECT *,
ROW_NUMBER() OVER(PARTITION BY location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;
```

Duplicates were then removed using a Common Table Expression (CTE) and a new table (`layoffs_staging2`) was created to store the cleaned data.

```sql
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

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;
```

### 3. **Standardize the Data**
The data was standardized to ensure consistency. This included trimming whitespace, correcting industry names, and fixing country names.

```sql
UPDATE layoffs_staging2
SET company = TRIM(company);

UPDATE layoffs_staging2
SET industry = TRIM(industry);

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';
```

### 4. **Handle Null or Blank Values**
Null and blank values were addressed, particularly in the `industry` column. Missing industry values were populated using a self-join.

```sql
UPDATE layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
    ON t1.company = t2.company
    AND t1.location = t2.location
SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;
```

### 5. **Remove Unnecessary Columns**
Finally, the `row_num` column, which was used to identify duplicates, was removed as it was no longer needed.

```sql
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;
```

## Conclusion
This project demonstrates the process of cleaning and preparing a dataset for analysis. The steps included removing duplicates, standardizing data, handling null or blank values, and removing unnecessary columns. The cleaned dataset is now ready for further analysis or visualization.

## Skills Demonstrated
- **SQL**: Data manipulation, window functions, joins, and updates.
- **Data Cleaning**: Handling duplicates, null values, and standardization.
- **Database Management**: Creating and modifying tables in SQL.
