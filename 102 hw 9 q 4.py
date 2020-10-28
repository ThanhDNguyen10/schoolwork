sum =0
a =6
for i in range (1, 21):
    sum+=a
    a*=2
    print ("i: ", i, "a: ", a, "sum: ", sum)


x=(6*(1-1048576))/(1-2)
print("Sum of formula is: ", x)

if ( sum == x):
    print ("It is equal.")
