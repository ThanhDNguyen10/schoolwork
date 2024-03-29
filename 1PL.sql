SET SERVEROUTPUT ON

BEGIN
    DBMS_OUTPUT.PUT_LINE('THANH NGUYEN');
END;

DECLARE
    V_1 NUMBER;
    V_2 NUMBER;
BEGIN
    V_1 := 0; V_2 := 0;
    V_2 := V_1+1;
    DBMS_OUTPUT.PUT_LINE(V_2);
END;    
   
DECLARE
    CUR_DATE DATE;
BEGIN
    CUR_DATE := SYSDATE;
    DBMS_OUTPUT.PUT_LINE(CUR_DATE);
END;    

DECLARE
    V_NUMBER NUMBER := 10;
BEGIN
    IF V_NUMBER >= 0 THEN
        DBMS_OUTPUT.PUT_LINE(V_NUMBER);
    END IF;    
END;  
/

DECLARE
    V_NUMBER NUMBER := -1;
BEGIN
    IF V_NUMBER >= 0 THEN
        DBMS_OUTPUT.PUT_LINE(V_NUMBER);
    ELSE 
        DBMS_OUTPUT.PUT_LINE(V_NUMBER);
    END IF;    
END;  
/

DECLARE
    CUR_DATE DATE := TO_DATE(SYSDATE, 'DD-MM-YYY');
    TODAY VARCHAR(10);
BEGIN
    TODAY := TO_CHAR(CUR_DATE, 'DAY');
    IF TODAY = ('FRIDAY') THEN
        DBMS_OUTPUT.PUT_LINE('TODAY IS ' ||TODAY|| '');
    ELSE
        DBMS_OUTPUT.PUT_LINE('NO, TODAY IS ' ||TODAY|| '');
    END IF;    
END;    
/

DECLARE
    BD DATE := '08-MAR-1995';
    CON_DATE DATE := TO_DATE(BD, 'DD-MM-YYY');
    WEEK_DAY VARCHAR2(10);
BEGIN
    WEEK_DAY := TO_CHAR(CON_DATE, 'DAY');
    IF WEEK_DAY = ('FRIDAY') THEN
        DBMS_OUTPUT.PUT_LINE('IT FALLS ON ' ||WEEK_DAY|| '');
    ELSIF WEEK_DAY = ('SATURDAY') THEN
        DBMS_OUTPUT.PUT_LINE('NO, TODAY IS ' ||WEEK_DAY|| '');
    ELSIF WEEK_DAY = ('SUNDAY') THEN
        DBMS_OUTPUT.PUT_LINE('NO, TODAY IS ' ||WEEK_DAY|| '');
    ELSE
        DBMS_OUTPUT.PUT_LINE('IT FALLS ON THE WEEK-DAY: ' ||WEEK_DAY|| '');
    END IF;    
END;    
/

DECLARE
    V_COUNTER BINARY_INTEGER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE(V_COUNTER); 
    LOOP
        V_COUNTER := V_COUNTER+1;
            IF V_COUNTER = 7 THEN
                EXIT;
            END IF;
        DBMS_OUTPUT.PUT_LINE(V_COUNTER);    
    END LOOP;    
END;    

DECLARE
    V_COUNTER BINARY_INTEGER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE(V_COUNTER);
    WHILE V_COUNTER < 6 LOOP
        V_COUNTER := V_COUNTER+1;
        DBMS_OUTPUT.PUT_LINE(V_COUNTER);    
    END LOOP;    
END;    

DECLARE
    V_COUNTER BINARY_INTEGER := 1;
    LOOP_COUNT BINARY_INTEGER;
BEGIN
    DBMS_OUTPUT.PUT_LINE(V_COUNTER);
    FOR LOOP_COUNT IN 1..5
    LOOP
        V_COUNTER := V_COUNTER+1;
        DBMS_OUTPUT.PUT_LINE(V_COUNTER);    
    END LOOP;    
END;    

DECLARE
    BD DATE := '27-OCT-1994';
    CON_DATE DATE := TO_DATE(BD, 'DD-MM-YYY');
    WEEK_DAY VARCHAR2(10);
BEGIN
    WEEK_DAY := TRIM(TO_CHAR(CON_DATE, 'DAY'));
    CASE
        WHEN WEEK_DAY = 'TUESDAY' THEN DBMS_OUTPUT.PUT_LINE('MY BIRTHDAY IS ON ' ||WEEK_DAY|| '');    
        ELSE DBMS_OUTPUT.PUT_LINE(WEEK_DAY);  
    END CASE;
END;    

DECLARE 
    LV_TEST_DATE DATE := '10-DEC-2012';
    LV_TEST_NUM CONSTANT NUMBER(3) := 10;
    LV_TEST_TXT VARCHAR2(10);
BEGIN
    LV_TEST_TXT := 'NGUYEN';
    DBMS_OUTPUT.PUT_LINE(LV_TEST_DATE||', '||LV_TEST_NUM||', '||LV_TEST_TXT);
END;

DECLARE 
    TOTAL_PURCHASES NUMBER(6,2);
