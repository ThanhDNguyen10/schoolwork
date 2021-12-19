DROP TABLE aliases CASCADE CONSTRAINTS;
DROP TABLE  criminals CASCADE CONSTRAINTS;
DROP TABLE  criminals_DW CASCADE CONSTRAINTS;

DROP TABLE  crimes CASCADE CONSTRAINTS;
DROP TABLE  appeals CASCADE CONSTRAINTS;
DROP TABLE  officers CASCADE CONSTRAINTS;
DROP TABLE  crime_officers CASCADE CONSTRAINTS;
DROP TABLE  crime_charges CASCADE CONSTRAINTS;
DROP TABLE  crime_codes CASCADE CONSTRAINTS;
DROP TABLE  prob_officers CASCADE CONSTRAINTS;
DROP TABLE  sentences CASCADE CONSTRAINTS;
DROP sequence appeals_id_seq;
DROP table prob_contact CASCADE CONSTRAINTS;
CREATE TABLE aliases
  (alias_id NUMBER(6),
   criminal_id NUMBER(6),
   alias VARCHAR2(10));
CREATE TABLE criminals
  (criminal_id NUMBER(6),
   last VARCHAR2(15),
   first VARCHAR2(10),
   street VARCHAR2(30),
   city VARCHAR2(20),
   state CHAR(2),
   zip CHAR(5),
   phone CHAR(10),
   v_status CHAR(1) DEFAULT 'N',
   p_status CHAR(1) DEFAULT 'N' );
CREATE TABLE crimes
  (crime_id NUMBER(9),
   criminal_id NUMBER(6),
   classification CHAR(1),
   date_charged DATE,
   status CHAR(2),
   hearing_date DATE,
   appeal_cut_date DATE);
CREATE TABLE sentences
  (sentence_id NUMBER(6),
   criminal_id NUMBER(9),
   type CHAR(1),
   prob_id NUMBER(5),
   start_date DATE,
   end_date DATE,
   violations NUMBER(3));
CREATE TABLE prob_officers
  (prob_id NUMBER(5),
   last VARCHAR2(15),
   first VARCHAR2(10),
   street VARCHAR2(30),
   city VARCHAR2(20),
   state CHAR(2),
   zip CHAR(5),
   phone CHAR(10),
   email VARCHAR2(30),
   status CHAR(1) DEFAULT 'A',
   mgr_id NUMBER(5) );
CREATE TABLE officers
  (officer_id NUMBER(8),
   last VARCHAR2(15),
   first VARCHAR2(10),
   precinct CHAR(4),
   badge VARCHAR2(14),
   phone CHAR(10),
   status CHAR(1) DEFAULT 'A' );
CREATE TABLE crime_codes
  (crime_code NUMBER(3),
   code_description VARCHAR2(30));
ALTER TABLE crimes
  MODIFY (classification DEFAULT 'U');
ALTER TABLE crimes
  ADD (date_recorded DATE DEFAULT SYSDATE);
