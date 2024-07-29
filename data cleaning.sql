select * from layoffs;

-- creating bakup table
create table layoffs_bakup like layoffs;

-- moving the data in bkup table
insert into layoffs_bakup (
select * from layoffs
);

-- checking duplicate 
select company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions,count(*) from layoffs 
group by company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions having count(*)>1;

-- DELETING DUPLICATES
DELETE FROM layoffs
WHERE company in(
    SELECT company
    FROM (
        WITH CTE AS (
            SELECT company,
                   ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
            FROM layoffs
        )
        SELECT company
        FROM CTE
        WHERE row_num > 1
    ) AS subquery
)    ;

-- handling null values
select * from layoffs where industry is null or industry = '' ;

update layoffs set industry = null where industry = '';

UPDATE layoffs t1
JOIN layoffs t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

delete from layoffs where company ="Bally's Interactive";

select * from layoffs where total_laid_off is null and percentage_laid_off is null;

delete from layoffs where total_laid_off is null and percentage_laid_off is null;


-- change date data type
UPDATE layoffs
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs
MODIFY COLUMN `date` DATE;

