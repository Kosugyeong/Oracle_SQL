-- ex18_subquery.sql

/*

    ANSI-SQL
    1. Sub Query
    2. Join
    
    Query, 시퀄 > SQL 문장
    
    
    Main Query, 일반 쿼리
    - 하나의 문장안에 하나의 SELECT(INSERT, UPDATE, DELETE)로 되어 있는 쿼리
    
    Sub Query, 서브 쿼리, 부속 질의
    - 하나의 문장(SELECT, INSERT, UPDATE, DELETE) 안에 또 다른 문장이 들어있는 쿼리
    - ex) 하나의 SELECT문 안에 또 다른 SELECT문이 들어있는 쿼리
    - SELECT > SELECT
    - INSERT > SELECT
    - UPDATE > SELECT
    - DELETE > SELECT
    - 삽입 위치 > SELECT절, FROM절, WHERE절, GROUP BY절, HAVING절, ORDER BY절...
    - 메인 쿼리에서 값으로 취급(사용)
*/


--tblCountry. 인구수가 가장 많은 나라의 이름?
select * from tblCountry;

select max(population) from tblCountry; --A1
select name from tblCountry where population = 120660; --A2


-- select name from tblCountry where population = max(population); -- 이렇게 사용 못함! 개별적인 값(name)과 max(population)와 같은 집합들이 모여 만들어진 값은 함께 사용 못한다. 


select name from tblCountry where population = (select max(population) from tblCountry); --B(A1 + A2)



select name --3.
from tblCountry --1. 
where population = (select max(population) from tblCountry); --2.


-- tblComedian. 체중이 가장 많이 나가는 사람 이름은?


select max(weigth) from tblComedian;

select * from tblComedian where weight = (select max(weight) from tblComedian);



-- tblInsa. 급여를 가장 많이 받는 직원?

select * from tblInsa where basicpay = (select max(basicpay) from tblInsa);

-- tblInsa. 평균 급여보다 많이 받는 직원?
select * from tblInsa where basicpay >= (select avg(basicpay) from tblInsa);



-- 서브쿼리 삽입 위치
-- 1. 조건절 > 비교값으로 사용
--      1. 반환값이 1행 1열 > 단일 값 반환 > 상수 취급 > 값 1개로 사용
--      2. 반환값이 N행 1열 > 다중 값 반환 > 값 N개로 사용 > 열거형 비교 > in 사용
--      3. 반환값이 1행 N열 > 다중 값 반환 > 그룹 비교 > N개 컬럼:N개 컬럼 비교
--      4. 반환값이 N행 N열 > 다중 값 반환 > 2 + 3 > in + 그룹 비교


-- 2. 반환값이 N행 1열 > 다중 값 반환 > 값 N개로 사용 > 열거형 비교 > in 사용


-- 급여가 260만원 이상 받는 직원이 근무하는 부서의 직원 명단을 가져오시오.
-- ORA-01427: single-row subquery returns more than one row
select * from tblInsa where buseo = (select buseo from tblInsa where basicpay >= 2600000);-- 서브 쿼리의 결과 값이 총무부, 기획부 가 나오므로 where = '총무부' , '기획부' 이건 말이 안됨!! 그래서 에러가 난다!!

-- 위 쿼리 문을 in절로 고치면 제대로 실행 된다!!
select * from tblInsa where buseo in (select buseo from tblInsa where basicpay >= 2600000);



-- 3. 반환값이 1행 N열 > 다중 값 반환 > 그룹 비교 > N개 컬럼:N개 컬럼 비교

-- '홍길동'과 같은 지역, 같은 부서인 직원 명단을 가져오시오.
select * from tblInsa where name = '홍길동';

select * from tblInsa where city = '서울' and buseo = '기획부';


--A > 1대 1일 비교
select * from tblInsa 
    where city = (select city from tblInsa where name = '홍길동') 
        and buseo = (select buseo from tblInsa where name = '홍길동');
    -- where 1:1 and 1:!

--A쿼리를 간단하게 줄인 쿼리문!!! > 2대 2 비교 ***************정답 쿼리문
select * from tblInsa 
    where (city, buseo) = (select city, buseo from tblInsa where name = '홍길동');
    -- where 2:2




-- 4. 반환값이 N행 N열 > 다중 값 반환 > 2 + 3 > in + 그룹 비교

-- 급여가 260만원 이상 받는 직원과 같은 부서 같은 지역에 있는 직원들을 모두 가져오시오.

-- 기획부에 근무하면서 서울에 있는 직원들과
-- 총무부에 근무하면서 경남에 있는 직원들을 모두 가져오시오.
select buseo, city from tblInsa where basicpay >= 2600000;


-- ***************정답 쿼리문
select * from tblInsa where (buseo, city) in (select buseo, city from tblInsa where basicpay >= 2600000);



-- 1. 조건절 > 비교값으로 사용
--      1. 반환값이 1행 1열 > 단일 값 반환 > 상수 취급 > 값 1개로 사용
--      2. 반환값이 N행 1열 > 다중 값 반환 > 값 N개로 사용 > 열거형 비교 > in 사용
--      3. 반환값이 1행 N열 > 다중 값 반환 > 그룹 비교 > N개 컬럼:N개 컬럼 비교
--      4. 반환값이 N행 N열 > 다중 값 반환 > 2 + 3 > in + 그룹 비교

