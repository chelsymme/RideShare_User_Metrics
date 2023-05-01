-- Questions for trends members VS casual riders
  -- Who rides more?
  -- Who rides when? month, day of the week, time of day
  -- Who rides what and when?
  -- Who rides longer and from what stations?
  -- Whats the most popular startions, by user, by ride type, and by location?

  -- WHO RIDES MORE

  SELECT  
  COUNT(ride_id) as number_of_users
  FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
  -- total rides 4,410,328

  SELECT
    member_casual as user_type,
    COUNT(ride_id) as number_of_users,
    ROUND(COUNT(ride_id) / (SELECT COUNT(*) FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`) * 100, 0) as percentage
FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
GROUP BY member_casual
    -- Casual 1,771,760 40%
    -- Member 2,638,568 60%

  
    
  -- WHO RIDES WHEN
  
  SELECT  
    member_casual as user_type,
    EXTRACT (month from started_at) as month,
    COUNT(ride_id) as number_of_users
    FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
    GROUP BY user_type, month
    ORDER BY month 
    -- Member Aug 335,230 rides
    -- Casual July 311,678 rides

SELECT  
  CASE
    WHEN EXTRACT(MONTH FROM started_at) = 1 THEN 'January'
    WHEN EXTRACT(MONTH FROM started_at) = 2 THEN 'February'
    WHEN EXTRACT(MONTH FROM started_at) = 3 THEN 'March'
    WHEN EXTRACT(MONTH FROM started_at) = 4 THEN 'April'
    WHEN EXTRACT(MONTH FROM started_at) = 5 THEN 'May'
    WHEN EXTRACT(MONTH FROM started_at) = 6 THEN 'June'
    WHEN EXTRACT(MONTH FROM started_at) = 7 THEN 'July'
    WHEN EXTRACT(MONTH FROM started_at) = 8 THEN 'August'
    WHEN EXTRACT(MONTH FROM started_at) = 9 THEN 'September'
    WHEN EXTRACT(MONTH FROM started_at) = 10 THEN 'October'
    WHEN EXTRACT(MONTH FROM started_at) = 11 THEN 'November'
    WHEN EXTRACT(MONTH FROM started_at) = 12 THEN 'December'
   END as month,
  EXTRACT (month from started_at) as month_number,
  member_casual as user_type,
  COUNT(ride_id) as number_of_users,
 FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
 GROUP BY month, user_type, month_number
 order by month_number, user_type
  -- for visualization 

  SELECT  
    member_casual as user_type,
    EXTRACT (dayofweek from started_at) as weekday,
    COUNT(ride_id) as number_of_users
    FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
    GROUP BY weekday, user_type
    ORDER BY number_of_users desc
    -- member Wed 422,759 rides
    -- Casual Sat 369,473 rides

  SELECT  
    CASE
    WHEN EXTRACT(dayofweek FROM started_at) = 1 THEN 'Sunday'
    WHEN EXTRACT(dayofweek FROM started_at) = 2 THEN 'Monday'
    WHEN EXTRACT(dayofweek FROM started_at) = 3 THEN 'Tuesday'
    WHEN EXTRACT(dayofweek FROM started_at) = 4 THEN 'Wednesday'
    WHEN EXTRACT(dayofweek FROM started_at) = 5 THEN 'Thursday'
    WHEN EXTRACT(dayofweek FROM started_at) = 6 THEN 'Friday'
    WHEN EXTRACT(dayofweek FROM started_at) = 7 THEN 'Saturday'
   END as day,
      member_casual as user_type,
      EXTRACT(DAYOFWEEK FROM started_at) as day_of_week,
      ROUND (COUNT(ride_id) / 365) as avg_daily_user
    FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
    GROUP BY day_of_week, day, user_type
    ORDER BY avg_daily_user desc
    -- for visualization

  SELECT  
    member_casual as user_type,
    EXTRACT (hour from started_at) as time_of_day,
    COUNT(ride_id) as number_of_users
    FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
    GROUP BY time_of_day, user_type
    ORDER BY number_of_users desc
    -- Member 17:00 283,481 rides
    -- Casual 17:00 170,762 rides
	

  -- WHO RIDES WHAT WHEN

  SELECT  
    rideable_type as ride_type,
    COUNT(ride_id) as number_of_users
    FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
    GROUP BY ride_type
    ORDER BY number_of_users desc
    -- classic_bike 2,624,427 rides; 
    -- electric_bike 1,608,037 rides; 
    -- docked_bike 177,864 rides

  SELECT  
    member_casual as user_type,
    rideable_type as ride_type,
    COUNT(ride_id) as number_of_users
    FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
    GROUP BY user_type, ride_type
    ORDER BY number_of_users desc
    -- member classic_bike 1,728,561 rides 
    -- casual classic_bike 895,866 rides
  
  SELECT  
    rideable_type as ride_type,
    extract (month from started_at) as month,
    COUNT(ride_id) as number_of_users
    FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
    GROUP BY ride_type, month
    ORDER BY number_of_users desc
    -- classic_bike June 406,009 rides
    -- electric_bike July 239,405 rides
    -- docked_bike July 30,599 rides

  SELECT  
    rideable_type as ride_type,
    member_casual as user_type,
    extract (month from started_at) as month,
    COUNT(ride_id) as number_of_users
    FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
    GROUP BY user_type, ride_type, month
    ORDER BY number_of_users desc
    -- member classic_bike June 236,561 rides
    -- casual electric_bike July 125,401 rides

  SELECT
  member_casual as user_type,
  rideable_type as ride_type,
  COUNT(ride_id) as number_of_users,
  ROUND(COUNT(ride_id) / (SELECT COUNT(*) 
    FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`) *   100, 0) as percentage
  FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
  GROUP BY user_type, ride_type
  -- for visualization

  -- MOST POPULAR STATIONS FOR WHO, WHAT, AND WHEN
  
  SELECT  
    start_station_name as start_location,
    COUNT(ride_id) as number_of_users
    FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
    GROUP BY start_location
    ORDER BY number_of_users desc
    -- Streeter Dr & Grand Ave 71,957 rides
  
  SELECT  
    start_station_name as start_location,
    rideable_type as ride_type,
    COUNT(ride_id) as number_of_users
    FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
    GROUP BY ride_type, start_location
    ORDER BY number_of_users desc
    -- classic_bike Streeter Dr & Grand Ave 41,413 rides
    -- electric_bike Streeter Dr & Grand Ave 18,782 rides
    -- docked_bike Streeter Dr & Grand Ave 11,762 rides

  SELECT  
    start_station_name as start_location,
    rideable_type as ride_type,
    extract (month from started_at) as month,
    COUNT(ride_id) as number_of_users
    FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
    GROUP BY ride_type, month, start_location
    ORDER BY number_of_users desc
    -- classic_bike @ Streeter Dr & Grand Ave July 7,712 rides
    -- electric_bike @ Streeter Dr & Grand Ave  July 3,964 rides
    -- docked_bike @ Streeter Dr & Grand Ave July 2,201 rides

  SELECT  
    member_casual as user_type,
    start_station_name as start_location,
    COUNT(ride_id) as number_of_users
    FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
    GROUP BY start_location, user_type
    ORDER BY number_of_users desc
    -- Casual @ Streeter Dr & Grand Ave 55,533 rides
    -- Member @ Kingsbury St & Kinzie St 23,976 rides
	

  SELECT  
    member_casual as user_type,
    start_station_name as start_location,
    extract (month from started_at) as month,
    COUNT(ride_id) as number_of_users
    FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
    GROUP BY month, start_location, user_type
    ORDER BY number_of_users desc
    -- Casual Streeter Dr & Grand Ave July 11028 rides
    -- Member Ellis Ave & 60th St Oct 3,457 rides

  SELECT  
      start_station_name as location,
      member_casual as user_type,
      EXTRACT(DAYOFWEEK FROM started_at) as day_of_week,
      COUNT(ride_id) / 365 as avg_daily_user
    FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
    GROUP BY day_of_week, location, user_type
    ORDER BY avg_daily_user desc
    -- Casual @ Streeter Dr & Grand Ave on Sat avg 37.5 rides
    -- Member @ Clinton St & Washington Blvd on Tues avg 11.6 rides
	

  --WHO RIDES LONGER

  SELECT  
    member_casual as user_type,
    avg(date_diff(ended_at, started_at, minute)) as trip_length_m
  FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
  group by member_casual
  ORDER BY trip_length_m desc
  -- Casual avg 23.68 minutes
  -- Member avg 11.95 minutes

  SELECT 
    member_casual as user_type,
    start_station_name as location,
    avg(date_diff(ended_at, started_at, hour)) as trip_length_hr
  FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
  group by member_casual, location
  ORDER BY trip_length_hr desc
  -- Casual @ South Chicago Ave & Elliot Ave avg 12.28 hr
  -- Member @ Langley Ave & Oakwood Blvd avg 3.0 hr


