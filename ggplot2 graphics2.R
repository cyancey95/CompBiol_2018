# ggplot Graphics 2
# April 2018
# CEY

# Preliminaries
library(ggplot2)
install.packages("ggthemes")
library(ggthemes)
library(patchwork)
library(TeachingDemos)
char2seed("10th Avenue Freeze-Out")

d<- mpg
str(d)
# wset of continuous, integer, and character string variables in an already made data frame


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

g3 <- ggplot(data=d, mapping=aes(x=displ, fill=I("royalblue"), color=I("black"))) +
  geom_bar(stat="count") + 
  theme(legend.position= "none") #gets rid of legend
print(g3)



g4 <- ggplot(data=d, mapping=aes(x=fl, y= cty, fill=fl)) +
  geom_boxplot() + theme(legend.position = "none")
print(g4)

# this is the code to call patchwork
# will add multipanel graphs

#place 2 plots horizontally
g1 +g2

# place  3 plots vertically
g1 + g2 +g3 +plot_layout(ncol=1)

# change the relative areas of each plot
g1 + g2 + plot_layout(ncol=1, heights=c(2,1))
g1 + g2 + plot_layout(ncol=2, widths=c(1,2)) 

# add a spacer plot under construction
g1 + plot_spacer() + g2

# set up nested plot
g1 + {
  g2+ {
    g3+
      g4 +
      plot_layout(ncol=1)
  }
} +
  plot_layout(ncol=1)

# minus operater

g1 + g2 - g3 +
  plot_layout(ncol=1)

# / | for very intuitive layouts 
(g1 | g2| g3)/g4

(g1|g2)/(g3|g4)

# swapping axis orientation
g3a <- g3 + scale_x_reverse()
g3b <- g3 + scale_y_reverse()
g3c <- g3 + scale_x_reverse() + scale_y_reverse()
(g3|g3a)/ (g3b|g3c)

# use coord_flip to flip coordinate axis 

# ggsave for creating and saving plots
ggsave(filename="MyPlotName.pdf", plot=g3, 
       device="pdf", width=20, height=20, units="cm",
       dpi=300)

m1 <- ggplot(data=mpg,
             mapping=(aes(x=displ, y=cty, color=class)))+
  geom_point()
print(m1)

m1 <- ggplot(data=mpg,
             mapping=(aes(x=displ, y=cty, shape=class)))+
  geom_point()
print(m1)
# kinda looks like garbage but might have it's function if you have fewer variables

# mapping a continuous variable onto point size (this is the only thing you really should do for point size)
m1 <- ggplot(data=mpg,
             mapping=(aes(x=displ, y=cty, size=hwy, color=class)))+
  geom_point()
print(m1)
# this can help you see the continuous variable visually with other data points

#map a continuous variable onto color
m1 <- ggplot(data=mpg,
             mapping=(aes(x=displ, y=cty, color=hwy)))+
  geom_point()
print(m1)

# map 2 variables to 2 different aes
m1 <- ggplot(data=mpg,
             mapping=(aes(x=displ, y=cty, shape=class, color=hwy)))+
  geom_point()
print(m1)

# mapping 3 variables onto shape, size, and color

m1 <- ggplot(data=mpg,
             mapping=(aes(x=displ, y=cty, shape=drv, color=fl, size=hwy)))+
  geom_point()
print(m1)
# this single graph gives you 5 attributes each data point

# mapping a variable to the same aesthetic for 2 different geoms
m1 <- ggplot(data=mpg,
             mapping=(aes(x=displ, y=cty, color=drv)))+
  geom_point() +
  geom_smooth(method="lm")
print(m1)


# faceting for excellent visualization in a set of related plots
m1 <- ggplot(data=mpg,
             mapping=(aes(x=displ, y=cty)))+
  geom_point()

  m1 + facet_grid(class~fl)
# empty grid cells shows you the combination of variables are not present in the data, really helpful
  # to show things in your data
  
  m1 + facet_grid(class~fl, scales="free_y")
# this graph looks similar to one above but, y axis are not the same, can generally see
  #relationships among points a little better, but the base set up is better because
  # it is a direct comparison with the same y value
  
  m1 + facet_grid(class~fl, scales="free_x")

# facet on only a single variable, probably better comparison
m1 + facet_grid(.~class)
# only looks at type of vehicle and one partition of data

m1 + facet_grid(class~.)
# problems with layout: lots of rows, get really skinny or really long plot not good for publicaiton
#to fix this: facet wrap for unordered graphs
m1 + facet_wrap(~class)
#rows and columns are not important, makes it easy to see

#combine varibales in a facet wrap
m1 + facet_wrap(~class + fl)
#create the individual graphs, mostly a big change in the labelling of the graph, individual title for
#each which gives you the variable combo

m1 + facet_wrap(~class + fl,
                drop=FALSE)
#shows you both the empty and full combinations

# use facet in combination with aesthetics
m1 <- ggplot(data=mpg, mapping=aes(x=displ, y=cty, color=drv)) + 
  geom_point()
m1 + facet_grid(.~class)


m1 <- ggplot(data=mpg, mapping=aes(x=displ, y=cty, color=drv)) + 
  geom_smooth(method="lm", se=FALSE)
m1 + facet_grid(.~class)

#fitting with boxplots over a continuous variables
m1 <- ggplot(data=mpg, mapping=aes(x=displ, y=cty)) + 
  geom_boxplot()
m1 + facet_grid(.~class)
