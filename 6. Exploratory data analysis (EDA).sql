-- Exploratory data analysis

SELECT *
FROM layoffs_staging2
ORDER BY 1;

SELECT MAX(total_laid_off),MAX(percentage_laid_off)  -- 12000 people were laid off on one go
FROM layoffs_staging2;								-- 100% pple were laid out on one go (company closure)

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off=1          -- All These companies closed down completely
ORDER BY funds_raised_millions DESC;

SELECT company,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY  company
ORDER BY 2 DESC;     -- Amazon has the highest number of lay-off

SELECT MIN(`date`),MAX(`date`)
FROM layoffs_staging2;         -- these layoffs cover the period 03/2020 to 06/2023

SELECT industry,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY  industry       -- consumer and retail were hit very hard by layoffs.  the lowest were manuifacturing and Fin tech with a combined layoff of 225
ORDER BY 2 DESC;    


SELECT country,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY  country            --  The US had the highest number of layoffs followed by India
ORDER BY 2 DESC;    

SELECT  YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY  YEAR(`date`)
ORDER BY 1 DESC;             -- The year 2022 had the highest number of highest number of lay offs

SELECT stage,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY  stage
ORDER BY 2 DESC;    

SELECT company,AVG(total_laid_off)
FROM layoffs_staging2
GROUP BY  company
ORDER BY 2 DESC;    

SELECT SUBSTRING(`date`,6,2) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY SUBSTRING(`date`,6,2)
;

SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7)  IS NOT NULL    -- these are total layoffs per month for the period
GROUP BY `MONTH`
ORDER BY 1 ASC
;

WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7)  IS NOT NULL    -- these are total layoffs per month for the period
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT`MONTH`, total_off,
SUM(total_off) OVER(ORDER BY`MONTH`) AS rolling_total
FROM Rolling_Total           -- This is our rolling total layoff based on months for the period.
;


SELECT company,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY  company
ORDER BY 2 DESC;     

SELECT company,YEAR(`date`), SUM(total_laid_off)   -- Looking at company layoffs by year 
FROM layoffs_staging2
GROUP BY  company,YEAR(`date`);

SELECT company,YEAR(`date`), SUM(total_laid_off)   -- in a descending order 
FROM layoffs_staging2
GROUP BY  company,YEAR(`date`)
ORDER BY 3 DESC;

-- We created our First CTE
WITH Company_Year (company,years,total_laid_off) AS
(
SELECT company,YEAR(`date`), SUM(total_laid_off)   -- 
FROM layoffs_staging2
GROUP BY  company,YEAR(`date`)
), Company_Year_Rank AS   -- This is the 2nd CTE
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank      -- This ranks the top 5 companies who  layed off moost people per year for the 3 year period
WHERE Ranking <=5
;

-- END OF THE EDA 