--for map visualzations
SELECT  
  member_casual as user_type,
  rideable_type as ride_type,
  CASE
    WHEN EXTRACT(MONTH FROM ended_at) = 1 THEN 'January'
    WHEN EXTRACT(MONTH FROM ended_at) = 2 THEN 'February'
    WHEN EXTRACT(MONTH FROM ended_at) = 3 THEN 'March'
    WHEN EXTRACT(MONTH FROM ended_at) = 4 THEN 'April'
    WHEN EXTRACT(MONTH FROM ended_at) = 5 THEN 'May'
    WHEN EXTRACT(MONTH FROM ended_at) = 6 THEN 'June'
    WHEN EXTRACT(MONTH FROM ended_at) = 7 THEN 'July'
    WHEN EXTRACT(MONTH FROM ended_at) = 8 THEN 'August'
    WHEN EXTRACT(MONTH FROM ended_at) = 9 THEN 'September'
    WHEN EXTRACT(MONTH FROM ended_at) = 10 THEN 'October'
    WHEN EXTRACT(MONTH FROM ended_at) = 11 THEN 'November'
    WHEN EXTRACT(MONTH FROM ended_at) = 12 THEN 'December'
   END as month,
  EXTRACT (month from ended_at) as month_number,
  substr(CAST(end_lng as STRING),2),
  CONCAT(end_lat,"N",', ',end_lng,"W") as end_location,
  FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
  order by month_number
  

