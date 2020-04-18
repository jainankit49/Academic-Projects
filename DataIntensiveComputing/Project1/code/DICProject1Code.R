############################## Question 1 ###############################
WDInd1 <- read.csv("C:\\Users\\Milky\\Documents\\NewDirectory\\World Indicators\\Agricultural land 07-11.csv", sep=",", header=TRUE)
View(WDInd1)
dim(WDInd1)
names(WDInd1)
str(WDInd1)
summary(WDInd1)
colnames(WDInd1)[1] <- "Country"
#table() command gives a frequency table:
table <- table(WDInd1$Country)
install.packages("ggplot")
#attach() allows to reference variables in WorldDevInd1 without the cumbersome WorldDevInd1$ prefix
attach(WDInd1)
# In general, graphic functions are very flexible and intuitive to use. For example, hist() produces a histogram.
pdf("Agricultural Land in different countries during 2002-2011.png")
barplot(Value, names.arg=Year, col="blue",border=NA, xlab="Year", ylab="Value") +
  ggtitle("Agricultural Land in different countries during 2002-2011 (% of land Area)")  
dev.off()
attach(WDInd1)
fill_colors <- c()
for ( i in 1:length(Country) ) {
  if (Country[i] == "United States" || Country[i] == "China" || Country[i] == "India") {
    fill_colors <- c(fill_colors, "#821122")
  } else {
    fill_colors <- c(fill_colors, "#cccccc")
  }
}

barplot(Value, names.arg=Year, col=fill_colors,border=NA, xlab="Year", ylab="Agricultural Land (% of land Area)")
barplot(WorldDevInd1$Value, names.arg=WorldDevInd1$Year, col=fill_colors,border=NA, space=0.3, xlab="Year", ylab="Agricultural Land (% of land Area)")
barplot(WorldDevInd1$Value, names.arg=WorldDevInd1$Year, col=fill_colors,border=NA, space=0.3, xlab="Year", ylab="Agricultural Land (% of land Area)",main="(Agricultural Land % of land area Vs Year for different countries)")

#Method 1
#Now to find the year in which the country had maximum land percentage
max_value1=sqldf("select country, year, max(value) from WorldDevInd1 group by country")
colnames(max_value1)[3] <- "Value"

#To change the coulmn names for max_value dataset
colnames(max_value)[1] <- "Country"
colnames(max_value)[2] <- "Value"

#Method 2
#To find the maximum value for each country with other colums also listed
install.packages("plyr")
library(plyr)
max_value3 <- ddply(WorldDevInd1, .(Country), function(x)x[x$Value==max(x$Value), na.rm=TRUE])

#Method 3
#Now to find the maximum agricultural land for each country
max_value <- aggregate(WorldDevInd1$Value~WorldDevInd1$Country, data=WorldDevInd1, max)  

#To find the data only for one country
Afghan_data <- WorldDevInd1[ which(WorldDevInd1$Country=='Afghanistan'), ]

#To find the data only for one country using subset function 
Afghan_data1 <- subset(WorldDevInd1, Country=='Afghanistan',select=c(Country, Value, Year))

