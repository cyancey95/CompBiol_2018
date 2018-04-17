# ggplot Graphics
# 5 April 2018
# CEY


# Preliminaries
library(ggplot2)
install.packages("ggthemes")
library(ggthemes)
library(patchwork)
install.packages("patchwork")
library(TeachingDemos)
char2seed("10th Avenue Freeze-Out")

d<- mpg
str(d)
# wset of continuous, integer, and character string variables in an already made data frame

#qplot for quick and dirty analysis without a data frame, good for fast analysis

#basic histogram
qplot(x=d$hwy)
qplot(x=d$hwy, fill=I("goldenrod"), color=I("black"))

#denisty plot
qplot(x=d$hwy, geom="density")

#scatter plot
qplot(x=d$displ, y=d$hwy, geom=c("smooth", "point"))

qplot(x=d$displ, y=d$hwy, geom=c("smooth", "point"),method="lm")

#basic boxplot
qplot(x=d$fl, y=d$cty, geom="boxplot", fill=I("mistyrose1"))

#basic bar plot
qplot(x=d$fl, geom="bar", fill=I("tan"))

#not what you expect,getting rid of the "I"
qplot(x=d$fl, geom="bar", fill=("tan"))
# the color of the bar is red, and it creates a variable called "tan"
#this is the distinction between setting and mapping a variable

# plotting curves and function
myVec <- seq(1,100, by=0.1)
myFun <- function(x) sin(x)+0.1*x

# plot built in functions
qplot(x=myVec, y=sin(myVec), geom="line")

#plot density distibutions or probability functions
qplot(x=myVec, y=dgamma(myVec, shape=5, scale=3), geom="line")

# plot user-defined functions
qplot(x=myVec, y=myFun(myVec), geom="line")

#------------------------------------------------------------------------

#GGPLOT2
# use this for publication quality graphics

p1 <- ggplot(data=d, mapping=aes(x=displ, y=cty)) + geom_point()
print(p1)

p1 + theme_classic() #no grid lines, publications like this
p1 + theme_linedraw() # black frame
p1 +  theme_dark() # good with bright points, presentation slides
p1 + theme_base() # looks like base R
p1 + theme_par() #pick up current settings from base R
p1 + theme_void() # only data
p1 + theme_economist() #many specialized themes
p1 + theme_grey()

# major theme modifications, very important
# use theme parameters to modify font and font size
p1+ theme_classic(base_size=30, base_family="serif")

p2 <-ggplot(data=d,
             mapping=aes(x=fl,fill=fl)) + geom_bar()
print(p2)
# flip the two coordinate axis
p2 + coord_flip() + 
  theme_economist(base_size=20, base_family="serif")

# minor theme modifications
p1 <- ggplot(data=d, 
             mapping=aes(x=displ, y=cty)) +
  geom_point(size=5, shape=21, color="black", fill="coral")
print(p1)

# add title
p1 <- ggplot(data=d, 
             mapping=aes(x=displ, y=cty)) +
  geom_point(size=5, shape=21, color="black", fill="coral") + ggtitle("My graph title here")
print(p1)

# add x and y labels
p1 <- ggplot(data=d, 
             mapping=aes(x=displ, y=cty)) +
  geom_point(size=5, shape=21, color="black", fill="coral") + ggtitle("My graph title here") + xlab("my x axis label") +
  ylab("my y axis label")
print(p1)

#adjust range of x and y axis
p1 <- ggplot(data=d, 
             mapping=aes(x=displ, y=cty)) +
  geom_point(size=5, shape=21, color="black", fill="coral") + 
  ggtitle("My graph title here") + 
  xlab("my x axis label") +
  ylab("my y axis label") +
  xlim(0,4) + ylim(0,20)
print(p1)
# some of data not seen, warning message will tell you how much data you aren't seeing on graph


# building graphs to use on patchwork
# create 4 individual graphs

g1 <- ggplot(data=d, mapping=aes(x=displ, y=cty))+
  geom_point()+
  geom_smooth()
print(g1)


g2 <- ggplot(data=d, mapping=aes(x=fl, fill=I("tomato"), color=I("black"))) +
  geom_bar(stat="count") + 
  theme(legend.position= "none") #gets rid of legend
print(g2)

g3 <- ggplot(data=d, mapping=aes(x=