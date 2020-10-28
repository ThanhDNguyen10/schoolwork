
count=1
score =int (input("Enter test score: "))
while score <0 or score >100:
    score=int(input("Invalid. Enter test score again: "))
    lst.append(score)
count +=1

print ("Highest score is: ", max int(score))
