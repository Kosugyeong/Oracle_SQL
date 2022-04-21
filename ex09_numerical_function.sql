-- ex09_numerical_function.sql 

/*

    round()
    - 반올림 함수
    - number round(컬럼명) : 정수 반환
    - number round(컬럼명, 소수이하자릿수) : 실수 반환


*/

select 
            height / weight, 
            round(height / weight), 
            round(height / weight, 1),
            round(height / weight, 2),
            round(height / weight, 3),
            round(height / weight, 0)
from tblComedian;

select round(avg(basicpay)) from tblInsa;


/*

    floor(), trunc()
    - 절삭 함수
    - 무조건 내림 함수
    - number floor(컬럼명)
    - number trunc(컬럼명 [, 소수이하자릿수])
    

*/

select
    height / weight,
    round(height / weight),
    floor(height / weight),
    trunc(height / weight, 1),
    trunc(height / weight, 2)
from tblComedian;



/*

    ceil()
    - 무조건 올림 함수(반올림 하지 않는 상황에서도 올려버림)
    - number ceil(컬럼명)


*/

select 
    height / weight,
    round(height / weight),
    floor(height / weight),
    ceil(height / weight)
from tblComedian;


-- 시스템 테이블
select * from dual; -- 1행 1열 테이블

select 100 from tblComedian;
select 100 + 100 from tblInsa;
select 100 + 100 from dual;

select sysdate from tblInsa; -- 어느 테이블에도 소속되지 않은 값인 현재 날짜만 출력하고 싶은데 컬럼 개수만큼 현재 날짜가 다 나옴

select sysdate from dual; -- 그래서 이와 같이 1행 1열 테이블인 dual에 출력되게 할 수 있다.


select
    floor(9.999999999999999999999999),
    ceil(9.00000000000000000000000001)
from dual;







/*

    mod()
    - 나머지 함수
    - number mod(피제수, 제수)
    


*/

select 
    10 / 3,
    floor(10/3) as "몫",
    mod(10, 3) as "나머지"
from dual;


select
    abs(10), --절대값 함수
    abs(-10),
    power(2, 2), -- 제곱 함수
    power(2, 3),
    power(2, 4),
    sqrt(4), --제곱근 함수
    sqrt(16),
    sqrt(64)
from dual;










