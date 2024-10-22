SELECT * FROM imdb.messy_imdb_dataset;

ALTER TABLE messy_imdb_dataset
RENAME COLUMN `Content Rating` to Rating;

select *, row_number() over(partition by Title_id, Movie_title, Release_date, Genre, Duration, Country, Rating, Director, Income, Votes, Score) as row_num
from imdb.messy_imdb_dataset;


with duplicate_cte as
(
select *, row_number() over(partition by Title_id, Movie_title, Release_date, Genre, Duration, Country, Rating, Director, Income, Votes, Score) as row_num
from imdb.messy_imdb_dataset
)
select * from duplicate_cte
where row_num > 1;

SELECT * FROM messy_imdb_dataset;


select *
from messy_imdb_dataset
where country like 'US%';


update messy_imdb_dataset
set Country = 'USA'
where Country like 'US%';

select *
from messy_imdb_dataset
where country like '%Germany%';



update messy_imdb_dataset
set Country = 'Germany'
where Country like '%Germany%';

SELECT * FROM messy_imdb_dataset;

select *
from messy_imdb_dataset
where Rating like '#N/A%';

update messy_imdb_dataset
set Rating = 'Not Rated'
where Rating like '#N/A%';


select Director,trim(Director)
from messy_imdb_dataset;


update messy_imdb_dataset
set Director = trim(Director);

SELECT * FROM messy_imdb_dataset;


select *
from messy_imdb_dataset
where Release_date like '%feb%';

update messy_imdb_dataset
set Release_date = '2022-02-04'
where Release_date like '%feb%';


select title_id, trim(Title_id)
from messy_imdb_dataset;

update messy_imdb_dataset
set title_id = trim(title_id);

select Release_date, str_to_date(Release_date, '%Y/%m/%d')
from messy_imdb_dataset;

select *
from messy_imdb_dataset
where Release_date like '10-29-99';

update messy_imdb_dataset
set Release_date = '1976/13/24'
where Release_date like '1976-13-24';


select * from messy_imdb_dataset;

update messy_imdb_dataset
set duration = 124
where Movie_title like 'Star Wars: Episode V - The Empire Strikes Back%';

SELECT  CONCAT(duration, ' ', 'mins') as duration2
FROM messy_imdb_dataset;

update messy_imdb_dataset
set duration = CONCAT(duration, ' ', 'mins');

select income from messy_imdb_dataset;




select *, replace(income, '$', '') as income2 from messy_imdb_dataset;


CREATE TABLE `messy_imdb_dataset2` (
  `Title_id` text,
  `Movie_title` text,
  `Release_date` text,
  `Genre` text,
  `Duration` text,
  `Country` text,
  `Rating` text,
  `Director` text,
  `Income` text,
  `Votes` text,
  `Score` text,
  `income2` text
  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from messy_imdb_dataset2;
insert into messy_imdb_dataset2
select *, replace(income, '$', '') as income2 from messy_imdb_dataset;


select concat('$', format(income2, 0)) as income3 from messy_imdb_dataset2;



CREATE TABLE `messy_imdb_dataset3` (
  `Title_id` text,
  `Movie_title` text,
  `Release_date` text,
  `Genre` text,
  `Duration` text,
  `Country` text,
  `Rating` text,
  `Director` text,
  `Income` text,
  `Votes` text,
  `Score` text,
  `income2` text,
  `income3` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into messy_imdb_dataset3
select *, concat('$', format(income2, 0)) as income3 from messy_imdb_dataset2;

select * from messy_imdb_dataset3;

ALTER TABLE messy_imdb_dataset3
DROP COLUMN income2;

ALTER TABLE messy_imdb_dataset3
RENAME COLUMN income3 TO Income;

select votes from messy_imdb_dataset3;


update messy_imdb_dataset3
set score = 8.7
where score like '++8.7';

select *, replace(votes, '.', ',') as votes2 from messy_imdb_dataset3;


CREATE TABLE `messy_imdb_dataset4` (
  `Title_id` text,
  `Movie_title` text,
  `Release_date` text,
  `Genre` text,
  `Duration` text,
  `Country` text,
  `Rating` text,
  `Director` text,
  `Votes` text,
  `Score` text,
  `Income` text,
  `votes2` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
insert into messy_imdb_dataset4
select *, replace(votes, '.', ',') as votes2 from messy_imdb_dataset3;


select * from messy_imdb_dataset4;


ALTER TABLE Employees MODIFY COLUMN empName VARCHAR(50) AFTER department;

alter table messy_imdb_dataset4
rename column votes2 to Votes;


ALTER TABLE messy_imdb_dataset4 MODIFY COLUMN Votes VARCHAR(50) AFTER Income;


DELETE FROM messy_imdb_dataset4 WHERE Title_id='' and Movie_title = '';