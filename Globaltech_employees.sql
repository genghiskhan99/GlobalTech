SET SQL_SAFE_UPDATES = 0;

alter table globaltech_solutions RENAME to employees;

#  Creating staging table


select * from employees_duplicate;

create table employees_duplicate like employees;


insert into employees_duplicate 
select * from employees;

;

select * from employees;


# data cleaning



SELECT 
    count(*) `no`,
    count(*) `first name`,
    count(*) `last name`,
    count(*) `Gender`,
    count(*) `start date`,
    count(*) `years`,
    count(*) `department`,
    count(*) `country`,
    count(*) `center`,
    count(*) `monthly salary`,
    count(*) `annual salary`,
    count(*) `job rate`,
    count(*) `sick leaves`,
    count(*) `unpaid leaves`,
    count(*) `overtime hours`
from employees_duplicate;




-- Finding Null values

SELECT 
    count(*) - count(`no`) as no_nulls ,
    count(*) - count( `first name`) as first_name_nulls,
    count(*) -count( `last name`) as last_name_nulls,
    count(*) - count(`Gender`) as gender_nulls,
    count(*) - count(`start date`) as start_date_nulls,
    count(*) - count(`years`) as years_nulls,
    count(*) - count(`department`) as department_nulls,
    count(*) - count( `country`) as country_nulls,
    count(*) - count(`center`) as center_nulls,
    count(*) - count( `monthly salary`) as monthly_salary_nulls,
    count(*) - count(`annual salary`) as annual_salary_nulls,
    count(*) - count(`job rate`) as job_rate_nulls,
    count(*) - count(`sick leaves`) as sick_leave_nulls,
    count(*) - count(`unpaid leaves`) as unpaid_leaves_nulls,
    count(*) - count( `overtime hours`) as overtime_nulls
from employees_duplicate;


-- Finding duplicates;

select `first name`, 
	`last name`,
    `gender`,
    `start date`,
    `country`,
    count(*) as record_count
from employees_duplicate

group by `first name`, 
	`last name`,
    `gender`,
    `start date`,
    `country`
having count(*) > 1
order by record_count asc
;


select * from employees_duplicate;


SELECT DISTINCT `Start Date`
FROM employees_duplicate
LIMIT 10;

ALTER TABLE employees_duplicate
ADD COLUMN `Start Date_New` DATE;

UPDATE employees_duplicate
SET `Start Date_New` = STR_TO_DATE(`Start Date`, '%Y-%m-%d')
WHERE `Start Date` IS NOT NULL;

SELECT `Start Date`, `Start Date_New`
FROM employees_duplicate
LIMIT 10;

ALTER TABLE employees_duplicate
DROP COLUMN `Start Date`,
CHANGE COLUMN `Start Date_New` `Start Date` DATE;

SELECT 
    *
FROM
    employees_duplicate
where (`Annual Salary` - (`Monthly Salary`*12)) > 1;

select distinct gender 
from employees_duplicate;


# Data Extraction

-- Salary by department

SELECT 
    department, AVG(`Monthly Salary`) as avg_monthly_salary, AVG(`Annual Salary`) as avg_annual_salary
FROM
    employees_duplicate
    group by department;
    
select distinct department
from employees_duplicate;

-- Salary by Country

SELECT 
    country, avg(`monthly salary`) as avg_montly_salary, avg(`annual salary`) as avg_annual_salary
FROM
    employees_duplicate
    group by country
    ;
    
    
-- Gender Pay Gap 

SELECT 
    department, gender, avg(`annual salary`) as avg_annual_salary, avg(`monthly salary`) as avg_monthly_salary
FROM
    employees_duplicate
group by  department, gender
 ;


-- Correlation with Job ratings and Overtime

SELECT 
    `job rate`, AVG(`Overtime Hours`) as avg_overtime, avg(`monthly salary`) as avg_monthly_salary, avg(`annual salary`) as avg_annual_salary
FROM
    employees_duplicate
    group by `job rate`
    ;



SELECT 
    department, count(*) as dept_count
FROM
    employees_duplicate
    group by department
    order by dept_count desc;


select * from employees_duplicate;

    


