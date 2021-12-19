SET SERVEROUTPUT ON

DECLARE
   CURSOR cur_basket IS
     SELECT bi.idBasket, bi.quantity, p.stock
       FROM bb_basketitem bi INNER JOIN bb_product p
         USING (idProduct)
       WHERE bi.idBasket = 6;
   TYPE type_basket IS RECORD (
     basket bb_basketitem.idBasket%TYPE,
     qty bb_basketitem.quantity%TYPE,
     stock bb_product.stock%TYPE);
   rec_basket type_basket;
   lv_flag_txt CHAR(1) := 'Y';
BEGIN
   OPEN cur_basket;
   LOOP 
     FETCH cur_basket INTO rec_basket;
      EXIT WHEN cur_basket%NOTFOUND;
      IF rec_basket.stock < rec_basket.qty THEN lv_flag_txt := 'N'; END IF;
   END LOOP;
   CLOSE cur_basket;
   IF lv_flag_txt = 'Y' THEN DBMS_OUTPUT.PUT_LINE('All items in stock!'); END IF;
   IF lv_flag_txt = 'N' THEN DBMS_OUTPUT.PUT_LINE('All items NOT in stock!'); END IF;   
END;

DECLARE
   CURSOR cur_shopper IS
     SELECT a.idShopper, a.promo,  b.total                          
       FROM bb_shopper a, (SELECT b.idShopper, SUM(bi.quantity*bi.price) total
                            FROM bb_basketitem bi, bb_basket b
                            WHERE bi.idBasket = b.idBasket
                            GROUP BY idShopper) b
        WHERE a.idShopper = b.idShopper
     FOR UPDATE OF a.idShopper NOWAIT;
   lv_promo_txt CHAR(1);
BEGIN
  FOR rec_shopper IN cur_shopper LOOP
   lv_promo_txt := 'X';
   IF rec_shopper.total > 100 THEN 
          lv_promo_txt := 'A';
   END IF;
   IF rec_shopper.total BETWEEN 50 AND 99 THEN 
          lv_promo_txt := 'B';
   END IF;   
   IF lv_promo_txt <> 'X' THEN
     UPDATE bb_shopper
      SET promo = lv_promo_txt
      WHERE CURRENT OF cur_shopper;
   END IF;
  END LOOP;
  COMMIT;
END;

SELECT IDSHOPPER, S.PROMO, SUM(BI.QUANTITY*BI.PRICE) TOTAL FROM BB_SHOPPER S INNER JOIN BB_BASKET B USING(IDSHOPPER) 
INNER JOIN BB_BASKETITEM BI USING(IDBASKET) GROUP BY IDSHOPPER, S.PROMO ORDER BY IDSHOPPER;

UPDATE bb_shopper
  SET promo = NULL;
UPDATE bb_shopper
  SET promo = 'B'
  WHERE idShopper IN (21,23,25);
UPDATE bb_shopper
  SET promo = 'A'
  WHERE idShopper = 22;
COMMIT;

BEGIN
 UPDATE bb_shopper
  SET promo = NULL
  WHERE promo IS NOT NULL;
END;

DECLARE
  lv_tax_num NUMBER(2,2);
BEGIN
 CASE  'NJ' 
  WHEN 'VA' THEN lv_tax_num := .04;
  WHEN 'NC' THEN lv_tax_num := .02;  
  WHEN 'NY' THEN lv_tax_num := .06;  
 END CASE;
 DBMS_OUTPUT.PUT_LINE('tax rate = '||lv_tax_num);
 EXCEPTION
    WHEN CASE_NOT_FOUND THEN DBMS_OUTPUT.PUT_LINE('No Tax');
END;

DECLARE   --THANH NGUYEN
    pledge_id   DD_PLEDGE.idpledge%TYPE;
    pledge_amt  DD_PLEDGE.pledgeamt%TYPE;
    pay_months  DD_PLEDGE.paymonths%TYPE;
    pay_date    DD_PAYMENT.paydate%TYPE;
    pay_amt     DD_PAYMENT.payamt%TYPE;
    donor_id    DD_PLEDGE.iddonor%TYPE; 
    CURSOR cur_pledges IS
    SELECT idpledge, pl.pledgeamt, pl.paymonths, pa.paydate,  
    pa.payamt, pl.iddonor FROM DD_PLEDGE pl JOIN DD_PAYMENT pa USING(IDPLEDGE) WHERE IDDONOR=301
    ORDER BY idpledge, pa.paydate; 
BEGIN
    OPEN cur_pledges;  
        LOOP
            FETCH cur_pledges INTO pledge_id, pledge_amt, pay_months, pay_date,pay_amt, donor_id;
                IF CUR_PLEDGES%ROWCOUNT = 1 THEN
                    DBMS_OUTPUT.PUT_LINE('Pledge ID: ' || pledge_id || ' Pledge Amount: $' 
                    || pledge_amt || ' Monthly Payment: $' || pay_months 
                    || ' Pay Date: ' || pay_date || ' Amount Paid: $' || pay_amt);    
                END IF;    
            EXIT WHEN cur_pledges%NOTFOUND;
        END LOOP;
    CLOSE cur_pledges;
END;

DECLARE   --THANH NGUYEN
    CURSOR cur_pledges (p_pled NUMBER) IS
    SELECT idpledge, pl.pledgeamt, pl.paymonths, pa.paydate,  
    pa.payamt, pl.iddonor FROM DD_PLEDGE pl JOIN DD_PAYMENT pa USING(IDPLEDGE) WHERE IDDONOR=302
    ORDER BY idpledge, pa.paydate; 
BEGIN
    FOR rec IN cur_pledges(1) LOOP
      IF cur_pledges%ROWCOUNT = 1 THEN
        DBMS_OUTPUT.PUT_LINE('Pledge ID: ' || rec.idpledge || ' Pledge Amount: $' 
                    || rec.pledgeamt || ' Monthly Payment: $' || rec.paymonths 
                    || ' Pay Date: ' || rec.paydate || ' Amount Paid: $' || rec.payamt);  
      END IF;    
      EXIT WHEN cur_pledges%NOTFOUND;              
    END LOOP;
END;
                
THANH NGUYEN
