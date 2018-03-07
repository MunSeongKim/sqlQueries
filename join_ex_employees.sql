-- Equi join
-- employees 테이블과 titles 테이블를 join하여 직원의 이름과 직책을 모두 출력 하세요.
SELECT concat(a.first_name, ' ', a.last_name) AS name,
       b.title
  FROM employees a, titles b
 WHERE a.emp_no = b.emp_no
   AND to_date = '9999-01-01';
   
-- employees 테이블과 titles 테이블를 join하여 직원의 이름과 직책을 출력하되 여성 엔지니어만 출력하세요.
SELECT concat(a.first_name, ' ', a.last_name) AS name,
       b.title,
       a.gender
  FROM employees a, titles b
 WHERE a.emp_no = b.emp_no
   AND to_date = '9999-01-01'
   AND gender = 'F';

-- join ~ on
SELECT concat(a.first_name, ' ', a.last_name) AS name,
       b.title
  FROM employees a
  JOIN titles b on a.emp_no = b.emp_no
 WHERE to_date = '9999-01-01'
   AND gender = 'F';
-- Equi join end

-- Natural join
      SELECT concat(a.first_name, ' ', a.last_name) AS name,
             b.title
        FROM employees a
NATURAL JOIN titles b;

-- join ~ using
SELECT concat(a.first_name, ' ', a.last_name) AS name,
       b.title
  FROM employees a
  JOIN titles b USING(emp_no);

-- 2-9 Q1. 현재 회사 상황을 반영한 직원별 근무부서를 사번, 직원 전체이름, 근무부서 형태로 출력해 보세요.
SELECT a.emp_no,
	   concat(a.first_name, ' ', a.last_name) AS name,
       c.dept_name
  FROM employees a, dept_emp b, departments c
 WHERE a.emp_no = b.emp_no
   AND b.dept_no = c.dept_no
   AND b.to_date = '9999-01-01';
   
-- 2-9 Q2. 현재 회사에서 지급되고 있는 급여체계를 반영한 결과를 출력하세요. 사번, 전체이름, 연봉 이런 형태로 출력하세요.
SELECT a.emp_no,
	   concat(a.first_name, ' ', a.last_name) AS name,
       b.salary
  FROM employees a, salaries b
 WHERE a.emp_no = b.emp_no
   AND b.to_date = '9999-01-01';

-- 현재 Fai Bale이 근무하는 부서에서 근무하는 직원의 사번, 전체 이름, 부서 이름을 출력해보세요. 
SELECT a.emp_no, a.first_name, c.dept_name
  FROM employees a, dept_emp b, departments c
 WHERE a.emp_no = b.emp_no AND b.dept_no = c.dept_no
   AND b.dept_no = ( SELECT b.dept_no
                       FROM employees a, dept_emp b
                      WHERE a.emp_no = b.emp_no
                        AND b.to_date = '9999-01-01'
                        AND CONCAT(a.first_name, ' ', a.last_name) = 'Fai Bale' );
                        
-- 3-4 Q1. 현재 전체사원의 평균 연봉보다 적은 급여를 받는 사원의 이름, 급여를 나타내세요.
SELECT a.first_name, b.salary
  FROM employees a, salaries b
 WHERE a.emp_no = b.emp_no
   AND b.to_date = '9999-01-01'
   AND b.salary < ( SELECT AVG(salary)
                      FROM salaries
                     WHERE to_date = '9999-01-01' )
ORDER BY 2 DESC;

-- 3-4 Q2. 현재 가장적은 평균 급여를 받고 있는 직책의 평균 급여를 구하세요.
SELECT MIN(c.avg_salary) as MIN_AVG_SALARY
  FROM ( SELECT b.title, AVG(a.salary) as avg_salary
           FROM salaries a, titles b
          WHERE a.emp_no = b.emp_no
            AND a.to_date = '9999-01-01'
            AND b.to_date = '9999-01-01'
       GROUP BY b.title ) c;

  SELECT b.title, ROUND(AVG(a.salary)) as avg_salary
    FROM salaries a, titles b
   WHERE a.emp_no = b.emp_no
     AND a.to_date = '9999-01-01'
	 AND b.to_date = '9999-01-01'
GROUP BY b.title
  HAVING avg_salary = ROUND(( SELECT MIN(c.avg_salary) as MIN_AVG_SALARY
						  FROM ( SELECT b.title, AVG(a.salary) as avg_salary
								   FROM salaries a, titles b
								  WHERE a.emp_no = b.emp_no
									AND a.to_date = '9999-01-01'
									AND b.to_date = '9999-01-01'
							   GROUP BY b.title ) c ));
