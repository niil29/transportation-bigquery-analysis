#  DATA ANALYSIS & BUSINESS INSIGHTS
# TRIP DEMAND TRENDS

SELECT pickup_date, COUNT(*) AS total_trips
FROM `sqlprojectsda.transportation.NYC_trips`
GROUP BY pickup_date
ORDER BY pickup_date DESC
;


# MONTHLY TRENDS (DEMAND + REVENUE)

SELECT EXTRACT(MONTH FROM pickup_date) AS month,
  COUNT(*) AS total_trips, ROUND(SUM(total_amount),2) AS revenue,
  ROUND(SUM(total_amount),2)/COUNT(*) AS rev_trip
FROM `sqlprojectsda.transportation.NYC_trips`
GROUP BY month
ORDER BY month
;


# PEAK HOURS ANALYSIS

SELECT pickup_hour, COUNT(*) AS total_trips, ROUND(SUM(total_amount),2) AS revenue
FROM `sqlprojectsda.transportation.NYC_trips`
GROUP BY pickup_hour
ORDER BY pickup_hour 
;


# TOP PICKUP LOCATIONS

SELECT pickup_location_id, COUNT(*) AS total_trips, ROUND(SUM(total_amount),2) AS revenue
FROM `sqlprojectsda.transportation.NYC_trips`
GROUP BY pickup_location_id
ORDER BY total_trips DESC
;


# TOP ROUTES

SELECT pickup_location_id, dropoff_location_id, COUNT(*) AS total_trips
FROM `sqlprojectsda.transportation.NYC_trips`
GROUP BY pickup_location_id, dropoff_location_id
ORDER BY 3 DESC
LIMIT 10
;


# AVERAGE TRIP MATRICS

SELECT ROUND(AVG(trip_distance),2) AS avg_trip_distance,
        ROUND(AVG(trip_duration),2) AS avg_trip_duration,
        ROUND(AVG(total_amount),2) AS avg_trip_amount
FROM `sqlprojectsda.transportation.NYC_trips`
;


# TOP 3 PICKUP LOCATIONS PER DAY

WITH daily_pickups AS (
  SELECT pickup_date, pickup_location_id, COUNT(*) AS trips
  FROM `sqlprojectsda.transportation.NYC_trips`
  GROUP BY 1,2
  ORDER BY 1
),
rank_pickups AS (
  SELECT *, RANK() OVER (PARTITION BY pickup_date ORDER BY daily_pickups.trips DESC) AS ranks
  FROM daily_pickups
)

SELECT *
FROM rank_pickups
WHERE ranks <= 3
ORDER BY 1


# DIMENSION TABLES, READABILITY & PROJECT POLISH
# CREATE LOCATION DIMENSION VIEW

SELECT locationID, Borough, zone
FROM `sqlprojectsda.transportation.dim_location`
LIMIT 50
;


# TOP PICK LOCATION (TOP 10)

SELECT l.Borough, l.Zone, COUNT(*) AS total_trips
FROM `sqlprojectsda.transportation.NYC_trips` t
  LEFT JOIN `sqlprojectsda.transportation.dim_location` l
  ON CAST(t.pickup_location_id AS STRING) = CAST(l.LocationID AS STRING) -- CAST IS USED TO CONVERT BOTH COLUMNS TO STRING
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 10
;


# TOP ROUTES

SELECT pl.Borough, dl.Borough, COUNT(*) AS total_trips 
FROM `sqlprojectsda.transportation.NYC_trips` t
  LEFT JOIN `sqlprojectsda.transportation.dim_location` pl
  ON CAST(t.pickup_location_id AS STRING) = CAST(pl.LocationID AS STRING) -- CAST IS USED TO CONVERT BOTH COLUMNS TO STRING
  LEFT JOIN `sqlprojectsda.transportation.dim_location` dl
  ON CAST(t.dropoff_location_id AS STRING) = CAST(dl.LocationID AS STRING) -- CAST IS USED TO CONVERT BOTH COLUMNS TO STRING
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 10
;


# PEAK HOURS AND REVENUE 

SELECT pickup_hour, 
        COUNT(*) total_trips, 
        ROUND(SUM(total_amount),2) AS total_rev,
        ROUND(AVG(total_amount),2) AS avg_rev
FROM `sqlprojectsda.transportation.NYC_trips`
GROUP BY 1
ORDER BY 1
;


# WEEKDAYS VS WEEKENDS

SELECT 
    CASE 
    WHEN EXTRACT(DAYOFWEEK FROM pickup_date) IN (1,7) THEN "Weekends"
    ELSE "Weekdays"
    END AS day_type,
    COUNT(*) AS total_trips,
    ROUND(SUM(total_amount),2) AS total_rev
FROM `sqlprojectsda.transportation.NYC_trips`
GROUP BY 1




