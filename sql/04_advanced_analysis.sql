# PERFORMANCE & PRODUCTION THINKING

# TRIP PERFORMANCE & SPEED ANALYSIS

SELECT pickup_hour, ROUND(AVG(trip_distance/(trip_duration/60.0)),2) AS avg_speed_mph
FROM `sqlprojectsda.transportation.NYC_trips`
WHERE trip_duration > 0
GROUP BY 1
ORDER BY 1
;


# CONGESTION DETECTION

SELECT pickup_hour, 
        COUNT(*) AS total_trips,
        ROUND(AVG(trip_duration),2) AS avg_trip_duration,
        ROUND(AVG(trip_distance),2) AS avg_trip_distance
FROM `sqlprojectsda.transportation.NYC_trips`
GROUP BY 1
ORDER BY 1
;


# HIGH-VALUE ROUTES (REVENUE FOCUS)

SELECT pl.Zone AS pickup_zone,
        dl.Zone AS dropoff_zone,
        COUNT(*) AS total_trips,
        ROUND(SUM(total_amount),2) AS total_revenue
FROM `sqlprojectsda.transportation.NYC_trips` t
LEFT JOIN `sqlprojectsda.transportation.dim_location` pl
  ON CAST(t.pickup_location_id AS STRING)  = CAST(pl.LocationID AS STRING)
LEFT JOIN `sqlprojectsda.transportation.dim_location` dl
  ON CAST(t.pickup_location_id AS STRING) = CAST(dl.LocationID AS STRING)
GROUP BY 1,2
HAVING total_trips > 1000
ORDER BY 4 DESC
LIMIT 10
;


# ROLLING TREND

WITH daily_trips AS (
  SELECT pickup_date, COUNT(*) AS total_trips
  FROM `sqlprojectsda.transportation.NYC_trips` 
  GROUP BY 1
)
SELECT pickup_date, daily_trips.total_trips, ROUND(AVG(daily_trips.total_trips) OVER (ORDER BY pickup_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2) AS rolling_7_day_avg
FROM daily_trips
ORDER BY 1
;


# SEGMENTATION: LONG & SHORT TRIPS

SELECT CASE WHEN trip_duration < 2 THEN "Short trip"
            WHEN trip_duration BETWEEN 2 AND 6 THEN "Medium Trip"
            ELSE "Long Trip"
        END AS trip_type,
        COUNT(*) AS total_trips
FROM `sqlprojectsda.transportation.NYC_trips`
GROUP BY 1
ORDER BY 2 DESC
;




