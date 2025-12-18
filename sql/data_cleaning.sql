
# DATA CLEANING

/* 
DEFINING THE CLEANING RULE:
    1. PASSENGER COUNT BETWEEN 1 AND 8
    2. TRIP DISTANCE > 0
    3. FARE AMOUNT > 0
    4. DROPOFF DATETIME > PICKUP DATETIME
    5. TRIP DURATION BETWEEN 1 AND 400 MINUTES
    
*/



# CREATE CLEAN VIEW


CREATE OR REPLACE VIEW `sqlprojectsda.transportation.NYC_trips` AS 

SELECT 
    pickup_datetime,
    dropoff_datetime,
    DATE(pickup_datetime) AS pickup_date,
    EXTRACT(HOUR FROM pickup_datetime) AS pickup_hour,
    DATE(dropoff_datetime) AS dropoff_date,
    EXTRACT(HOUR FROM dropoff_datetime) AS dropoff_hour,
    passenger_count,
    trip_distance, 
    pickup_location_id, 
    dropoff_location_id, 
    fare_amount, 
    tip_amount, 
    total_amount,
    TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, MINUTE) AS trip_duration
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2016`
WHERE
  passenger_count BETWEEN 1 AND 8
  AND trip_distance > 0
  AND fare_amount > 0
  AND dropoff_datetime > pickup_datetime
  AND TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, MINUTE) BETWEEN 1 AND 400 
;

SELECT *
FROM `sqlprojectsda.transportation.NYC_trips`
LIMIT 1000
;



# VALIDATING CLEANING IMPACT

# EXPECTING A SIGNIFICANT REDUCTION IN ROWS

SELECT 
    (SELECT COUNT(*) FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2016`) AS raw_rows,
    (SELECT COUNT(*) FROM `sqlprojectsda.transportation.NYC_trips`) AS clean_rows
    ;



# SANITY CHECKS ON THE CLEAN DATA

# PASSENGER COUNT DISTRIBUTION

SELECT passenger_count, COUNT(*) AS trips
FROM `sqlprojectsda.transportation.NYC_trips`
GROUP BY passenger_count
ORDER BY passenger_count
;

# TRIP DURATION RANGE

SELECT MAX(trip_duration) AS max_trip, 
        MIN(trip_duration) AS min_trip 
FROM `sqlprojectsda.transportation.NYC_trips`
;



