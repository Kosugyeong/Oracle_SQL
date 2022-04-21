-- ex10_string_function.sql

/*

    문자열 함수
    
    upper(), lower(), initcap()
    - varchar2 upper(컬럼)
    - varchar2 lower(컬럼)
    - varchar2 initcap(컬럼)



*/

select
    first_name,
    upper(first_name),
    lower(first_name)
from employees;


select
    'abc',
    initcap('abc') --첫글자를 대문자로 변환해줌
from dual;

-- 이름에 'an' 포함된 직원 > 대소문자 구분없이
select first_name from employees where  lower(first_name) like '%an%';


/*

    substr()
    - 문자열 추출 함수
    - varchar2 substr(컬럼, 시작위치, 가져올 문자 개수)
    - varchar2 substr(컬럼, 시작위치)
    - *** SQL은 one-based index 사용. 즉, 첨자가 1부터 시작함
*/

select 
    title,
    substr(title, 3, 4)
from tblTodo;

select
    'ABCDEFG',
    substr('ABCDEFG', 2, 3)
from dual;


select
    name,
    substr(name, 1, 1) as "성",
    substr(name,2) as "이름",
    substr(ssn, 1, 2) as "생년",
    substr(ssn, 3, 2) as "생월",
    substr(ssn, 5, 2) as "생일",
    substr(ssn, 8, 1) as "성별"
from tblInsa;


-- 김, 이, 박, 최, 정 > 몇명?
select
    count(case
        when substr(name, 1, 1) = '김' then 1
    end) as 김,
    count(case
        when substr(name, 1, 1) = '이' then 1
    end) as 이,
    count(case
        when substr(name, 1, 1) = '박' then 1
    end) as 박,
    count(case
        when substr(name, 1, 1) = '최' then 1
    end) as 최,
    count(case
        when substr(name, 1, 1) = '정' then 1
    end) as 정,
    count(case
        when substr(name, 1, 1) not in ('김', '이','박','최','정') then 1
    end) as "그 외 성"
from tblInsa;


--남자 오름차순 
select * from tblInsa
    order by substr(ssn, 8, 1) asc;










