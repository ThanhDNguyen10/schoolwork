SET SERVEROUTPUT ON

DECLARE
  lv_ship_date bb_basketstatus.dtstage%TYPE;
  lv_shipper_txt bb_basketstatus.shipper%TYPE;
  lv_ship_num bb_basketstatus.shippingnum%TYPE;
  lv_bask_num bb_basketstatus.idbasket%TYPE := 7;
BEGIN
  SELECT dtstage, shipper, shippingnum
   INTO lv_ship_date, lv_shipper_txt, lv_ship_num
   FROM bb_basketstatus
   WHERE idbasket = lv_bask_num
    AND idstage = 5;
  DBMS_OUTPUT.PUT_LINE('Date Shipped: '||lv_ship_date);
  DBMS_OUTPUT.PUT_LINE('Shipper: '||lv_shipper_txt);
  DBMS_OUTPUT.PUT_LINE('Shipping #: '||lv_ship_num);
END;

DECLARE
  rec_ship bb_basketstatus%ROWTYPE;
  lv_bask_num bb_basketstatus.idbasket%TYPE := 3;
BEGIN
  SELECT *
   INTO rec_ship
   FROM bb_basketstatus
   WHERE idbasket =  lv_bask_num
    AND idstage = 5;
  DBMS_OUTPUT.PUT_LINE('Date Shipped: '||rec_ship.dtstage);
  DBMS_OUTPUT.PUT_LINE('Shipper: '||rec_ship.shipper);
  DBMS_OUTPUT.PUT_LINE('Shipping #: '||rec_ship.shippingnum);
  DBMS_OUTPUT.PUT_LINE('Notes: '||rec_ship.notes);
END;

DECLARE
 lv_total_num NUMBER(6,2);
 lv_rating_txt VARCHAR2(4);
 lv_shop_num bb_basket.idshopper%TYPE := 22;
BEGIN
 SELECT SUM(total)
 INTO lv_total_num
 FROM bb_basket
  WHERE idShopper = 22
    AND orderplaced = 1
  GROUP BY idshopper;
  IF lv_total_num > 200 THEN
    lv_rating_txt := 'HIGH';
  ELSIF lv_total_num > 100 THEN
    lv_rating_txt := 'MID';  
  ELSE    lv_rating_txt := 'LOW';   
  END IF; 
    DBMS_OUTPUT.PUT_LINE('Shopper '||lv_shop_num||' is rated '||lv_rating_txt);
END;

SELECT SUM(total) FROM bb_basket WHERE idShopper = 22 AND orderplaced = 1 GROUP BY idshopper;

DECLARE
 lv_total_num NUMBER(6,2);
 lv_rating_txt VARCHAR2(4);
 lv_shop_num bb_basket.idshopper%TYPE := 22;
BEGIN
 SELECT SUM(total) INTO lv_total_num
 FROM bb_basket
  WHERE idShopper = 22
    AND orderplaced = 1
  GROUP BY idshopper;
  CASE
    WHEN lv_total_num > 200 THEN lv_rating_txt := 'HIGH';
    WHEN lv_total_num > 100 THEN lv_rating_txt := 'MID';  
    ELSE lv_rating_txt := 'LOW';   
  END CASE; 
    DBMS_OUTPUT.PUT_LINE('Shopper '||lv_shop_num||' is rated '||lv_rating_txt);
END;

SELECT SUM(total) FROM bb_basket WHERE idShopper = 22 AND orderplaced = 1 GROUP BY idshopper;

DECLARE
 lv_amount NUMBER(6,2) := 0;
 lv_quantity NUMBER := 0;
 lv_price bb_product.price%TYPE;
BEGIN
 SELECT price INTO lv_price
 FROM bb_product
  WHERE idproduct = 4;
  WHILE lv_price < (100-lv_amount) LOOP
     lv_amount := lv_price + lv_amount;
     lv_quantity := lv_quantity+1;
  END LOOP; 
    DBMS_OUTPUT.PUT_LINE('Total spend: '||lv_amount||' quantity of '||lv_quantity);
END;

DECLARE
  lv_id bb_basket.idbasket%TYPE;
  lv_sub bb_basket.subtotal%TYPE;
  lv_ship bb_basket.shipping%TYPE;
  lv_tax bb_basket.tax%TYPE;
  lv_total bb_basket.total%TYPE;
