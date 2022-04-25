# Oracle_SQL
SQL 개념 파일


create table tblMemo (
    
   
    seq number(3) , 
    name varchar2(30) not null,
    memo varchar2(1000 ) null, 
    regdate date,
    
    -- 테이블 수준의 제약사항 정의 
    -- 제약사항명: 테이블명_컬럼명_제약사항
    constraint tblmemo_seq_pk primary key(seq),
    constraint tblmemo_name_uq unique(name),
    constraint tblmemo_memo_ck check(length(memo) >= 10)
    
);

프로젝트 진행할 때는 위와 같이 테이블 제약사항을 밑으로 한번에 빼서 정의하도록 하자! 공부할 때는 그냥 컬럼 수준으로 컬럼 바로 옆에다가 써서 해도 되고 테이블 수준으로 밑으로 빼서 해도 됨.
