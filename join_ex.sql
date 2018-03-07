insert into major
values (null, '컴퓨터공학과', '');
insert into major
values (null, '토목공학과', '');
insert into major
values (null, '철학과', '');

select *
  from major;
  
desc student;

insert into student
values (null, '둘리', '1111', 1);
insert into student
values (null, '마이콜', '1111', 2);
insert into student
values (null, '도우넛', '1111', 3);

update student
   set major_no = null
 where no = 2;
 
select * from student;

-- Equi join
select s.name, s.sno, m.name
  from student as s, major m
 where s.major_no = m.no;
 
-- Left join
select * from major;
select * from student;

   SELECT a.name, a.sno, ifnull(b.name, '퇴학')
     FROM student a
LEFT JOIN major b ON a.major_no = b.no;
-- Left join end

-- SUBQUERY Example
SELECT ( SELECT count(*) FROM major ),
       ( SELECT COUNT(*) FROM student )
  