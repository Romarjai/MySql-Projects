-- exploratory data analysis

select *
from layoffs_staging2;

select max(total_laid_off), min(total_laid_off), max(percentage_laid_off), min(percentage_laid_off)
from layoffs_staging2;


select *
from layoffs_staging2
where percentage_laid_off =1 and total_laid_off >= 1000;


select *
from layoffs_staging2
where percentage_laid_off = '';


select *
from layoffs_staging2
where percentage_laid_off =1 and total_laid_off >= 100
order by total_laid_off desc;

 select location, sum(total_laid_off)
 from layoffs_staging2
 group by location
 order by 2 desc;
 
 
 select company, sum(total_laid_off)
 from layoffs_staging2
 group by company
 order by 2 desc;
 
 
  select year(`date`), sum(total_laid_off)
 from layoffs_staging2
 group by year(`date`)
 order by 2 desc;
 
 
select substring(`date`,1,7) as `month`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1;

with rolling_total as
(
select substring(`date`,1,7) as `month`, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1
)
select `month`, total_off, sum(total_off) over(order by `month`) as ROLLING_TOTAL
from rolling_total;




select company, year(`date`), sum(total_laid_off) 
 from layoffs_staging2
 group by company, `date`
 order by 3 desc;
 
 
 with company_year (company, `year`, total_laid_off) as
 (
 select company, year(`date`), sum(total_laid_off) 
 from layoffs_staging2
 group by company, `date`
 order by 3 desc
 ),
 company_year_rank as
 (
 select *, dense_rank() over (partition by `year` order by total_laid_off desc) as ranking
 from company_year
 where company is not null
 and `year` is not null
)
select *
from company_year_rank
where ranking <=5;
