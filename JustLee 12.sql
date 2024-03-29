Create Table department
 (deptno NUMBER(2),
  dname VARCHAR2(20));
INSERT INTO department
 VALUES (10, 'General Admin');
INSERT INTO department
 VALUES (20, 'Engineering');
INSERT INTO department
 VALUES (30, 'Support');
Create table Books_1
(ISBN VARCHAR2(10), 
Title VARCHAR2(30), 
PubDate DATE, 
Retail NUMBER (5,2), 
Category VARCHAR2(12),
  CONSTRAINT books_1_isbn_pk PRIMARY KEY(isbn)); 
 INSERT INTO BOOKS_1
VALUES ('8843172113','DATABASE IMPLEMENTATION','04-JUN-05',55.95, 'COMPUTER'); 
INSERT INTO BOOKS_1
VALUES ('3437212490','COOKING WITH MUSHROOMS','28-FEB-06',19.95, 'COOKING'); 
INSERT INTO BOOKS_1 
VALUES ('3957136468','HOLY GRAIL OF ORACLE','31-DEC-05',65.95, 'BUSINESS'); 
COMMIT;
Create table Books_2
(ISBN VARCHAR2(10), 
Title VARCHAR2(30), 
PubDate DATE, 
Retail NUMBER (5,2), 
Category VARCHAR2(12),
  CONSTRAINT books_2_isbn_pk PRIMARY KEY(isbn)); 
INSERT INTO BOOKS_2
VALUES ('8843172113','DATABASE IMPLEMENTATION','04-JUN-05',55.95, 'COMPUTER'); 
INSERT INTO BOOKS_2 
VALUES ('3437212490','COOKING WITH MUSHROOMS','28-FEB-06',29.95, 'COOKING'); 
INSERT INTO BOOKS_2 
VALUES ('3957136468','HOLY GRAIL OF ORACLE','31-DEC-05',75.95, 'COMPUTER'); 
INSERT INTO BOOKS_2
VALUES ('1915762492','HANDCRANKED COMPUTERS','21-JAN-05',25.00, 'COMPUTER'); 
INSERT INTO BOOKS_2
VALUES ('0299282519','THE WOK WAY TO COOK','11-SEP-00',28.75, 'COOKING'); 
COMMIT;

SELECT Title, Retail FROM BOOKS WHERE Retail < (SELECT AVG(Retail) FROM BOOKS);

SELECT TITLE, CATEGORY, COST FROM BOOKS b WHERE COST < (SELECT AVG(COST) FROM BOOKS GROUP BY CATEGORY HAVING CATEGORY = b.CATEGORY);

SELECT Order# FROM Orders WHERE ShipState = (SELECT ShipState FROM Orders WHERE Order# = 1014);

SELECT Order#, SUM(QUANTITY*PAIDEACH) FROM ORDERITEMS GROUP BY Order# HAVING SUM(QUANTITY*PAIDEACH) > (SELECT SUM(QUANTITY*PAIDEACH) FROM ORDERITEMS WHERE Order#=1008);

SELECT LNAME, FNAME FROM AUTHOR JOIN BOOKAUTHOR USING(AUTHORID) WHERE ISBN IN 
(SELECT ISBN FROM ORDERITEMS GROUP BY ISBN HAVING SUM(QUANTITY) = (SELECT MAX(COUNT(*)) FROM ORDERITEMS GROUP BY ISBN));

SELECT TITLE FROM BOOKS WHERE CATEGORY IN (SELECT DISTINCT CATEGORY FROM BOOKS JOIN ORDERITEMS USING(ISBN) JOIN ORDERS USING(Order#) WHERE Customer#=1007) AND ISBN
NOT IN (SELECT ISBN FROM ORDERS JOIN ORDERITEMS USING(Order#) WHERE Customer# = 1007);

SELECT SHIPCITY, SHIPSTATE FROM ORDERS WHERE SHIPDATE-ORDERDATE = (SELECT MAX(SHIPDATE-ORDERDATE) FROM ORDERS);

SELECT CUSTOMER# FROM CUSTOMERS JOIN ORDERS USING(CUSTOMER#) JOIN ORDERITEMS USING(ORDER#) JOIN BOOKS USING(ISBN)WHERE RETAIL = (SELECT MIN(RETAIL) FROM BOOKS); 

SELECT COUNT(DISTINCT CUSTOMER#) FROM ORDERS JOIN ORDERITEMS USING(ORDER#) WHERE ISBN IN (SELECT ISBN FROM ORDERITEMS JOIN BOOKAUTHOR USING(ISBN) 
JOIN AUTHOR USING(AUTHORID) WHERE LNAME ='AUSTIN' AND FNAME='JAMES');

SELECT TITLE FROM BOOKS WHERE PUBID = (SELECT PUBID FROM BOOKS WHERE TITLE = 'THE WOK WAY TO COOK');

CREATE SEQUENCE SQ_CUSTOMER INCREMENT BY 1 START WITH 1021 NOMAXVALUE NOMINVALUE NOCYCLE NOCACHE NOORDER;

INSERT INTO CUSTOMERS (CUSTOMER#,LASTNAME, FIRSTNAME, ZIP) VALUES (SQ_CUSTOMER.NEXTVAL, 'SHOULDERS','FRANK',23567);

CREATE SEQUENCE MY_FIRST_SEQ INCREMENT BY -3 START WITH 5 MINVALUE 0 MAXVALUE 5 NOCYCLE;

SELECT MY_FIRST_SEQ.NEXTVAL FROM DUAL;
SELECT MY_FIRST_SEQ.NEXTVAL FROM DUAL;
SELECT MY_FIRST_SEQ.NEXTVAL FROM DUAL;

ALTER SEQUENCE MY_FIRST_SEQ MINVALUE -1000;

CREATE BITMAP INDEX MY_INDEX ON CUSTOMERS(State);

SELECT INDEX_NAME FROM USER_INDEXES;

DROP INDEX MY_INDEX;

THANH NGUYEN