-- 집계 함수는 일반 컬럼과 같이 못 쓴다!
--2. 컬럼리스트에서 사용
--      - 반드시 결과값이 1행 1열이어야 한다.(**************) > 스칼라 쿼리
--      - 다른 컬럼과 관계있는 값을 반환해야 한다. ( 하나의 레코드의 모든 컬럼은 서로 연관이 있어야 한다.)
--      - 1. 정적 쿼리 > 모든 행에 동일한 값을 적용 > 사용 빈도 적음
--      - 2. 상관 서브 쿼리(*********엄청 중요!!!!!!!!!) 

--이렇게는 잘 안쓴다!!!!!
select
    name, buseo, basicpay,
    (select round(avg(basicpay)) from tblInsa) as "평균급여"
from tblInsa;


--이렇게도 안쓴다!!!
select
    name, buseo, basicpay,
    (select jikwi from tblInsa where name = '홍길동') as jikwi
from tblInsa;

--오류 난다.
-- ORA-00913: too many values
select
    name, buseo, basicpay,
    (select jikwi, sudang from tblInsa where num = 1001)
from tblInsa;



--상관 서브 쿼리--

select
    name,
    buseo,
    basicpay,
    (select round(avg(basicpay)) from tblInsa) as "전체 평균 급여", --정적 쿼리
    (select round(avg(basicpay)) from tblInsa where buseo = a.buseo) as "소속 부서 평균 급여"
from tblInsa a;

--a.buseo라고 쓰면 바깥쪽에 있는 테이블(메인쿼리)의 buseo값을 가져온다. 


select * from tblMan;
select * from tblWoman;

--남자의 이름, 키, 몸무게와 여자친구의 이름, 키, 몸무게를 가져오시오.
select
    name as "남자 이름",
    height as "남자 키",
    weight as "남자 몸무게",
    couple as "여자 이름",
    (select height from tblWoman where name = a.couple) as "여자친구 키",
    (select weight from tblWoman where name = a.couple) as "여자 몸무게"
from tblMan a; --메인 쿼리(tblMan)




-- 1. 조건절 > 비교값으로 사용
--      1. 반환값이 1행 1열 > 단일 값 반환 > 상수 취급 > 값 1개로 사용
--      2. 반환값이 N행 1열 > 다중 값 반환 > 값 N개로 사용 > 열거형 비교 > in 사용
--      3. 반환값이 1행 N열 > 다중 값 반환 > 그룹 비교 > N개 컬럼:N개 컬럼 비교
--      4. 반환값이 N행 N열 > 다중 값 반환 > 2 + 3 > in + 그룹 비교

-- 집계 함수는 일반 컬럼과 같이 못 쓴다!
--2. 컬럼리스트에서 사용
--      - 반드시 결과값이 1행 1열이어야 한다.(**************) > 스칼라 쿼리
--      - 다른 컬럼과 관계있는 값을 반환해야 한다. ( 하나의 레코드의 모든 컬럼은 서로 연관이 있어야 한다.)
--      - 1. 정적 쿼리 > 모든 행에 동일한 값을 적용 > 사용 빈도 적음
--      - 2. 상관 서브 쿼리(*********엄청 중요!!!!!!!!!) 

-- 3. FROM절에서 사용
--      - 인라인 뷰(Inline View)
--      1. 서브쿼리의 결과셋을 또 하나의 테이블이라고 생각하고 또 다른 SELECT의 FROM절에 사용이 가능

-- select 실행 > 결과 테이블(Result Table), 결과집합(ResultSet) > 임시 테이블
select * from (select name, buseo, jikwi from tblInsa);

select * from (select * from (select name, buseo, jikwi from tblInsa));

-- 주의점
-- 메인쿼리 > tblInsa(X), 서브쿼리(O)
-- 서브쿼리 > tblInsa
select name, buseo, jikwi, basicpay from (select name, buseo, jikwi from tblInsa); -- 오류!! basicpay를 가져올 곳이 없다!

-- from 서브쿼리가 별칭 사용 > 바깥쪽 메인쿼리는 별칭을 원래 컬럼명으로 인식
select name, buseo, position from (select name, buseo, jikwi as position from tblInsa);


-- "length(name)" 의미?
select name, len from (select name, length(name) as len from tblInsa); -- length(name)과 같은 경우는 메인 쿼리에서 혼동되지 않게 alia를 붙여야 함! 


select name, height, couple, (select height from tblWoman where tblMan.couple = name) from tblMan;


--ORA-00960: ambiguous column naming in select list
-- 애매모호한 이름 발견!!! order by에서 어떤 height를 가져와야할지 모른다. 이름이 같아서 구별이 안됨.
select
    name, height, couple,
    (select height from tblWoman where tblMan.couple = name) as height
from tblMan
    order by height asc; -- 문제 발생!! > height가 남자키? 여자키?

-- 그래서 다음과 같이 같은 컬럼 이름을 사용하지 말고 이름을 바꿔주자.
select
    name, height, couple,
    (select height from tblWoman where tblMan.couple = name) as height2
from tblMan
    order by height2 asc;
    













