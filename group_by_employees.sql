-- 각 사원별로 평균연봉 출력
  SELECT emp_no, avg(salary)
    FROM salaries
GROUP BY emp_no
ORDER BY 2 DESC; -- = ORDER BY avg(salary) DESC;

-- 각 현재 Manager 직책 사원에 대한 평균 연봉은?
  SELECT emp_no, avg(salary)
    FROM salaries
   WHERE emp_no IN ( SELECT emp_no -- IN() == =ANY()
		    		   FROM dept_manager
				      WHERE to_date = '9999-01-01' )
GROUP BY emp_no;

-- SELECT avg(salary)
-- FROM salaries
-- WHERE to_date = '9999-01-01'
-- AND emp_no IN (
-- SELECT emp_no -- IN() == =ANY()
-- FROM dept_manager
-- WHERE to_date = '9999-01-01' );

-- 사원별 몇 번의 직책 변경이 있었는지 조회
  SELECT emp_no, COUNT(title)
    FROM titles
GROUP BY emp_no;
-- 가장 많은 직책 변경 수
-- 표준쿼리 적용 방법
SELECT MAX(a.cnt_title)
  FROM ( SELECT emp_no, COUNT(title) as cnt_title
           FROM titles
       GROUP BY emp_no ) a;
-- MySQL 적용 방법 : LIMIT를 오라클에서 지원하지 않기 때문에
-- MAX()와 다르게 처리 과정이 가장 마지막이므로 리소스 소모가 MAX() 대비 많음
  SELECT emp_no, COUNT(title)
    FROM titles
GROUP BY emp_no
ORDER BY 2 DESC LIMIT 1; 

-- 각 사원별로 평균연봉 출력하되 50,000불 이상인 직원만 출력
  SELECT emp_no, AVG(salary)    
    FROM salaries
GROUP BY emp_no
  HAVING AVG(salary) > 50000
ORDER BY AVG(salary) ASC;

-- 현재 직책별로 평균 연봉과 인원수를 구하되 직책별로 인원이 100명 이상인 직책만 출력하세요.
  SELECT title, COUNT(*)
    FROM titles
   WHERE to_date = '9999-01-01'
GROUP BY title
  HAVING COUNT(*) > 1000;
