--ex03_select.sql
/*

    SQL, Query(질의)
    
    SELECT 문
    - DML, DQL
    - 관계대수 연산 중 셀렉션 작업을 구현한 명령어
    - 대상 테이블로부터 원하는 행(튜플)을 추출하는 작업 > 오라클 서버에게 데이터 주세요~ 요청
    
    SELECT 문
    
    [WITH <Sub Query>]
    SELECT column_list
    FROM table_name
    [WHERE serch_condition]
    [GROUP BY group_by_expression]
    [HAVING search_condition]
    [ORDER BY oorder_expression [ASC|DESC]]
    
    SELECT column_list
    FROM table_name
    
    
    SELECT 컬럼리스트
    FROM 테이블;
    
    SELECT를 구성하는 절의 실행 순서(***********)
    1. FROM 절
    2. SELECT 절
    
    1. FROM 테이블 > 데이터를 가져올 테이블을 지정한다. 
    2. SELECT 컬럼리스트 > 가져올 특정 컬럼을 지정한다. 
    
    
    
    
    
    
    

*/
--SELECT: 셀렉션
--컬럼리스트: 프로젝션
select first_name
from employees;


--명령어
--1. SQL 명령어 > 기억O + 수업!!!
--2. SQL Plus 명령어 > 기억할 필요 없음
-- 콘솔(sqlplus) or SQL Developer(sqlplus 내장
desc tblCountry; -- 해당 테이블의 스키마? > 컬럼 구조 .. )

-- 단일 컬럼
select name from tblCountry;
select capital from tblCountry;
select population from tblCountry;

-- 여러개
select name, capital from tblCountry;
select name, capital, population, continent, area from tblCountry;
select * from tblCountry; -- 와일드 카드(*) > 모든 컬럼

select name, length(name) from tblCountry;

--컬럼 리스트의 순서는 원본 테이블의 컬럼 순서와 무관하다. 
select name, capital from tblCountry;
select capital, name  from tblCountry;


-- 여러가지 시스템 정보 확인
-- > 시스템 테이블
--1. 사용자 정보

select * from dba_users; --ORA-00942: table or view does not exist


--2. 특정 사용자가 소유한 테이블 정보
select * from tabs; -- 현재 접속한 계정이 소유하는 테이블 목록

select * from dba_tables where owner = 'HR';

--3. 특정 테이블의 컬럼 정보 > 스키마
select * from dba_tab_columns where owner = 'HR' and table_name = 'TBLCOUNTRY';




