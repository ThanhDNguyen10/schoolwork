CREATE OR REPLACE FUNCTION dd_paydate1_sf
  (p_id IN dd_pledge.idpledge%TYPE)
  RETURN DATE
  IS
  lv_pl_dat DATE;
  lv_mth_txt VARCHAR2(2);
  lv_yr_txt VARCHAR2(4);
BEGIN
  SELECT ADD_MONTHS(pledgedate,1)
    INTO lv_pl_dat
    FROM dd_pledge
    WHERE idpledge = p_id;
  lv_mth_txt := TO_CHAR(lv_pl_dat,'mm');
  lv_yr_txt := TO_CHAR(lv_pl_dat,'yyyy');
  RETURN TO_DATE((lv_mth_txt || '-01-' || lv_yr_txt),'mm-dd-yyyy');
END;

CREATE OR REPLACE FUNCTION dd_payend_sf
  (p_id IN dd_pledge.idpledge%TYPE)
  RETURN DATE
  IS
  lv_pay1_dat DATE;
  lv_mths_num dd_pledge.paymonths%TYPE;
BEGIN
  SELECT dd_paydate1_sf(idpledge), paymonths - 1
    INTO lv_pay1_dat, lv_mths_num
    FROM dd_pledge
    WHERE idpledge = p_id;
  IF lv_mths_num = 0 THEN
     RETURN lv_pay1_dat;
  ELSE
     RETURN ADD_MONTHS(lv_pay1_dat, lv_mths_num);
  END IF;
END;


--7.9

CREATE OR REPLACE PACKAGE PLEDGE_PKG IS --THANH NGUYEN
    FUNCTION DD_PAYDATE1_PF 
    (PID IN DD_PLEDGE.IDPLEDGE%TYPE) 
    RETURN DATE;
    FUNCTION DD_PAYEND_PF 
    (PID IN DD_PLEDGE.IDPLEDGE%TYPE) 
    RETURN DATE;
END PLEDGE_PKG;

CREATE OR REPLACE PACKAGE BODY PLEDGE_PKG IS --THANH NGUYEN
 FUNCTION DD_PAYDATE1_PF
    (PID IN DD_PLEDGE.IDPLEDGE%TYPE)
    RETURN DATE
 IS   
  lv_pl_dat DATE;
  lv_mth_txt VARCHAR2(2);
  lv_yr_txt VARCHAR2(4);
BEGIN
  SELECT ADD_MONTHS(pledgedate,1) INTO lv_pl_dat FROM dd_pledge WHERE idpledge = pid;
  lv_mth_txt := TO_CHAR(lv_pl_dat,'mm');
  lv_yr_txt := TO_CHAR(lv_pl_dat,'yyyy');
  RETURN TO_DATE((lv_mth_txt || '-01-' || lv_yr_txt),'mm-dd-yyyy');
 END DD_PAYDATE1_PF;
 FUNCTION DD_PAYEND_PF
    (PID IN DD_PLEDGE.IDPLEDGE%TYPE)
    RETURN DATE
 IS 
    lv_pay1_dat DATE;
  lv_mths_num dd_pledge.paymonths%TYPE;
BEGIN
  SELECT dd_paydate1_sf(idpledge), paymonths - 1 INTO lv_pay1_dat, lv_mths_num FROM dd_pledge WHERE idpledge = pid;
  IF lv_mths_num = 0 THEN
     RETURN lv_pay1_dat;
  ELSE
     RETURN ADD_MONTHS(lv_pay1_dat, lv_mths_num);
  END IF;
 END DD_PAYEND_PF;
END; 

THANH NGUYEN

DECLARE
    IDP NUMBER := 101;
BEGIN
    DBMS_OUTPUT.PUT_LINE('PLEDGE ID: '||IDP);
    DBMS_OUTPUT.PUT_LINE('FIRST PAY DATE: '||PLEDGE_PKG.DD_PAYDATE1_PF(IDP));
    DBMS_OUTPUT.PUT_LINE('LAST PAY DATE: '||PLEDGE_PKG.DD_PAYEND_PF(IDP));
END;

THANH NGUYEN

SELECT IDPLEDGE, PLEDGE_PKG.DD_PAYDATE1_PF(IDPLEDGE), PLEDGE_PKG.DD_PAYEND_PF(IDPLEDGE) FROM DD_PLEDGE WHERE IDPLEDGE BETWEEN 100 AND 112;

THANH NGUYEN

SET SERVEROUTPUT ON

--7.10
CREATE OR REPLACE PACKAGE PLEDGE_PKG IS --THANH NGUYEN
    F_P DATE;
    L_P DATE;
    PROCEDURE DD_PLIST_PP
    (IDD IN DD_DONOR.IDDONOR%TYPE, NAME OUT VARCHAR2, IDP OUT DD_PLEDGE.IDPLEDGE%TYPE, F_PAY OUT DATE, L_PAY OUT DATE);
END PLEDGE_PKG;

