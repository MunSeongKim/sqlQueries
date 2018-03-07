-- 1. 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
SELECT COUNT(*)
  FROM salaries
 WHERE to_date = '9999-01-01'
   AND salary >= ( SELECT AVG(salary)
                     FROM salaries
                    WHERE to_date = '9999-01-01' );

-- 2. 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서, 연봉을 조회하세요.
-- 단, 조회결과는 연봉의 내림차순으로 졍렬되어 나타나야 합니다.

SELECT a.emp_no as '사번',
	   concat(first_name, ' ', last_name) as '이름',
	   d.dept_name as '부서',
	   a.salary as '연봉'
  FROM salaries a,
       dept_emp b,
	   employees c, 
       ( SELECT a.dept_no as dept, MAX(salary) as max_salary, a.dept_name as dept_name
		   FROM departments a, dept_emp b, employees c, salaries d
		  WHERE a.dept_no = b.dept_no
			AND b.emp_no = c.emp_no
			AND c.emp_no = d.emp_no
            AND b.to_date = '9999-01-01'
            AND d.to_date = '9999-01-01'
	   GROUP BY a.dept_name ) d
 WHERE a.emp_no = c.emp_no
   AND b.emp_no = c.emp_no
   AND a.salary = d.max_salary
   AND b.dept_no = d.dept
   AND b.to_date = '9999-01-01'
   AND a.to_date = '9999-01-01'
ORDER BY 연봉 DESC;

-- 3. 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요
SELECT a.emp_no as '사번',
	   concat(first_name, ' ', last_name) as '이름',
	   a.salary as '연봉'
  FROM salaries a,
       dept_emp b,
	   employees c, 
       ( SELECT a.dept_no as dept, ROUND(AVG(salary)) as avg_salary, a.dept_name as dept_name
		   FROM departments a, dept_emp b, employees c, salaries d
		  WHERE a.dept_no = b.dept_no
			AND b.emp_no = c.emp_no
			AND c.emp_no = d.emp_no
            AND b.to_date = '9999-01-01'
            AND d.to_date = '9999-01-01'
	   GROUP BY a.dept_name ) d
 WHERE a.emp_no = c.emp_no
   AND b.emp_no = c.emp_no
   AND a.salary >= d.avg_salary
   AND b.dept_no = d.dept
   AND b.to_date = '9999-01-01'
   AND a.to_date = '9999-01-01'
ORDER BY 3 ASC;
   
-- 4. 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해보세요.
SELECT a.emp_no as '사번',
	   concat(first_name, ' ', last_name) as '이름',
       tmp.full_name as '매니저 이름',
       tmp.dept_name as '부서'
  FROM employees a,
       dept_emp b,
       ( SELECT concat(first_name, ' ', last_name) as full_name,
		        c.dept_name as dept_name,
                c.dept_no as dept_no
		   FROM employees a, dept_manager b, departments c
		  WHERE a.emp_no = b.emp_no
			AND b.dept_no = c.dept_no
			AND b.to_date = '9999-01-01' ) tmp
 WHERE a.emp_no = b.emp_no
   AND b.dept_no = tmp.dept_no
   AND b.to_date = '9999-01-01';
   
-- 5. 현재, 평균 연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
SELECT a.emp_no as '사번',
	   concat(first_name, ' ', last_name) as '이름',
       c.title as '직책',
       d.salary as'연봉'
       -- b.dept_no
  FROM employees a, dept_emp b, titles c, salaries d,
       ( SELECT b.dept_no as dept_no, ROUND(AVG(salary)) as avg_salary
		   FROM departments a, dept_emp b, employees c, salaries d
		  WHERE a.dept_no = b.dept_no
			AND b.emp_no = c.emp_no
			AND c.emp_no = d.emp_no
            AND b.to_date = '9999-01-01'
            AND d.to_date = '9999-01-01'
	   GROUP BY a.dept_name
         HAVING avg_salary = ( SELECT MAX(a.avg_salary)
			  				     FROM ( SELECT a.dept_no as dept, ROUND(AVG(salary)) as avg_salary, a.dept_name as dept_name
								 	      FROM departments a, dept_emp b, employees c, salaries d
									     WHERE a.dept_no = b.dept_no
										   AND b.emp_no = c.emp_no
										   AND c.emp_no = d.emp_no
										   AND b.to_date = '9999-01-01'
										   AND d.to_date = '9999-01-01'
								      GROUP BY a.dept_name ) a ) ) tmp
 WHERE a.emp_no = b.emp_no
   AND a.emp_no = c.emp_no
   AND a.emp_no = d.emp_no
   AND b.dept_no = tmp.dept_no
   AND d.to_date = '9999-01-01'
   AND c.to_date = '9999-01-01'
   AND b.to_date = '9999-01-01'
