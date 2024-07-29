-- EDA

-- Looking at Percentage to see how big these layoffs were
SELECT MAX(percentage_laid_off),  MIN(percentage_laid_off)
FROM layoffs
WHERE  percentage_laid_off IS NOT NULL;

-- Which companies had 1 which is basically 100 percent of they company laid off
SELECT *
FROM layoffs
WHERE  percentage_laid_off = 1;
-- these are mostly startups it looks like who all went out of business during this time

-- if we order by funcs_raised_millions we can see how big some of these companies were
SELECT *
FROM layoffs
WHERE  percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- -- Companies with the biggest single Layoff
select company, total_laid_off from layoffs order by total_laid_off desc limit 10;


-- Companies with the most Total Layoffs
select company,sum(total_laid_off) as total_layoff from layoffs group by company order by total_layoff desc limit 10;

-- most layoffs by location
select location,sum(total_laid_off) as total_layoff from layoffs group by location order by total_layoff desc;

-- layoffs by country wise
SELECT country, SUM(total_laid_off)
FROM layoffs
GROUP BY country
ORDER BY 2 DESC;

-- year wise layoffs
select year(`date`),sum(total_laid_off) as total_layoff from layoffs group by year(`date`) order by total_layoff desc limit 10;

-- indusrtry wise layoffs
SELECT industry, SUM(total_laid_off)
FROM layoffs
GROUP BY industry
ORDER BY 2 DESC;

-- stage wise layoffs
SELECT stage, SUM(total_laid_off)
FROM layoffs
GROUP BY stage
ORDER BY 2 DESC;

-- month wise layoffs
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs
GROUP BY dates
ORDER BY dates ASC;

