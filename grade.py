def percentCorrect ():
    score = float(input("Enter student's score: "))
    while score <0 or score >maxScore:
        score=float(input("Score has to be between 0-100: "))
    return score

def assignGrade(percentCorrect):
    if score > 88:
        grade = "E"
    elif score >=70:
        grade= "G"
    else:
        grade ="F"
    return grade

def output(grade):
    print (grade)

    
maxScore=float(input("Enter value for max score: "))
score=percentCorrect()
grade= assignGrade(score)
output(grade)
        
