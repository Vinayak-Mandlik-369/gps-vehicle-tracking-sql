-- GPS project
-- create database 
-- create database name_db
CREATE DATABASE gps_tracking;

-- create use database 
 USE gps_tracking; 
 

 
 -- cerate Table name
CREATE TABLE vehicles (
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_number VARCHAR(20),
    vehicle_type VARCHAR(50),
    city VARCHAR(50)
);


INSERT INTO vehicles (vehicle_number, vehicle_type, city) VALUES
('MH01AB1234','Car','Mumbai'),
('MH02CD5678','Truck','Pune'),
('MH03EF9012','Van','Thane'),
('MH04GH3456','Bus','Nashik'),
('MH05IJ7890','Car','Mumbai'),
('MH06KL1122','Truck','Nagpur'),
('MH07MN3344','Car','Pune'),
('MH08OP5566','Van','Mumbai'),
('MH09QR7788','Bus','Thane'),
('MH10ST9900','Car','Nashik');

SELECT*FROM vehicles;

CREATE TABLE drivers (
    driver_id INT PRIMARY KEY AUTO_INCREMENT,
    driver_name VARCHAR(100),
    experience_years INT,
    vehicle_id INT,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);


INSERT INTO drivers (driver_name, experience_years, vehicle_id) VALUES
('Ramesh Patil',5,1),
('Suresh More',8,2),
('Amit Shah',3,3),
('Raj Verma',10,4),
('Kunal Joshi',4,5),
('Vikas Yadav',6,6),
('Deepak Singh',7,7),
('Manoj Kumar',2,8),
('Arjun Mehta',9,9),
('Nitin Rao',5,10);
SELECT*FROM drivers;

CREATE TABLE trips (
    trip_id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_id INT,
    start_time DATETIME,
    end_time DATETIME,
    distance_km DECIMAL(6,2),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);


INSERT INTO trips (vehicle_id,start_time,end_time,distance_km) VALUES
(1,'2025-02-01 08:00:00','2025-02-01 10:00:00',120.5),
(1,'2025-02-02 09:00:00','2025-02-02 11:00:00',95.0),
(2,'2025-02-01 09:00:00','2025-02-01 14:00:00',300.0),
(2,'2025-02-03 07:00:00','2025-02-03 12:00:00',250.0),
(3,'2025-02-02 07:30:00','2025-02-02 09:30:00',90.0),
(3,'2025-02-04 08:00:00','2025-02-04 10:00:00',110.0),
(4,'2025-02-02 10:00:00','2025-02-02 16:00:00',400.0),
(5,'2025-02-03 08:15:00','2025-02-03 09:45:00',75.5),
(6,'2025-02-04 06:00:00','2025-02-04 11:00:00',350.0),
(7,'2025-02-05 08:00:00','2025-02-05 10:30:00',140.0),
(8,'2025-02-06 09:00:00','2025-02-06 11:00:00',80.0),
(9,'2025-02-07 07:00:00','2025-02-07 13:00:00',420.0),
(10,'2025-02-08 08:00:00','2025-02-08 09:30:00',60.0),
(5,'2025-02-09 07:30:00','2025-02-09 10:00:00',130.0),
(6,'2025-02-10 08:00:00','2025-02-10 14:00:00',370.0),
(7,'2025-02-11 06:30:00','2025-02-11 09:30:00',150.0),
(8,'2025-02-12 08:00:00','2025-02-12 10:00:00',95.0),
(9,'2025-02-13 07:00:00','2025-02-13 12:00:00',390.0),
(10,'2025-02-14 08:30:00','2025-02-14 10:00:00',85.0),
(4,'2025-02-15 09:00:00','2025-02-15 15:00:00',410.0);

SELECT*FROM trips;

CREATE TABLE gps_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_id INT,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    speed DECIMAL(5,2),
    fuel_level DECIMAL(5,2),
    log_time DATETIME,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);


INSERT INTO gps_logs (vehicle_id,latitude,longitude,speed,fuel_level,log_time) VALUES
(1,19.0760,72.8777,60,45,'2025-02-01 08:30:00'),
(1,19.0800,72.8800,85,43,'2025-02-01 09:00:00'),
(2,18.5204,73.8567,70,60,'2025-02-01 10:00:00'),
(2,18.5300,73.8600,95,55,'2025-02-01 12:00:00'),
(3,19.2183,72.9781,50,40,'2025-02-02 08:00:00'),
(4,19.9975,73.7898,88,70,'2025-02-02 12:00:00'),
(5,19.0760,72.8777,45,50,'2025-02-03 08:45:00'),
(6,21.1458,79.0882,92,65,'2025-02-04 09:00:00'),
(7,18.5204,73.8567,78,55,'2025-02-05 09:30:00'),
(8,19.0760,72.8777,66,48,'2025-02-06 10:00:00'),
(9,19.2183,72.9781,100,75,'2025-02-07 11:00:00'),
(10,19.9975,73.7898,58,60,'2025-02-08 09:00:00'),
(6,21.1500,79.0900,105,62,'2025-02-10 10:00:00'),
(4,19.9900,73.7800,82,68,'2025-02-15 11:00:00');

SELECT*FROM vehicles;
SELECT*FROM drivers;
SELECT*FROM trips;
SELECT*FROM gps_logs;

-- Q1. how many vehicles are there 
SELECT distinct COUNT(*) As Total_vehicles
FROM vehicles;