BEGIN
    TOTAL_PURCHASES := 1000.25;
    IF TOTAL_PURCHASES > 200 THEN
        DBMS_OUTPUT.PUT_LINE('HIGH RATE');
    ELSIF TOTAL_PURCHASES > 100 THEN
        DBMS_OUTPUT.PUT_LINE('MID RATE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('LOW RATE');
    END IF;    
END;

DECLARE
    TOTAL_PURCHASES NUMBER(6,2);
BEGIN
    TOTAL_PURCHASES := 1.25;    CASE
        WHEN TOTAL_PURCHASES > 200 THEN DBMS_OUTPUT.PUT_LINE('HIGH RATE');    
        WHEN TOTAL_PURCHASES > 100 THEN DBMS_OUTPUT.PUT_LINE('MID RATE');   
        ELSE DBMS_OUTPUT.PUT_LINE('LOW RATE');  
    END CASE;
END;   

DECLARE 
    ACCT_BAL NUMBER(7,2);
    PAYMENT NUMBER(7,2);
    STILL_DUE BOOLEAN := TRUE;
BEGIN
    ACCT_BAL := 1000;
    PAYMENT := 1000;
    IF (ACCT_BAL - PAYMENT) > 0 THEN 
        STILL_DUE := TRUE;
        DBMS_OUTPUT.PUT_LINE('STILL OWED');
    ELSE
        STILL_DUE := FALSE;
        DBMS_OUTPUT.PUT_LINE('PAID OFF');
    END IF;  
END;

BEGIN
    DBMS_OUTPUT.PUT_LINE('THANH NGUYEN');
END;

DECLARE
    V_1 NUMBER;
    V_2 NUMBER;
BEGIN
    V_1 := 0; V_2 := 0;
    V_2 := V_1+1;
    DBMS_OUTPUT.PUT_LINE(V_2);
END;    
   
DECLARE
    CUR_DATE DATE;
BEGIN
    CUR_DATE := SYSDATE;
    DBMS_OUTPUT.PUT_LINE(CUR_DATE);
END;    

DECLARE
    V_NUMBER NUMBER := 10;
BEGIN
    IF V_NUMBER >= 0 THEN
        DBMS_OUTPUT.PUT_LINE(V_NUMBER);
    END IF;    
END;  
/

DECLARE
    V_NUMBER NUMBER := -1;
BEGIN
    IF V_NUMBER >= 0 THEN
        DBMS_OUTPUT.PUT_LINE(V_NUMBER);
    ELSE 
        DBMS_OUTPUT.PUT_LINE(V_NUMBER);
    END IF;    
END;  
/

DECLARE
    CUR_DATE DATE := TO_DATE(SYSDATE, 'DD-MM-YYY');
    TODAY VARCHAR(10);
BEGIN
    TODAY := TO_CHAR(CUR_DATE, 'DAY');
    IF TODAY = ('FRIDAY') THEN
        DBMS_OUTPUT.PUT_LINE('TODAY IS ' ||TODAY|| '');
    ELSE
        DBMS_OUTPUT.PUT_LINE('NO, TODAY IS ' ||TODAY|| '');
    END IF;    
END;    
/

DECLARE
    BD DATE := '08-MAR-1995';
    CON_DATE DATE := TO_DATE(BD, 'DD-MM-YYY');
    WEEK_DAY VARCHAR2(10);
BEGIN
    WEEK_DAY := TO_CHAR(CON_DATE, 'DAY');
    IF WEEK_DAY = ('FRIDAY') THEN
        DBMS_OUTPUT.PUT_LINE('IT FALLS ON ' ||WEEK_DAY|| '');
    ELSIF WEEK_DAY = ('SATURDAY') THEN
        DBMS_OUTPUT.PUT_LINE('NO, TODAY IS ' ||WEEK_DAY|| '');
    ELSIF WEEK_DAY = ('SUNDAY') THEN
        DBMS_OUTPUT.PUT_LINE('NO, TODAY IS ' ||WEEK_DAY|| '');
    ELSE
        DBMS_OUTPUT.PUT_LINE('IT FALLS ON THE WEEK-DAY: ' ||WEEK_DAY|| '');
    END IF;    
END;    
/

DECLARE
    V_COUNTER BINARY_INTEGER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE(V_COUNTER); 
    LOOP
        V_COUNTER := V_COUNTER+1;
            IF V_COUNTER = 7 THEN
                EXIT;
            END IF;
        DBMS_OUTPUT.PUT_LINE(V_COUNTER);    
    END LOOP;    
END;    

DECLARE
    V_COUNTER BINARY_INTEGER := 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE(V_COUNTER);
    WHILE V_COUNTER < 6 LOOP
        V_COUNTER := V_COUNTER+1;
        DBMS_OUTPUT.PUT_LINE(V_COUNTER);    
    END LOOP;    
END;    

DECLARE
    V_COUNTER BINARY_INTEGER := 1;
    LOOP_COUNT BINARY_INTEGER;
BEGIN
    DBMS_OUTPUT.PUT_LINE(V_COUNTER);
    FOR LOOP_COUNT IN 1..5
    LOOP
        V_COUNTER := V_COUNTER+1;
        DBMS_OUTPUT.PUT_LINE(V_COUNTER);    
    END LOOP;    
END;    

DECLARE
    BD DATE := '27-OCT-1994';
    CON_DATE DATE := TO_DATE(BD, 'DD-MM-YYY');
    WEEK_DAY VARCHAR2(10);
BEGIN
    WEEK_DAY := TRIM(TO_CHAR(CON_DATE, 'DAY'));
    CASE
        WHEN WEEK_DAY = 'TUESDAY' THEN DBMS_OUTPUT.PUT_LINE('MY BIRTHDAY IS ON ' ||WEEK_DAY|| '');    
        ELSE DBMS_OUTPUT.PUT_LINE(WEEK_DAY);  
    END CASE;
END;    

THANH NGUYEN



