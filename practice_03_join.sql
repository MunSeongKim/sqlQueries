-- 1. 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력하시오.
 SELECT a.emp_no as '사번',
        concat(first_name, ' ', last_name) as '이름',
        b.salary as '연봉'
   FROM employees a, salaries b
  WHERE a.emp_no = b.emp_no
	AND b.to_date = '9999-01-01'
ORDER BY 연봉 DESC;

-- 2. 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.
  SELECT a.emp_no as '사번',
         concat(first_name, ' ', last_name) as '이름',
	 	 title as '직책'
    FROM employees a, titles b
   WHERE a.emp_no = b.emp_no
     AND b.to_date = '9999-01-01'
ORDER BY 이름 ASC;

-- 3. 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요.
  SELECT a.emp_no as '사번',
         concat(first_name, ' ', last_name) as '이름',
	 	 c.dept_name as '부서'
    FROM employees a, dept_emp b, departments c
   WHERE a.emp_no = b.emp_no AND b.dept_no = c.dept_no
     AND b.to_date = '9999-01-01'
ORDER BY 이름 ASC;

-- 4. 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.
  SELECT a.emp_no as '사번',
         concat(first_name, ' ', last_name) as '이름',
         b.salary as '연봉',
         c.title as '직책',
         d.dept_name as '부서'
    FROM employees a, salaries b, titles c, departments d, dept_emp e
   WHERE a.emp_no = b.emp_no
     AND a.emp_no = c.emp_no
     AND a.emp_no = e.emp_no
     AND d.dept_no = e.dept_no
     AND b.to_date = '9999-01-01'
     AND c.to_date = '9999-01-01'
     AND e.to_date = '9999-01-01'
ORDER BY 이름 ASC;

-- 5. ‘Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요.
-- (현재 ‘Technique Leader’의 직책으로 근무하는 사원은 고려하지 않습니다.)
-- 이름은 first_name과 last_name을 합쳐 출력 합니다.
SELECT a.emp_no as '사번',
       concat(first_name, ' ', last_name) as '이름'
  FROM employees a, titles b
 WHERE a.emp_no = b.emp_no
   AND b.title = 'Technique Leader'
   AND b.to_date <> '9999-01-01';
   
-- 6. 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.
SELECT concat(first_name, ' ', last_name) as '이름',
       c.dept_name as '부서명',
       b.title as '직책'
  FROM employees a, titles b, departments c, dept_emp d
 WHERE a.emp_no = b.emp_no
   AND a.emp_no = d.emp_no
   AND d.dept_no = c.dept_no
   AND a.last_name LIKE 'S%';
   
-- 7. 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 큰 순서대로 출력하세요.
  SELECT a.emp_no as '사번',
         concat(first_name, ' ', last_name) as '이름',
         b.title as '직책',
         c.salary as '급여'
    FROM employees a, titles b, salaries c
   WHERE a.emp_no = b.emp_no
     AND a.emp_no = c.emp_no
     AND c.to_date = '9999-01-01'
     AND b.to_date = '9999-01-01'
     AND c.salary >= 40000
     AND b.title = 'Engineer'
ORDER BY c.salary DESC;

-- 8. 현재 급여가 50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력하시오.
  SELECT a.title as '직책',
		 b.salary as '급여'
    FROM titles a, salaries b, employees c
   WHERE a.emp_no = c.emp_no
     AND b.emp_no = c.emp_no
     AND b.salary >= 50000
     AND b.to_date = '9999-01-01'
ORDER BY b.salary DESC;

-- 9. 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.
  SELECT a.dept_name as '부서', 
         AVG(d.salary) as '평균 연봉'
    FROM departments a, dept_emp b, employees c, salaries d
   WHERE a.dept_no = b.dept_no
     AND b.emp_no = c.emp_no
     AND c.emp_no = d.emp_no
     AND d.to_date = '9999-01-01'
     AND b.to_date = '9999-01-01'
GROUP BY a.dept_name
ORDER BY AVG(d.salary) DESC;

-- 10. 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.
  SELECT a.title as '직책', 
         AVG(d.salary) as '평균 연봉'
    FROM titles a, employees c, salaries d
   WHERE a.emp_no = c.emp_no
     AND c.emp_no = d.emp_no
     AND d.to_date = '9999-01-01'
     AND a.to_date = '9999-01-01'
GROUP BY a.title
ORDER BY AVG(d.salary) DESC;
    