CREATE TABLE THANH_NGUYEN1 (ID VARCHAR2(20), SSN VARCHAR2(20), name CHAR(30) NOT NULL, age NUMBER(2), DOB DATE,
CONSTRAINT THANH_NGUYEN1_ID_pk PRIMARY KEY (ID), 
CONSTRAINT THANH_NGUYEN1_ID_uk UNIQUE (SSN),
CONSTRAINT THANH_NGUYEN1_DOB_ck CHECK (DOB = '08-MAR-1995'));

DESCRIBE THANH_NGUYEN1;

INSERT INTO THANH_NGUYEN1 VALUES ('VA1234', 'US1111', 'Thanh Nguyen', 26, '08-MAR-1995');

SELECT*FROM THANH_NGUYEN1;

INSERT INTO THANH_NGUYEN1 VALUES ('VA1235', 'US1112', 'Adam Ryan', 26, '08-MAR-1995');

SELECT*FROM THANH_NGUYEN1;

UPDATE THANH_NGUYEN1 SET name = 'Adam Brian', SSN = 'US1988' WHERE ID = 'VA1235';

DELETE THANH_NGUYEN1 WHERE SSN = 'US1988';

COMMIT; 

ROLLBACK;

SELECT*FROM THANH_NGUYEN1;

DROP TABLE THANH_NGUYEN1;

THANH NGUYEN