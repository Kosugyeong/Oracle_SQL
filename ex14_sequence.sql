-- ex14_sequence.sql

/*
    오라클의 모든 데이터는 하드디스크에 저장이 됨!!!! 그래서 날라가지 않고 계속 저장이 된다. 

    시퀀스, Sequence
    - 데이터베이스 객체 중 하나
    - 오라클 전용 객체(다른 DBMS에는 없음)
    - 일련 번호를 생성하는 객체(*******)
    - (주로) 식별자를 만드는데 사용한다. > PK 컬럼에 값을 넣을 때 잘 사용한다. 



    시퀀스 객체 생성하기
    - create sequence 시퀀스명;
    
    시퀀스 객체 삭제하기
    - drop sequence 시퀀스명;
    
    시퀀스 객체 사용하기
    - 시퀀스.nextVal (************) > 이거를 많이 씀
    - 시퀀스.currVal
    

*/

create sequence seqNum;

select 10 + 20 from dual;

select sysdate from dual;

select seqNum.nextVal from dual;



drop table tblMemo;

create table tblMemo (
    
   
    seq number(3) primary key,          
    name varchar2(30),      
    memo varchar2(1000), 
    regdate date                  

);

select * from tblMemo;

create sequence seqMemo;



insert into tblMemo(seq, name, memo, regdate) values (seqMemo.nextVal, '홍길동' , '메모입니다.', sysdate);
insert into tblMemo(seq, name, memo, regdate) values (seqMemo.nextVal, '홍길동홍길동홍길동홍길동' , '메모입니다.', sysdate);

-- 다양한 형태로 활용
-- 쇼핑몰 > 상품 테이블 > 상품번호(A10214)

select 'A' || seqNum.nextVal from dual;
select 'A' || to_char(seqNum.nextVal, '0000') from dual; -- 자릿수 맞춘 상품번호 A 0010
select 'A' || ltrim(to_char(seqNum.nextVal, '0000')) from dual; -- 부호 자리 없애줌 A0011

--컨트롤 힘들다;;;; 두 개 이상 동시에 같이 출력하는거
select 'A' || ltrim(to_char(seqNum.nextVal, '0000')) || 'B' || ltrim(to_char(seqNum.nextVal, '0000')) from dual;




-- currVal > Current Value > Peek() 역할 > 실제로 소비하지는 않고 확인만 시켜줌
-- session: 현재 로그인 상태
select seqNum.currVal from dual; 
-- 껐다가 키면 ORA-08002: sequence SEQNUM.CURRVAL is not yet defined in this session
-- 즉, currVal를 사용하려면 nextVal가 최소 1회 이상은 호출이 되어야 currVal가 만들어짐. 근데 접속을 끊으면 currVal가 사라지므로 currVal는 영구적이지 않음. 그래서 많이 안쓴다. 

select seqNum.nextVal from dual;


/*

    시퀀스 객체 생성하기
    
    create sequence 시퀀스명;
    
    원래 시퀀스 객체 생성하는 원형 모습 > 하지만 원형 모습보다는 기본 모습을 많이 쓴다. 
    create sequence 시퀀스명 
                    increment by n -- 증감치!!(양수/음수)
                    start with n   -- 시작값(seed)
                    maxvalue n     -- 최댓값
                    minvalue n     -- 최솟값
                    cycle 
                    cache n;       -- 입출력을 효과적으로 하기 위해..


*/

drop sequence seqTest;

create sequence seqTest
                --increment by 1 -- 증감치
                --start with 1
                --maxvalue 30
                -- minvalue 5 
                --cycle
                cache 20;

select seqTest.nextVal from dual;




















