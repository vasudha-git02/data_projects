
 CREATE VIEW hourly_ride_distribution AS
 SELECT
    EXTRACT(HOUR FROM start_time) AS ride_hour,
    COUNT(*) AS ride_count
FROM bike_rides
where date = '2016-01-01'
GROUP BY ride_hour
ORDER BY ride_hour
;

CREATE VIEW gender_subscription_breakdown AS
SELECT
    gender,
    user_type,
    COUNT(*) AS ride_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percent_of_total
FROM bike_rides
GROUP BY gender, user_type
ORDER BY ride_count DESC;


CREATE VIEW gender_distribution AS
SELECT
    gender,
    COUNT(*) AS ride_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percent_of_total
FROM bike_rides
GROUP BY gender
ORDER BY ride_count DESC;

CREATE VIEW subscription_distribution AS
SELECT
    user_type,
    COUNT(*) AS ride_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percent_of_total
FROM bike_rides
GROUP BY user_type
ORDER BY ride_count DESC;


CREATE VIEW top_start_stations AS
SELECT
    s.station_id,
    s.station_name,
    COUNT(*) AS ride_count
FROM bike_rides br
JOIN stations s
  ON br.start_station_id = s.station_id
GROUP BY s.station_id, s.station_name
ORDER BY ride_count DESC
LIMIT 20;

CREATE VIEW top_end_stations AS
SELECT
    s.station_id,
    s.station_name,
    COUNT(*) AS ride_count
FROM bike_rides br
JOIN stations s
  ON br.end_station_id = s.station_id
GROUP BY s.station_id, s.station_name
ORDER BY ride_count DESC
LIMIT 20;

CREATE VIEW station_net_flow AS
SELECT
    s.station_id,
    s.station_name,
    COALESCE(start_counts.start_count, 0) AS rides_started,
    COALESCE(end_counts.end_count, 0) AS rides_ended,
    COALESCE(start_counts.start_count, 0) - COALESCE(end_counts.end_count, 0) AS net_flow
FROM stations s
LEFT JOIN (
    SELECT start_station_id, COUNT(*) AS start_count
    FROM bike_rides
    GROUP BY start_station_id
) start_counts
  ON s.station_id = start_counts.start_station_id
LEFT JOIN (
    SELECT end_station_id, COUNT(*) AS end_count
    FROM bike_rides
    GROUP BY end_station_id
) end_counts
  ON s.station_id = end_counts.end_station_id
ORDER BY net_flow DESC;

CREATE VIEW daily_rides_weather AS
SELECT
    br.date,
    COUNT(*) AS total_rides,
    wd.tavg,
    wd.tmin,
    wd.tmax,
    wd.prcp,
    wd.snow
FROM bike_rides br
JOIN weather_daily wd
  ON br.date = wd.date
GROUP BY br.date, wd.tavg, wd.tmin, wd.tmax, wd.prcp, wd.snow
ORDER BY br.date;

CREATE VIEW rides_by_temp_range AS
SELECT
  CASE
    WHEN tavg IS NULL THEN 'Unknown'
    WHEN tavg >= 75 THEN 'Hot'
    WHEN tavg BETWEEN 50 AND 74 THEN 'Warm'
    ELSE 'Cold'
  END AS temp_category,
  COUNT(*) AS total_rides
FROM bike_rides br
JOIN weather_daily wd
  ON br.date = wd.date
GROUP BY temp_category
ORDER BY total_rides DESC;


CREATE VIEW avg_duration_by_temp AS
SELECT
  wd.tavg,
  AVG(br.trip_duration_hrs) AS avg_trip_duration_hrs,
  COUNT(*) AS ride_count
FROM bike_rides br
JOIN weather_daily wd
  ON br.date = wd.date
GROUP BY wd.tavg
ORDER BY wd.tavg;

CREATE VIEW avg_rides_by_precipitation AS
SELECT
  CASE
    WHEN prcp = 0 THEN 'No Rain'
    WHEN prcp < 0.1 THEN 'Light Rain'
    ELSE 'Rainy'
  END AS rain_category,
  CASE
    WHEN snow = 0 THEN 'No Snow'
    WHEN snow < 0.1 THEN 'Light Snow'
    ELSE 'Snowy'
  END AS snow_category,
  COUNT(*) AS total_rides
FROM bike_rides br
JOIN weather_daily wd
  ON br.date = wd.date
GROUP BY rain_category, snow_category
ORDER BY total_rides DESC;

CREATE VIEW rider_age_groups AS
SELECT
  CASE
    WHEN birth_year IS NULL THEN 'Unknown'
    WHEN 2024 - birth_year < 20 THEN '<20'
    WHEN 2024 - birth_year BETWEEN 20 AND 29 THEN '20s'
    WHEN 2024 - birth_year BETWEEN 30 AND 39 THEN '30s'
    WHEN 2024 - birth_year BETWEEN 40 AND 49 THEN '40s'
    ELSE '50+'
  END AS age_group,
  COUNT(*) AS ride_count,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percent_of_total
FROM bike_rides
GROUP BY age_group
ORDER BY ride_count DESC;

CREATE VIEW monthly_rides_summary AS
SELECT
  TO_CHAR(start_time, 'Month') AS month_name,
  EXTRACT(MONTH FROM start_time) AS month_number,
  COUNT(*) AS ride_count
FROM bike_rides
GROUP BY month_name, month_number
ORDER BY month_number;

CREATE VIEW seasonal_rides_summary AS
SELECT
  CASE
    WHEN EXTRACT(MONTH FROM start_time) IN (12, 1, 2) THEN 'Winter'
    WHEN EXTRACT(MONTH FROM start_time) IN (3, 4, 5) THEN 'Spring'
    WHEN EXTRACT(MONTH FROM start_time) IN (6, 7, 8) THEN 'Summer'
    ELSE 'Fall'
  END AS season,
  COUNT(*) AS ride_count
FROM bike_rides
GROUP BY season
ORDER BY ride_count DESC;
