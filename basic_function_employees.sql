-- 문자형 함수
SELECT ucase('Seoul'), upper('Seoul');
SELECT LOWER('SEoul'), LCASE('seOUL');
SELECT SUBSTRING('Happy Day',3,2);

SELECT concat( first_name, ' ', last_name ) AS 이름,
	 hire_date AS 입사일
FROM employees
WHERE substring( hire_date, 1, 4) = '1986';

SELECT LPAD('hi', '10', '*');
SELECT RPAD('hi', '10', '*');

-- cast() : Type casting
SELECT emp_no, LPAD( cast(salary as char), 10, '*') -- LPAD가 문자형 함수이기 때문에 타입 캐스팅
  FROM salaries     
 WHERE from_date like '2001-%'       
   AND salary < 70000;

SELECT LTRIM(' hello '), RTRIM(' hello '); 
SELECT TRIM(' hi '), TRIM(BOTH 'x' FROM 'xxxh ixxx');

SELECT concat('----', TRIM(' hi '), '----');

SELECT emp_no, TRIM(LEADING '*' from LPAD( cast(salary as char), 10, '*')) -- LPAD가 문자형 함수이기 때문에 타입 캐스팅
  FROM salaries     
 WHERE from_date like '2001-%'       
   AND salary < 70000;



-- 숫자형 함수
SELECT ABS(2), ABS(-2);
SELECT MOD(234,10), 253 % 7, MOD(29,9);
SELECT FLOOR(1.23), FLOOR(-1.23);
SELECT CEILING(1.23), CEILING(-1.23);
SELECT ROUND(-1.23), ROUND(-1.58), ROUND(1.58);
SELECT POW(2,2),POWER(2,-2);
SELECT POW(2, 0.5), SQRT(2);
SELECT SIGN(-32), SIGN(0), SIGN(234); 
SELECT GREATEST(2,0),GREATEST(4.0,3.0,5.0),GREATEST("B","A","C");

-- 날짜형 함수
SELECT CURDATE(), CURRENT_DATE;
SELECT NOW(), SYSDATE(), CURRENT_TIMESTAMP;
SELECT first_name, DATE_FORMAT(hire_date, '%Y-%M-%D %h:%i:%s')
  FROM employees;
  
SELECT DATE_FORMAT(now(), '%W %D %M %y %h:%i:%s');

-- PERIOD_DIFF(p1,p2) : YYMM이나 YYYYMM으로 표기되는 p1과 p2의 차이 개월을 반환 한다.
-- 예제 : 각 직원들에 대해 직원이름과 근무개월수 출력
SELECT first_name,
	   PERIOD_DIFF( DATE_FORMAT(CURDATE(), '%Y%m'),
					DATE_FORMAT(hire_date, '%Y%m') )
  FROM employees;
  
-- 예제 : 각 직원들은 입사 후 6개월이 지나면 근무평가를 한다.
-- 		 각 직원들의 이름, 입사일, 최초 근무평가일은 언제인지 출력
SELECT first_name,
	   hire_date,
       DATE_ADD(hire_date, INTERVAL 6 MONTH) as '근무평가일'
  FROM employees;

SELECT cast(now() as date);


-- 예제 : salaries 테이블에서 사번이 10060인 직원의 급여 평균과 총 합계를 출력
SELECT AVG(salary) as '급여평균', SUM(salary) as '총합'
FROM salaries
WHERE emp_no = 10060;

SELECT from_date
  FROM salaries
 WHERE emp_no = 10060
   AND salary in (93188, 74686);

SELECT MIN(salary), MAX(salary)
  FROM salaries
 WHERE emp_no = 10060;
 

-- SELECT from_date
--  FROM salaries
-- WHERE emp_no = 10060
--   AND salary IN ( SELECT MIN(salary), MAX(salary)
					-- FROM salaries
				   -- WHERE emp_no = 10060 );
-- 다중 로우에 대해 IN 연산이 가능.
-- 위 문제 해결 -> Equi join
SELECT a.*
  FROM salaries a,
       ( SELECT MIN(salary) as MIN_SALARY,
		        MAX(salary) as MAX_SALARY
		   FROM salaries
		  WHERE emp_no = 10060 ) b
 WHERE emp_no = 10060
   AND (a.salary = b.MIN_SALARY OR a.salary = b.MAX_SALARY);
