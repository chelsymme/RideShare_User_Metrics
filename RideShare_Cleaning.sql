-- turning monthly tables into single year table, did not include station id's 
select 
    ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
  FROM
    `cyclistic-case-study-373019.cyclistic_tripdata.202112DEC`
  union all
    select
      ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
    FROM
    `cyclistic-case-study-373019.cyclistic_tripdata.202201JAN`
  union all
    select
      ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
    FROM
    `cyclistic-case-study-373019.cyclistic_tripdata.202202FEB`
  union all
    select
      ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
    FROM
    `cyclistic-case-study-373019.cyclistic_tripdata.202203MAR`
  union all
    select
      ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
    FROM
    `cyclistic-case-study-373019.cyclistic_tripdata.202204APR`
  union all
    select
      ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
    FROM
    `cyclistic-case-study-373019.cyclistic_tripdata.202205MAY`
  union all
    select
      ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
    FROM
    `cyclistic-case-study-373019.cyclistic_tripdata.202206JUN`
  union all
    select
      ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
    FROM
    `cyclistic-case-study-373019.cyclistic_tripdata.202207JUL`
  union all
    select
      ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
    FROM
    `cyclistic-case-study-373019.cyclistic_tripdata.202208AUG`
  union all
    select
      ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
    FROM
    `cyclistic-case-study-373019.cyclistic_tripdata.202209SEP`
  union all
    select
      ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
    FROM
    `cyclistic-case-study-373019.cyclistic_tripdata.202210OCT`
  union all
    select
      ride_id, rideable_type, started_at, ended_at, start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
    FROM
    `cyclistic-case-study-373019.cyclistic_tripdata.202211NOV`
  order by started_at;
-- Removed NUll values for stations, could not find reliable data on of lat/lng, saved new table "1_FullYear_DEC21-NOV22_Clean"

SELECT * FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22` 
  WHERE start_station_name is NOT null
    AND end_station_name is NOT null;

-- Created new colomn "rack_type" to pull public tag out of station name

alter table `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
  Add column start_rack_type string,
  Add column end_rack_type string;

-- Renamed rack column

alter table `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
  Rename column rack_type TO start_rack_type;

-- Moved public rack tag to new column

UPDATE
    `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
  SET
    start_rack_type = "Public"
  WHERE
    start_station_name LIKE 'Pub%';

UPDATE
    `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
  SET
    end_rack_type = "Public"
  WHERE
    end_station_name LIKE 'Pub%';

-- Removed public rack tag from station name

UPDATE 
    `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
  SET 
    start_station_name = substring(start_station_name, 15)
  WHERE
    start_station_name LIKE 'Public Rack%';

UPDATE 
    `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
  SET 
    end_station_name = substring(end_station_name, 15)
  WHERE
    end_station_name LIKE 'Public Rack%';

-- Checked consitancy and trimming extra spaces from string columns

SELECT 
  COUNT(DISTINCT start_station_name)
  FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
  --1339--

SELECT 
  COUNT(DISTINCT start_station_name)
  FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
  --1356--

UPDATE
    `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
  SET 
    start_station_name = TRIM(start_station_name)
  WHERE
    start_station_name LIKE '%';

UPDATE
    `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
  SET 
    end_station_name = TRIM(end_station_name)
  WHERE
    end_station_name LIKE '%';

-- Look for spelling errors then capitalized first letter member/causal for consistency 

SELECT 
  DISTINCT  member_casual
  FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
   --2--

UPDATE 
    `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
  SET 
    member_casual = "Casual"
  WHERE 
    member_casual = "casual"

UPDATE 
    `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
  SET 
    member_casual = "Member"
  WHERE 
    member_casual = "Member"

-- Verified ride types and checked for consistancy

SELECT 
  DISTINCT  rideable_type
  FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
  --3--