ALTER TABLE prob_officers
  ADD (pager# CHAR(10));
ALTER TABLE aliases
  MODIFY (alias VARCHAR2(20));
ALTER TABLE criminals
  ADD CONSTRAINT criminals_id_pk PRIMARY KEY (criminal_id);
ALTER TABLE criminals
  ADD CONSTRAINT criminals_vstatus_ck CHECK (v_status IN('Y','N'));
ALTER TABLE criminals
  ADD CONSTRAINT criminals_pstatus_ck CHECK (p_status IN('Y','N'));
ALTER TABLE aliases
  ADD CONSTRAINT aliases_id_pk PRIMARY KEY (alias_id);
ALTER TABLE aliases
  ADD CONSTRAINT appeals_criminalid_fk FOREIGN KEY (criminal_id)
             REFERENCES criminals(criminal_id);
ALTER TABLE aliases
  MODIFY (criminal_id NOT NULL);
ALTER TABLE crimes
  ADD CONSTRAINT crimes_id_pk PRIMARY KEY (crime_id);
ALTER TABLE crimes
  ADD CONSTRAINT crimes_class_ck CHECK (classification IN('F','M','O','U'));
ALTER TABLE crimes
  ADD CONSTRAINT crimes_status_ck CHECK (status IN('CL','CA','IA'));
ALTER TABLE crimes
  ADD CONSTRAINT crimes_criminalid_fk FOREIGN KEY (criminal_id)
             REFERENCES criminals(criminal_id);
ALTER TABLE crimes
  MODIFY (criminal_id NOT NULL);
ALTER TABLE prob_officers
   ADD CONSTRAINT probofficers_id_pk PRIMARY KEY (prob_id);
ALTER TABLE prob_officers
  ADD CONSTRAINT probofficers_status_ck CHECK (status IN('A','I'));
ALTER TABLE sentences
  ADD CONSTRAINT sentences_id_pk PRIMARY KEY (sentence_id);
ALTER TABLE sentences
  ADD CONSTRAINT sentences_crimeid_fk FOREIGN KEY (criminal_id)
             REFERENCES criminals(criminal_id);
ALTER TABLE sentences
  MODIFY (criminal_id NOT NULL);
ALTER TABLE sentences
  ADD CONSTRAINT sentences_probid_fk FOREIGN KEY (prob_id)
             REFERENCES prob_officers(prob_id);
ALTER TABLE sentences
  ADD CONSTRAINT sentences_type_ck CHECK (type IN('J','H','P'));
ALTER TABLE officers
  ADD CONSTRAINT officers_id_pk PRIMARY KEY (officer_id);
ALTER TABLE officers
  ADD CONSTRAINT officers_status_ck CHECK (status IN('A','I'));
ALTER TABLE crime_codes
  ADD CONSTRAINT crimecodes_code_pk PRIMARY KEY (crime_code);

CREATE TABLE appeals
  (appeal_id NUMBER(5),
   crime_id NUMBER(9) NOT NULL,
   filing_date DATE,
   hearing_date DATE,
   status CHAR(1) DEFAULT 'P',
     CONSTRAINT appeals_id_pk PRIMARY KEY (appeal_id),
     CONSTRAINT appeals_crimeid_fk FOREIGN KEY (crime_id)
             REFERENCES crimes(crime_id),
     CONSTRAINT appeals_status_ck CHECK (status IN('P','A','D')) );
CREATE TABLE crime_officers
  (crime_id NUMBER(9),
   officer_id NUMBER(8),
     CONSTRAINT crimeofficers_cid_oid_pk PRIMARY KEY (crime_id,officer_id),
     CONSTRAINT crimeofficers_crimeid_fk FOREIGN KEY (crime_id)
             REFERENCES crimes(crime_id),
     CONSTRAINT crimeofficers_officerid_fk FOREIGN KEY (officer_id)
             REFERENCES officers(officer_id) );
CREATE TABLE crime_charges
  (charge_id NUMBER(10),
   crime_id NUMBER(9) NOT NULL,
   crime_code NUMBER(3) NOT NULL,
   charge_status CHAR(2),
   fine_amount NUMBER(7,2),
   court_fee NUMBER(7,2),
   amount_paid NUMBER(7,2),
   pay_due_date DATE,
     CONSTRAINT crimecharges_id_pk PRIMARY KEY (charge_id),
     CONSTRAINT crimecharges_crimeid_fk FOREIGN KEY (crime_id)
             REFERENCES crimes(crime_id),
     CONSTRAINT crimecharges_code_fk FOREIGN KEY (crime_code)
             REFERENCES crime_codes(crime_code),
     CONSTRAINT crimecharges_status_ck CHECK (charge_status IN('PD','GL','NG')) );

INSERT INTO crime_codes
  VALUES (301,'Agg Assault');
INSERT INTO crime_codes
  VALUES (302,'Auto Theft');
INSERT INTO crime_codes
  VALUES (303,'Burglary-Business');
INSERT INTO crime_codes
  VALUES (304,'Criminal Mischief');
INSERT INTO crime_codes
  VALUES (305,'Drug Offense');
INSERT INTO crime_codes
  VALUES (306,'Bomb Threat');
INSERT INTO prob_officers (prob_id, last, first, city, status, mgr_id)
  VALUES (100, 'Peek', 'Susan', 'Virginia Beach', 'A', NULL);
INSERT INTO prob_officers (prob_id, last, first, city, status, mgr_id)
  VALUES (102, 'Speckle', 'Jeff', 'Virginia Beach', 'A', 100);
INSERT INTO prob_officers (prob_id, last, first, city, status, mgr_id)
  VALUES (104, 'Boyle', 'Chris', 'Virginia Beach', 'A', 100);
INSERT INTO prob_officers (prob_id, last, first, city, status, mgr_id)
  VALUES (106, 'Taps', 'George', 'Chesapeake', 'A', NULL);
INSERT INTO prob_officers (prob_id, last, first, city, status, mgr_id)
  VALUES (108, 'Ponds', 'Terry', 'Chesapeake', 'A', 106);
INSERT INTO prob_officers (prob_id, last, first, city, status, mgr_id)
  VALUES (110, 'Hawk', 'Fred', 'Chesapeake', 'I', 106);
INSERT INTO officers (officer_id, last, first, precinct, badge, phone, status)
  VALUES (111112, 'Shocks', 'Pam', 'OCVW', 'E5546A33', '7574446767', 'A');
INSERT INTO officers (officer_id, last, first, precinct, badge, phone, status)
  VALUES (111113, 'Busey', 'Gerry', 'GHNT', 'E5577D48', '7574446767', 'A');
INSERT INTO officers (officer_id, last, first, precinct, badge, phone, status)
  VALUES (111114, 'Gants', 'Dale', 'SBCH', 'E5536N02', '7574446767', 'A');
INSERT INTO officers (officer_id, last, first, precinct, badge, phone, status)
  VALUES (111115, 'Hart', 'Leigh', 'WAVE', 'E5511J40', '7574446767', 'A');
INSERT INTO officers (officer_id, last, first, precinct, badge, phone, status)
  VALUES (111116, 'Sands', 'Ben', 'OCVW', 'E5588R00', '7574446767', 'I');
COMMIT;
INSERT INTO criminals (criminal_id, last, first, street, city, state, zip, phone, v_status, p_status)
  VALUES (1020, 'Phelps','Sam','1105 Tree Lane', 'Virginia Beach', 'VA', '23510', 
                  7576778484, 'Y', 'N');
INSERT INTO crimes (crime_id, criminal_id, classification, date_charged, status,
                                 hearing_date, appeal_cut_date)
  VALUES (10085, 1020, 'F', '03-SEP-08', 'CA', '15-SEP-08', '15-DEC-08');
INSERT INTO crime_charges(charge_id, crime_id, crime_code, charge_status,
                                           fine_amount, court_fee, amount_paid, pay_due_date)
  VALUES (5000, 10085, 301, 'GL', 3000, 200, 40, '15-OCT-08');
INSERT INTO crime_charges(charge_id, crime_id, crime_code, charge_status,
                                           fine_amount, court_fee, amount_paid, pay_due_date)
  VALUES (5001, 10085, 305, 'GL', 1000, 100, NULL, '15-OCT-08');
INSERT INTO sentences (sentence_id, criminal_id, type, prob_id, start_date,
                                      end_date, violations)
   VALUES (1000, 1020, 'J', NULL, '15-SEP-08', '15-SEP-10', 0);
INSERT INTO aliases (alias_id, criminal_id, alias)
  VALUES (100, 1020, 'Bat');
INSERT INTO crime_officers (crime_id, officer_id)
   VALUES (10085, 111112);
INSERT INTO criminals (criminal_id, last, first, street, city, state, zip, phone, v_status, p_status)
  VALUES (1021, 'Sums','Tammy','22 E. Ave', 'Virginia Beach', 'VA', '23510', 
                  7575453390, 'N', 'Y');
INSERT INTO crimes (crime_id, criminal_id, classification, date_charged, status,
                                 hearing_date, appeal_cut_date)
  VALUES (10086, 1021, 'M', '20-OCT-08', 'CL', '05-DEC-08', NULL);
INSERT INTO crime_charges(charge_id, crime_id, crime_code, charge_status,
                                           fine_amount, court_fee, amount_paid, pay_due_date)
  VALUES (5002, 10086, 304, 'GL', 200, 100, 25, '15-FEB-09');
INSERT INTO sentences (sentence_id, criminal_id, type, prob_id, start_date,
                                      end_date, violations)
   VALUES (1001, 1021, 'P', 102, '05-DEC-08', '05-JUN-09', 0);
INSERT INTO crime_officers (crime_id, officer_id)
   VALUES (10086, 111114);

INSERT INTO criminals (criminal_id, last, first, street, city, state, zip, phone, v_status, p_status)
  VALUES (1022, 'Caulk','Dave', '8112 Chester Lane', 'Chesapeake', 'VA', '23320', 
                  7578403690, 'N', 'Y');
INSERT INTO crimes (crime_id, criminal_id, classification, date_charged, status,
                                 hearing_date, appeal_cut_date)
  VALUES (10087, 1022, 'M', '30-OCT-08', 'IA', '05-DEC-08', '15-MAR-09');
INSERT INTO crime_charges(charge_id, crime_id, crime_code, charge_status,
                                           fine_amount, court_fee, amount_paid, pay_due_date)
  VALUES (5003, 10087, 305, 'GL', 100, 50, 150, '15-MAR-09');
INSERT INTO sentences (sentence_id, criminal_id, type, prob_id, start_date,
                                      end_date, violations)
   VALUES (1002, 1022, 'P', 108, '20-MAR-09', '20-AUG-09', 0);
INSERT INTO crime_officers (crime_id, officer_id)
   VALUES (10087, 111115);
INSERT INTO aliases (alias_id, criminal_id, alias)
  VALUES (101, 1022, 'Cabby');
INSERT INTO appeals (appeal_id, crime_id, filing_date, hearing_date, status)
   VALUES (7500, 10087,  '10-DEC-08',  '20-DEC-08', 'A');
INSERT INTO appeals (appeal_id, crime_id, filing_date, hearing_date, status)
   VALUES (7501, 10086,  '15-DEC-08',  '20-DEC-08', 'A');
INSERT INTO appeals (appeal_id, crime_id, filing_date, hearing_date, status)
   VALUES (7502, 10085,  '20-SEP-08',  '28-OCT-08', 'A');
INSERT INTO criminals (criminal_id, last, first, street, city, state, zip, phone, v_status, p_status)
  VALUES (1023, 'Dabber','Pat', NULL, 'Chesapeake', 'VA', '23320', 
                  NULL, 'N', 'N');
INSERT INTO crimes (crime_id, criminal_id, classification, date_charged, status,
                                 hearing_date, appeal_cut_date)
  VALUES (10088, 1023, 'O', '05-NOV-08', 'CA',  NULL, NULL);
INSERT INTO crime_charges(charge_id, crime_id, crime_code, charge_status,
                                           fine_amount, court_fee, amount_paid, pay_due_date)
  VALUES (5004, 10088, 306, 'PD', NULL, NULL, NULL, NULL);
INSERT INTO crime_officers (crime_id, officer_id)
   VALUES (10088, 111115);

INSERT INTO criminals (criminal_id, last, first, street, city, state, zip, phone, v_status, p_status)
  VALUES (1025, 'Cat','Tommy', NULL, 'Norfolk', 'VA', '26503', 
                  NULL, 'N', 'Y');
INSERT INTO crimes (crime_id, criminal_id, classification, date_charged, status,
                                 hearing_date, appeal_cut_date)
  VALUES (10089, 1025, 'M', '22-OCT-08', 'CA', '25-NOV-08', '15-FEB-09');
INSERT INTO crime_charges(charge_id, crime_id, crime_code, charge_status,
                                           fine_amount, court_fee, amount_paid, pay_due_date)
  VALUES (5005, 10089, 305, 'GL', 100, 50, NULL, '15-FEB-09');
INSERT INTO sentences (sentence_id, criminal_id, type, prob_id, start_date,
                                      end_date, violations)
   VALUES (1004, 1025, 'P', 106, '20-DEC-08', '20-MAR-09', 0);
INSERT INTO crime_officers (crime_id, officer_id)
   VALUES (10089, 111115);
INSERT INTO crime_officers (crime_id, officer_id)
   VALUES (10089, 111116);

INSERT INTO criminals (criminal_id, last, first, street, city, state, zip, phone, v_status, p_status)
  VALUES (1026, 'Simon','Tim', NULL, 'Norfolk', 'VA', '26503', 
                  NULL, 'N', 'Y');
INSERT INTO crimes (crime_id, criminal_id, classification, date_charged, status,
                                 hearing_date, appeal_cut_date)
  VALUES (10090, 1026, 'M', '22-OCT-08', 'CA', '25-NOV-08', '15-FEB-09');
INSERT INTO crime_charges(charge_id, crime_id, crime_code, charge_status,
                                           fine_amount, court_fee, amount_paid, pay_due_date)
  VALUES (5006, 10090, 305, 'GL', 100, 50, NULL, '15-FEB-09');
INSERT INTO sentences (sentence_id, criminal_id, type, prob_id, start_date,
                                      end_date, violations)
   VALUES (1005, 1026, 'P', 106, '20-DEC-08', '20-MAR-09', 0);
INSERT INTO crime_officers (crime_id, officer_id)
   VALUES (10090, 111115);

INSERT INTO criminals (criminal_id, last, first, street, city, state, zip, phone, v_status, p_status)
  VALUES (1027, 'Pints','Reed', NULL, 'Norfolk', 'VA', '26505', 
                  NULL, 'N', 'Y');
INSERT INTO crimes (crime_id, criminal_id, classification, date_charged, status,
                                 hearing_date, appeal_cut_date)
  VALUES (10091, 1027, 'M', '24-OCT-08', 'CA', '28-NOV-08', '15-FEB-09');
INSERT INTO crime_charges(charge_id, crime_id, crime_code, charge_status,
                                           fine_amount, court_fee, amount_paid, pay_due_date)
  VALUES (5007, 10091, 305, 'GL', 100, 50, 20, '15-FEB-09');
INSERT INTO sentences (sentence_id, criminal_id, type, prob_id, start_date,
                                      end_date, violations)
   VALUES (1006, 1027, 'P', 106, '20-DEC-08', '20-MAR-09', 0);
INSERT INTO crime_officers (crime_id, officer_id)
   VALUES (10091, 111115);

INSERT INTO criminals (criminal_id, last, first, street, city, state, zip, phone, v_status, p_status)
  VALUES (1028, 'Mansville','Nancy', NULL, 'Norfolk', 'VA', '26505', 
                  NULL, 'N', 'Y');
INSERT INTO crimes (crime_id, criminal_id, classification, date_charged, status,
                                 hearing_date, appeal_cut_date)
  VALUES (10092, 1028, 'M', '24-OCT-08', 'CA', '28-NOV-08', '15-FEB-09');
INSERT INTO crime_charges(charge_id, crime_id, crime_code, charge_status,
                                           fine_amount, court_fee, amount_paid, pay_due_date)
  VALUES (5008, 10092, 305, 'GL', 100, 50, 25, '15-FEB-09');
INSERT INTO sentences (sentence_id, criminal_id, type, prob_id, start_date,
                                      end_date, violations)
   VALUES (1007, 1028, 'P', 106, '20-DEC-08', '20-MAR-09', 0);
INSERT INTO crime_officers (crime_id, officer_id)
   VALUES (10092, 111115);

INSERT INTO criminals (criminal_id, last, first, street, city, state, zip, phone, v_status, p_status)
  VALUES (1024, 'Perry','Cart', NULL, 'Norfolk', 'VA', '26501', 
                  NULL, 'N', 'Y');
INSERT INTO crimes (crime_id, criminal_id, classification, date_charged, status,
                                 hearing_date, appeal_cut_date)
  VALUES (10093, 1024, 'M', '22-OCT-08', 'CA', '25-NOV-08', '15-FEB-09');
INSERT INTO crime_charges(charge_id, crime_id, crime_code, charge_status,
                                           fine_amount, court_fee, amount_paid, pay_due_date)
  VALUES (5009, 10093, 305, 'GL', 100, 50, NULL, '15-FEB-09');
INSERT INTO sentences (sentence_id, criminal_id, type, prob_id, start_date,
                                      end_date, violations)
   VALUES (1003, 1024, 'P', 106, '20-DEC-08', '20-MAR-09', 1);
INSERT INTO crime_officers (crime_id, officer_id)
   VALUES (10093, 111115);

INSERT INTO criminals (criminal_id, last, first, street, city, state, zip, phone, v_status, p_status)
  VALUES (1029, 'Statin','Penny', NULL, 'Norfolk', 'VA', '26505', 
                  NULL, 'N', 'Y');
INSERT INTO crimes (crime_id, criminal_id, classification, date_charged, status,
                                 hearing_date, appeal_cut_date)
  VALUES (10094, 1029, 'M', '26-OCT-08', 'CA', '26-NOV-08', '17-FEB-09');
INSERT INTO crime_charges(charge_id, crime_id, crime_code, charge_status,
                                           fine_amount, court_fee, amount_paid, pay_due_date)
  VALUES (5010, 10094, 305, 'GL', 50, 50, NULL, '17-FEB-09');
INSERT INTO sentences (sentence_id, criminal_id, type, prob_id, start_date,
                                      end_date, violations)
   VALUES (1008, 1029, 'P', 106, '20-DEC-08', '05-FEB-09', 1);
INSERT INTO crime_officers (crime_id, officer_id)
   VALUES (10094, 111115);

INSERT INTO criminals (criminal_id, last, first, street, city, state, zip, phone, v_status, p_status)
  VALUES (1030, 'Panner','Lee', NULL, 'Norfolk', 'VA', '26505', 
                  NULL, 'N', 'Y');
INSERT INTO crimes (crime_id, criminal_id, classification, date_charged, status,
                                 hearing_date, appeal_cut_date)
  VALUES (25344031, 1030, 'M', '26-OCT-08', 'CA', '26-NOV-08', '17-FEB-09');
INSERT INTO crime_charges(charge_id, crime_id, crime_code, charge_status,
                                           fine_amount, court_fee, amount_paid, pay_due_date)
  VALUES (5011, 25344031, 305, 'GL', 50, 50, NULL, '17-FEB-09');
INSERT INTO sentences (sentence_id, criminal_id, type, prob_id, start_date,
                                      end_date, violations)
   VALUES (1009, 1030, 'P', 106, '20-DEC-08', '05-FEB-09', 1);
INSERT INTO crime_officers (crime_id, officer_id)
   VALUES (25344031, 111115);

INSERT INTO crimes (crime_id, criminal_id, classification, date_charged, status,
                                 hearing_date, appeal_cut_date)
  VALUES (25344060, 1030, 'M', '18-NOV-08', 'CL', '26-NOV-08', NULL);
INSERT INTO crime_charges(charge_id, crime_id, crime_code, charge_status,
                                           fine_amount, court_fee, amount_paid, pay_due_date)
  VALUES (5012, 25344060, 305, 'GL', 50, 50, 100, '17-FEB-09');
INSERT INTO sentences (sentence_id, criminal_id, type, prob_id, start_date,
                                      end_date, violations)
   VALUES (1010, 1030, 'P', 106, '06-FEB-09', '06-JUL-09', 0);
INSERT INTO crime_officers (crime_id, officer_id)
   VALUES (25344060, 111116);
COMMIT;

CREATE SEQUENCE appeals_id_seq
  START WITH 7505
  NOCACHE
  NOCYCLE;

CREATE TABLE prob_contact 
  (prob_cat number(2),
   low_amt number(5),
   high_amt number(5),
   con_freq VARCHAR2(20) );
INSERT INTO prob_contact
  VALUES(10, 1, 80, 'Weekly');
INSERT INTO prob_contact
  VALUES(20, 81, 160, 'Every 2 weeks');
INSERT INTO prob_contact
  VALUES(30, 161, 500, 'Monthly');
COMMIT;

CREATE TABLE criminals_dw
  (criminal_id NUMBER(6),
   last VARCHAR2(15),
   first VARCHAR2(10),
   street VARCHAR2(30),
   city VARCHAR2(20),
   state CHAR(2),
   zip CHAR(5),
   phone CHAR(10),
   v_status CHAR(1),
   p_status CHAR(1) );
INSERT INTO criminals_dw (criminal_id, last, first, street, city, state, zip, phone, v_status, p_status)
  VALUES (1020, 'Phelps','Sam','1105 Tree Lane', 'Virginia Beach', 'VA', '23510', 
                  7576778484, 'Y', 'N');
INSERT INTO criminals_dw (criminal_id, last, first, street, city, state, zip, phone, v_status, p_status)
  VALUES (1021, 'Sums','Tammy','22 E. Ave', 'Virginia Beach', 'VA', '23510', 
                  7575453390, 'N', 'Y');
INSERT INTO criminals_dw (criminal_id, last, first, street, city, state, zip, phone, v_status, p_status)
  VALUES (1022, 'Caulk','Dave', '8112 Chester Lane', 'Chesapeake', 'VA', '23320', 
                  7578403690, 'N', 'Y');
INSERT INTO criminals_dw (criminal_id, last, first, street, city, state, zip, phone, v_status, p_status)
  VALUES (1023, 'Dabber','Pat', NULL, 'Chesapeake', 'VA', '23320', 
                  NULL, 'N', 'N');
INSERT INTO criminals_dw (criminal_id, last, first, street, city, state, zip, phone, v_status, p_status)
  VALUES (1024, 'Perry','Cart', '11 New St.', 'Surry', 'VA', '54501', 
                  NULL, 'N', 'Y');
INSERT INTO criminals_dw (criminal_id, last, first, street, city, state, zip, phone, v_status, p_status)
  VALUES (1025, 'Cat','Tommy', NULL, 'Norfolk', 'VA', '26503', 
                  7578889393, 'N', 'Y');
COMMIT;

SELECT LAST, FIRST FROM OFFICERS JOIN CRIME_OFFICERS USING(OFFICER_ID) GROUP BY LAST,FIRST 
HAVING COUNT(*) > (SELECT COUNT(*)/(COUNT(DISTINCT(OFFICER_ID))) FROM CRIME_OFFICERS);

SELECT*FROM APPEALS WHERE (HEARING_DATE-FILING_DATE) < (SELECT AVG(HEARING_DATE-FILING_DATE) FROM APPEALS);

SELECT LAST, FIRST FROM PROB_OFFICERS GROUP BY LAST, FIRST HAVING COUNT(PROB_ID) < (SELECT COUNT(*)/COUNT(DISTINCT(PROB_ID)) FROM SENTENCES);

SELECT CRIME_ID FROM CRIMES WHERE CRIME_ID IN (SELECT CRIME_ID FROM APPEALS GROUP BY CRIME_ID HAVING COUNT(*) =
(SELECT MAX(COUNT(*)) FROM APPEALS GROUP BY CRIME_ID));

SELECT*FROM CRIME_CHARGES WHERE FINE_AMOUNT > (SELECT AVG(FINE_AMOUNT) FROM CRIME_CHARGES ) AND AMOUNT_PAID < (SELECT AVG(FINE_AMOUNT) FROM CRIME_CHARGES);

SELECT LAST, FIRST FROM CRIMINALS JOIN CRIMES USING(CRIMINAL_ID) JOIN CRIME_CHARGES USING(CRIME_ID)
WHERE CRIME_ID = 10089 AND CRIME_CODE IN (SELECT CRIME_CODE FROM CRIME_CHARGES);

SELECT CRIMINAL_ID, LAST, FIRST FROM CRIMINALS WHERE EXISTS (SELECT CRIMINAL_ID FROM CRIMINALS JOIN SENTENCES USING(CRIMINAL_ID)) AND P_STATUS = 'Y';

SELECT DISTINCT LAST, FIRST FROM OFFICERS JOIN CRIME_OFFICERS USING(OFFICER_ID) WHERE OFFICER_ID IN
(SELECT OFFICER_ID FROM CRIME_OFFICERS GROUP BY OFFICER_ID HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM CRIME_OFFICERS GROUP BY OFFICER_ID));
COMMIT;