BEGIN
  SELECT idbasket, subtotal, shipping, tax, total
   INTO lv_id, lv_sub, lv_ship, lv_tax, lv_total
   FROM bb_basket
   WHERE idbasket = 12;
  DBMS_OUTPUT.PUT_LINE('ID: '||lv_id);
  DBMS_OUTPUT.PUT_LINE('Subtotal: '||lv_sub);
  DBMS_OUTPUT.PUT_LINE('Shipping: '||lv_ship);
  DBMS_OUTPUT.PUT_LINE('Tax: '||lv_tax);
  DBMS_OUTPUT.PUT_LINE('Total: '||lv_total);
END;

DECLARE
  lv_id dd_project.idProj%TYPE;
  lv_name dd_project.Projname%TYPE;
  lv_num dd_pledge.idPledge%TYPE;
  lv_total dd_pledge.pledgeamt%TYPE;
  lv_avg dd_pledge.pledgeamt%TYPE;
BEGIN
  SELECT idProj, d.Projname, count(idPledge), SUM(pledgeamt), avg(pledgeamt)
   INTO lv_id, lv_name, lv_num, lv_total, lv_avg
   FROM dd_project d JOIN dd_pledge p USING (idproj) GROUP BY idproj, projname;
  DBMS_OUTPUT.PUT_LINE('Project ID: '||lv_id);
  DBMS_OUTPUT.PUT_LINE('Project name: '||lv_name);
  DBMS_OUTPUT.PUT_LINE('Number of pledges: '||lv_num);
  DBMS_OUTPUT.PUT_LINE('Total $: '||lv_total);
  DBMS_OUTPUT.PUT_LINE('Average: '||lv_avg);
END;

CREATE SEQUENCE DD_PROJECT_SEQ START WITH 530 INCREMENT BY 1 MINVALUE 1 NOCACHE;

DECLARE
  proj_name_txt dd_project.projname%TYPE := 'HK ANIMAL SHELTERS EXTENSION';
  proj_start dd_project.projstartdate%TYPE := '01-JAN-2013';
  proj_end dd_project.projenddate%TYPE := '31-MAY-2013';
  proj_goal dd_project.projfundgoal%TYPE := 65000;
BEGIN
  INSERT INTO DD_PROJECT (idproj, Projname, projstartdate, projenddate, projfundgoal)
  VALUES (DD_PROJECT_SEQ.NEXTVAL, proj_name_txt, proj_start, proj_end, proj_goal);
END;

DECLARE
  pledge dd_pledge%ROWTYPE;
  pl_id dd_pledge.idpledge%TYPE;
  pl_don dd_pledge.iddonor%TYPE;
  pl_amt dd_pledge.pledgeamt%TYPE;
BEGIN
  SELECT idProj, d.Projname, count(idPledge), SUM(pledgeamt), avg(pledgeamt)
  INTO lv_id, lv_name, lv_num, lv_total, lv_avg
  FROM dd_project d JOIN dd_pledge p USING (idproj) GROUP BY idproj, projname;
  DBMS_OUTPUT.PUT_LINE('Project ID: '||lv_id);
  DBMS_OUTPUT.PUT_LINE('Project name: '||lv_name);
  DBMS_OUTPUT.PUT_LINE('Number of pledges: '||lv_num);
  DBMS_OUTPUT.PUT_LINE('Total $: '||lv_total);
  DBMS_OUTPUT.PUT_LINE('Average: '||lv_avg);
END;

DECLARE
    pledges dd_pledge%ROWTYPE;
    start_month dd_pledge.pledgedate%TYPE := '01-OCT-12';
    end_month dd_pledge.pledgedate%TYPE := '31-OCT-12';
BEGIN
    FOR PLEDGES IN
        (SELECT IDPLEDGE, IDDONOR, PLEDGEAMT, CASE
            WHEN PAYMONTHS = 0 THEN 'Lump Sum.'
            ELSE 'Monthly - ' || PAYMONTHS
            END AS MONTHLY_PAYMENT
        FROM DD_PLEDGE
    WHERE PLEDGEDATE >= START_MONTH AND PLEDGEDATE <= END_MONTH ORDER BY PAYMONTHS)
    LOOP
DBMS_OUTPUT.PUT_LINE('ID: ' || PLEDGES.IDPLEDGE || ', Donor ID: '|| PLEDGES.IDDONOR || ', Amount: ' ||to_char(PLEDGES.PLEDGEAMT,
'$9999.99') || ', Monthly Payments: ' || PLEDGES.MONTHLY_PAYMENT);
    END LOOP;
END;

THANH NGUYEN