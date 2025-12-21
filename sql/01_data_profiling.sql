# DATA EXPLORATION & UNDERSTANDING

# PREVIEW DATASET

SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2016` LIMIT 1000
;

# ROW COUNT

SELECT COUNT(*) AS total_rows
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2016`
;

# CHECK DATE RANGE

SELECT MIN(pickup_datetime) AS min_date, MAX(pickup_datetime) AS max_date
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2016`
;



# DATA QUALITY CHECKS

# INVALID PASSENGERS COUNT

SELECT passenger_count, COUNT(*) AS trips
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2016`
GROUP BY passenger_count
ORDER BY passenger_count
;

# INVALID TRIP DISTANCE

SELECT COUNT(*) AS invalid_trip_distance
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2016`
WHERE trip_distance <= 0
;

# INVALID FARE AMOUNT 

SELECT COUNT(*) AS invalid_fare_amount
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2016`
WHERE fare_amount <= 0


# TRIP DURATION CALCULATION 

SELECT MIN(TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, MINUTE)) AS min_duration,
        MAX(TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, MINUTE)) AS max_duration
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2016`
;