-- CLAUSES
-- Q2. Show all vehicles from Mumbai.
SELECT * FROM vehicles
WHERE city = 'Mumbai';

-- Q3. Show drivers with experience more than 5 years.
SELECT * FROM drivers
WHERE  experience_years>5;

-- Q4. Show top 3 vehicles with highest total distance.
SELECT v.vehicle_id, v.vehicle_number,sum(t.distance_km) AS Total_distance
FROM vehicles v
JOIN trips t
ON v.vehicle_id = t.vehicle_id
GROUP BY  v.vehicle_id, v.vehicle_number
ORDER BY Total_distance DESC
LIMIT 3;

-- KEYWORDS
-- Q5 Find trips between '2025-02-01' and '2025-02-03'.
SELECT*FROM trips
WHERE DATE(start_time)  BETWEEN '2025-02-01' AND '2025-02-03' ;

-- Q6. Show vehicles located in Mumbai or Pune.
SELECT*FROM vehicles
WHERE city IN ('Mumbai','Pune');

-- Q7. Show top 5 highest speed records.
SELECT * FROM gps_logs 
ORDER BY speed DESC
LIMIT 5;

-- JOIN
-- Q8. Show vehicle number with driver name.
SELECT v.vehicle_number,d.driver_name
FROM  vehicles v
INNER join  drivers d
ON v.vehicle_id = d.vehicle_id;

-- Q9. Show vehicle number and total trip distance.
SELECT v.vehicle_number,sum(t.distance_km) AS Total_distance
FROM vehicles v
JOIN trips t 
ON v.vehicle_id = t.vehicle_id
GROUP BY vehicle_number;

-- Q10. Show vehicle number with average speed.
SELECT v.vehicle_number,avg(g.speed) AS Avg_speed
FROM vehicles v
JOIN gps_logs  g 
ON v.vehicle_id = g.vehicle_id
GROUP BY v.vehicle_number;

-- Q11. Show vehicle details with latest GPS log time.
Select v.vehicle_id,v.vehicle_type,v.vehicle_number,v.city,Max(g.log_time) AS Latest_log_time
FROM vehicles v 
JOIN gps_logs g
ON v.vehicle_id = g.vehicle_id
GROUP BY v.vehicle_id,v.vehicle_type,v.vehicle_number,v.city;

-- Q12. Find drivers whose vehicles traveled more than 200 km.
SELECT d.driver_name,v.vehicle_number,sum(t.distance_km) AS Total_traveled
FROM drivers d 
JOIN vehicles  v
ON d.vehicle_id = v.vehicle_id
JOIN trips t 
ON v.vehicle_id = t.vehicle_id
GROUP BY d.driver_name,v.vehicle_number
HAVING sum(distance_km) > 200;

-- Q13. Show vehicles Nmuber  with Pre hour fuel average.
SELECT v.vehicle_number,v.city,avg(g.fuel_level) AS Total_fule_avg
FROM vehicles v 
Join gps_logs g 
ON v.vehicle_id = g.vehicle_id
GROUP BY v.vehicle_number,v.city;

SELECT v.vehicle_number,
       DATE(g.log_time) AS log_date,
       HOUR(g.log_time) AS log_hour,
       AVG(g.fuel_level) AS avg_fuel_per_hour
FROM vehicles v
JOIN gps_logs g
ON v.vehicle_id = g.vehicle_id
GROUP BY v.vehicle_number,
         DATE(g.log_time),
         HOUR(g.log_time);

-- Q14. Rank vehicles based on total distance traveled.
SELECT vehicle_id,vehicle_number,total_distance,
RANK() OVER(ORDER BY total_distance) AS vehicle_Rank
FROM (SELECT v.vehicle_id,v.vehicle_number,sum(t.distance_km) AS total_distance
FROM vehicles v 
JOIN trips t 
ON v.vehicle_id = t.vehicle_id
GROUP BY v.vehicle_id,v.vehicle_number
) Rank_data;

-- Q15. Show top 3 highest speed logs using ROW_NUMBER.
SELECT vehicle_id,speed,log_time
FROM (SELECT vehicle_id,speed,log_time,
ROW_NUMBER() over(ORDER BY speed DESC) as highest_speed
FROM gps_logs) Ranked_log
WHERE highest_speed<=3;

-- Find second highest trip distance.
SELECT max(distance_km) AS second_highest
FROM trips 
WHERE distance_km < (SELECT max(distance_km) FROM trips);

SELECT distance_km
FROM (
    SELECT distance_km,
           DENSE_RANK() OVER (ORDER BY distance_km DESC) AS rnk
    FROM trips
) ranked
WHERE rnk = 2;

-- Q16. Show rank of drivers based on experience.
SELECT driver_name,experience_years,
RANK() over(ORDER BY experience_years) as experience
FROM drivers ;

-- Q17 Show highest speed per vehicle using window function.
SELECT speed,log_time,vehicle_id,
ROW_number() over(order by speed DESC) as highest
FROM gps_logs
;

SELECT vehicle_id,
       speed,
       log_time
FROM (
    SELECT vehicle_id,
           speed,
           log_time,
           ROW_NUMBER() OVER (PARTITION BY vehicle_id ORDER BY speed DESC) AS rn
    FROM gps_logs
) ranked
WHERE rn = 1;






