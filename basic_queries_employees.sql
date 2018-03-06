SELECT dept_no, dept_name
FROM departments;

SELECT first_name, gender, last_name
FROM employees;

SELECT first_name as '이름', gender as '성별', last_name as '성'
FROM employees;

SELECT CONCAT(first_name, ' ', last_name) as '이름', gender as '성별'
FROM employees;

SELECT DISTINCT title
FROM titles;


-- 예제 : employees 테이블에서 1991년 이전에 입사한 직원의 이름, 성별, 입사일을 출력
SELECT CONCAT(first_name, ' ', last_name),
	gender,
	hire_date
FROM employees
WHERE hire_date < '1991-00-00';

-- 예제 : employees 테이블에서 1989년 이전에 입사한 여직원의 이름, 입사일을 출력
SELECT CONCAT(first_name, ' ', last_name) as '이름',
	hire_date as '입사일'
FROM employees
WHERE hire_date < '1989-00-00' AND gender = 'f'
ORDER BY hire_date DESC;

-- 예제 : dept_emp 테이블에서 부서 번호가 d005나 d009에 속한 사원의 사번, 부서번호 출력
SELECT emp_no, dept_no
FROM dept_emp
WHERE dept_no in ('d005', 'd009');

-- 예제 : employees 테이블에서 1989년에 입사한 직원의 이름, 입사일을 출력
SELECT first_name, 
	hire_date
FROM employees
WHERE hire_date LIKE '1989%';

-- 예제를 산술비교 연산자를 사용한 SQL문으로 변경해 보세요
SELECT first_name, 
	hire_date
FROM employees
WHERE hire_date <= '1989-12-31'
	and hire_date >= '1989-01-01';
    
-- 예제 : employees 테이블에서 직원의 전체이름,  성별, 입사일을  입사일 순으로 출력
  SELECT first_name,
	     gender,
         hire_date
    FROM employees
ORDER BY hire_date ASC, gender ASC, first_name ASC;

-- 예제 : salaries 테이블에서 2001년 월급을 가장 높은순으로 사번, 월급순으로 출력
  SELECT emp_no, salary
    FROM salaries
   WHERE from_date like '2001-%'
ORDER BY salary DESC;
