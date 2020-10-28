itemCost = float(input("Enter cost of purchase: "))

while itemCost<0.01 or itemCost>10000:
    itemCost= float(input("INVALID! Enter cost of purchase: "))

rate = float(input("Enter sales tax rate: "))

while rate >1 or rate <0:
    rate= float(input("INVALID! Enter sales tax rate (between 0 and 1): "))

tax = itemCost*rate
total = itemCost+tax
print ("Cost: ", "%.2f" % itemCost)
print ("Tax: " "%.2f" % tax)
print ("Total: ", "%.2f" % total)
