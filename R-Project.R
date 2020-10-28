sn <- read.csv("social_network.csv", header = T)

x <- 1:5
x
y <- c(6,7,8,9,10)
y
x+y
x*2
ls()

hist(sn$Age) 

hist(sn$Age, col = "green", main = "This is my midterm exam", xlab = "Age of respondents") 

boxplot(sn$Age)

table(sn$Site)  
site.freq <- table(sn$Site) 
site.freq 

prop.table(site.freq)
round(prop.table(site.freq), 2)

summary(sn$Age)
summary(sn)
