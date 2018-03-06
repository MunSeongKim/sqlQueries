-- Basic Queries(MySQL Tutorial)

drop table pet;

-- 테이블 생성
CREATE TABLE pet (
	name varchar(20),
    owner varchar(20),
    species varchar(20),
    gender char(1),
    birth date,
    death date
);

-- schema 확인
desc pet; -- = describe pet;

-- row 확인
select * from pet;

insert
  into pet
values (
		'Fluffy',
		'Harold',
		'cat',
		'f',
		'1999-02-04',
		NULL
        );
        
select *
from pet;

load data local infile 'D:\\temp\\pet.txt' into table pet
LINES terminated by '\r\n'; -- Windows notepad 에서의 라인 터미네이터 지정 아니면 null을 인식 못함

delete from pet;

select *
from pet
where name = 'Bowser';

select *
from pet
-- where birth > '1998-01-00' and birth < '1998-12-32';
-- where birth LIKE '1998%';
where birth LIKE '1998-__-__';

select name, birth
from pet
order by birth;

select *
from pet
where death is not null;

-- update
update pet
set death = null
where death = '0000-00-00';

select name
from pet
where name LIKE '_____';

select count(*) as Pet_Count
from pet;

select owner, count(*) as Pet_Count
from pet
where death is null
group by owner
having Pet_Count > 2;

select owner, count(*) as Pet_Count
from pet
group by owner
having Pet_Count = (
	select max(p.Pet_Count)
	from (
		select owner, count(*) as Pet_Count
		from pet
		group by owner
		) p
	);