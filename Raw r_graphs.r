#Installation
install.packages("ggplot2")
install.packages("reshape2") 
install.packages("readxl")
install.packages("scatterplot3d")


#Import libraries

library("ggplot2") #Graphs
library("reshape2") #Bars per group
library("readxl") #XLSL files
library("scatterplot3d") #Scatterplot in 3D

#archive CSV
setwd("")
mydata_csv <- read.csv("")
head(mydata_csv)

#archive TXT
setwd("")
mydata_txt <- read.delim("cc.txt", header =FALSE)
head(mydata_txt)

#archive XLSX
setwd("")
mydata_xlsx <- read_excel("")
head(mydata_xlsx)

####Bars
#We create a dataframe
data <- data.frame(
  name = letters[1:5], #Dependent variable 
  value = sample(seq(4,15),5), #RANDOM Independent variable variable
  sd = c(1,0.2,3,2,4) #Predisigned error 
)

#Just bars, something simple ----------------
ggplot(data, aes(name,value)) + geom_bar(stat = "identity")

#Bars with error -----------
b <- ggplot(data) +
  geom_bar(aes(x = name, y = value), stat = "identity", fill= "red", alpha = 0.7) + #bars
  geom_errorbar(aes(x=name, ymin=value-sd, ymax=value+sd), width=0.4, colour= "brown",
                  alpha=0.9, size=1.3) #error margin
b + ggtitle("Bar plot with errorbars") + xlab("Dependent variable")+ ylab("Independent variable") 
#Text added to the graph

####Scatterplots -----------
#simple
ggplot(iris,aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point()

#"Complex"
c <- ggplot(data = iris, aes(x=Sepal.Length, y = Sepal.Width))+
  geom_point(aes(color=Species, shape=Species)) 

c + ggtitle ("Gráfico especies iris") + xlab("Sepal length (cm)") + ylab("Sepal width (cm))")
#We add text to the graph

#Pie ----------
x <- c(11,21,35) #Lets make a compilation
lbls <- c("Producto A", "Producto B", "Producto C") #Name labels
pie(x,labels = lbls, main = "Pie chart of products") #We make graph

#Others
df = data.frame("Products" = c("Product A", "Product B", "Product C"), "porciento" = c(11,21,35))

#Basic bar
pC = ggplot(df, aes(x= "", y = porciento, fill = Products)) + geom_bar(stat = "identity", width = 1, alpha =0.7)

#Conversion to pie graph
pC = pC+coord_polar("y", start = 0) + geom_text(aes(label = paste0(round(porciento*100),
                                                                   "%")), position = position_stack(
                                                                     vjust = 0.5), size = 6, color ="white")
#Add color 
pC = pC + scale_fill_manual(values=c("#660000", "#cc0000", "#CC0033")) #Manual color assingment

#Remove tags and title 
pC = pC + labs (x= NULL, y = NULL, fill = NULL)

#Final cleaning
pC = pC + theme_classic() 

pC <- pC + theme(legend.position = "bottom")

pC #Final graph

#Scatterplots-----
#3D instalation
install.packages("scatterplot3d")
library("scatterplot3d")

#Simple
scatterplot3d(iris[,1:3], angle = 75)

#Specific axis
scatterplot3d(iris[,1:3],
             main = "3D scatterplot",
             xlab = "Sepal lenght (cm)",
             ylab = "Sepal Width (cm)",
             zlab = "Petal length(cm)")

#Change marker colors 
scatterplot3d(iris[,1:3], pch = 16, color = "steelblue") #Blue color assigned 

#Species with color
colors <- c("#3333CC", "#99CCFF", "#6600CC") #Colors per specie
colors <- colors[as.numeric(iris$Species)]
s3d <- scatterplot3d(iris[,1:3], pch = 16, color = colors)
legend(s3d$xyz.convert(6.3, 4.5), legend = levels(iris$Species), col = c(
  "#3333CC", "#99CCFF", "#6600CC"), pch = 16) #Para leyendas

#Heatmaps
library("gplots")

heatmap.2(t(iris[,1:4]), trace = "none", scale = "row", key = TRUE, mar= c(2,8),
          cexRow = 1, ColsideColors = c("pink", "purple", "magenta")[iris$Species])

#library("ggarrange")
tiff("ABI.tiff", width = 4000, height = 4000, units = 'px', res=300,
     compression = 'lzw')
ggarrange(pC, b, box, labels = c("A","B","C"))
dev.off()

#Boxplot 
par(mfrow=c(2,2)) #subplot

#Comparison 1
boxplot(Sepal.Length~Species,data = iris,
        xlab = "Species", ylab = "Sepal Length", main = "Sepal Length comp")

#Comparison 2
boxplot(Sepal.Width~Species,data = iris,
        xlab = "Species", ylab = "Sepal Width", main = "Sepal Width comp")

#Comparison 3
boxplot(Petal.Length~Species,data = iris,
        xlab = "Species", ylab = "Petal Length", main = "Petal Length comp")

#Comparison 4
boxplot(Petal.Width~Species,data = iris,
        xlab = "Species", ylab = "Petal Width", main = "Petal Width comp")

par(mfrow=c(1,1)) #GIndividual graph

#Color
box <- ggplot(data=iris, aes(x=Species, y=Sepal.Length))
box <- box + geom_boxplot(aes(fill=Species)) +
  ylab("Sepal Lenght (cm)") + ggtitle("Iris Boxplot") #Title and name of X axis
box <- box + theme_bw()
box

#Histograma
#Simple
hist(iris$Sepal.Width, freq = NULL, density= NULL, breaks=12,
     xlab = "Sepal Width", ylab = "Frequency", main = "Histogram 777") #Titles

#Comparison between 3 species 
histogram <- ggplot(data=iris, aes( x=Sepal.Width))

#Colors
histogram + geom_histogram(binwidth = 0.2, color = "white", aes(fill=Species))+
  xlab("Sepal Width") + ylab("Frequency") + ggtitle ("Histogram 777 pt2")

#Graphs of Bars per Group
install.packages("reshape2")
library("reshape2")

head(iris)
iris2 <- melt(iris, id.vars = "Species")
iris2[1:3,]
head(iris2)
x <- iris

bar1 <- ggplot(data=iris2, aes(x=Species, y=value, fill=variable))
bar1 + geom_bar (stat= "identity", position= "dodge") +
  scale_fill_manual(values=c("#660000", "#FFCC33", "#CC0033", "#6600CC"),
                    name= "Iris\nMeasurements",
                    breaks = c("Sepal.Length", "Sepal.Width", "Petal.Length",
                               "Petal.Width"),
                    labels = c("Sepal.Length", "Sepal.Width", "Petal.Length",
                               "Petal.Width"))