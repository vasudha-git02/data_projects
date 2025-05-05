#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import os
from glob import glob
from datetime import datetime as dt


# In[2]:


os.getcwd()


# In[3]:


csv_files = glob("data/data/*tripdata.csv")


# In[4]:


print(csv_files)


# In[5]:


df_list = []
for csv in csv_files:
    i = pd.read_csv(csv)
    df_list.append(i)
df = pd.concat(df_list,ignore_index = True)


# In[6]:


df.head(-5)


# In[7]:


df.isnull().sum()


# In[8]:


df["User Type"] = df["User Type"].fillna("Unknown")


# In[9]:


df.isnull().sum()


# In[10]:


print(df["Birth Year"].min(),df["Birth Year"].max())


# In[11]:


df["Birth Year"] = df["Birth Year"].fillna(df["Birth Year"].median())


# In[12]:


df.isnull().sum()


# In[13]:


df["Birth Year"] = df["Birth Year"].astype(int)


# In[14]:


df.head()


# In[15]:


df["Gender"] = df["Gender"].replace({0: "Unknown",1:"Male",2:"Female"})


# In[16]:


df.head()


# In[17]:


df.duplicated().sum()


# In[18]:


df["Trip Duration (hrs)"] = round(df["Trip Duration"]/3600,4)


# In[19]:


df.head()


# In[20]:


df.dtypes


# In[21]:


df["Start Time"] = pd.to_datetime(df["Start Time"])


# In[22]:


df["Stop Time"] = pd.to_datetime(df["Stop Time"])


# In[23]:


df.dtypes


# In[24]:


df["Start Station Name"] = df["Start Station Name"].astype(str)


# In[25]:


df["End Station Name"] = df["End Station Name"].astype(str)
df["User Type"] = df["User Type"].astype(str)
df["Gender"] = df["Gender"].astype(str)


# In[26]:


df.columns = df.columns.str.strip().str.lower().str.replace(" ","_")


# In[27]:


df.head()


# In[28]:


weather_df = pd.read_csv("data/data/newark_airport_2016.csv")
weather_df.head()


# In[29]:


weather_df.isnull().sum()


# In[30]:


weather_df.info


# In[31]:


weather_df.drop(columns = ["PGTM","TSUN"],inplace=True)


# In[32]:


weather_df.head()


# In[33]:


weather_df.dtypes


# In[34]:


weather_df["STATION"] = weather_df["STATION"].astype(str)
weather_df["NAME"] = weather_df["NAME"].astype(str)


# In[35]:


weather_df["DATE"] = pd.to_datetime(weather_df["DATE"])


# In[36]:


weather_df.dtypes


# In[37]:


weather_df.columns = weather_df.columns.str.strip().str.lower()


# In[38]:


weather_df.head()


# In[39]:


weather_df.isnull().sum()


# In[40]:


weather_df["wdf5"] = weather_df["wdf5"].fillna(0)
weather_df["wsf5"] = weather_df["wsf5"].fillna(0)


# In[41]:


weather_units = {
    "tavg": "Average Temp (°F)",
    "tmin": "Min Temp (°F)",
    "tmax": "Max Temp (°F)",
    "prcp": "Precipitation (inches)",
    "snow": "Snowfall (inches)",
    "snwd": "Snow Depth (inches)",
    "awnd": "Average Wind Speed (m/s)",
    "wsf2": "Fastest 2-minute Wind (m/s)",
    "wsf5": "Fastest 5-second Wind (m/s)",
    "wdf2": "Wind Direction 2-min (degrees)",
    "wdf5": "Wind Direction 5-sec (degrees)"
}


# In[42]:


df.columns


# In[43]:


weather_df.columns


# In[44]:


df.head()


# In[45]:


weather_df.head()


# In[47]:


from sqlalchemy import create_engine
from dotenv import load_dotenv


# In[54]:


load_dotenv()
user = os.getenv("DB_USER")
password = os.getenv("DB_PASS")
dbname = os.getenv("DB_NAME")
host = os.getenv("DB_HOST")
port = os.getenv("DB_PORT")

engine = create_engine(f"postgresql+psycopg2://{user}:{password}@{host}:{port}/{dbname}")


# In[55]:


print("Port:", port)  # Should print 5432


# In[56]:


os.getcwd()


# In[57]:


print("User:", os.getenv("DB_USER")) 


# In[58]:


start_stations = df[['start_station_id',
       'start_station_name', 'start_station_latitude',
       'start_station_longitude',]]
start_stations.columns = ["station_id","station_name","latitude","longitude"]

end_stations = df[['end_station_id', 'end_station_name',
       'end_station_latitude', 'end_station_longitude']]
end_stations.columns = ["station_id","station_name","latitude","longitude"]
stations_df = pd.concat([start_stations,end_stations]).drop_duplicates(subset="station_id").reset_index(drop=True)


# In[59]:


stations_df.head()


# In[60]:


stations_df.shape


# In[61]:


df.head()


# In[62]:


stations_df.to_sql("stations",engine,if_exists="append",index=False)
print("Stations table loaded")


# In[64]:


weather_clean = weather_df[["date","awnd","prcp","snow","snwd","tavg","tmax","tmin","wdf2","wdf5","wsf2","wsf5"]]


# In[65]:


weather_clean.head()


# In[67]:


weather_clean.to_sql("weather_daily",engine,if_exists="append",index=False)
print("weather data loaded")


# In[70]:


df_clean = df[['start_time', 'stop_time', 'start_station_id',
        'end_station_id',  'bike_id', 'user_type',
       'birth_year', 'gender','trip_duration','trip_duration_(hrs)']]
df_clean.columns=['start_time', 'stop_time', 'start_station_id',
        'end_station_id',  'bike_id', 'user_type',
       'birth_year', 'gender','trip_duration','trip_duration_hrs']
df_clean["date"] = df_clean["start_time"].dt.date
df_clean.head()


# In[71]:


df_clean.to_sql("bike_rides",engine,if_exists="append",index=False)
print("bike ride table loaded")


# In[ ]:




