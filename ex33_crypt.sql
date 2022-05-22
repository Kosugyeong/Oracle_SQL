
-- ex33_crypt.sql


/*

    암호화/복호화
    - 단방향 암호화
    - 양방향 암호화
    
    
    dbms_obfuscaation_toolkit 패키지
    - 암호화/복호화 기능 제공
    - C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin
    - 터미널 열기
        - > sqlplus
        - > Enter user name : sys as sysdba
        - SQL > @ dbmsobtk.sql
        - SQL > @provtobtk.plb
        - SQL > grant execute on dbms_obfuscation_toolkit to public;


*/

-- 패키지 생성 > 암호화/복호화 함수 생성
CREATE OR REPLACE PACKAGE pkgCrypto AS 
   FUNCTION encrypt( Str VARCHAR2, hash VARCHAR2 ) RETURN VARCHAR2;
   FUNCTION decrypt( xCrypt VARCHAR2, hash VARCHAR2 ) RETURN VARCHAR2;
END pkgCrypto;
/

CREATE OR REPLACE PACKAGE BODY pkgCrypto AS 
    crypted_string VARCHAR2(2000);
    
    FUNCTION encrypt( Str VARCHAR2, hash VARCHAR2 ) RETURN VARCHAR2 
    AS
        pieces_of_eight INTEGER := ((FLOOR(LENGTH(Str)/8 + .9)) * 8);
    BEGIN
    
        DBMS_OBFUSCATION_TOOLKIT.DESENCRYPT(
            input_string     => RPAD( Str, pieces_of_eight ),
            key_string       => RPAD(hash,8,'#'), 
            encrypted_string => crypted_string 
        );
        
        RETURN crypted_string;
    END;
    
    FUNCTION decrypt( xCrypt VARCHAR2, hash VARCHAR2 ) RETURN VARCHAR2 
    AS 
    BEGIN
        DBMS_OBFUSCATION_TOOLKIT.DESDECRYPT(
            input_string     => xCrypt, 
            key_string       => RPAD(hash,8,'#'), 
            decrypted_string => crypted_string 
        );
        
        RETURN trim(crypted_string);
    END;
END pkgCrypto;
/

drop table tblBoard;
drop table tblUser;

create table tblUser (
    id varchar2(30) primary key,
    name varchar2(30) not null,
    pw varchar2(30) not null
);

insert into tblUser values('hong', '홍길동', '1234');
insert into tblUser values('test', '테스트', pkgCrypto.encrypt('1234', 'java'));
insert into tblUser values('aaa', '가가가', pkgCrypto.encrypt('1234', 'java'));
insert into tblUser values('bbb', '나나나', pkgCrypto.encrypt('5678', 'java'));
insert into tblUser values('ccc', '다다다', pkgCrypto.encrypt('1234', 'oracle'));

select * from tblUser;

--로그인
select * from tblUser where id = ? and pw = ?;

select * from tblUser where id = 'hong' and pw = '1234';

select * from tblUser where id = 'test' and pw = pkgCrypto.encrypt('1234', 'java');

select id, pw, pkgCrypto.decrypt(pw, 'java'), pkgcrypto.decrypt(pw, 'oracle')  from tblUser where id <> 'hong';


-- 단방향 암호화
-- dbms_crypto.hash
-- 암호화 알고리즘 지원
-- 1. MD4
-- 2. MD5
-- 3. SH1
SELECT 
    RAWTOHEX(DBMS_CRYPTO.HASH(TO_CLOB(TO_CHAR('test')), 1)) ,
    RAWTOHEX(DBMS_CRYPTO.HASH(TO_CLOB(TO_CHAR('test')), 2)) ,
    RAWTOHEX(DBMS_CRYPTO.HASH(TO_CLOB(TO_CHAR('test')), 3)) 
from dual;



______________________________________________________________________________

-- AES-128 알고리즘 --> ************** 프로젝트할 때 이걸로 사용하기!!!


CREATE OR REPLACE PACKAGE CRYPTO
IS
    FUNCTION ENCRYPT (input_string IN VARCHAR2
                    , key_data IN VARCHAR2 := 'test1234test1234') 
    RETURN RAW;
    FUNCTION DECRYPT (input_string IN VARCHAR2
                    , key_data IN VARCHAR2 := 'test1234test1234')
    RETURN VARCHAR2;
END CRYPTO;


CREATE OR REPLACE PACKAGE BODY CRYPTO
IS
    SQLERRMSG   VARCHAR2(255);
    SQLERRCDE   NUMBER;
     
    FUNCTION encrypt (input_string IN VARCHAR2
                    , key_data IN VARCHAR2 := 'test1234test1234') 
     RETURN RAW
    IS
        input_raw RAW(1024);
        key_raw RAW(16) := UTL_RAW.CAST_TO_RAW(key_data);
        v_out_raw RAW(1024);
        AES_CBC_PKCS5 CONSTANT PLS_INTEGER := DBMS_CRYPTO.ENCRYPT_AES128 
                                            + DBMS_CRYPTO.CHAIN_CBC 
                                            + DBMS_CRYPTO.PAD_PKCS5;
    BEGIN
        IF input_string IS NULL THEN
         RETURN NULL;
        end IF;
        
        input_raw := UTL_I18N.STRING_TO_RAW(input_string, 'AL32UTF8');
        v_out_raw := DBMS_CRYPTO.ENCRYPT(
                src => input_raw,       
                typ => AES_CBC_PKCS5,   
                key => key_raw);     
    RETURN v_out_raw;
    END encrypt;
    
    FUNCTION decrypt (input_string IN VARCHAR2
                    , key_data IN VARCHAR2 := 'test1234test1234') 
     RETURN VARCHAR2
    IS
        key_raw RAW(16) := UTL_RAW.CAST_TO_RAW(key_data);
        output_raw RAW(1024);
        v_out_string VARCHAR2(1024);
        AES_CBC_PKCS5 CONSTANT PLS_INTEGER := DBMS_CRYPTO.ENCRYPT_AES128 
                     + DBMS_CRYPTO.CHAIN_CBC
                     + DBMS_CRYPTO.PAD_PKCS5;

    BEGIN
        IF input_string IS NULL THEN
         RETURN NULL;
        end IF;
    
        output_raw := DBMS_CRYPTO.DECRYPT(
                src => input_string,
                typ => AES_CBC_PKCS5,
                key => key_raw);
        v_out_string := UTL_I18N.RAW_TO_CHAR(output_raw, 'AL32UTF8');
    RETURN v_out_string;
    END decrypt ;
END CRYPTO;

/
-- 암호화
select crypto.encrypt ('1234') from dual;

-- 복호화
select crypto.decrypt('B2E4C35A1597FC7BB923913B0786341F') from dual;