#So we have extracted the data countrywise, and also the maximum data for each country. Now comes the ploting part, to get a better picture, let's reduce the data for only five years as that is easy to visualize and interpret,
WorldDevIndUS <- read.csv("C:\\Users"\\Ankit\\Desktop\\DIC Project 1\\World Development Indicators Data\\Agriland2007-2011.csv", sep=",", header=TRUE)
                          colnames(WorldDevIndUS)[1]<-"Country"
                          US_data <- subset(WorldDevIndUS, WorldDevIndUS$Country=='United States', select=c(Country, Value, Year))
                          
                          #Now doing the plotting for five year data for US
                          #Lets start with barplot, scatterplot
                          
                          #Barplot
                          barplot(US_data$Value, names.arg=US_data$Year, col="blue",border=NA, space=0.3, ylim=c(43,46), xlab="Year", ylab="Agricultural Land (% of land Area)",main="(Agricultural Land (% of Land Area) vs Year for US)")

#Since the demarcation is not clearly visible, let's try scatter plots
#ScatterPlot
plot(US_data$Value, type="p", ylim=c(44, 46))
plot(US_data$Value, type="h", ylim=c(44, 46), xlab="Year", ylab="% of land") points(US_data$Value, pch=19, col="black")

#Time Series Plot
plot(US_data$Year, US_data$Value, type="l", xlim=c(1,5), ylim=c(44.5, 46), xlab="Year", ylab="% of Agricultural Land")


install.packages("doBy")
library("doBy")

install.packages("ggplot2")
library(ggplot2)

## -- downloading data from resource for all 30 days of New York Times --
## ======================================================================
data1<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt1.csv")
data2<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt2.csv")
data3<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt3.csv")
data4<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt4.csv")
data5<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt5.csv")
data6<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt6.csv")
data7<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt7.csv")
data8<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt8.csv")
data9<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt9.csv")
data10<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt10.csv")
data11<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt11.csv")
data12<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt12.csv")
data13<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt13.csv")
data14<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt14.csv")
data15<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt15.csv")  
data16<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt16.csv")
data17<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt17.csv")
data18<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt18.csv")
data19<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt19.csv")
data20<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt20.csv")
data21<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt21.csv")
data22<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt22.csv")
data23<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt23.csv")
data24<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt24.csv")
data25<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt25.csv")
data26<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt26.csv")
data27<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt27.csv")
data28<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt28.csv")
data29<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt29.csv")
data30<-read.csv("http://stat.columbia.edu/~rachel/datasets/nyt30.csv")


## ---- Categorizing data on the basis of age categories ----
## ===========================================================
data1$agecat <-cut(data1$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data2$agecat <-cut(data2$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data3$agecat <-cut(data3$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data4$agecat <-cut(data4$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data5$agecat <-cut(data5$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data6$agecat <-cut(data6$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data7$agecat <-cut(data7$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data8$agecat <-cut(data8$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data9$agecat <-cut(data9$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data10$agecat <-cut(data10$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data11$agecat <-cut(data11$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data12$agecat <-cut(data12$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data13$agecat <-cut(data13$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data14$agecat <-cut(data14$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data15$agecat <-cut(data15$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data16$agecat <-cut(data16$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data17$agecat <-cut(data17$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data18$agecat <-cut(data18$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data19$agecat <-cut(data19$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data20$agecat <-cut(data20$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data21$agecat <-cut(data21$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data22$agecat <-cut(data22$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data23$agecat <-cut(data23$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data24$agecat <-cut(data24$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data25$agecat <-cut(data25$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data26$agecat <-cut(data26$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data27$agecat <-cut(data27$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data28$agecat <-cut(data28$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data29$agecat <-cut(data29$Age,c(-Inf,0,18,24,34,44,54,64,Inf))
data30$agecat <-cut(data30$Age,c(-Inf,0,18,24,34,44,54,64,Inf))

## Calculating Clicks/Impressions for every data frame
## ===================================================
data1$CTR <- data1$Clicks/data1$Impressions
data2$CTR <- data2$Clicks/data2$Impressions
data3$CTR <- data3$Clicks/data3$Impressions
data4$CTR <- data4$Clicks/data4$Impressions
data5$CTR <- data5$Clicks/data5$Impressions
data6$CTR <- data6$Clicks/data6$Impressions
data7$CTR <- data7$Clicks/data7$Impressions
data8$CTR <- data8$Clicks/data8$Impressions
data9$CTR <- data9$Clicks/data9$Impressions
data10$CTR <- data10$Clicks/data10$Impressions
data11$CTR <- data11$Clicks/data11$Impressions
data12$CTR <- data12$Clicks/data12$Impressions
data13$CTR <- data13$Clicks/data13$Impressions
data14$CTR <- data14$Clicks/data14$Impressions
data15$CTR <- data15$Clicks/data15$Impressions
data16$CTR <- data16$Clicks/data16$Impressions
data17$CTR <- data17$Clicks/data17$Impressions
data18$CTR <- data18$Clicks/data18$Impressions
data19$CTR <- data19$Clicks/data19$Impressions
data20$CTR <- data20$Clicks/data20$Impressions
data21$CTR <- data21$Clicks/data21$Impressions
data22$CTR <- data22$Clicks/data22$Impressions
data23$CTR <- data23$Clicks/data23$Impressions
data24$CTR <- data24$Clicks/data24$Impressions
data25$CTR <- data25$Clicks/data25$Impressions
data26$CTR <- data25$Clicks/data26$Impressions
data27$CTR <- data27$Clicks/data27$Impressions
data28$CTR <- data28$Clicks/data28$Impressions
data29$CTR <- data29$Clicks/data29$Impressions
data30$CTR <- data30$Clicks/data30$Impressions

## - replacing all 'NA' with zero -
## ================================
data1$CTR[is.nan(data1$CTR)] <-0
data2$CTR[is.nan(data2$CTR)] <-0
data3$CTR[is.nan(data3$CTR)] <-0
data4$CTR[is.nan(data4$CTR)] <-0
data5$CTR[is.nan(data5$CTR)] <-0
data6$CTR[is.nan(data6$CTR)] <-0
data7$CTR[is.nan(data7$CTR)] <-0
data8$CTR[is.nan(data8$CTR)] <-0
data9$CTR[is.nan(data9$CTR)] <-0
data10$CTR[is.nan(data10$CTR)] <-0
data11$CTR[is.nan(data11$CTR)] <-0
data12$CTR[is.nan(data12$CTR)] <-0
data13$CTR[is.nan(data13$CTR)] <-0
data14$CTR[is.nan(data14$CTR)] <-0
data15$CTR[is.nan(data15$CTR)] <-0
data16$CTR[is.nan(data16$CTR)] <-0
data17$CTR[is.nan(data17$CTR)] <-0
data18$CTR[is.nan(data18$CTR)] <-0
data19$CTR[is.nan(data19$CTR)] <-0
data20$CTR[is.nan(data20$CTR)] <-0
data21$CTR[is.nan(data21$CTR)] <-0
data22$CTR[is.nan(data22$CTR)] <-0
data23$CTR[is.nan(data23$CTR)] <-0
data24$CTR[is.nan(data24$CTR)] <-0
data25$CTR[is.nan(data25$CTR)] <-0
data26$CTR[is.nan(data26$CTR)] <-0
data27$CTR[is.nan(data27$CTR)] <-0
data28$CTR[is.nan(data28$CTR)] <-0
data29$CTR[is.nan(data29$CTR)] <-0
data30$CTR[is.nan(data30$CTR)] <-0

## - replacing all 'infinity' with zero -
## ======================================
data1$CTR[is.infinite(data1$CTR)] <-0
data2$CTR[is.infinite(data2$CTR)] <-0
data3$CTR[is.infinite(data3$CTR)] <-0
data4$CTR[is.infinite(data4$CTR)] <-0
data5$CTR[is.infinite(data5$CTR)] <-0
data6$CTR[is.infinite(data6$CTR)] <-0
data7$CTR[is.infinite(data7$CTR)] <-0
data8$CTR[is.infinite(data8$CTR)] <-0
data9$CTR[is.infinite(data9$CTR)] <-0
data10$CTR[is.infinite(data10$CTR)] <-0
data11$CTR[is.infinite(data11$CTR)] <-0
data12$CTR[is.infinite(data12$CTR)] <-0
data13$CTR[is.infinite(data13$CTR)] <-0
data14$CTR[is.infinite(data14$CTR)] <-0
data15$CTR[is.infinite(data15$CTR)] <-0
data16$CTR[is.infinite(data16$CTR)] <-0
data17$CTR[is.infinite(data17$CTR)] <-0
data18$CTR[is.infinite(data18$CTR)] <-0
data19$CTR[is.infinite(data19$CTR)] <-0
data20$CTR[is.infinite(data20$CTR)] <-0
data21$CTR[is.infinite(data21$CTR)] <-0
data22$CTR[is.infinite(data22$CTR)] <-0
data23$CTR[is.infinite(data23$CTR)] <-0
data24$CTR[is.infinite(data24$CTR)] <-0
data25$CTR[is.infinite(data25$CTR)] <-0
data26$CTR[is.infinite(data26$CTR)] <-0
data27$CTR[is.infinite(data27$CTR)] <-0
data28$CTR[is.infinite(data28$CTR)] <-0
data29$CTR[is.infinite(data29$CTR)] <-0
data30$CTR[is.infinite(data30$CTR)] <-0

## defining siterange function to calculate length,sum,min,mean,max
## ================================================================
siterange <- function(x){c(length(x),sum(x),min(x),mean(x),max(x))}

## summarizing data by Age on the basis of age categories &
## attaching Day no. to every row under column 'Day'
## ========================================================
stats1 <- summaryBy(Age~agecat, data =data1, FUN=siterange)
stats1 <- data.frame(c(rep(1,times=8)),stats1)
colnames(stats1)[1]<-"Day"
stats2 <- summaryBy(Age~agecat, data =data2, FUN=siterange)
stats2 <- data.frame(c(rep(2,times=8)),stats2)
names(stats2)[1]<-"Day"
stats3 <- summaryBy(Age~agecat, data =data3, FUN=siterange)
stats3 <- data.frame(c(rep(3,times=8)),stats3)
names(stats3)[1]<-"Day"
stats4 <- summaryBy(Age~agecat, data =data4, FUN=siterange)
stats4 <- data.frame(c(rep(4,times=8)),stats4)
names(stats4)[1]<-"Day"
stats5 <- summaryBy(Age~agecat, data =data5, FUN=siterange)
stats5 <- data.frame(c(rep(5,times=8)),stats5)
names(stats5)[1]<-"Day"
stats6 <- summaryBy(Age~agecat, data =data6, FUN=siterange)
stats6 <- data.frame(c(rep(6,times=8)),stats6)
names(stats6)[1]<-"Day"
stats7 <- summaryBy(Age~agecat, data =data7, FUN=siterange)
stats7 <- data.frame(c(rep(7,times=8)),stats7)
names(stats7)[1]<-"Day"
stats8 <- summaryBy(Age~agecat, data =data8, FUN=siterange)
stats8 <- data.frame(c(rep(8,times=8)),stats8)
names(stats8)[1]<-"Day"
stats9 <- summaryBy(Age~agecat, data =data9, FUN=siterange)
stats9 <- data.frame(c(rep(9,times=8)),stats9)
names(stats9)[1]<-"Day"
stats10 <- summaryBy(Age~agecat, data =data10, FUN=siterange)
stats10 <- data.frame(c(rep(10,times=8)),stats10)
names(stats10)[1]<-"Day"
stats11 <- summaryBy(Age~agecat, data =data11, FUN=siterange)
stats11 <- data.frame(c(rep(11,times=8)),stats11)
names(stats11)[1]<-"Day"
stats12 <- summaryBy(Age~agecat, data =data12, FUN=siterange)
stats12 <- data.frame(c(rep(12,times=8)),stats12)
names(stats12)[1]<-"Day"
stats13 <- summaryBy(Age~agecat, data =data13, FUN=siterange)
stats13 <- data.frame(c(rep(13,times=8)),stats13)
names(stats13)[1]<-"Day"
stats14 <- summaryBy(Age~agecat, data =data14, FUN=siterange)
stats14 <- data.frame(c(rep(14,times=8)),stats14)
names(stats14)[1]<-"Day"
stats15 <- summaryBy(Age~agecat, data =data15, FUN=siterange)
stats15 <- data.frame(c(rep(15,times=8)),stats15)
names(stats15)[1]<-"Day"
stats16 <- summaryBy(Age~agecat, data =data16, FUN=siterange)
stats16 <- data.frame(c(rep(16,times=8)),stats16)
names(stats16)[1]<-"Day"
stats17 <- summaryBy(Age~agecat, data =data17, FUN=siterange)
stats17 <- data.frame(c(rep(17,times=8)),stats17)
names(stats17)[1]<-"Day"
stats18 <- summaryBy(Age~agecat, data =data18, FUN=siterange)
stats18 <- data.frame(c(rep(18,times=8)),stats18)
names(stats18)[1]<-"Day"
stats19 <- summaryBy(Age~agecat, data =data19, FUN=siterange)
stats19 <- data.frame(c(rep(19,times=8)),stats19)
names(stats19)[1]<-"Day"
stats20 <- summaryBy(Age~agecat, data =data20, FUN=siterange)
stats20 <- data.frame(c(rep(20,times=8)),stats20)
names(stats20)[1]<-"Day"
stats21 <- summaryBy(Age~agecat, data =data21, FUN=siterange)
stats21 <- data.frame(c(rep(21,times=8)),stats21)
names(stats21)[1]<-"Day"
stats22 <- summaryBy(Age~agecat, data =data22, FUN=siterange)
stats22 <- data.frame(c(rep(22,times=8)),stats22)
names(stats22)[1]<-"Day"
stats23 <- summaryBy(Age~agecat, data =data23, FUN=siterange)
stats23 <- data.frame(c(rep(23,times=8)),stats23)
names(stats23)[1]<-"Day"
stats24 <- summaryBy(Age~agecat, data =data24, FUN=siterange)
stats24 <- data.frame(c(rep(24,times=8)),stats24)
names(stats24)[1]<-"Day"
stats25 <- summaryBy(Age~agecat, data =data25, FUN=siterange)
stats25 <- data.frame(c(rep(25,times=8)),stats25)
names(stats25)[1]<-"Day"
stats26 <- summaryBy(Age~agecat, data =data26, FUN=siterange)
stats26 <- data.frame(c(rep(26,times=8)),stats26)
names(stats26)[1]<-"Day"
stats27 <- summaryBy(Age~agecat, data =data27, FUN=siterange)
stats27 <- data.frame(c(rep(27,times=8)),stats27)
names(stats27)[1]<-"Day"
stats28 <- summaryBy(Age~agecat, data =data28, FUN=siterange)
stats28 <- data.frame(c(rep(28,times=8)),stats28)
names(stats28)[1]<-"Day"
stats29 <- summaryBy(Age~agecat, data =data29, FUN=siterange)
stats29 <- data.frame(c(rep(29,times=8)),stats29)
names(stats29)[1]<-"Day"
stats30 <- summaryBy(Age~agecat, data =data30, FUN=siterange)
stats30 <- data.frame(c(rep(30,times=8)),stats30)
names(stats30)[1]<-"Day"

## summarizing data by Clicks on the basis of age categories &
## attaching Day no. to every row under column 'Day'
## ========================================================
stats_Clicks1 <- summaryBy(Clicks~agecat, data =data1, FUN=siterange)
stats_Clicks1 <- data.frame(c(rep(1,times=8)),stats_Clicks1)
names(stats_Clicks1)[1]<-"Day"
stats_Clicks2 <- summaryBy(Clicks~agecat, data =data2, FUN=siterange)
stats_Clicks2 <- data.frame(c(rep(2,times=8)),stats_Clicks2)
names(stats_Clicks2)[1]<-"Day"
stats_Clicks3 <- summaryBy(Clicks~agecat, data =data3, FUN=siterange)
stats_Clicks3 <- data.frame(c(rep(3,times=8)),stats_Clicks3)
names(stats_Clicks3)[1]<-"Day"
stats_Clicks4 <- summaryBy(Clicks~agecat, data =data4, FUN=siterange)
stats_Clicks4 <- data.frame(c(rep(4,times=8)),stats_Clicks4)
names(stats_Clicks4)[1]<-"Day"
stats_Clicks5 <- summaryBy(Clicks~agecat, data =data5, FUN=siterange)
stats_Clicks5 <- data.frame(c(rep(5,times=8)),stats_Clicks5)
names(stats_Clicks5)[1]<-"Day"
stats_Clicks6 <- summaryBy(Clicks~agecat, data =data6, FUN=siterange)
stats_Clicks6 <- data.frame(c(rep(6,times=8)),stats_Clicks6)
names(stats_Clicks6)[1]<-"Day"
stats_Clicks7 <- summaryBy(Clicks~agecat, data =data7, FUN=siterange)
stats_Clicks7 <- data.frame(c(rep(7,times=8)),stats_Clicks7)
names(stats_Clicks7)[1]<-"Day"
stats_Clicks8 <- summaryBy(Clicks~agecat, data =data8, FUN=siterange)
stats_Clicks8 <- data.frame(c(rep(8,times=8)),stats_Clicks8)
names(stats_Clicks8)[1]<-"Day"
stats_Clicks9 <- summaryBy(Clicks~agecat, data =data9, FUN=siterange)
stats_Clicks9 <- data.frame(c(rep(9,times=8)),stats_Clicks9)
names(stats_Clicks9)[1]<-"Day"
stats_Clicks10 <- summaryBy(Clicks~agecat, data =data10, FUN=siterange)
stats_Clicks10 <- data.frame(c(rep(10,times=8)),stats_Clicks10)
names(stats_Clicks10)[1]<-"Day"
stats_Clicks11 <- summaryBy(Clicks~agecat, data =data11, FUN=siterange)
stats_Clicks11 <- data.frame(c(rep(11,times=8)),stats_Clicks11)
names(stats_Clicks11)[1]<-"Day"
stats_Clicks12 <- summaryBy(Clicks~agecat, data =data12, FUN=siterange)
stats_Clicks12 <- data.frame(c(rep(12,times=8)),stats_Clicks12)
names(stats_Clicks12)[1]<-"Day"
stats_Clicks13 <- summaryBy(Clicks~agecat, data =data13, FUN=siterange)
stats_Clicks13 <- data.frame(c(rep(13,times=8)),stats_Clicks13)
names(stats_Clicks13)[1]<-"Day"
stats_Clicks14 <- summaryBy(Clicks~agecat, data =data14, FUN=siterange)
stats_Clicks14 <- data.frame(c(rep(14,times=8)),stats_Clicks14)
names(stats_Clicks14)[1]<-"Day"
stats_Clicks15 <- summaryBy(Clicks~agecat, data =data15, FUN=siterange)
stats_Clicks15 <- data.frame(c(rep(15,times=8)),stats_Clicks15)
names(stats_Clicks15)[1]<-"Day"
stats_Clicks16 <- summaryBy(Clicks~agecat, data =data16, FUN=siterange)
stats_Clicks16 <- data.frame(c(rep(16,times=8)),stats_Clicks16)
names(stats_Clicks16)[1]<-"Day"
stats_Clicks17 <- summaryBy(Clicks~agecat, data =data17, FUN=siterange)
stats_Clicks17 <- data.frame(c(rep(17,times=8)),stats_Clicks17)
names(stats_Clicks17)[1]<-"Day"
stats_Clicks18 <- summaryBy(Clicks~agecat, data =data18, FUN=siterange)
stats_Clicks18 <- data.frame(c(rep(18,times=8)),stats_Clicks18)
names(stats_Clicks18)[1]<-"Day"
stats_Clicks19 <- summaryBy(Clicks~agecat, data =data19, FUN=siterange)
stats_Clicks19 <- data.frame(c(rep(19,times=8)),stats_Clicks19)
names(stats_Clicks19)[1]<-"Day"
stats_Clicks20 <- summaryBy(Clicks~agecat, data =data20, FUN=siterange)
stats_Clicks20 <- data.frame(c(rep(20,times=8)),stats_Clicks20)
names(stats_Clicks20)[1]<-"Day"
stats_Clicks21 <- summaryBy(Clicks~agecat, data =data21, FUN=siterange)
stats_Clicks21 <- data.frame(c(rep(21,times=8)),stats_Clicks21)
names(stats_Clicks21)[1]<-"Day"
stats_Clicks22 <- summaryBy(Clicks~agecat, data =data22, FUN=siterange)
stats_Clicks22 <- data.frame(c(rep(22,times=8)),stats_Clicks22)
names(stats_Clicks22)[1]<-"Day"
stats_Clicks23 <- summaryBy(Clicks~agecat, data =data23, FUN=siterange)
stats_Clicks23 <- data.frame(c(rep(23,times=8)),stats_Clicks23)
names(stats_Clicks23)[1]<-"Day"
stats_Clicks24 <- summaryBy(Clicks~agecat, data =data24, FUN=siterange)
stats_Clicks24 <- data.frame(c(rep(24,times=8)),stats_Clicks24)
names(stats_Clicks24)[1]<-"Day"
stats_Clicks25 <- summaryBy(Clicks~agecat, data =data25, FUN=siterange)
stats_Clicks25 <- data.frame(c(rep(25,times=8)),stats_Clicks25)
names(stats_Clicks25)[1]<-"Day"
stats_Clicks26 <- summaryBy(Clicks~agecat, data =data26, FUN=siterange)
stats_Clicks26 <- data.frame(c(rep(26,times=8)),stats_Clicks26)
names(stats_Clicks26)[1]<-"Day"
stats_Clicks27 <- summaryBy(Clicks~agecat, data =data27, FUN=siterange)
stats_Clicks27 <- data.frame(c(rep(27,times=8)),stats_Clicks27)
names(stats_Clicks27)[1]<-"Day"
stats_Clicks28 <- summaryBy(Clicks~agecat, data =data28, FUN=siterange)
stats_Clicks28 <- data.frame(c(rep(28,times=8)),stats_Clicks28)
names(stats_Clicks28)[1]<-"Day"
stats_Clicks29 <- summaryBy(Clicks~agecat, data =data29, FUN=siterange)
stats_Clicks29 <- data.frame(c(rep(29,times=8)),stats_Clicks29)
names(stats_Clicks29)[1]<-"Day"
stats_Clicks30 <- summaryBy(Clicks~agecat, data =data30, FUN=siterange)
stats_Clicks30 <- data.frame(c(rep(30,times=8)),stats_Clicks30)
names(stats_Clicks30)[1]<-"Day"

## combining all data frames into one
## ==================================
wholeMonth <- rbind(stats_Clicks1,stats_Clicks2,stats_Clicks3,stats_Clicks4,stats_Clicks5,stats_Clicks6,stats_Clicks7,stats_Clicks8,stats_Clicks9,stats_Clicks10,stats_Clicks11,stats_Clicks12,stats_Clicks13,stats_Clicks14,stats_Clicks15,stats_Clicks16,stats_Clicks17,stats_Clicks18,stats_Clicks19,stats_Clicks20,stats_Clicks21,stats_Clicks22,stats_Clicks23,stats_Clicks24,stats_Clicks25,stats_Clicks26,stats_Clicks27,stats_Clicks28,stats_Clicks29,stats_Clicks30)


## changing column names
## =====================
names(wholeMonth)[3] <- "Length"
names(wholeMonth)[4] <- "Sum"
names(wholeMonth)[5] <- "Minimum"
names(wholeMonth)[6] <- "Mean"
names(wholeMonth)[7] <- "Maximum"

## calculating quantiles
## ===============================================================
M1 <-length(data1$CTR[(data1$CTR > quantile(data1$CTR,0.95))])
M2 <-length(data2$CTR[(data2$CTR > quantile(data2$CTR,0.95))])
M3 <-length(data3$CTR[(data3$CTR > quantile(data3$CTR,0.95))])
M4 <-length(data4$CTR[(data4$CTR > quantile(data4$CTR,0.95))])
M5 <-length(data5$CTR[(data5$CTR > quantile(data5$CTR,0.95))])
M6 <-length(data6$CTR[(data6$CTR > quantile(data6$CTR,0.95))])
M7 <-length(data7$CTR[(data7$CTR > quantile(data7$CTR,0.95))])
M8 <-length(data8$CTR[(data8$CTR > quantile(data8$CTR,0.95))])
M9 <-length(data9$CTR[(data9$CTR > quantile(data9$CTR,0.95))])
M10 <-length(data10$CTR[(data10$CTR > quantile(data10$CTR,0.95))])
M11 <-length(data11$CTR[(data11$CTR > quantile(data11$CTR,0.95))])
M12 <-length(data12$CTR[(data12$CTR > quantile(data12$CTR,0.95))])
M13 <-length(data13$CTR[(data13$CTR > quantile(data13$CTR,0.95))])
M14 <-length(data14$CTR[(data14$CTR > quantile(data14$CTR,0.95))])
M15 <-length(data15$CTR[(data15$CTR > quantile(data15$CTR,0.95))])
M16 <-length(data16$CTR[(data16$CTR > quantile(data16$CTR,0.95))])
M17 <-length(data17$CTR[(data17$CTR > quantile(data17$CTR,0.95))])
M18 <-length(data18$CTR[(data18$CTR > quantile(data18$CTR,0.95))])
M19 <-length(data19$CTR[(data19$CTR > quantile(data19$CTR,0.95))])
M20 <-length(data20$CTR[(data20$CTR > quantile(data20$CTR,0.95))])
M21 <-length(data21$CTR[(data21$CTR > quantile(data21$CTR,0.95))])
M22 <-length(data22$CTR[(data22$CTR > quantile(data22$CTR,0.95))])
M23 <-length(data23$CTR[(data23$CTR > quantile(data23$CTR,0.95))])
M24 <-length(data24$CTR[(data24$CTR > quantile(data24$CTR,0.95))])
M25 <-length(data25$CTR[(data25$CTR > quantile(data25$CTR,0.95))])
M26 <-length(data26$CTR[(data26$CTR > quantile(data26$CTR,0.95))])
M27 <-length(data27$CTR[(data27$CTR > quantile(data27$CTR,0.95))])
M28 <-length(data28$CTR[(data28$CTR > quantile(data28$CTR,0.95))])
M29 <-length(data29$CTR[(data29$CTR > quantile(data29$CTR,0.95))])
M30 <-length(data30$CTR[(data30$CTR > quantile(data30$CTR,0.95))])

M <- c(M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12,M13,M14,M15,M16,M17,M18,M19,M20,M21,M22,M23,M24,M25,M26,M27,M28,M29,M30)


===============================================================
  
  
  wholeMonth <- rbind(stats1,stats2,stats3,stats4,stats5,stats6,stats7,stats8,stats9,stats10,stats11,stats12,stats13,stats14,stats15,stats16,stats17,stats18,stats19,stats20,stats21,stats22,stats23,stats24,stats25,stats26,stats27,stats28,stats29,stats30)
names(wholeMonth)[3] <- "Length"
names(wholeMonth)[4] <- "Mum"
names(wholeMonth)[5] <- "minimum"
names(wholeMonth)[6] <- "Mean"
names(wholeMonth)[7] <- "Maximum"

A <- ggplot(wholeMonth, aes(Day,length,fill=agecat))
A <- A + geom_histogram(binwidth=1,stat="identity")
A <- A + xlab("Days") + ylab("Number of users signed in based on age categories")

A <- ggplot(wholeMonth, aes(Day,average,color=agecat))
A <- A + geom_line(binwidth=1,stat="identity")
A <- A + xlab("Days") + ylab("Number of average clicks based on age categories")

x <- ggplot(data = data1, aes(x = agecat, y = CTR, col=Age))
x <- x + geom_point(size = 2)
x <- x + facet_wrap(~Gender)
x <- x + xlab("Distribution of Age") + ylab("Click-Through Rate") + ggtitle("Distribution of Click Through Rate based on Age")

a <- ggplot(data1, aes(x=Impressions, fill=agecat))
a <- a + xlab("Number of Impression") + ylab("Counts based on age categories")
a <- a + geom_bar(position="dodge")  # stack by default

b <- ggplot(wholeMonth, aes(Day,length, colour = agecat))
b <- b + geom_freqpoly(binwidth = 1000)
b <- b + geom_line(linetype = 2)

################################ Question 1ends ##################################


############################### Question 2 starts ################################

getwd()
setwd("C:\\Users\\anant\\Desktop\\dic")
library(sqldf)
library(plotrix)
####------------------------save all 
manhat <- read.csv(file="C:\\Users\\Milky\\Desktop\\dds_datasets\\rollingsales_manhattan.csv")
brok <- read.csv(file="C:\\Users\\Milky\\Desktop\\dds_datasets\\rollingsales_brooklyn.csv")
queens <- read.csv(file="C:\\Users\\Milky\\Desktop\\dds_datasets\\rollingsales_queens.csv")
bronx <- read.csv(file="C:\\Users\\Milky\\Desktop\\dds_datasets\\rollingsales_bronx.csv")
statiland <- read.csv(file="C:\\Users\\Milky\\Desktop\\dds_datasets\\rollingsales_statenisland.csv")

combined_data_NY <- rbind(manhat,brok,queens,bronx,statiland)


##########-----------------brooklyn data-------------
summary(brok)

# changing $1234 to 1234
brok$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","",brok$SALE.PRICE))
brok$land.sqft <- as.numeric(gsub("[^[:digit:]]","",brok$LAND.SQUARE.FEET))
brok$sale.date <- as.Date(as.character(brok$SALE.DATE),"%m/%d/%y")

attach(brok) ## attach to same work space and use variable
hist(SALE.PRICE.N)
hist(SALE.PRICE.N[SALE.PRICE.N>0])
hist(land.sqft[SALE.PRICE.N==0])
detach(brok)

brok.sale <- brok[brok$SALE.PRICE.N!=0,]#### create a new work sheet
plot(brok.sale$land.sqft,brok.sale$SALE.PRICE.N,col = "dark green",main= "Brooklyn Homes v/s Sale Prize")

plot(log(brok.sale$land.sqft),log(brok.sale$SALE.PRICE.N),col = "blue",main= "Brooklyn Homes v/s Sale Prize (log)")
brok.homes <- brok.sale[which(grepl("FAMILY",brok.sale$BUILDING.CLASS.CATEGORY)),] # grep, grepl, regexpr and gregexpr search for matches to argument pattern within each element of a character vector: they differ in the format of and amount of detail in the results.sub and gsub perform replacement of the first and all matches respectively. 

plot(log(brok.homes$land.sqft),log(brok.homes$SALE.PRICE.N),col = "magenta",main= "Brooklyn Homes v/s Sale Prize for Family")
brok.homes[which(brok.homes$SALE.PRICE.N<100000),][order(brok.homes[which(brok.homes$SALE.PRICE.N<100000),]$SALE.PRICE.N),]

brok.homes$outliers <- (log(brok.homes$SALE.PRICE.N) <=5) + 0
brok.homes <- brok.homes[which(brok.homes$outliers==0),]
plot(log(brok.homes$land.sqft),log(brok.homes$SALE.PRICE.N),col = "brown",main= "Brooklyn Homes v/s Sale Prize for Family (log)")
typeof(brok.homes)



#---------------------------manhattan------------------------------

summary(manhat)

manhat$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","",manhat$SALE.PRICE)) # changing $1234 to 1234

manhat$land.sqft <- as.numeric(gsub("[^[:digit:]]","",manhat$LAND.SQUARE.FEET))
manhat$sale.date <- as.Date(as.character(manhat$SALE.DATE),"%m/%d/%y")

attach(manhat) ## attach to same work space and use variable
hist(SALE.PRICE.N)
hist(SALE.PRICE.N[SALE.PRICE.N>0])
hist(land.sqft[SALE.PRICE.N==0])
detach(manhat)

manhat.sale <- manhat[manhat$SALE.PRICE.N!=0,]#### create a new work sheet
plot(manhat.sale$land.sqft,manhat.sale$SALE.PRICE.N,col = "blue",main= "Manhattan Homes v/s Sale Prize")
plot(log(manhat.sale$land.sqft),log(manhat.sale$SALE.PRICE.N),col = "magenta",main= "Manhattan Homes v/s Sale Prize (log)")

manhat.homes <- manhat.sale[which(grepl("FAMILY",manhat.sale$BUILDING.CLASS.CATEGORY)),] # grep, grepl, regexpr and gregexpr search for matches to argument pattern within each element of a character vector: they differ in the format of and amount of detail in the results.sub and gsub perform replacement of the first and all matches respectively. 
plot(log(manhat.homes$land.sqft),log(manhat.homes$SALE.PRICE.N),col = "green",main= "Manhattan Homes v/s Sale Prize for Family")

manhat.homes[which(manhat.homes$SALE.PRICE.N<100000),][order(manhat.homes[which(manhat.homes$SALE.PRICE.N<100000),]$SALE.PRICE.N),]

manhat.homes$outliers <- (log(manhat.homes$SALE.PRICE.N) <=5) + 0
manhat.homes <- manhat.homes[which(manhat.homes$outliers==0),]
plot(log(manhat.homes$land.sqft),log(manhat.homes$SALE.PRICE.N),col = "red",main= "Manhattan Homes v/s Sale Prize for Family (log)")


###################----------------queens----------------


summary(queens)

queens$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","",queens$SALE.PRICE)) # changing $1234 to 1234

queens$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","",queens$SALE.PRICE))
queens$land.sqft <- as.numeric(gsub("[^[:digit:]]","",queens$LAND.SQUARE.FEET))
queens$sale.date <- as.Date(as.character(queens$SALE.DATE),"%m/%d/%y")

attach(queens) ## attach to same work space and use variable
hist(SALE.PRICE.N)
hist(SALE.PRICE.N[SALE.PRICE.N>0])
hist(land.sqft[SALE.PRICE.N==0])
detach(queens)

queens.sale <- queens[queens$SALE.PRICE.N!=0,]#### create a new work sheet
plot(queens.sale$land.sqft,queens.sale$SALE.PRICE.N,col = "blue",main= "Queens Homes v/s Sale Prize")
plot(log(queens.sale$land.sqft),log(queens.sale$SALE.PRICE.N),col = "magenta",main= "Queens Homes v/s Sale Prize (log)")

queens.homes <- queens.sale[which(grepl("FAMILY",queens.sale$BUILDING.CLASS.CATEGORY)),] # grep, grepl, regexpr and gregexpr search for matches to argument pattern within each element of a character vector: they differ in the format of and amount of detail in the results.sub and gsub perform replacement of the first and all matches respectively. 
plot(log(queens.homes$land.sqft),log(queens.homes$SALE.PRICE.N),col = "green",main= "Queens Homes v/s Sale Prize for Family")

queens.homes[which(queens.homes$SALE.PRICE.N<100000),][order(queens.homes[which(queens.homes$SALE.PRICE.N<100000),]$SALE.PRICE.N),]

queens.homes$outliers <- (log(queens.homes$SALE.PRICE.N) <=5) + 0
queens.homes <- queens.homes[which(queens.homes$outliers==0),]
plot(log(queens.homes$land.sqft),log(queens.homes$SALE.PRICE.N),col = "red",main= "Queens Homes v/s Sale Prize for Family (log)")


##############--------------------------Total Data analysis--------------

summary(combined_data_NY)

# changing $1234 to 1234
combined_data_NY$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","",combined_data_NY$SALE.PRICE))
combined_data_NY$land.sqft <- as.numeric(gsub("[^[:digit:]]","",combined_data_NY$LAND.SQUARE.FEET))
combined_data_NY$sale.date <- as.Date(as.character(combined_data_NY$SALE.DATE),"%m/%d/%y")

attach(combined_data_NY) ## attach to same work space and use variable
hist(SALE.PRICE.N)
hist(SALE.PRICE.N[SALE.PRICE.N>0])
hist(land.sqft[SALE.PRICE.N==0])
detach(combined_data_NY)

combined_data_NY.sale <- combined_data_NY[combined_data_NY$SALE.PRICE.N!=0,]#### create a new work sheet
plot(combined_data_NY.sale$land.sqft,combined_data_NY.sale$SALE.PRICE.N,col = "blue",main= "Total Homes v/s Sale Prize")

plot(log(combined_data_NY.sale$land.sqft),log(combined_data_NY.sale$SALE.PRICE.N),col = "magenta",main= "Total Homes v/s Sale Prize (log)")
combined_data_NY.homes <- combined_data_NY.sale[which(grepl("FAMILY",combined_data_NY.sale$BUILDING.CLASS.CATEGORY)),] # grep, grepl, regexpr and gregexpr search for matches to argument pattern within each element of a character vector: they differ in the format of and amount of detail in the results.sub and gsub perform replacement of the first and all matches respectively. 

plot(log(combined_data_NY.homes$land.sqft),log(combined_data_NY.homes$SALE.PRICE.N),col = "green",main= "Total Homes v/s Sale Prize for Family")
combined_data_NY.homes[which(combined_data_NY.homes$SALE.PRICE.N<100000),][order(combined_data_NY.homes[which(combined_data_NY.homes$SALE.PRICE.N<100000),]$SALE.PRICE.N),]

combined_data_NY.homes$outliers <- (log(combined_data_NY.homes$SALE.PRICE.N) <=5) + 0

combined_data_NY.homes <- combined_data_NY.homes[which(combined_data_NY.homes$outliers==0),]
plot(log(combined_data_NY.homes$land.sqft),log(combined_data_NY.homes$SALE.PRICE.N),col = "red",main= "Homes v/s Sale Prize in NY for Family (log)")
############################### Question 2 ends #####################################

############################### Question 3 ##########################################
WDInd1 <- read.csv("C:\\Users\\Milky\\Documents\\NewDirectory\\World Indicators\\Agricultural land 07-11.csv", sep=",", header=TRUE)
View(WDInd1)
dim(WDInd1)
names(WDInd1)
str(WDInd1)
summary(WDInd1)
colnames(WDInd1)[1] <- "Country"
#table() command gives a frequency table:
table <- table(WDInd1$Country)
install.packages("ggplot")
#attach() allows to reference variables in WorldDevInd1 without the cumbersome WorldDevInd1$ prefix
attach(WDInd1)
# In general, graphic functions are very flexible and intuitive to use. For example, hist() produces a histogram.
pdf("Agricultural Land in different countries during 2002-2011.png")
barplot(Value, names.arg=Year, col="blue",border=NA, xlab="Year", ylab="Value") +
  ggtitle("Agricultural Land in different countries during 2002-2011 (% of land Area)")  
dev.off()
attach(WDInd1)
fill_colors <- c()
for ( i in 1:length(Country) ) {
  if (Country[i] == "United States" || Country[i] == "China" || Country[i] == "India") {
    fill_colors <- c(fill_colors, "#821122")
  } else {
    fill_colors <- c(fill_colors, "#cccccc")
  }
}

barplot(Value, names.arg=Year, col=fill_colors,border=NA, xlab="Year", ylab="Agricultural Land (% of land Area)")
barplot(WorldDevInd1$Value, names.arg=WorldDevInd1$Year, col=fill_colors,border=NA, space=0.3, xlab="Year", ylab="Agricultural Land (% of land Area)")
barplot(WorldDevInd1$Value, names.arg=WorldDevInd1$Year, col=fill_colors,border=NA, space=0.3, xlab="Year", ylab="Agricultural Land (% of land Area)",main="(Agricultural Land % of land area Vs Year for different countries)")

#Method 1
#Now to find the year in which the country had maximum land percentage
max_value1=sqldf("select country, year, max(value) from WorldDevInd1 group by country")
colnames(max_value1)[3] <- "Value"

#To change the coulmn names for max_value dataset
colnames(max_value)[1] <- "Country"
colnames(max_value)[2] <- "Value"

#Method 2
#To find the maximum value for each country with other colums also listed
install.packages("plyr")
library(plyr)
max_value3 <- ddply(WorldDevInd1, .(Country), function(x)x[x$Value==max(x$Value), na.rm=TRUE])

#Method 3
#Now to find the maximum agricultural land for each country
max_value <- aggregate(WorldDevInd1$Value~WorldDevInd1$Country, data=WorldDevInd1, max)  

#To find the data only for one country
Afghan_data <- WorldDevInd1[ which(WorldDevInd1$Country=='Afghanistan'), ]

#To find the data only for one country using subset function 
Afghan_data1 <- subset(WorldDevInd1, Country=='Afghanistan',select=c(Country, Value, Year))

#So we have extracted the data countrywise, and also the maximum data for each country. Now comes the ploting part, to get a better picture, let's reduce the data for only five years as that is easy to visualize and interpret,
WorldDevIndUS <- read.csv("C:\\Users"\\Ankit\\Desktop\\DIC Project 1\\World Development Indicators Data\\Agriland2007-2011.csv", sep=",", header=TRUE)
                          colnames(WorldDevIndUS)[1]<-"Country"
                          US_data <- subset(WorldDevIndUS, WorldDevIndUS$Country=='United States', select=c(Country, Value, Year))
                          
                          #Now doing the plotting for five year data for US
                          #Lets start with barplot, scatterplot
                          
                          #Barplot
                          barplot(US_data$Value, names.arg=US_data$Year, col="blue",border=NA, space=0.3, ylim=c(43,46), xlab="Year", ylab="Agricultural Land (% of land Area)",main="(Agricultural Land (% of Land Area) vs Year for US)")

#Since the demarcation is not clearly visible, let's try scatter plots
#ScatterPlot
plot(US_data$Value, type="p", ylim=c(44, 46))
plot(US_data$Value, type="h", ylim=c(44, 46), xlab="Year", ylab="% of land") points(US_data$Value, pch=19, col="black")

#Time Series Plot
plot(US_data$Year, US_data$Value, type="l", xlim=c(1,5), ylim=c(44.5, 46), xlab="Year", ylab="% of Agricultural Land")

################################################

WDInd1 <- read.csv("C:\\Users\\Milky\\Documents\\NewDirectory\\World Indicators\\Agricultural land.csv", sep=",", header=TRUE)
WDInd2 <- read.csv("C:\\Users\\Milky\\Documents\\NewDirectory\\World Indicators\\Electric power consumption.csv", sep=",", header=TRUE)
WDInd3 <- read.csv("C:\\Users\\Milky\\Documents\\NewDirectory\\World Indicators\\GDP growth.csv", sep=",", header=TRUE)
WDInd4 <- read.csv("C:\\Users\\Milky\\Documents\\NewDirectory\\World Indicators\\Internet users.csv", sep=",", header=TRUE)
WDInd5 <- read.csv("C:\\Users\\Milky\\Documents\\NewDirectory\\World Indicators\\Mobile cellular subscriptions.csv", sep=",", header=TRUE)
WDInd6 <- read.csv("C:\\Users\\Milky\\Documents\\NewDirectory\\World Indicators\\Mortality rate under-5.csv", sep=",", header=TRUE)
WDInd7 <- read.csv("C:\\Users\\Milky\\Documents\\NewDirectory\\World Indicators\\Population total.csv", sep=",", header=TRUE)
WDInd8 <- read.csv("C:\\Users\\Milky\\Documents\\NewDirectory\\World Indicators\\Poverty headcount ratio.csv", sep=",", header=TRUE)
WDInd9 <- read.csv("C:\\Users\\Milky\\Documents\\NewDirectory\\World Indicators\\Prevalence of HIV.csv", sep=",", header=TRUE)
WDInd10 <- read.csv("C:\\Users\\Milky\\Documents\\NewDirectory\\World Indicators\\Ratio of girls to boys.csv", sep=",", header=TRUE)

installing.packages("sqldf")
library("sqldf")

colnames(WDInd1)[1] <- "Country"
colnames(WDInd2)[1] <- "Country"
colnames(WDInd3)[1] <- "Country"
colnames(WDInd4)[1] <- "Country"
colnames(WDInd5)[1] <- "Country"
colnames(WDInd6)[1] <- "Country"
colnames(WDInd7)[1] <- "Country"
colnames(WDInd8)[1] <- "Country"
colnames(WDInd9)[1] <- "Country"
colnames(WDInd10)[1] <- "Country"

WDInd1=sqldf("select country,value, year from WDInd1 where country= 'United States' and Year>=2002") 
WDInd2=sqldf("select country,value, year from WDInd2 where country= 'United States' and Year>=2002") 
WDInd3=sqldf("select country,value, year from WDInd3 where country= 'United States' and Year>=2002") 
WDInd4=sqldf("select country,value, year from WDInd4 where country= 'United States' and Year>=2002") 
WDInd5=sqldf("select country,value, year from WDInd5 where country= 'United States' and Year>=2002") 
WDInd6=sqldf("select country,value, year from WDInd6 where country= 'United States' and Year>=2002") 
WDInd7=sqldf("select country,value, year from WDInd7 where country= 'United States' and Year>=2002") 
WDInd8=sqldf("select country,value, year from WDInd8 where country= 'United States' and Year>=2002") 
WDInd9=sqldf("select country,value, year from WDInd9 where country= 'United States' and Year>=2002") 
WDInd10=sqldf("select country,value, year from WDInd10 where country= 'United States' and Year>=2002") 

ggplot(data=WDInd1, aes(x=Year, y=Value, group=1)) + geom_line(colour="purple") + geom_point() + ylim(44.5, max(WDInd1$Value)) + xlab("Year") + ylab("Value")+ 
ggtitle("Agricultural Land available in US during 2002-2011 (% of land Area)")
ggsave("USInd1.pdf")

ggplot(data=WDInd2, aes(x=Year, y=Value, group=1)) + geom_line(colour="blue") + geom_point() + ylim(12750, max(WDInd2$Value)) + xlab("Year") + ylab("Value")+ 
ggtitle("Electric Power Consumption in US during 2002-2011 (KWh per Capita)")
ggsave("USInd2.pdf")

ggplot(data=WDInd3, aes(x=Year, y=Value, group=1)) + geom_line(colour="red") + geom_point() + ylim(-4, max(WDInd3$Value)) + xlab("Year") + ylab("Value")+ 
ggtitle("GDP Growth in US during 2002-2011 (Annual %)")
ggsave("USInd3.pdf")

WDInd3$colour <- ifelse(WDInd3$Value  < 0, "firebrick1","steelblue")
WDInd3$hjust <- ifelse(WDInd3$Value > 0, 3.5, -3.5)
ggplot(WDInd3, aes(Year, Value, label = "", hjust = hjust)) + 
geom_text(aes(y = 0, colour = colour)) +  theme(legend.position = "none") +
geom_bar(stat = "identity", aes(fill = colour), colour="black") + 
ggtitle("GDP Growth in US during 2002-2012 (Annual %)") +
ggsave("USInd3_.pdf")

ggplot(data=WDInd4, aes(x=Year, y=Value, group=1)) + geom_line(colour="green") + geom_point() + ylim(55, max(WDInd4$Value)) + xlab("Year") + ylab("Value")+ 
ggtitle("Internet Users in US during 2002-2011 (per 100 people)") +
scale_x_continuous(limits=c(2002, 2011))
ggsave("USInd4.pdf")

ggplot(data=WDInd5, aes(x=Year, y=Value, group=1)) + geom_line(colour="brown") + geom_point() + ylim(40, max(WDInd5$Value)) + xlab("Year") + ylab("Value")+ 
ggtitle("Mobile Cellular Subscriptions in US during 2002-2011 (per 100 people)") +
scale_x_continuous(limits=c(2002, 2011))
ggsave("USInd5.pdf")

ggplot(data=WDInd6, aes(x=Year, y=Value, group=1)) + geom_line(colour="cyan") + geom_point() + ylim(7, max(WDInd6$Value)) + xlab("Year") + ylab("Value")+ 
ggtitle("Mortality Rate, under-5 in US during 2002-2011 (per 1,000)") 
ggsave("USInd6.pdf")

ggplot(data=WDInd7, aes(x=Year, y=Value, group=1)) + geom_line(colour="orange") + geom_point() + ylim(2.8e+08, max(WDInd7$Value)) + xlab("Year") + ylab("Value")+ 
ggtitle("Population, total in US during 2002-2011")
ggsave("USInd7.pdf")

ggplot(data=WDInd9, aes(x=Year, y=Value, group=1)) + geom_line(colour="magenta") + geom_point() + ylim(0.55, max(WDInd9$Value)) + xlab("Year") + ylab("Value")+ 
ggtitle("Prevalence of HIV, total in US during 2002-2011 (% of population ages 15-49)")
ggsave("USInd9.pdf")

ggplot(data=WDInd10, aes(x=Year, y=Value, group=1)) + geom_line(colour="dark green") + geom_point() + ylim(99.5, max(WDInd10$Value)) + xlab("Year") + ylab("Value")+ 
ggtitle("Ratio of Girls to Boys in Primary and Secondary Education in US during 2002-2011 (%)")
ggsave("USInd10.pdf")

WDIndComp <- read.csv("C:\\Users\\Milky\\Documents\\NewDirectory\\World Indicators\\Compare Internet & Mobile Users.csv", sep=",", header=TRUE)
ggplot(WDIndComp, aes(x=Year, y=Value, colour= 'Users')) + 
geom_line(aes(y = WDIndComp$Internet.Users, colour = "Internet Users")) + 
geom_line(aes(y = WDIndComp$Mobile.Users, colour = "Mobile Users")) +
scale_x_continuous(limits=c(2002, 2011)) +
ggtitle("No. of Internet Users & Mobile Users in US, 2002-2011 (per 100 people)") 
ggsave("USInd11.pdf")

WDIndComp2 <- read.csv("C:\\Users\\Milky\\Documents\\NewDirectory\\World Indicators\\Compare Internet & Mobile Users2.csv", sep=",", header=TRUE)
ggplot(data=WDIndComp2, aes(x=Year, y=Value, fill=Users)) + geom_bar(stat="identity", position=position_dodge(), colour="black") +
scale_fill_manual(values=c("#999999", "#E69F00")) +
ggtitle("No. of Internet Users & Mobile Users in US, 2002-2012 (per 100 people)") 
ggsave("USInd12.pdf")

library(ggplot2)
WDIndComp3 <- read.csv("C:\\Users\\Milky\\Documents\\NewDirectory\\World Indicators\\Compare ratio of girls to boys.csv", sep=",", header=TRUE)
ggplot(data=WDIndComp3, aes(x=Year, y=Value, fill=Gender)) + geom_bar(stat="identity", colour="black") + ylim(0, 201) + xlim(2001, 2013) +
  ggtitle("% of girls to boys in primary and secondary education in US, 2002-2011") 
ggsave("USInd13.pdf")

# Pie Chart with Percentages
WDIndPie <- read.csv("C:\\Users\\Milky\\Documents\\NewDirectory\\World Indicators\\% contri to GDP.csv")
slices <- WDIndPie$PartofGDP[WDIndPie$Year==2011]
lbls <- WDIndPie$Indicator[WDIndPie$Year==2011]
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct)  
lbls <- paste(lbls,"%",sep="") 
pie(slices,labels = lbls, col=rainbow(length(lbls)), cex=0.7)

slices1 <- WDIndPie$PartofGDP[WDIndPie$Year==2002]
lbls1 <- WDIndPie$Indicator[WDIndPie$Year==2002]
pct1 <- round(slices1/sum(slices1)*100)
lbls1 <- paste(lbls1, pct1)  
lbls1 <- paste(lbls1,"%",sep="") 
pie(slices1,labels = lbls1, col=rainbow(length(lbls1)), cex=0.7)


library(plotrix)
slices11 <- c(44.95,30.96,24.07) 
lbls11 <- c("Agricultural Land \n44.95%", "Forest Area \n30.96%", "Others \n24.07%")
png("Surface Area Distribution of US in 2011.png")
pie3D(slices11,labels=lbls11,explode=0.1, height=0.16, labelcex=0.8, radius=3,col=c("green","dark green","#dd00dd"),
      main="Surface Area Distribution of US in 2011")
dev.off()

slices02 <- c(45.08,31.24,24.09) 
lbls02 <- c("Agricultural Land \n45.08%", "Forest Area \n31.24%", "Others \n24.09%")
png("Surface Area Distribution of US in 2002.png")
pie3D(slices02,labels=lbls02,explode=0.1, height=0.16, labelcex=0.8, radius=3,col=c("green","dark green","#dd00dd"),
      main="Surface Area Distribution of US in 2002")
dev.off()


ggplot(WDInd2, aes(x=Year, y=Value)) + geom_point(shape=1) + geom_smooth(method=lm, fullrange=T) +
  ylim(13250,13750) +
  ggtitle("Electric Power Consumption in US during 2002-2011 (KWh per Capita)") 

install.packages("rworldmap")
library(rworldmap)

map <- getMap(resolution = 'high')
plot(map,main="World")
ggmap(map)
map.world

library(maps)
data(world.cities)
ctrys1=c("China","India","Australia","USA","Canada","Sweden","Kuwait","Namibia","Saudi Arabia","Thailand")
cols=c("China"='red',"India"='orange',"Australia"='brown',"USA"='blue',"Canada"='magenta',"Sweden"='pink',"Kuwait"='grey',"Namibia"='dark green',"Saudi Arabia"='yellow',"Thailand"='cyan')
a=map('world',regions=ctrys1, exact = TRUE ,mar=c(0,0,0,0),fill=1,col=cols)

newmap <- getMap(resolution = "high")
plot(newmap, main = "World")

library(OIdata)
library(RColorBrewer)
library(classInt)

data("newmap")

nclr <- 9 # number of bins
min <- 0 # theoretical minimum
max <- 100 # theoretical maximum
breaks <- (max - min) / nclr

# set up colors:
plotclr <- brewer.pal(nclr, "Reds")
plotvar <- newmap$nuclear
class <- classIntervals(plotvar,nclr,style = "fixed",fixedBreaks = seq(min, max, breaks))
colcode <- findColours(class,  plotclr)

# map data:
map("state", col = "gray80", fill = TRUE, lty = 0)
map("state", col = colcode, fill = TRUE, lty = 0, add = TRUE)
map("state", col = "gray",lwd = 1.4,lty = 1,add = TRUE)

legend("bottomleft", legend = names(attr(colcode, "table")), title = "Percent",
fill = attr(colcode, "palette"), cex = 0.56, bty = "n")

# set up colors:
plotclr <- brewer.pal(nclr, "Reds")
plotvar <- newmap$nuclear
class <- classIntervals(plotvar,nclr,style = "fixed",fixedBreaks = seq(min, max, breaks))                   
colcode <- findColours(class, plotclr)
NAColor <- "gray80"
plotclr <- c(plotclr, NAColor)

# map data:
map("state", col = NAColor,fill = TRUE,lty = 0)
map("state", col = colcode,fill = TRUE,lty = 0,add = TRUE)
map("state",col = "gray",lwd = 1.4,lty = 1,add = TRUE)

# set legend text:
legendText <- c()
for(i in seq(min, max - (max - min) / nclr, (max - min) / nclr)) {
  if (i == max(seq(min, max - (max - min) / nclr, (max - min) / nclr))) {
    legendText <- c(legendText, paste(round(i,3), "\u2264 n \u2264", round(i + (max - min) / nclr,3)))
  } else
    legendText <- c(legendText, paste(round(i,3), "\u2264 n <", round(i + (max - min) / nclr,3))) 
}

# set legend text:
legendText <- c()
for(i in seq(min, max - (max - min) / nclr, (max - min) / nclr)) {
  if (i == max(seq(min, max - (max - min) / nclr, (max - min) / nclr))) {
    legendText <- c(legendText, paste(round(i,3), "\u2264 n \u2264", round(i + (max - min) / nclr,3)))
    if (!is.na(NAColor)) legendText <- c(legendText, "NA")
  } else
    legendText <- c(legendText, paste(round(i,3), "\u2264 n <", round(i + (max - min) / nclr,3))) 
}


data(countryExData)
sPDF <- joinCountryData2Map( countryExData
                             ,joinCode = "ISO3"
                             ,nameJoinColumn = "ISO3V10")

data(countryExData)
sPDF <- joinCountryData2Map( countryExData
                             ,joinCode = "ISO3"
                             ,nameJoinColumn = "ISO3V10")
mapDevice() #create world map shaped window
mapCountryData(sPDF
               ,nameColumnToPlot='BIODIVERSITY')
data(gridExData)
mapDevice() #create world map shaped window
mapGriddedData(gridExData)