drop table member;

-- Ex.1
CREATE TABLE member (
	no INTEGER not null auto_increment primary key,
    email char(200) not null,
    password char(20) not null,
    name char(25) null,
    department_name char(25) null
);

-- Ex.2
alter table member add juminbunho char(14) not null after no;
-- Ex.3
alter table member drop juminbunho;
-- Ex.4
alter table member add join_date DATETIME not null;
-- Ex.5
alter table member change password password char(64) not null;
-- Ex.6
alter table member change department_name dept_name varchar(25) null;
-- Ex.7
alter table member change name name char(10) not null;
-- Ex.9
alter table member rename user;

desc user;

-- Ex.10
insert into user
values (null, 'a@a.com', password('123456'), '둘리', null, sysdate());
insert into user(email, password, name, join_date)
values ('a@a.com', password('123456'), '둘리', sysdate());
insert into user(email, juminbunho, name, password, join_date)
values ('a@a.com', '123-123', '도우넛', password('123456'), sysdate());

-- Ex.11
update user
   set name = 'Dooly', password=password('1234567890')
 where no = 2;
 
-- Ex.12
DELETE FROM user WHERE no = 2;

select * from user;
select length(password) from user;