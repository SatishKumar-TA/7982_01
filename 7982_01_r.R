#library(readxl)
#library(dplyr)
#dataframe<- read_excel("C:/Users/satish.bogala/Documents/SaleData.xlsx")

#1. Find the least amount sale that was done for each item.
q1<-function(dataframe)
{
  return(aggregate(dataframe[,"Sale_amt"], list(dataframe$Item), min))
}
#q1(dataframe)



# 2. Compute the total sales for each year and region across all items 
q2<-function(dataframe)
{
  dataframe['year']=format(as.Date(dataframe$OrderDate, format="%m/%d/%Y"),"%Y")
  return(aggregate(dataframe[,'Sale_amt'], list(dataframe$Item,dataframe$year,dataframe$Region), sum))
}
#q2(dataframe)


# 3. Create new column 'days_diff' with number of days difference between reference date passed and each order date 
q3<-function(dataframe,refer_date)
{
  dataframe$days_diff <-as.Date(refer_date,'%m-%d-%Y')
  dataframe$days_diff<- difftime(dataframe$days_diff ,dataframe$OrderDate , units = c("days"))
  return(dataframe)
}
#q3(dataframe,'01-25-2020')


# 4. Create a dataframe with two columns: 'manager', 'list_of_salesmen'. Column 'manager' will contain the unique managers present and column 'list_of_salesmen' will contain an array of all salesmen under each manager. 
q4<-function(dataframe)
{
  dataframe1<-aggregate((dataframe['SalesMan']), list(dataframe$Manager), unique)
  colnames(dataframe1)[1]<-"manager"
  colnames(dataframe1)[2]<-"list_of_salesmen"
  return(dataframe1)
}
#q4(dataframe)


# 5. For all regions find number of salesman and total sales. Return as a dataframe with three columns Region, salesmen_count and total_sale
q5<-function(dataframe)
{
  dataframe2<-aggregate(dataframe['Sale_amt'], list(dataframe$Region), sum)
  colnames(dataframe2)[1]<-'Region'
  colnames(dataframe2)[2]<-'total_sale'
  dataframe3<-aggregate(dataframe['SalesMan'],list(dataframe$Region),list)
  dataframe2['Salesman_count']<-c(1,1,1)
  for(i in 1:3)
  {
      dataframe2[i,3]<-length(unique(unlist(dataframe3[i,2])))
  }
  return(dataframe2)
}
#q5(dataframe)


# 6. Create a dataframe with total sales as percentage for each manager. Dataframe to contain manager and percent_sales
q6<-function(dataframe)
{
  dataframe4<-aggregate(dataframe['Sale_amt'], list(dataframe$Manager), sum)
  s<-sum(dataframe$Sale_amt)
  dataframe4['percent_sales']<-(dataframe4['Sale_amt']/s)*100
  dataframe4$Sale_amt<-NULL
  colnames(dataframe4)[1]<-"manager"
  return(dataframe4)
}
#q6(dataframe)



#dataframe<-read.csv("C:/Users/satish.bogala/Documents/imdb.csv")

# 7. Get the imdb rating for fifth movie of dataframe
q7<-function(dataframe)
{
  return(dataframe[['imdbRating']][5])
}
#q7(dataframe)

# 8. Return titles of movies with shortest and longest run time
q8<-function(dataframe)
{
  mini=dataframe$title[which.min(dataframe$duration)]
  maxi=dataframe$title[which.max(dataframe$duration)]
  l=list(mini,maxi)
  return(l)
}
#q8(dataframe)


#9. Sort the data frame by in the order of when they where released and have higer ratings, Hint : release_date (earliest) and Imdb rating(highest to lowest)
q9<-function(dataframe)
{
  dataframe<-dataframe %>% drop_na(year,imdbRating )
  dataframe1<-dataframe[order( dataframe[,9],-dataframe[,6] ),]
  return(dataframe1)
}
#q9(dataframe)


# 10. Subset the dataframe with movies having the following prameters. revenue more than 2 million spent less than 1 million duration between 30 mintues to 180 minutes 
#dataframe2<-read.csv("C:/Users/satish.bogala/Documents/movie_metadata.csv")
q10<-function(dataframe2)
{
  dataframe3<-subset(dataframe2,(duration>30)&(duration<180)&(gross>2000000)&(budget<1000000))
  return(dataframe3)
}
#q10(dataframe2)



#dataframe<-read.csv('C:/Users/satish.bogala/Documents/diamonds.csv')

