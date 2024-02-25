-- create new database
CREATE DATABASE city_cycling;

-- creating a table for the 12 datasets
CREATE TABLE cycling_data (
	ride_id	varchar(50),
	rideable_type varchar(20),
	started_at timestamp,
	ended_at timestamp,
	start_station_name varchar(100),
	start_station_id varchar(50),
	end_station_name varchar(100),
	end_station_id	varchar(50),
	start_lat numeric,	
	start_lng numeric,
	end_lat	numeric,
	end_lng numeric,	
	ride_plan varchar(50)
);

--After uploading the 12 datasets to the new table, next is data cleaining

-- DATA CLEANING
-- checking for duplicate
SELECT distinct ride_id
FROM cycling_data;

SELECT ride_id, count(*)
FROM public.cycling_data
GROUP BY ride_id
HAVING count(*) > 1;
--no duplicate data 

-- check for nulls 
SELECT *
FROM cycling_data
WHERE started_at IS NULL
	OR ended_at IS NULL;
	
SELECT *
FROM cycling_data
WHERE ride_id IS NULL
	OR rideable_type IS NULL 
	OR started_at IS NULL
	OR ended_at IS NULL
	OR start_station_name IS NULL
	OR end_station_name IS NULL
	OR start_station_id IS NULL
	OR end_station_id IS NULL
	OR start_lat IS NULL
	OR start_lng IS NULL
	OR end_lat IS NULL
	OR end_lng IS NULL
	OR ride_plan IS NULL;
	
-- removing records with null data
DELETE FROM cycling_data
WHERE start_station_name IS NULL
	OR end_station_name IS NULL
	OR start_station_id IS NULL
	OR end_station_id IS NULL 
	OR end_lat IS NULL 
	OR end_lng IS NULL;
	
-- checking for errors in user and bike types
SELECT distinct rideable_type
FROM cycling_data;

SELECT distinct ride_plan, COUNT(*)
FROM cycling_data
GROUP BY ride_plan;


-- DATA WRANGLING & EXPLORATION
-- Feature engineering
-- Creating new columns
ALTER TABLE cycling_data ADD COLUMN ride_length interval;

UPDATE cycling_data 
SET ride_length = EXTRACT(EPOCH FROM (ended_at - started_at)) * interval '60 second';

-- creating new column for ride length in minutes
ALTER TABLE cycling_data ADD COLUMN ride_length_min NUMERIC;

UPDATE cycling_data
SET ride_length_min = EXTRACT(EPOCH FROM ride_length)/60;

UPDATE cycling_data
SET ride_length_min = ROUND(ride_length_min, 2);


SELECT ride_id, ride_length, ride_length_min
FROM cycling_data
ORDER BY 2 DESC
LIMIT 200;

-- creating column for month
ALTER TABLE cycling_data ADD COLUMN date_month text;

UPDATE cycling_data 
SET date_month = TO_CHAR(started_at, 'Month');

-- creating column for Day of week
ALTER TABLE cycling_data ADD COLUMN day_of_week text;

UPDATE cycling_data 
SET day_of_week = TO_CHAR(started_at, 'Day');


-- creating column for ride start time in hours
ALTER TABLE cycling_data ADD COLUMN time_hour int;

UPDATE cycling_data 
SET time_hour = EXTRACT(HOUR FROM started_at);

SELECT date_month, day_of_week, time_hour
FROM cycling_data;

--Data summary
SELECT ride_plan,
		min(ride_length),
		avg(ride_length),
		max(ride_length)
FROM cycling_data
GROUP BY ride_plan;

--Negative ride_lenth interval observed, checking ride_length data for inconsistencies
SELECT ride_id, ride_length
FROM cycling_data
ORDER BY 2 
LIMIT 200;

--Remove negative ride_length and records with less than 1 minute
DELETE FROM cycling_data
WHERE ride_length < INTERVAL '1 minute';


-- EXPLORATORY ANALYSIS
-- number of rides per ride plan
SELECT ride_plan, COUNT(ride_id)
FROM cycling_data
GROUP BY 1;

-- Average ride length by ride plan
SELECT ride_plan, ROUND(AVG(ride_length_min), 2) Avg_ride_len
FROM cycling_data
GROUP BY 1;

--checking bike types by ride plan
SELECT ride_plan, rideable_type, COUNT(*) rides
FROM cycling_data
GROUP BY 1, 2;

-- no of rides per month
SELECT ride_plan, date_month, COUNT(*) rides
FROM cycling_data
GROUP BY 1, 2
ORDER BY 3 DESC;

-- number of rides and average ride length per users by day of week
SELECT ride_plan, day_of_week, COUNT(*) rides, AVG(ride_length)
FROM cycling_data
GROUP BY 1, 2
ORDER BY 3, 4 DESC;

-- no of rides per time of the day
SELECT ride_plan, time_hour, COUNT(*) rides
FROM cycling_data
GROUP BY 1, 2
ORDER by 3 DESC;

-- most rides per start station
SELECT start_station_name, ride_plan, COUNT(*) start_station_rides
FROM cycling_data
WHERE ride_plan = 'casual'
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 20

SELECT end_station_name, ride_plan, COUNT(*) end_rides
FROM cycling_data 
WHERE ride_plan = 'casual'
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 20;


SELECT start_station_name, ride_plan, COUNT(*) start_station_rides
FROM cycling_data
WHERE ride_plan = 'member'
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 20;


SELECT start_station_name, ride_plan, COUNT(*) start_station_rides
FROM cycling_data
WHERE ride_plan = 'member'
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 20;
