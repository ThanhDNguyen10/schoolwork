total = 0
count = 1
while count <=6:
    mins = int(input("How long it takes to finish the homework in minutes? "))
    while mins <0:
        mins = int (input("Invalid. How many minutes? "))
    total+=mins
    count+=1
avg=total/count
print ("The avg is:", "%.2f" % avg)
