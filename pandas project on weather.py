#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd


# In[11]:


df=pd.read_csv("WeatherData.csv")


# In[12]:


df


# Q. 1)  Find all the unique 'Wind Speed' values in the data.
# Q. 2) Find the number of times when the 'Weather is exactly Clear'.
# Q. 3) Find the number of times when the 'Wind Speed was exactly 4 km/h'.
# Q. 4) Find out all the Null Values in the data.
# Q. 5) Rename the column name 'Weather' of the dataframe to 'Weather Condition'.
# Q. 6) What is the mean 'Visibility' ?
# Q. 7) What is the Standard Deviation of 'Pressure'  in this data?
# Q. 8) What is the Variance of 'Relative Humidity' in this data ?
# Q. 9) Find all instances when 'Snow' was recorded.
# Q. 10) Find all instances when 'Wind Speed is above 24' and 'Visibility is 25'.
# Q. 11) What is the Mean value of each column against each 'Weather Condition ?
# Q. 12) What is the Minimum & Maximum value of each column against each 'Weather Condition ?
# Q. 13) Show all the Records where Weather Condition is Fog.
# Q. 14) Find all instances when 'Weather is Clear' or 'Visibility is above 40'.
# Q. 15) Find all instances when :
# A. 'Weather is Clear' and 'Relative Humidity is greater than 50'
# or
# B. 'Visibility is above 40'

# In[17]:


#Find all the unique 'Wind Speed' values in the data.
df["Wind Speed_km/h"].unique()


# In[18]:


df["Wind Speed_km/h"].nunique()


# In[14]:


df.head()


# In[29]:


#Find the number of times when the 'Weather is exactly Clear'.
df.Weather.value_counts()


# In[30]:


df[df.Weather == "Clear"]


# In[32]:


#groupby 
df.groupby("Weather").get_group("Clear")


# In[40]:


#Find the number of times when the 'Wind Speed was exactly 4 km/h'.
df[df["Wind Speed_km/h"] == 4]


# In[43]:


# Find out all the Null Values in the data.
df.isnull().sum()


# In[46]:


#Rename the column name 'Weather' of the dataframe to 'Weather Condition'.
df.rename(columns = {"Weather" : "Weather Condition"}, inplace = True)


# In[47]:


df.head(2)


# In[48]:


#hat is the mean 'Visibility' 
df.Visibility_km.mean()


# In[49]:


#what is the Standard Deviation of 'Pressure'  in this data?
df.Press_kPa.std()


# In[52]:


#What is the Variance of 'Relative Humidity' in this data ?
df["Rel Hum_%"].var()


# In[54]:


#Find all instances when 'Snow' was recorded.
df[df["Weather Condition"] == "Snow"]


# In[57]:


df[df["Weather Condition"].str.contains("Snow")]


# In[60]:


#Find all instances when 'Wind Speed is above 24' and 'Visibility is 25'.
df[(df["Wind Speed_km/h"] >24) & (df["Visibility_km"] == 25.0)]


# In[62]:


#What is the Mean value of each column against each 'Weather Condition ?
df.groupby("Weather Condition").mean()


# In[63]:


#What is the Minimum & Maximum value of each column against each 'Weather Condition ?
df.groupby("Weather Condition").max()


# In[64]:


df.groupby("Weather Condition").min()


# In[66]:


#Show all the Records where Weather Condition is Fog.
df[df["Weather Condition"] == "Fog"]


# In[68]:


#Find all instances when 'Weather is Clear' or 'Visibility is above 40'.
df[(df["Weather Condition"]== "Clear") | (df["Visibility_km"] >40)]


# Find all instances when :
# A. 'Weather is Clear' and 'Relative Humidity is greater than 50'
# or
# B. 'Visibility is above 40'

# In[69]:


df[((df["Weather Condition"] =="Clear") & (df["Rel Hum_%"] >50)) | (df["Visibility_km"] >40)]


# In[ ]:




