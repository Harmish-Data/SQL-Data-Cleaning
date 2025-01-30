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

### 2. **Remove Duplicates**
To ensure data integrity, duplicates were removed. A staging table (`layoffs_staging`) was created to work on the data without affecting the original dataset.

A new column (`row_num`) was added to identify duplicate rows using the `ROW_NUMBER()` window function.

Duplicates were then removed using a Common Table Expression (CTE) and a new table (`layoffs_staging2`) was created to store the cleaned data.

### 3. **Standardize the Data**
The data was standardized to ensure consistency. This included trimming whitespace, correcting industry names, and fixing country names.

### 4. **Handle Null or Blank Values**
Null and blank values were addressed, particularly in the `industry` column. Missing industry values were populated using a self-join.

### 5. **Remove Unnecessary Columns**
Finally, the `row_num` column, which was used to identify duplicates, was removed as it was no longer needed.

## Conclusion
This project demonstrates the process of cleaning and preparing a dataset for analysis. The steps included removing duplicates, standardizing data, handling null or blank values, and removing unnecessary columns. The cleaned dataset is now ready for further analysis or visualization.

## Skills Demonstrated
- **SQL**: Data manipulation, window functions, joins, and updates.
- **Data Cleaning**: Handling duplicates, null values, and standardization.
- **Database Management**: Creating and modifying tables in SQL.
