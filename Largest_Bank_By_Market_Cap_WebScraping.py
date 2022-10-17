#!/usr/bin/env python
# coding: utf-8

# # WebScrapping; Data Engineering project

# # Objectives: 
#     Use webscraping to get bank information

# For this project am using python and other Python libraries.

# In[1]:


#!pip install pandas
get_ipython().system('pip install bs4')
get_ipython().system('pip install lxml')
get_ipython().system('pip install html5lib')
#!pip install requests


# # Import
# 
# Importing necessary libraries

# In[2]:


from bs4 import BeautifulSoup
import requests
import pandas as pd


# # Extract Data Using Web Scraping

# The wikipedia https://en.wikipedia.org/wiki/List_of_largest_banks provides information about the largest banks in the world by various parameters. Scrape the data from the table 'By market capitalization' and store it in a JSON file.

# # Webpage Contents

# Gather the contents of the webpage in text format using requests library and assign it to the variable html_data

# In[3]:


data = requests.get("https://en.wikipedia.org/wiki/List_of_largest_banks")
html_data = data.content


# In[4]:


html_data[101:124]


# # Scrapping the Data
# 
# Using beautifulsoup and html_data to load the data by market_capitalization table into a pandas dataframe. The dataframe will have the country Name and Market Cap (US$ Billion) as the column names.

# In[5]:


soup = BeautifulSoup(html_data, "html5lib")


# I will load the data from the By Market Capitalization table into a pandas dataframe. The dataframe will have Country Name and Market Cap(US$ Billion) as column names. I will use an empty dataframe data and the a loop extract the necessary data from each row and append it to the empty dataframe.

# In[6]:


data_frame = pd.DataFrame(columns=['Name','Market Cap (US$ Billion)'])

for row in soup.find_all('tbody')[3].find_all('tr'):
    col =row.find_all('td')
    if col:
        bank_name = col[1].find_all('a')[1].text
        market_cap = (col[2].text)
        data_frame = data_frame.append({"Name": bank_name,
                                       "Market Cap (US$ Billion)":market_cap},
                                      ignore_index= True)


# In[9]:


data_frame.tail()


# In[ ]:


#400.37[6]\n i have to figure out how to clean this part


# In[10]:


#This one of the method to clean the data from here
data_frame['Market Cap (US$ Billion)'].str.split('\n',expand = True)

