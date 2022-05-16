-- ex30_account.sql

/*

    사용자 관련 > DCL
    - 계정 생성, 삭제, 잠금 제어
    - 리소스(DB Object) 접근 권한 제어
    
    현시점 사용 계정
    - system
    - hr
    
    사용자 계정 생성하기
    - 시스템 권한을 가지고 있는 계정만 가능하다.
    - 계정 생성 권한을 가지고 있는 일반 계정도 가능하다. 
    
    - create user 계정명 identified by 암호  //계정 생성
    - alter user 계정명 identified by 암호   //계정 삭제
    - alter user 계정명 account unlock       //계정 잠금 해제
    - alter user 계정명 account lock         //계정 잠금 설정


    - 새로 생성된 계정은 아무 권한이 없다. > 접속할 권한조차도 없다.
    
    사용자에게만 권한 부여하기
    - 시스템 권한을 가지고 있는 계정만 가능하다. > 관리자급
    - grant 권한명 to 유저명
    
    사용자에게 권한 제거하기
    - revoke 권한명 from 유저명
    
    권한 종류
    - create user
    - drop user
    - drop any table
    - create session
    - create table
    - create view
    - create sequence
    - create procedure
    
    권한의 집합 > Role
    - HR(connecet + resource + create view)
    1. connect
        - 사용자 DB 접속 + 기본적 행동 > 권한 모음
        
    2. resource
        - 사용자가 객체를 생성하거나 조작하는 권한 모음
        
    3. 

*/


-- system 계정
show user;

create user hong identified by java1234;

grant create session to hong; -- create sesession > hong으로 접속을 할 수 있게..
grant create table to hong;   -- create table > 테이블 생성권한




-- hong 계정
show user;


-- ORA-01031: insufficient privileges   > 권한이 없다는 에러 
create table tblDate (
    seq number primary key,
    data varchar2(100) not null
);



----------------------------------------------------------------------
--프로젝트 진행 > 프로젝트용 계정 생성
create user team identified by java1234;

grant connect, resouce, dba to team;



