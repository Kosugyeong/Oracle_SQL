--ex04_operator.sql

/*

    연산자, Operator
    
    1. 산술 연산자
    - +,-,*,/
    - %(없음) > 함수로 제공(mod())
    
    2. 문자열 연산자
    - +(X) > ||(O) > ||을 써야 문자열이 합쳐짐
    
    3. 비교 연산자
    - >, >=, <, <=
    - =(==), <>(!=)
    - 논리값 반환 > 명시적으로 표현 가능한 자료형이 아니다. > 조건을 필요한 상황에서만 내부적으로 사용된다. 
    - 컬럼 리스트에서 사용 불가
    - 조건절에서 사용가능
    
    4. 논리 연산자
    - and(&&) , or(||), not(!)
    - 컬럼 리스트에서 사용 불가
    - 조건절에서 사용 가능
    
    5. 대입 연산자
    - =
    - 컬럼 = 값
    - UPDATE문에서 사용
    
    6. 3항 연산자
    - 없음
    - 제어문 없음
    
    7. 증감 연산자
    - 없음
    
    8. SQL 연산자
    - 자바: instanceof, typeof 등..
    - in, between, like, is 등..(=구, =절)
    
    
    
    
*/
-- ORA-01722: invalid number
select name + capital from tblCountry; -- 문자열을 합치고 싶으면 + 가 아니라
select name || capital from tblCountry; -- ||을 써야 문자열이 합쳐짐.

--select name <> capital from tblCountry;
--select population > area from tblCountry;








select * from tblMan;
select * from tblWoman;

-- 컬럼이 별칭(Alias) 만들기
-- SELECT의 결과 테이블에만 적용 > 일시적인 행동
-- 컬럼명 as 별명

select name as 남자이름, couple as 여자이름 from tblMan;

select name, weight, weight + 5 from tblMan;
select name, weight, weight + 5 as weight2 from tblMan; --weight + 5 의 별칭 붙여주기

select name, name as name2 from tblMan;

select name as "남자 이름" from tblMan;





--이 모습이 원래 원형이다!!! 계정이름(소유주 이름).테이블이름. 
select 
    hr.tblCountry.name,
    hr.tblCountry.capital,
    hr.tblCountry.population
from hr.tblCountry; -- 테이블 앞에는 소유주 이름(여기서는 hr)이 생략되어 있음. 

-- 테이블 별칭 만들기
-- 테이블 별칭은 테이블 이름을 반복해서 사용할 때 코드량을 줄이기 위해서 사용 > 보통 알파벳 한글자로 함

select                  --2.
    c.name,
    c.capital,
    c.population
from tblCountry c;  --1.


-- Alias : 같이 사용 가능한 별명(X) > 개명(O)










