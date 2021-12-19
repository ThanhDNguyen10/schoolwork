SELECT Customer#, ShipCost FROM Orders WHERE ShipCost <= 2.00;

SELECT ISBN, Title, PubDate FROM Books WHERE PubDate BETWEEN '01-JAN-03' AND '12-DEC-04'; 

SELECT*FROM Customers WHERE State IN ('FL', 'WA');

SELECT Contact FROM Publisher WHERE Phone LIKE '8%'; 

SELECT ISBN, Title, Category FROM Books WHERE Discount IS NULL;

SELECT Order#, Item# FROM ORDERITEMS WHERE Quantity = 1 AND (Item# = 2 OR Item# = 3);

SELECT Order#, Customer#, ShipDate FROM Orders WHERE ShipDate IS NOT NULL AND (ShipCost > 5.00 OR (Customer# BETWEEN 1000 AND 1010)) ORDER BY ShipState;

THANH NGUYEN