-- ex24_transaction.sql

/*
    많이 중요함!!!!!!!!!!
    트랜잭션 , Transaction
    - 데이터를 조작하는 업무의 물리적(시간적) 단위
    - 1개 이상의 명령어(행동, SQL)로 구성된 작업 단위(기간)
    - 1개 이상의 명령어를 하나의 목적(논리 집합)으로 묶어 놓은 단위

*/

-- 테이블 복사 ! 

create table tblTrans
as
select name, buseo, jikwi from tblInsa where city = '서울';

select * from tblTrans;

-- 로그인(접속) > 트랜잭션이 시작됨.

--INSERT, UPDATE, DELETE 명령어는 실행 즉시 데이터베이스에 반영 되지 않는다. 
-- > 임시 적용한다. 

delete from tblTrans where name = '박문수';

select * from tblTrans;

commit;     --"현재 트랜잭션에서 했던 모든 행동"을 진짜 데이터베이스에 반영해라
rollback;   --"현재 트랜잭션에서 했던 모든 행동"을 진짜 데이터베이스에 반영하지 말고 없었던 일로 취소해라(되돌려라, 타임머신처럼)

select * from tblTrans;

delete from tblTrans where name = '박문수';

select * from tblTrans;

-- 몇 번의 확인 차 박문수가 delete 되는게 확실하다고 느껴질 때!!!!
commit;

select * from tblTrans;

-- 한 번 commit한 작업은 rollback 해도 되돌릴 수 없다. 
rollback;

select * from tblTrans;


-- 또 새로운 사람을 삭제해보자.
delete from tblTrans where name = '김인수';

select * from tblTrans;

update tblCountry set capital = '서울';

select * from tblCountry;

--잘못 update 한걸 발견하면 아직 commit은 안했으니 rollback
rollback;

select * from tblCountry;

--맞는 쿼리문으로 수정하고
update tblCountry set capital = '세종' where name = '대한민국';
--확인했을 때 맞게 들어간걸 본다면
select * from tblCountry;
--commit을 한다. 
commit;



--commit과 rollback하는 기준을 적당히 잘 조절해서 적용해야한다.
--업무별로 묶기
--시간대별로 묶기
--> 트랜잭션은 관리를 매우매우 잘해야한다!!!!!!

/*

    트랜잭션이 언제 시작하고? 언제 끝나는지?
    
    새로운 트랜잭션이 시작하는 경우
    1. 클라이언트 접속 직 후
    2. commit 실행 직 후
    3. rollback 실행 직 후
    
    현재 트랜잭션이 종료되는 경우
    1. commit 실행 > 현재 트랜잭션을 DB에 반영함
    2. rollback 실행 > 현재 트랜잭션을 DB에 반영 안함
    3. 클라이언트 접속 종료
        a. 정상 종료
            - 현재 트랜잭션에 아직 반영안된 명령어가 남아있으면 사용자에게 질문?
        b. 비정상 종료
            - 무조건 rollback 처리
    4. DDL 실행 ********잊지 말자
        - CREATE, ALTER, DROP  > 실행 > 그 즉시 commit 동반 > Auto commit
        - DDL 성격 > 구조 변경 > 데이터 영향 O > 사전에 미리 저장(Commit)
        
        
    클라이언트 도구
    - SQL Developer
    - Auto Commit 옵션(사용자 선택)
*/


select * from tblTrans;

commit; -- 지금부터 새로운 트랜잭션 시작의 의미!!! > 내 자신한테 확인시켜 주기 위한 commit

delete from tblTrans where buseo = '영업부';

--아직까지는 이 delete를 commit해야할지 rollback해야할지 모르겠다. 고민중... 
--근데 갑자기 create를 하게 되었다. 이 때는 자동으로 commit이 실행되어버린다 되돌릴 수 없다 조심하자...

commit;

delete from tblTrans where buseo = '기획부';

select * from tblTrans;

rollback;

select * from tblTrans;


commit;

select * from tblTrans;

insert into tblTrans values ('가가가','영업부','부장');
insert into tblTrans values ('나나나','영업부','과장');

select * from tblTrans;

savepoint a; --중간 저장

delete from tblTrans where name = '김말숙';

select * from tblTrans;

savepoint b;

delete from tblTrans where buseo = '개발부';

select * from tblTrans;

--savepoint b까지 했던 내용들로 돌아감
rollback to b;

select * from tblTrans;

rollback;

select * from tblTrans;

