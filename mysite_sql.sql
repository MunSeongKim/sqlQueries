INSERT
  INTO guestbook
VALUES (null, '안대혁', password('1234'), '안녕하세요.안녕하세요.', DATE_FORMAT('2013-01-15', '%Y-%m-%d %h:%i:%s'));

delete from guestbook where no =1;

SELECT no, name, password, content, DATE_FORMAT(reg_date, '%Y-%m-%d %h:%i:%s')
  FROM guestbook;
  
SELECT * from users;

-- 회원가입
INSERT INTO users
VALUES (null, '둘리', 'dooly@a.com', PASSWORD('1234'), 'male', now());

-- 로그인
SELECT no, name, password
  FROM users
 WHERE email='go@a.com';

-- 수정(회원정보)
UPDATE users
   SET password=PASSWORD('1234')
 WHERE no=2;
 
 
 
 SELECT * FROM board LIMIT 1;
(SELECT IFNULL(MAX(group_no), 0) +1 FROM board);

SELECT board.no,
	   board.title,
       board.content,
       board.hit_count,
       board.reg_date,
       board.group_no,
       board.order_no,
       board.depth,
       board.user_no,
       users.name
  FROM board, users
 WHERE board.user_no = users.no
ORDER BY group_no DESC, order_no ASC
   LIMIT 20, 10;

-- 글쓰기
INSERT INTO board
VALUES(
		null,
		'첫번째 글입니다.',
        '첫번째 글 테스트',
        0,
        now(),
        (SELECT IFNULL(MAX(group_no), 0)+1 FROM board as max_no),
        1,
        0,
        2
       );
 
-- Modify Test
UPDATE board
   SET title = '피곤', content = '지침'
 WHERE no = 3;
  
-- Insert a dummy datas for paging test
DELIMITER $$
DROP PROCEDURE IF EXISTS loopInsert$$
CREATE PROCEDURE loopInsert()
BEGIN
	DECLARE i INT DEFAULT 1;
	WHILE i <= 500 DO
		INSERT INTO board
          VALUES (null,
				  concat(i, '번째 게시물'),
                  concat(i, '번째 글글글글'),
                  0,
                  CURRENT_TIMESTAMP,
                  (SELECT IFNULL(MAX(group_no), 0)+1 FROM board as max_no),
                  1, 0, 2);
		SET i = i + 1;
	END WHILE;
END$$
DELIMITER $$

CALL loopInsert;


 