ORDER BY 연봉 ASC;

-- 6. 평균 연봉이 가장 높은 부서는?
SELECT tmp.dept_name as '최고 평균 연봉 부서'
FROM ( SELECT a.dept_name, ROUND(AVG(salary)) as avg_salary
		 FROM departments a, dept_emp b, employees c, salaries d
		WHERE a.dept_no = b.dept_no
		  AND b.emp_no = c.emp_no
		  AND c.emp_no = d.emp_no
		  AND b.to_date = '9999-01-01'
          AND d.to_date = '9999-01-01'
	 GROUP BY a.dept_name
       HAVING avg_salary = ( SELECT MAX(a.avg_salary)
	    				       FROM ( SELECT a.dept_no as dept, ROUND(AVG(salary)) as avg_salary, a.dept_name as dept_name
								        FROM departments a, dept_emp b, employees c, salaries d
									   WHERE a.dept_no = b.dept_no
										 AND b.emp_no = c.emp_no
										 AND c.emp_no = d.emp_no
										 AND b.to_date = '9999-01-01'
										 AND d.to_date = '9999-01-01'
									GROUP BY a.dept_name ) a ) ) tmp;
                                    
-- 7. 평균 연봉이 가장 높은 직책?
SELECT tmp.title as '최고 평균 연봉 직책'
FROM ( SELECT a.title, ROUND(AVG(salary)) as avg_salary
		 FROM titles a, employees c, salaries d
		WHERE a.emp_no = c.emp_no
		  AND c.emp_no = d.emp_no
		  AND a.to_date = '9999-01-01'
          AND d.to_date = '9999-01-01'
	 GROUP BY a.title
       HAVING avg_salary = ( SELECT MAX(a.avg_salary)
	    				       FROM ( SELECT ROUND(AVG(salary)) as avg_salary
								        FROM titles a, employees c, salaries d
									   WHERE a.emp_no = c.emp_no
										 AND c.emp_no = d.emp_no
										 AND a.to_date = '9999-01-01'
										 AND d.to_date = '9999-01-01'
									GROUP BY a.title ) a ) ) tmp;
                                    
-- 8. 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 매니저 연봉 순으로 출력합니다.
-- 자신의 매니저 보다 높은 연봉을 받는 사람, 현재
SELECT manager.dept_name as '부서이름', 
       concat(a.first_name, ' ', a.last_name) as '사원이름', 
       c.salary as '연봉',
       manager.manager_name as '매니저 이름',
       manager.salary as '매니저 연봉'
  FROM employees a,
       dept_emp b,
       salaries c,
		-- 부서별 현재 매니저의 현재 연봉
	   ( SELECT a.emp_no, b.dept_no, b.dept_name, d.salary, concat(first_name, ' ', last_name) as manager_name
		   FROM employees a, departments b, dept_manager c, salaries d
		  WHERE a.emp_no = c.emp_no
		    AND b.dept_no = c.dept_no
		    AND a.emp_no = d.emp_no
		    AND c.to_date = '9999-01-01'
		    AND d.to_date = '9999-01-01' ) manager
 WHERE a.emp_no = b.emp_no
   AND b.dept_no = manager.dept_no
   AND a.emp_no = c.emp_no
   AND manager.salary < c.salary
   AND c.to_date = '9999-01-01'
   AND b.to_date = '9999-01-01';