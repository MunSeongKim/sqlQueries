-- 1. 최고임금(salary)과  최저임금을 “최고임금, “최저임금”프로젝션 타이틀로 함께 출력해 보세요.
-- 두 임금의 차이는 얼마인가요? 함께 “최고임금 – 최저임금”이란 타이틀로 출력해 보세요.
SELECT MAX(salary) as '최고임금',
       MIN(salary) as '최저임금',
       (MAX(salary) - MIN(salary)) as '최고임금 - 최저임금'
  FROM salaries;
  
-- 2. 마지막으로 신입사원이 들어온 날은 언제입니까? 다음 형식으로 출력해주세요.
SELECT DATE_FORMAT(MAX(hire_date), '%Y년 %m월 %d일') as '최근 사원 입사일'
  FROM employees;
  
-- 3. 가장 오래 근속한 직원의 입사일은 언제인가요? 다음 형식으로 출력해주세요.
SELECT DATE_FORMAT(hire_date, '%Y년 %m월 %d일') as '최장기 근속자 입사일'
  FROM employees
 WHERE hire_date = ( SELECT MIN(from_date)
						FROM salaries
					GROUP BY emp_no
					  HAVING PERIOD_DIFF( DATE_FORMAT(MAX(to_date), '%Y%m%d'),
										DATE_FORMAT(MIN(from_date), '%Y%m%d') )
							 = ( SELECT MAX(a.date)
								  FROM ( SELECT PERIOD_DIFF( DATE_FORMAT(MAX(to_date), '%Y%m%d'),
															 DATE_FORMAT(MIN(from_date), '%Y%m%d') ) as date
										   FROM salaries
									   GROUP BY emp_no ) a ) LIMIT 1) LIMIT 1;
                                       
SELECT DATE_FORMAT(MIN(hire_date), '%Y년 %m월 %d일') as '최장기 근속자 입사일'
  FROM employees;
                   
-- 4. 현재 이 회사의 평균 연봉은 얼마입니까?
SELECT AVG(salary) as '평균 연봉'
  FROM salaries
 WHERE to_date = '9999-01-01';
 
-- 5. 현재 이 회사의 최고/최저 연봉은 얼마입니까?
SELECT MAX(salary) as '최고 연봉',
       MIN(salary) as '최저 연봉'
  FROM salaries
 WHERE to_date = '9999-01-01';
 
-- 6. 최고 어린 사원의 나이와 최 연장자의 나이는?
SELECT MIN(DATE_FORMAT(now(), '%Y')-DATE_FORMAT(birth_date, '%Y')) as '최연소자 나이',
       MAX(DATE_FORMAT(now(), '%Y')-DATE_FORMAT(birth_date, '%Y')) as '최연장자 나이'
  FROM employees;