MERGE INTO CRIMINALS_DW A USING CRIMINALS B ON (A.CRIMINAL_ID = B.CRIMINAL_ID)
WHEN MATCHED THEN 
    UPDATE SET A.V_STATUS=B.V_STATUS, A.P_STATUS = B.P_STATUS
WHEN NOT MATCHED THEN
    INSERT (criminal_id, last, first, street, city, state, zip, phone, v_status, p_status) 
    VALUES (B.criminal_id, B.last, B.first, B.street, B.city, B.state, B.zip, B.phone, B.v_status, B.p_status);

THANH NGUYEN

SELECT*FROM CRIMINALS;
SELECT*FROM CRIMINALS_DW;


THANH NGUYEN








SELECT officer_id, avg(crime_id) FROM crime_officers GROUP BY officer_id;

THANH NGUYEN

SELECT criminal_id, last||' ' ||first AS NAME, count(sentence_id) AS NUM_SENTENCES 
FROM criminals JOIN sentences USING(criminal_id) GROUP BY criminal_id, last, first 
HAVING COUNT(SENTENCE_ID) >1; 

SELECT precinct, COUNT(charge_status) FROM crime_charges h JOIN crimes c USING(crime_id) JOIN crime_officers f USING(crime_id)
JOIN officers o USING(officer_id) WHERE charge_status = 'GL' GROUP BY precinct HAVING COUNT(charge_status) >=7;

