SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name='Leslie';

-- Logical operators
SELECT *
FROM parks_and_recreation.employee_demographics
WHERE age>40 
AND age<50;

SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE (first_name='Leslie' AND age=44) OR age>55;

-- LIKE STATEMENT
-- % everything _ Specific number of characters

SELECT *
FROM employee_demographics
WHERE birth_date Like'%89%';

-- GROUPBY and ORDERBY , HAVING STATEMENTS
SELECT gender
FROM employee_demographics
GROUP BY gender;

SELECT gender,AVG(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING AVG(age) >40;

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 75000
;

-- Limit  specifies how many rows you want in your output

SELECT *
FROM employee_demographics
ORDER BY age DESC       #limiting by age in a descending order
LIMIT 2,1
;

-- Aliasing a way to change the name of a column

SELECT gender,AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender
HAVING AVG (age)> 40
;