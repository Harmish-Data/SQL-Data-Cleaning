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
