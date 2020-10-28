itemCost = int (input ("Enter cost of purchase:"))
rate = int (input ("Enter sales tax rate:"))

tax = float
Total = float

if rate > 1 :

    st = float( rate )/100

    
print ("Cost: $20.00")

tax = float (itemCost*st)

print ("Tax: $", "%.2f" % tax)

Total = float (itemCost+tax)

print ("Total: $", "%.2f" % Total)
