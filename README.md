# Citi Bike PostgreSQL ETL Project

This project explores Citi Bike trip data combined with Newark airport weather data. It uses PostgreSQL views to answer business and operational questions about user behavior, station demand, and weather-based usage trends. A Power BI dashboard visualizes the key insights.

---

## Database Schema Overview

### Tables
- **bike_rides**: Cleaned ride data
- **stations**: Unique station details
- **weather_daily**: Daily weather metrics

### ER Diagram
Stored in `/images/er_diagram.png` (generated via dbdiagram.io)

---

## SQL Views for Analysis

### Rides Per Hour
**View:** `hourly_ride_distribution`  
- Shows total rides per hour (0–23)  
- Helps identify peak usage times

### Gender and Subscription Analysis
**View:** `gender_subscription_breakdown`  
- Shows how ride counts vary by gender and user type

**View:** `gender_distribution` & `subscription_distribution`  
- Separate views showing percentages of total rides by gender and by subscription type

### Station-Based Trends
**View:** `top_start_stations`  
- Top 20 stations where most rides start

**View:** `top_end_stations`  
- Top 20 drop-off stations

**View:** `station_net_flow`  
- Net flow of rides (start - end) per station to identify imbalances

### Weather-Based Insights
**View:** `daily_rides_weather`  
- Merges ride count with daily weather data

**View:** `rides_by_temp_range`  
- Categorizes days into Hot, Moderate, or Cold and counts rides

**View:** `avg_duration_by_temp`  
- Shows average trip duration for each average daily temperature

**View:** `avg_rides_by_precipitation`  
- Groups rides by rain/snow levels

### Age-Based Usage
**View:** `rider_age_groups`  
- Groups users by age bracket (<20, 20s, 30s, 40s, 50+)  
- Includes ride count and percent of total

### Seasonal Trends
**View:** `monthly_rides_summary`  
- Total rides by month, useful for trend charts

**View:** `seasonal_rides_summary`  
- Categorizes rides into Spring, Summer, Fall, Winter

---

## Power BI Dashboard

A Power BI dashboard was created to visualize:
- Hourly ride distribution  
- Gender & subscription usage  
- Temperature-based trends with 7-day rolling averages  
- Monthly ride trends  
- Station popularity  

All visuals are saved in `/images/`.

The `.pbix` file is stored in the `/images/` folder for reference.

---

## How It Was Built

- Python (Pandas, SQLAlchemy, dotenv)
- PostgreSQL 15
- Data transformation using Jupyter Notebook
- Power BI for dashboarding
- `.env` used for secure DB connection (excluded from repo)
- ER diagram via [dbdiagram.io](https://dbdiagram.io)

---

## Folder Structure
/data_projects/
├── citi-bike-etl-postgresql/
│ ├── data/
│ ├── images/
│ │ ├── er_diagram.png
│ │ └── dashboard.pbix
│ ├── notebooks/
│ ├── sql_views/
│ ├── etl.py
│ ├── .env.example
│ └── README.md

---

## Notes

- The `.env` file is not tracked in version control.
- The project is currently in a stable state. Additional enhancements (e.g., advanced visuals, data refresh automation) can be added in future iterations.

---

Feel free to fork, explore, and adapt this project for your own analysis.