CREATE OR REPLACE PACKAGE BODY PLEDGE_PKG IS --THANH NGUYEN
 FUNCTION DD_PAYDATE1_PF
    (PID IN DD_PLEDGE.IDPLEDGE%TYPE)
    RETURN DATE
 IS   
  lv_pl_dat DATE;
  lv_mth_txt VARCHAR2(2);
  lv_yr_txt VARCHAR2(4);
BEGIN
  SELECT ADD_MONTHS(pledgedate,1) INTO lv_pl_dat FROM dd_pledge WHERE idpledge = pid;
  lv_mth_txt := TO_CHAR(lv_pl_dat,'mm');
  lv_yr_txt := TO_CHAR(lv_pl_dat,'yyyy');
  F_P := TO_DATE((lv_mth_txt || '-01-' || lv_yr_txt),'mm-dd-yyyy');
  RETURN TO_DATE((lv_mth_txt || '-01-' || lv_yr_txt),'mm-dd-yyyy');
 END DD_PAYDATE1_PF;
 FUNCTION DD_PAYEND_PF              --THANH NGUYEN
    (PID IN DD_PLEDGE.IDPLEDGE%TYPE)
    RETURN DATE
 IS 
    lv_pay1_dat DATE;
  lv_mths_num dd_pledge.paymonths%TYPE;
BEGIN
  SELECT dd_paydate1_sf(idpledge), paymonths - 1 INTO lv_pay1_dat, lv_mths_num FROM dd_pledge WHERE idpledge = pid;
  IF lv_mths_num = 0 THEN
     RETURN lv_pay1_dat;
     L_P := LV_PAY1_DAT;
  ELSE
     RETURN ADD_MONTHS(lv_pay1_dat, lv_mths_num);
     L_P := ADD_MONTHS(lv_pay1_dat, lv_mths_num);
  END IF;
 END DD_PAYEND_PF;
 PROCEDURE DD_PLIST_PP
     (IDD IN DD_DONOR.IDDONOR%TYPE, NAME OUT VARCHAR2, IDP OUT DD_PLEDGE.IDPLEDGE%TYPE, F_PAY OUT DATE, L_PAY OUT DATE)
 IS
    ID_D DD_DONOR.IDDONOR%TYPE;
 BEGIN
    SELECT FIRSTNAME||' '||LASTNAME, P.IDPLEDGE INTO NAME, IDP FROM DD_DONOR D JOIN DD_PLEDGE P USING(IDDONOR) WHERE IDD = IDDONOR;
    F_PAY := DD_PAYDATE1_PF(IDP);
    L_PAY := DD_PAYEND_PF(IDP);
 END DD_PLIST_PP;   
END; 

THANH NGUYEN

DECLARE
    IDD NUMBER(5) := 302;
    NAME VARCHAR(25);
    IDP NUMBER(5);
    F_P DATE;
    L_P DATE;
BEGIN
    PLEDGE_PKG.DD_PLIST_PP(IDD,NAME,IDP,F_P,L_P);    
    DBMS_OUTPUT.PUT_LINE('NAME: '||NAME);
    DBMS_OUTPUT.PUT_LINE('PLEDGE ID: '||IDP);
    DBMS_OUTPUT.PUT_LINE('FIRST PAY DATE: '||F_P);
    DBMS_OUTPUT.PUT_LINE('LAST PAY DATE: '||L_P);
END;


--7.11
CREATE OR REPLACE PACKAGE PLEDGE_PKG IS --THANH NGUYEN
    F_P DATE;
    L_P DATE;
    PROCEDURE DD_PLIST_PP
    (IDD IN DD_DONOR.IDDONOR%TYPE, NAME OUT VARCHAR2, IDP OUT DD_PLEDGE.IDPLEDGE%TYPE, F_PAY OUT DATE, L_PAY OUT DATE);
    PROCEDURE DD_PAYS_PP
    (IDD IN DD_DONOR.IDDONOR%TYPE, LNAME OUT VARCHAR2, IDP OUT DD_PLEDGE.IDPLEDGE%TYPE, P_AMT OUT DD_PAYMENT.PAYAMT%TYPE, P_DATE OUT DD_PAYMENT.PAYDATE%TYPE);
END PLEDGE_PKG;

THANH NGUYEN

CREATE OR REPLACE PACKAGE BODY PLEDGE_PKG IS --THANH NGUYEN
 FUNCTION DD_PAYDATE1_PF
    (PID IN DD_PLEDGE.IDPLEDGE%TYPE)
    RETURN DATE
 IS   
  lv_pl_dat DATE;
  lv_mth_txt VARCHAR2(2);
  lv_yr_txt VARCHAR2(4);
BEGIN
  SELECT ADD_MONTHS(pledgedate,1) INTO lv_pl_dat FROM dd_pledge WHERE idpledge = pid;
  lv_mth_txt := TO_CHAR(lv_pl_dat,'mm');
  lv_yr_txt := TO_CHAR(lv_pl_dat,'yyyy');
  F_P := TO_DATE((lv_mth_txt || '-01-' || lv_yr_txt),'mm-dd-yyyy');
  RETURN TO_DATE((lv_mth_txt || '-01-' || lv_yr_txt),'mm-dd-yyyy');
 END DD_PAYDATE1_PF;
 FUNCTION DD_PAYEND_PF              --THANH NGUYEN
    (PID IN DD_PLEDGE.IDPLEDGE%TYPE)
    RETURN DATE
 IS 
    lv_pay1_dat DATE;
  lv_mths_num dd_pledge.paymonths%TYPE;
BEGIN
  SELECT dd_paydate1_sf(idpledge), paymonths - 1 INTO lv_pay1_dat, lv_mths_num FROM dd_pledge WHERE idpledge = pid;
  IF lv_mths_num = 0 THEN
     RETURN lv_pay1_dat;
     L_P := LV_PAY1_DAT;
  ELSE
     RETURN ADD_MONTHS(lv_pay1_dat, lv_mths_num);
     L_P := ADD_MONTHS(lv_pay1_dat, lv_mths_num);
  END IF;
 END DD_PAYEND_PF;
 PROCEDURE DD_PLIST_PP                      --THANH NGUYEN
     (IDD IN DD_DONOR.IDDONOR%TYPE, NAME OUT VARCHAR2, IDP OUT DD_PLEDGE.IDPLEDGE%TYPE, F_PAY OUT DATE, L_PAY OUT DATE)
 IS
    ID_D DD_DONOR.IDDONOR%TYPE;
 BEGIN
    SELECT FIRSTNAME||' '||LASTNAME, P.IDPLEDGE INTO NAME, IDP FROM DD_DONOR D JOIN DD_PLEDGE P USING(IDDONOR) WHERE IDD = IDDONOR;
    F_PAY := DD_PAYDATE1_PF(IDP);
    L_PAY := DD_PAYEND_PF(IDP);
 END DD_PLIST_PP;   
 PROCEDURE DD_PAYS_PP
    (IDD IN DD_DONOR.IDDONOR%TYPE, LNAME OUT VARCHAR2, IDP OUT DD_PLEDGE.IDPLEDGE%TYPE, P_AMT OUT DD_PAYMENT.PAYAMT%TYPE, P_DATE OUT DD_PAYMENT.PAYDATE%TYPE)
 IS
 BEGIN
    SELECT D.LASTNAME, IDPLEDGE, P.PAYAMT, P.PAYDATE INTO LNAME, IDP, P_AMT, P_DATE
    FROM DD_DONOR D JOIN DD_PLEDGE E USING (IDDONOR) JOIN DD_PAYMENT P USING (IDPLEDGE)
    WHERE IDD = IDDONOR;
 END DD_PAYS_PP;
END; 

THANH NGUYEN

DECLARE
    IDD NUMBER(5) := 306;
    LNAME VARCHAR(25);
    IDP NUMBER(5);
    AMT number(8,2);
    P_D DATE;
BEGIN
    PLEDGE_PKG.DD_PAYS_PP(IDD,LNAME,IDP,AMT,P_D);    
    DBMS_OUTPUT.PUT_LINE('NAME: '||LNAME);
    DBMS_OUTPUT.PUT_LINE('PLEDGE ID: '||IDP);
    DBMS_OUTPUT.PUT_LINE('PAY AMOUNT: '||AMT);
    DBMS_OUTPUT.PUT_LINE('PAY DATE: '||P_D);
END;

THANH NGUYEN

SET SERVEROUTPUT ON


--9.9
CREATE TABLE DD_PAYTRACK(
                   idPayT number(6),
                   USERNAME VARCHAR2(25),
                   Curdate DATE,
                   ACTION VARCHAR2(10),
                   CONSTRAINT PAYTRACK_ID_PK PRIMARY KEY(IDPAYT));   

CREATE SEQUENCE DD_PAYTRACK_SEQ START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 9999; 
         
CREATE OR REPLACE TRIGGER PAYTRACK
    BEFORE INSERT OR UPDATE OR DELETE ON DD_PAYMENT
    FOR EACH ROW
DECLARE
    V_CHANGE VARCHAR2(25);
BEGIN
    IF INSERTING THEN 
        V_CHANGE := 'INSERT';
    ELSIF UPDATING THEN
        V_CHANGE := 'UPDATE';
    ELSE
        V_CHANGE := 'DELETE';
    END IF;
    INSERT INTO DD_PAYTRACK VALUES (DD_PAYTRACK_SEQ.NEXTVAL,USER,SYSDATE,V_CHANGE);
END;    

THANH NGUYEN

INSERT INTO dd_payment
   VALUES (1465,101,5,'21-SEP-2012','DC');
   
THANH NGUYEN   
  
SELECT*FROM DD_PAYTRACK;

THANH NGUYEN
