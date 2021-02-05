#Thanh Nguyen
#IT 322
library(sqldf)
employees <- read.csv('employees.txt', sep='\t')
employees
#Q1
female <- sqldf("SELECT ID, LASTNAME, FIRSTNAME
              FROM employees WHERE GENDER = 'f'")
female
#Q2
name <- sqldf("SELECT ID, LASTNAME, FIRSTNAME
              FROM employees WHERE LASTNAME = 'a' OR LASTNAME = 's' OR LASTNAME = 'p'")
name
#Q3
count <- sqldf("SELECT COUNT(FIRSTNAME) AS OCCURANCE FROM employees")
count


#Q4
count_name <- sqldf("SELECT COUNT(FIRSTNAME) AS OCCURANCE FROM employees 
               WHERE NOT FIRSTNAME = 'eric'")
count_name

#Q5
employees$CALIFORNIA <- c("no","no","yes","no","no","no","yes","no","no","no","no","no","yes","yes","no","no","no","no","no","no")
employees
#Q5 fixed INCOMPLETED
employees <- sqldf("SELECT ID, LASTNAME, FIRSTNAME, CASE WHEN FIRSTNAME = 'hila'
                   OR FIRSTNAME = 'stewart' OR FIRSTNAME = 'tim' OR FIRSTNAME = 'chris'
                   THEN 1 ELSE 0 END as CALIFORNIA FROM employees")


#Q6
order <- sqldf("SELECT * FROM employees ORDER BY CALIFORNIA DESC, FIRSTNAME ASC")
order


orders <- read.csv('orders.txt', sep='\t')
orders

#Q7
lowest <- sqldf("SELECT a.LASTNAME, a.FIRSTNAME, b.ID, b.ITEM, b.ITEM_COST
                       FROM employees a JOIN orders b ON a.ID = b.ID WHERE ITEM_COST < 10.0
                       ORDER BY ITEM_COST")
lowest

#Q8
join_table <- sqldf("SELECT a.LASTNAME, a.FIRSTNAME, b.ID, b.ITEM, b.QUANTITY_ORDERED, b.ITEM_COST
                       FROM employees a JOIN orders b ON a.ID = b.ID")
join_table
total <- sqldf("SELECT LASTNAME, FIRSTNAME, ID, ITEM, QUANTITY_ORDERED, ITEM_COST,
              (QUANTITY_ORDERED*ITEM_COST) AS TOTAL_PRICE 
                  FROM join_table")
total
less_20 <- sqldf("SELECT*FROM total WHERE TOTAL_PRICE < 20")
less_20

#Q9
lunch <- sqldf("SELECT LASTNAME, FIRSTNAME, SUM(TOTAL_PRICE) AS LUNCH_COST FROM total
                   GROUP BY ID HAVING LUNCH_COST <50")
lunch

#Q10
lunch_cost <- sqldf("SELECT LASTNAME, FIRSTNAME, SUM(TOTAL_PRICE) AS LUNCH_COST FROM total
                   GROUP BY ID")
lunch_cost
avg_lunch <- sqldf("SELECT LASTNAME, FIRSTNAME, SUM(TOTAL_PRICE) AS LUNCH_COST FROM total
                   GROUP BY ID HAVING LUNCH_COST < (SELECT AVG(lunch_cost) as AVG from lunch_cost)")
avg_lunch
avg <- sqldf("SELECT AVG(lunch_cost) as AVG from lunch_cost")
avg



