# import pandas, numpy
# Create the required data frames by reading in the files

# Q1 Find least sales amount for each item
# has been solved as an example
def least_sales(df):
    # write code to return pandas dataframe
    df1=df.groupby('Item')['Sale_amt'].min().reset_index()
    return df1
# Q2 compute total sales at each year X region
def sales_year_region(df):
    # write code to return pandas dataframe
    df['year']=pd.DatetimeIndex(df['OrderDate']).year
    df2=df.groupby(['year','Region','Item']).sum()
    return df2

# Q3 append column with no of days difference from present date to each order date
def days_diff(df,reference_date):
    # write code to return pandas dataframe
    ref=pd.to_datetime(reference_date)
    df['days_diff']=ref-df['OrderDate']
    return df

# Q4 get dataframe with manager as first column and  salesman under them as lists in rows in second column.
def mgr_slsmn(df):
    # write code to return pandas dataframe
    df1=df.groupby('Manager')['SalesMan'].unique().reset_index(name='list_of_sales_men')
    return df1

# Q5 For all regions find number of salesman and number of units
def slsmn_units(df):
    # write code to return pandas dataframe
    df4=pd.DataFrame() 
    df4['salesmen_count ']=df.groupby('Region')["SalesMan"].nunique()
    df4[' total_sales']=df.groupby('Region')['Sale_amt'].sum() 
    return df4

# Q6 Find total sales as percentage for each manager
def sales_pct(df):
    # write code to return pandas dataframe
    df5=(df.groupby('Manager')['Sale_amt'].sum()/df['Sale_amt'].sum())*100
    return df5

# Q7 get imdb rating for fifth movie of dataframe
def fifth_movie(df):
    # write code here
    return df['imdbRating'][4]

# Q8 return titles of movies with shortest and longest run time
def movies(df):
    minval=df[df["duration"]==df["duration"].min()]["title"]
    maxval=df[df["duration"]==df["duration"].max()]["title"]
    return minval,maxval

# Q9 sort by two columns - release_date (earliest) and Imdb rating(highest to lowest)
def sort_df(df):
    # write code here
    df6=df.sort_values(['year', 'imdbRating'], ascending=[True, False])
    return df6

# Q10 subset revenue more than 2 million and spent less than 1 million & duration between 30 mintues to 180 minutes
def sort_df(df):
    # write code here
    df6=df.sort_values(['year', 'imdbRating'], ascending=[True, False])
    return df6
    

# Q11 count the duplicate rows of diamonds DataFrame.
def dupl_rows(df):
    # write code here
    x=df[df.duplicated()]
    return len(x)

# Q12 droping those rows where any value in a row is missing in carat and cut columns
def drop_row(df):
    # write code here
    df8=df.dropna(subset=['carat','cut'])
    return df8

# Q13 subset only numeric columns
def sub_numeric(df):
    # write code here
    df1=df._get_numeric_data()
    return df1

# Q14 compute volume as (x*y*z) when depth > 60 else 8
def volume(df):
    df['z'].fillna(0, inplace = True)
    for i in range(0,len(df)):
        if(df['z'][i]=="None"):
            df['z'][i]=0
    for i in range(0,len(df)):
        df['z']=df['z'].astype(float)
    ans=[]
    for i in range(0,len(df)):
        if df['depth'][i]>60:
            ans.append(df['x'][i]*df['y'][i]*df['z'][i])
        else:
            ans.append(8)
    df['volume']=ans
    return df

# Q15 impute missing price values with mean
def impute(df):
    # write code here
    df.fillna(df.mean())
    return df


#Bonus questions (Optional) 
# Q1  Generate a report that tracks the various Genere combinations for each type year on year. 
#The result data frame should contain type, Genere_combo, year, avg_rating, min_rating, max_rating, total_run_time_mins 
def bonus1(df):
    df['GenreCombo']=df[df.columns[16:]].T.apply(lambda g: '|'.join(g.index[g==1]),axis=0)
    df1=df.groupby(["type","year","GenreCombo"]).agg({"imdbRating":[min,max,np.mean],'duration':np.sum})
    return df1