SELECT  
  member_casual as user_type,
  rideable_type as ride_type,
  CASE
    WHEN EXTRACT(MONTH FROM started_at) = 1 THEN 'January'
    WHEN EXTRACT(MONTH FROM started_at) = 2 THEN 'February'
    WHEN EXTRACT(MONTH FROM started_at) = 3 THEN 'March'
    WHEN EXTRACT(MONTH FROM started_at) = 4 THEN 'April'
    WHEN EXTRACT(MONTH FROM started_at) = 5 THEN 'May'
    WHEN EXTRACT(MONTH FROM started_at) = 6 THEN 'June'
    WHEN EXTRACT(MONTH FROM started_at) = 7 THEN 'July'
    WHEN EXTRACT(MONTH FROM started_at) = 8 THEN 'August'
    WHEN EXTRACT(MONTH FROM started_at) = 9 THEN 'September'
    WHEN EXTRACT(MONTH FROM started_at) = 10 THEN 'October'
    WHEN EXTRACT(MONTH FROM started_at) = 11 THEN 'November'
    WHEN EXTRACT(MONTH FROM started_at) = 12 THEN 'December'
   END as month,
  EXTRACT (month from started_at) as month_number,
  COUNT(ride_id) as number_of_users,
  CONCAT(start_lat,', ',start_lng) as start_location,
  FROM `cyclistic-case-study-373019.cyclistic_tripdata.1_FullYear_DEC21-NOV22_Clean`
  group by start_location, member_casual, rideable_type, month, month_number
  ORDER BY start_location, number_of_users desc
