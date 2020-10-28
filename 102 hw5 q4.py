
num= int(input("Enter number of students: "))
n=1
max = None
while n <=num:
    score =int (input("Enter test score: "))
    while score <0 or score >100:
        score=int(input("Invalid. Enter test score again: "))
    if max is None or score> max:
        max=score
    n+=1  
    

print ("Highest score is: ", int(max))
