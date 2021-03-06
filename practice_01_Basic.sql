-- 1. 사번이 10944인 사원의 이름은(전체 이름)
SELECT CONCAT(first_name, ' ', last_name)
  FROM employees
 WHERE emp_no = 10944;
 
-- 2. 전체직원의 다음 정보를 조회하세요. 가장 선임부터 출력이 되도록 하세요.
--    출력은 이름, 성별, 입사일 순서이고 "이름", "성별", "입사일"로 컬럽이름을 대체해 보세요.
  SELECT CONCAT(first_name, ' ', last_name) as '이름',
	     gender as '성별',
         hire_date as '입사일'
    FROM employees
ORDER BY hire_date ASC;

-- 3. 여직원과 남직원은 각각 몇 명이나 있나요?
SELECT ( SELECT COUNT(*)
		   FROM employees
		  WHERE gender = 'm' ) as '남직원 수',
	   ( SELECT COUNT(*)
           FROM employees
		  WHERE gender = 'f' ) as '여직원 수';

   SELECT gender, COUNT(*) as count
     FROM employees
 GROUP BY gender;

-- 4. 현재 근무하고 있는 직원 수는 몇 명입니까?
SELECT COUNT(DISTINCT emp_no) as '직원 수'
  FROM salaries
 WHERE to_date LIKE '9999%';
 
-- 5. 부서는 총 몇개가 있나요?
SELECT COUNT(*) as '부서 수'
  FROM departments;
  
-- 6. 현재 부서 매니저는 몇 명이나 있나요?
SELECT COUNT(*) as '매니저 수'
  FROM dept_manager
 WHERE to_date > now();

-- 7. 전체 부서를 출력하려고 합니다. 순서는 부서이름이 긴 순서대로 출력해 보세요.
SELECT *
  FROM departments
ORDER BY LENGTH(dept_name) DESC;

-- 8. 현재 급여가 120,000이상 받는 사원은 몇 명이나 있습니까?
SELECT COUNT(*)
  FROM salaries
 WHERE salary >= 120000 AND to_date LIKE '9999%';
 
-- 9. 어떤 직책들이 있나요? 중복 없이 이름이 긴 순서대로 출력해 보세요.
  SELECT DISTINCT title
    FROM titles
ORDER BY LENGTH(title) DESC;

-- 10. 현재 Engineer 직책의 사원은 총 몇 명입니까?
SELECT COUNT(DISTINCT emp_no)
  FROM titles
 WHERE title LIKE 'Engineer';

-- 11. 사번이 13250(Zeydy)인 직원의 직책 변경 상황을 시간순으로 출력해보세요.
  SELECT *
    FROM titles
   WHERE emp_no = 13250
ORDER BY from_date ASC;