#11. Count the duplicate rows of diamonds DataFrame.
q11<-function(dataframe)
{
  x<-(nrow(dataframe)-nrow(unique(dataframe)))
  return(x)
}
#q11(dataframe)



# 12. Drop rows in case of missing values in carat and cut columns. 
q12<-function(dataframe)
{
  dataframe1<-dataframe[complete.cases(dataframe[ , 1:2]),]
  return(dataframe1)
}
#q12(dataframe)


# 13. Subset the dataframe with only numeric columns.
q13<-function(dataframe)
{
  dataframe2<-select_if(dataframe, is.numeric)
  return(dataframe2)
}
#q13(dataframe)


# 14. Compute volume as (x y z) when depth is greater than 60. In case of depth less than 60 default volume to 8. 
q14<-function(dataframe)
{
  dataframe$z = as.numeric(as.character(dataframe$z))
  dataframe$z[is.na(dataframe$z)] <- 0
  dataframe$volume<-0
  dataframe$volume <- ifelse(dataframe$depth>60,dataframe$x*dataframe$y*dataframe$z, 8)
  return(dataframe)
}
#q14(dataframe)


# 15. Impute missing price values with mean.
q15<-function(dataframe)
{
  dataframe4<-dataframe
  dataframe4$price <- ifelse(is.na(dataframe4$price), mean(dataframe4$price, na.rm=TRUE), dataframe4$price)
  return(dataframe4)
}
#q15(dataframe)



#BONUS QUESTIONS
#library(dplyr)
#library(descr)#cross tab
#library(mltools)#cut
#library(readr)#escape back slash
#library(tidyr)
#library(imputeTS)

#2Ans
dataframe <- read.csv('C:/Users/satish.bogala/Documents/diamonds.csv')
q2<-function(dataframe)
{
  dataframe1$length1<-nchar(gsub(" ","",dataframe1$wordsInTitle,fixed=TRUE))
  dataframe1$quantile<-as.numeric(ntile(dataframe1$length1,4))
  df3<-as.data.frame.matrix(table(dataframe1$year,dataframe1$quantile))
  df4<-dataframe1%>%group_by(year)%>%summarise(minimum=min(length1,na.rm=TRUE),maximum=max(length1,na.rm=TRUE))
  df4=drop_na(df4)
  df5<-cbind(df4,df3)
  row.names(df5)<-NULL
  return(df5)
}
#q2(dataframe)


#3Ans
dataframe <- read.csv('C:/Users/satish.bogala/Documents/diamonds.csv')
q3<-function(dataframe)
{
  depth.filter<-dataframe$depth>60
  v<-c()
  for(i in 1:length(depth.filter))
    {
      if(depth.filter[i])
        {
          vol<-(as.numeric(as.character(dataframe$x[i]))*
          as.numeric(as.character(dataframe$y[i]))*
          as.numeric(as.character(dataframe$z[i])))
        }
      else
      {
        vol<-8
      }
    v<-c(v,vol)
  }
  dataframe$volume<-v
  dataframe$Bins<-as.numeric(ntile(dataframe$volume,5))
  tvol=sum(dataframe$volume)
  t<-crosstab(dataframe$Bins,dataframe$cut,plot=FALSE,prop.t=TRUE)
  return(t)
}
#q3(dataframe)


#5Ans
df2<-read_delim("D:/imdb.csv", delim=',', escape_double=FALSE, escape_backslash=TRUE)
q5<-function(df)
{
  df2<-na_mean(df2)
  df2$deciles<-as.numeric(ntile(df2$duration,10))
  df3<-df2%>%group_by(deciles)%>%summarise(nr_Of_Nominations=sum(nrOfNominations,na.rm=TRUE),nr_Of_Wins=sum(nrOfWins))
  df3$count<-as.data.frame(table(df2$deciles))['Freq']
  df4<-df2[c(17:45)]
  df5<-df4%>%group_by(deciles)%>%summarise_all(sum)
  df5<-as.data.frame.matrix(t(df5))
  names<-row.names(df5)
  high<-function(x)
  {
    return(names[order(x,decreasing = TRUE)[1:3]])
  }
  df6<-as.data.frame.matrix(t(sapply(df5,high)))
  colnames(df6)<-c('first','second','third')
  df3['top genres']<-paste(df6$first,',',df6$second,',',df6$third)
  return(df3)
}
#q5(df2)
