-- ex20_view.sql

/*

    View, 뷰
    - 데이터베이스 객체 중 하나(CREATE, ALTER, DROP > 테이블, 시퀀스, 제약사항, 뷰)
    - 가상 테이블, 복사 테이블, 뷰 테이블 등...
    - 테이블처럼 사용한다.(********)
    - 반복된 SELECT of 긴 SELECT > 뷰 생성 > 효과
    - 뷰 정의 > SQL을 저장한 객체(***********)
    - 실시간으로 반영된다. 
    - 쿼리문에 이름을 붙인게 뷰다. 굳이 쿼리문을 또 안써도 뷰를 select해서 결과 데이터를 확인할 수 있다. 
    
    CREATE VIEW 뷰이름
    AS
    SELECT 문;
    
    CREATE OR REPLACE VIEW 뷰이름
    AS
    SELECT 문;
    
*/

create view vwInsa
as
select * from tblInsa;

select * from vwInsa; --tblInsa처럼 행동


create or replace view vwInsa
as
select * from tblInsa where buseo = '영업부';

-- 뷰 사용 용도? > 쿼리의 양을 줄이는게 목적
-- select * from tblInsa where buseo = '영업부' vs select * from vwInsa

-- 비디오 가게 사장 > 하루 업무
create or replace view 대여체크
as
select
    m.name as mname,
    v.name as vname,
    to_char(r.rentdate, 'yyyy-mm-dd') as rentdate,
    case
        when r.rentdate is not null then '완료'
        else '미완료'
    end as state
from tblRent r
    inner join tblVideo v
        on v.seq = r.video
            inner join tblMember m
                on m.seq = r.member;




select * from 대여체크;




-- tblInsa > 서울 직원 > view
create or replace view vWSeoul
as
select * from tblInsa where city = '서울'; --뷰를 만드는 시점 > 20명


select * from vwSeoul; --20명                              --A.실명. 이름이 있는 뷰 > 뷰
select * from (select * from tblInsa where city = '서울'); --B.익명. 이름이 없는 뷰 > 인라인 뷰

update tblInsa set city = '제주' where num in(1001, 1005,1008);


select * from tblInsa where city = '서울'; --17명

select * from vwSeoul; --20명 > 17명



-- 권한 > 계정별로 객체에 대한 접근/조작 등을 통제

select * from tblInsa; --신입. tblInsa 접근권한X > 다른 직원들의 월급은 볼 수 없도록..
select * from 신입전용; --신입. view 접근권한O


create or replace view 신입전용
as
select num, name, city from tblInsa;



create or replace view vwTodo
as
select * from tblTodo;


select * from vwTodo;


--뷰 사용
--1. SELECT > 실행O > 뷰는 읽기 전용으로 사용한다.(****) == 읽기 전용 테이블
--2. INSERT > 실행O > 절대 사용 금지
--3. UPDATE > 실행O > 절대 사용 금지
--4. DELETE > 실행O > 절대 사용 금지

select * from vwTodo; --단순뷰 > 뷰의 SELECT가 1개의 테이블로 구성
insert into vwTodo values (21, '오라클 정리하기', sysdate, null);
update vwTodo set completedate = sysdate where seq = 21;
delete from vwTodo where seq = 21;



select * from 대여체크; --복합뷰 > 2개 이상의 테이블을 SELECT
insert into 대여체크 values ('홍길동', '영구와 땡칠이', sysdate, '미완료');

