#Q2  Is there a realation between the length of a movie title and the ratings ? 
#Generate a report that captures the trend of the number of letters in movies titles over years.
#We expect a cross tab between the year of the video release and the quantile that length fall under.
#The results should contain year, min_length, max_length, num_videos_less_than25Percentile, num_videos_25_50Percentile , num_videos_50_75Percentile, num_videos_greaterthan75Precentile 
def bonus2_correlation(df):
    df['Title_Length']=df['title'].apply(lambda x:len(x.split('(')[0].replace(' ','').rstrip()))
    relation=df['Title_Length'].corr(df['imdbRating'])
    return relation
def bonus2_continue(df):
    df['Quantile']=pd.qcut(df['Title_Length'],4,labels=False)
    df['Title_Length']=df['title'].apply(lambda x:len(x.split('(')[0].replace(' ','').rstrip()))
    df1=pd.crosstab(df.year,df.Quantile,margins=False)
    df1["min"]=df.groupby(["year"])["Title_Length"].min()
    df1["max"]=df.groupby(["year"])["Title_Length"].max()
    return df1

#Q3 In diamonds data set Using the volumne calculated above, create bins that have equal population within them. 
#Generate a report that contains cross tab between bins and cut. Represent the number under each cell as a percentage of total.
def bonus3(df):
    df=df.mask(df.eq('None'))
    df.fillna(value=0,inplace=True)
    df['volumes']=df['x']*df['y']*(df['z'].astype("float32"))
    df["volumes"][df["depth"]<=60]=8
    df["bins"]=pd.qcut(df["volumes"],q=5,labels=['1','2','3','4','5'])
    df1=(pd.crosstab(df["bins"],df["cut"],normalize=True))*100
    df1
    return df1

#Q4 Generate a report that tracks the Avg. imdb rating quarter on quarter, in the last 10 years, for movies that are top performing. 
#You can take the top 10% grossing movies every quarter. Add the number of top performing movies under each genere in the report as well.
#df=movie_metadata
#df_1=imdb
def bonus5(df,df_1):
    import math  
    df['url']=df['movie_imdb_link'].apply(lambda x:x.split('?')[0])
    df1=pd.DataFrame()
    years=df['title_year'].unique()
    for i in years:
        df2=df[(df['title_year']==i)]
        df3=df2.sort_values(by=['gross'], ascending=False)
        g=df3.head(math.ceil(len(df2)*0.10))
        df1=df1.append(g)
    df4=pd.merge(df1,df_1,on="url",how="left")
    genres=df4.loc[:,'Action':'Western'].columns.tolist()
    df5=pd.DataFrame()
    df5=df4.groupby("title_year")[genres].sum()
    df5['Avg_imdb']=df4.groupby("title_year")["imdb_score"].mean()
    return df5
#bonus5(df,df_1)

#Q5 Bucket the movies into deciles using the duration. 
#Generate the report that tracks various features like nomiations, wins, count, top 3 geners in each decile
def bonus5(df):
    df["decile"]=pd.qcut(df["duration"],10,labels=False)
    df1=df.groupby("decile")[["nrOfNominations","nrOfWins"]].sum()
    df1["count"]=df.groupby("decile")["year"].count()
    df2=df.iloc[:,np.r_[8,17:45]]#data
    df3=df2.groupby("decile")[df2.columns.tolist()[1:28]].sum()
    df3=df3.transpose()
    df4=pd.DataFrame(df3.apply(lambda df1: df1.nlargest(3).index,axis=0).transpose(),)
    df4.columns=["1st","2nd","3rd"]
    df1["Top Genres"]=df4["1st"]+","+df4["2nd"]+","+df4["3rd"]
    return df1