SELECT classification, SUM(fine_Amount+court_fee) AS Collections FROM crime_charges INNER JOIN crimes ON crime_charges.crime_id = crimes.crime_id 
GROUP BY classification;

SELECT c.classification, c.status, COUNT(charge_id) AS NUM_CHARGES FROM crime_charges h INNER JOIN crimes c ON c.crime_id = h.crime_id
GROUP BY status, classification;

SELECT COUNT(*) AS total FROM crime_charges h LEFT JOIN crimes c ON h.crime_id = c.crime_id WHERE c.classification = 'M' GROUP BY c.classification;

SELECT COUNT(*) AS total FROM crime_charges h LEFT JOIN crimes c ON h.crime_id = c.crime_id WHERE h.charge_status = 'GL' GROUP BY h.charge_status;

SELECT SUM(total) AS subtotal FROM (SELECT COUNT(*) AS total FROM crime_charges h LEFT JOIN crimes c ON h.crime_id = c.crime_id 
WHERE c.classification = 'M' GROUP BY c.classification);

SELECT SUM(total) AS subtotal FROM (SELECT COUNT(*) AS total FROM crime_charges h LEFT JOIN crimes c ON h.crime_id = c.crime_id 
WHERE h.charge_status = 'GL' GROUP BY h.charge_status);

THANH NGUYEN