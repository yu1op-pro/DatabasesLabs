-- DDL PART
-- 1 task
CREATE TABLE airline_info (
    airline_id INT PRIMARY KEY NOT NULL,
    airline_code VARCHAR(30) NOT NULL,
    airline_name VARCHAR(50) NOT NULL,
    airline_country VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    info VARCHAR(50) NOT NULL
);

CREATE TABLE airport (
    airport_id INT PRIMARY KEY NOT NULL,
    airport_name VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE TABLE baggage_check (
    baggage_check_id INT PRIMARY KEY NOT NULL,
    check_result VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    booking_id INT NOT NULL,
    passenger_id INT NOT NULL
);

CREATE TABLE baggage (
    baggage_id INT PRIMARY KEY NOT NULL,
    weight_in_kg DECIMAL(4,2) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    booking_id INT NOT NULL
);

CREATE TABLE boarding_pass (
    boarding_pass_id INT PRIMARY KEY NOT NULL,
    booking_id INT NOT NULL,
    seat VARCHAR(50) NOT NULL,
    boarding_time TIMESTAMP NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE TABLE booking_flight (
    booking_flight_id INT PRIMARY KEY NOT NULL,
    booking_id INT NOT NULL,
    flight_id INT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE TABLE booking (
    booking_id INT PRIMARY KEY NOT NULL,
    flight_id INT NOT NULL,
    passenger_id INT NOT NULL,
    booking_platform VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    status VARCHAR(50) NOT NULL,
    price DECIMAL(7,2) NOT NULL
);

CREATE TABLE flights (
    flight_id INT PRIMARY KEY NOT NULL,
    sch_departure_time TIMESTAMP NOT NULL,
    sch_arrival_time TIMESTAMP NOT NULL,
    departing_airport_id INT NOT NULL,
    arriving_airport_id INT NOT NULL,
    departing_gate VARCHAR(50) NOT NULL,
    arriving_gate VARCHAR(50) NOT NULL,
    airline_id INT NOT NULL,
    act_departure_time TIMESTAMP NOT NULL,
    act_arrival_time TIMESTAMP NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE TABLE passengers (
    passenger_id INT PRIMARY KEY NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(50) NOT NULL,
    country_of_citizenship VARCHAR(50) NOT NULL,
    country_of_residence VARCHAR(50) NOT NULL,
    passport_number VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE TABLE security_check (
    security_check_id INT PRIMARY KEY NOT NULL,
    check_result VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    passenger_id INT NOT NULL
);

-- 5 task
ALTER TABLE airline_info RENAME TO airline;

-- 6 task
ALTER TABLE booking RENAME COLUMN price TO ticket_price;

-- 7 task
ALTER TABLE flights ALTER COLUMN departing_gate TYPE text;

-- 8 task
ALTER TABLE airline DROP COLUMN info;

-- 9 task
-- Passengers with Security_check
ALTER TABLE security_check
ADD CONSTRAINT fk_security_passenger
FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id);

-- Passengers with Booking
ALTER TABLE booking
ADD CONSTRAINT fk_booking_passenger
FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id);

-- Passengers with Baggage_check
ALTER TABLE baggage_check
ADD CONSTRAINT fk_baggage_check_passenger
FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id);


-- Booking with Baggage_check
ALTER TABLE baggage_check
ADD CONSTRAINT fk_baggage_check_booking
FOREIGN KEY (booking_id) REFERENCES booking(booking_id);

-- Booking with Baggage
ALTER TABLE baggage
ADD CONSTRAINT fk_baggage_booking
FOREIGN KEY (booking_id) REFERENCES booking(booking_id);

-- Booking with Boarding_pass
ALTER TABLE boarding_pass
ADD CONSTRAINT fk_boarding_pass_booking
FOREIGN KEY (booking_id) REFERENCES booking(booking_id);

-- Booking with Booking_flight
ALTER TABLE booking_flight
ADD CONSTRAINT fk_booking_flight_booking
FOREIGN KEY (booking_id) REFERENCES booking(booking_id);

-- Flights with Booking_flight
ALTER TABLE booking_flight
ADD CONSTRAINT fk_booking_flight_flight
FOREIGN KEY (flight_id) REFERENCES flights(flight_id);

-- Airport with Flights (departing)
ALTER TABLE flights
ADD CONSTRAINT fk_flights_departing_airport
FOREIGN KEY (departing_airport_id) REFERENCES airport(airport_id);

-- Airport with Flights (arriving)
ALTER TABLE flights
ADD CONSTRAINT fk_flights_arriving_airport
FOREIGN KEY (arriving_airport_id) REFERENCES airport(airport_id);

-- Airline with Flights
ALTER TABLE flights
ADD CONSTRAINT fk_flights_airline
FOREIGN KEY (airline_id) REFERENCES airline(airline_id);


SELECT * FROM airline_info;

SELECT * FROM airport;

SELECT * FROM baggage_check;

SELECT * FROM baggage;

SELECT * FROM boarding_pass;

SELECT * FROM booking_flight;

SELECT * FROM booking;

SELECT * FROM flights;

SELECT * FROM passengers;

SELECT * FROM security_check;


--dml
-- task 2
INSERT INTO airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at, info) VALUES (201, 'KZ001', 'KazAir', 'Kazakhstan', NOW(), NOW(), 'National airline');

--task 3
UPDATE airline_info SET airline_country = 'Turkey' WHERE airline_name = 'KazAir';

--task 4
INSERT INTO airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at, info) VALUES 
(203, 'FR001', 'AirEasy', 'France', NOW(), NOW(), 'French airline'),
(204, 'BR001', 'FlyHigh', 'Brazil', NOW(), NOW(), 'Brazilian airline'),
(205, 'PL001', 'FlyFly', 'Poland', NOW(), NOW(), 'Polish airline');

--task 5
DELETE FROM flights WHERE sch_arrival_time BETWEEN '2024-01-01' AND '2024-12-31';

--task 6
UPDATE booking SET price = price * 1.15;

--task 7
DELETE FROM booking WHERE price < 10000;

--task 1(200 data)
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (1, 'SA', 'South African Airways', 'France', '10/5/2024', '1/18/2025', 'odio');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (2, 'SQ', 'Singapore Airlines', 'China', '3/22/2025', '12/12/2024', 'purus');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (3, 'SK', 'SAS Scandinavian', 'France', '4/24/2025', '12/30/2024', 'erat');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (4, 'AI', 'Air India', 'Thailand', '7/16/2025', '8/22/2025', 'curabitur');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (5, 'SQ', 'Singapore Airlines', 'Netherlands', '6/5/2025', '11/30/2024', 'non ligula');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (6, 'TG', 'Thai Airways', 'Singapore', '3/5/2025', '9/26/2024', 'curabitur in');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (7, 'BA', 'British Airways', 'France', '1/28/2025', '10/14/2024', 'justo pellentesque');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (8, 'AZ', 'Alitalia', 'France', '11/16/2024', '4/23/2025', 'nulla dapibus');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (9, 'SA', 'South African Airways', 'France', '9/2/2025', '10/19/2024', 'nisi');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (10, 'AV', 'Avianca', 'USA', '9/8/2025', '9/23/2024', 'cras');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (11, 'AI', 'Air India', 'India', '6/28/2025', '5/21/2025', 'ipsum');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (12, 'BA', 'British Airways', 'France', '7/14/2025', '9/5/2025', 'morbi sem');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (13, 'QF', 'Qantas', 'Japan', '7/3/2025', '8/12/2025', 'in');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (14, 'AZ', 'Alitalia', 'Austria', '10/1/2024', '7/3/2025', 'consequat dui');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (15, 'LA', 'LATAM Airlines', 'Argentina', '9/2/2025', '5/8/2025', 'suscipit');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (16, 'ET', 'Ethiopian Airlines', 'Qatar', '9/5/2025', '3/4/2025', 'congue diam');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (17, 'AZ', 'Alitalia', 'France', '6/23/2025', '1/19/2025', 'ac');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (18, 'NH', 'All Nippon Airways', 'South Korea', '2/21/2025', '2/17/2025', 'luctus');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (19, 'AI', 'Air India', 'India', '9/7/2025', '2/23/2025', 'nulla nisl');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (20, 'LH', 'Lufthansa', 'France', '6/22/2025', '11/16/2024', 'hac');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (21, 'KE', 'Korean Air', 'Japan', '7/6/2025', '12/4/2024', 'rutrum neque');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (22, 'QR', 'Qatar Airways', 'Germany', '7/2/2025', '10/5/2024', 'in sagittis');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (23, 'WN', 'Southwest Airlines', 'Argentina', '6/14/2025', '5/7/2025', 'posuere felis');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (24, 'LH', 'Lufthansa', 'France', '3/5/2025', '7/23/2025', 'placerat praesent');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (25, 'SA', 'South African Airways', 'India', '7/15/2025', '5/24/2025', 'luctus');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (26, 'QR', 'Qatar Airways', 'Ethiopia', '2/20/2025', '12/8/2024', 'odio curabitur');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (27, 'AI', 'Air India', 'India', '10/5/2024', '1/3/2025', 'leo');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (28, 'EK', 'Emirates', 'Italy', '12/25/2024', '10/27/2024', 'nibh');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (29, 'ET', 'Ethiopian Airlines', 'Qatar', '8/21/2025', '7/7/2025', 'ipsum');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (30, 'ET', 'Ethiopian Airlines', 'Qatar', '11/30/2024', '7/1/2025', 'semper');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (31, 'WN', 'Southwest Airlines', 'USA', '1/5/2025', '5/16/2025', 'sapien');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (32, 'KL', 'KLM Royal Dutch Airlines', 'Germany', '3/26/2025', '3/27/2025', 'nulla');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (33, 'AC', 'Air Canada', 'USA', '5/21/2025', '8/15/2025', 'suspendisse accumsan');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (34, 'AC', 'Air Canada', 'USA', '5/31/2025', '6/15/2025', 'at');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (35, 'LH', 'Lufthansa', 'France', '9/15/2025', '2/19/2025', 'lobortis');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (36, 'QR', 'Qatar Airways', 'France', '9/22/2025', '3/18/2025', 'phasellus id');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (37, 'BA', 'British Airways', 'Sweden', '11/24/2024', '3/22/2025', 'elementum');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (38, 'BA', 'British Airways', 'Germany', '9/7/2025', '9/23/2024', 'ultrices');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (39, 'SQ', 'Singapore Airlines', 'Australia', '1/8/2025', '11/10/2024', 'aliquam');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (40, 'LH', 'Lufthansa', 'Switzerland', '4/20/2025', '7/23/2025', 'elit');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (41, 'AZ', 'Alitalia', 'France', '11/7/2024', '1/2/2025', 'id');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (42, 'DL', 'Delta Air Lines', 'USA', '4/28/2025', '2/3/2025', 'id ligula');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (43, 'BA', 'British Airways', 'France', '1/6/2025', '11/7/2024', 'nec dui');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (44, 'TG', 'Thai Airways', 'Singapore', '11/26/2024', '12/17/2024', 'pellentesque');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (45, 'UA', 'United Airlines', 'Peru', '12/6/2024', '1/21/2025', 'pulvinar nulla');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (46, 'DL', 'Delta Air Lines', 'USA', '12/31/2024', '1/18/2025', 'ridiculus');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (47, 'BA', 'British Airways', 'France', '1/19/2025', '3/6/2025', 'aliquam non');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (48, 'AI', 'Air India', 'India', '8/15/2025', '8/30/2025', 'semper porta');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (49, 'ET', 'Ethiopian Airlines', 'Qatar', '7/5/2025', '12/15/2024', 'in');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (50, 'BA', 'British Airways', 'France', '11/18/2024', '9/30/2024', 'felis');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (51, 'LA', 'LATAM Airlines', 'USA', '9/22/2025', '9/9/2025', 'in');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (52, 'NZ', 'Air New Zealand', 'Australia', '3/26/2025', '8/4/2025', 'tortor');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (53, 'KL', 'KLM Royal Dutch Airlines', 'New Zealand', '8/30/2025', '5/5/2025', 'diam vitae');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (54, 'AI', 'Air India', 'India', '12/21/2024', '10/19/2024', 'cursus');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (55, 'ET', 'Ethiopian Airlines', 'Qatar', '7/23/2025', '10/10/2024', 'odio');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (56, 'KE', 'Korean Air', 'India', '2/27/2025', '4/6/2025', 'quam pharetra');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (57, 'AZ', 'Alitalia', 'France', '8/9/2025', '11/16/2024', 'massa volutpat');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (58, 'AV', 'Avianca', 'USA', '1/25/2025', '3/25/2025', 'gravida');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (59, 'EK', 'Emirates', 'Qatar', '12/30/2024', '9/20/2025', 'ultrices libero');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (60, 'AZ', 'Alitalia', 'France', '12/4/2024', '8/16/2025', 'luctus');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (61, 'KE', 'Korean Air', 'Japan', '3/10/2025', '10/20/2024', 'aliquam convallis');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (62, 'UA', 'United Airlines', 'USA', '8/20/2025', '9/16/2025', 'augue a');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (63, 'DL', 'Delta Air Lines', 'USA', '6/12/2025', '7/12/2025', 'in');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (64, 'AM', 'Aeroméxico', 'USA', '12/24/2024', '7/8/2025', 'donec');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (65, 'SA', 'South African Airways', 'USA', '5/24/2025', '8/21/2025', 'eleifend');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (66, 'KL', 'KLM Royal Dutch Airlines', 'France', '11/10/2024', '11/7/2024', 'vel');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (67, 'QR', 'Qatar Airways', 'Ethiopia', '4/14/2025', '4/28/2025', 'suscipit nulla');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (68, 'SK', 'SAS Scandinavian', 'Malaysia', '12/29/2024', '12/14/2024', 'rhoncus aliquam');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (69, 'TG', 'Thai Airways', 'Singapore', '5/16/2025', '10/8/2024', 'viverra');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (70, 'LH', 'Lufthansa', 'France', '1/13/2025', '12/24/2024', 'potenti');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (71, 'AA', 'American Airlines', 'USA', '1/28/2025', '12/16/2024', 'quis');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (72, 'IB', 'Iberia', 'France', '11/6/2024', '2/17/2025', 'ante ipsum');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (73, 'QF', 'Qantas', 'Australia', '11/8/2024', '5/6/2025', 'vulputate justo');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (74, 'AZ', 'Alitalia', 'France', '5/29/2025', '2/6/2025', 'nulla');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (75, 'SK', 'SAS Scandinavian', 'Malaysia', '4/1/2025', '4/18/2025', 'vestibulum');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (76, 'CX', 'Cathay Pacific', 'Singapore', '10/16/2024', '9/14/2025', 'in hac');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (77, 'SA', 'South African Airways', 'France', '11/11/2024', '10/28/2024', 'mi');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (78, 'SQ', 'Singapore Airlines', 'India', '9/16/2025', '7/19/2025', 'nisi');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (79, 'TG', 'Thai Airways', 'Singapore', '8/8/2025', '4/30/2025', 'varius ut');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (80, 'TG', 'Thai Airways', 'Singapore', '6/29/2025', '5/17/2025', 'eu nibh');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (81, 'LA', 'LATAM Airlines', 'Argentina', '6/2/2025', '1/13/2025', 'proin');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (82, 'UA', 'United Airlines', 'USA', '11/25/2024', '6/3/2025', 'mauris');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (83, 'AV', 'Avianca', 'USA', '5/9/2025', '4/15/2025', 'nisl');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (84, 'IB', 'Iberia', 'France', '11/2/2024', '6/11/2025', 'ultrices');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (85, 'CX', 'Cathay Pacific', 'Singapore', '3/5/2025', '1/27/2025', 'tortor');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (86, 'QF', 'Qantas', 'Australia', '1/31/2025', '9/13/2025', 'vehicula');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (87, 'AZ', 'Alitalia', 'France', '9/16/2025', '1/21/2025', 'in');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (88, 'LA', 'LATAM Airlines', 'Argentina', '4/25/2025', '11/25/2024', 'blandit nam');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (89, 'TG', 'Thai Airways', 'Singapore', '9/26/2024', '7/29/2025', 'nunc nisl');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (90, 'KE', 'Korean Air', 'Japan', '10/2/2024', '8/4/2025', 'et ultrices');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (91, 'SK', 'SAS Scandinavian', 'France', '12/3/2024', '6/14/2025', 'porttitor');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (92, 'KL', 'KLM Royal Dutch Airlines', 'France', '2/8/2025', '6/2/2025', 'ipsum');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (93, 'LA', 'LATAM Airlines', 'Argentina', '2/9/2025', '12/8/2024', 'eget rutrum');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (94, 'WN', 'Southwest Airlines', 'USA', '4/20/2025', '2/26/2025', 'pede');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (95, 'SK', 'SAS Scandinavian', 'France', '4/11/2025', '5/31/2025', 'odio in');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (96, 'AI', 'Air India', 'Austria', '9/20/2025', '12/15/2024', 'ullamcorper purus');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (97, 'AM', 'Aeroméxico', 'USA', '4/4/2025', '1/25/2025', 'vestibulum vestibulum');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (98, 'DL', 'Delta Air Lines', 'USA', '2/22/2025', '2/28/2025', 'ullamcorper');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (99, 'QR', 'Qatar Airways', 'Ethiopia', '8/1/2025', '3/11/2025', 'magna ac');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (100, 'SQ', 'Singapore Airlines', 'Denmark', '10/10/2024', '6/18/2025', 'quam');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (101, 'AM', 'Aeroméxico', 'USA', '12/6/2024', '8/29/2025', 'auctor sed');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (102, 'IB', 'Iberia', 'France', '10/16/2024', '1/18/2025', 'magna');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (103, 'BA', 'British Airways', 'Denmark', '1/30/2025', '6/9/2025', 'at dolor');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (104, 'AF', 'Air France', 'Germany', '5/31/2025', '5/26/2025', 'sapien');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (105, 'CX', 'Cathay Pacific', 'France', '7/9/2025', '2/13/2025', 'adipiscing');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (106, 'QR', 'Qatar Airways', 'China', '3/18/2025', '2/25/2025', 'convallis eget');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (107, 'AM', 'Aeroméxico', 'USA', '4/16/2025', '1/6/2025', 'erat volutpat');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (108, 'AC', 'Air Canada', 'USA', '1/4/2025', '3/12/2025', 'commodo');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (109, 'SK', 'SAS Scandinavian', 'France', '2/5/2025', '4/9/2025', 'vel');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (110, 'AI', 'Air India', 'Switzerland', '10/8/2024', '9/19/2025', 'aenean fermentum');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (111, 'NZ', 'Air New Zealand', 'Thailand', '7/5/2025', '12/13/2024', 'vel');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (112, 'QF', 'Qantas', 'Italy', '2/10/2025', '8/8/2025', 'diam');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (113, 'BA', 'British Airways', 'France', '7/1/2025', '7/21/2025', 'in lacus');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (114, 'KE', 'Korean Air', 'Japan', '5/24/2025', '1/13/2025', 'in');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (115, 'AF', 'Air France', 'Germany', '5/31/2025', '2/24/2025', 'massa volutpat');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (116, 'SK', 'SAS Scandinavian', 'France', '11/7/2024', '9/17/2025', 'aliquam');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (117, 'TG', 'Thai Airways', 'Singapore', '4/15/2025', '4/22/2025', 'id');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (118, 'KL', 'KLM Royal Dutch Airlines', 'France', '4/1/2025', '5/16/2025', 'in');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (119, 'CX', 'Cathay Pacific', 'Singapore', '10/10/2024', '11/21/2024', 'suspendisse accumsan');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (120, 'AZ', 'Alitalia', 'France', '3/2/2025', '11/4/2024', 'in felis');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (121, 'ET', 'Ethiopian Airlines', 'Qatar', '7/18/2025', '11/14/2024', 'odio consequat');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (122, 'SK', 'SAS Scandinavian', 'France', '2/7/2025', '1/18/2025', 'nisi nam');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (123, 'ET', 'Ethiopian Airlines', 'Germany', '6/28/2025', '2/25/2025', 'cum');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (124, 'AI', 'Air India', 'India', '2/1/2025', '10/30/2024', 'velit vivamus');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (125, 'UA', 'United Airlines', 'USA', '5/9/2025', '5/12/2025', 'vulputate elementum');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (126, 'TG', 'Thai Airways', 'China', '11/27/2024', '10/4/2024', 'semper rutrum');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (127, 'SK', 'SAS Scandinavian', 'France', '8/31/2025', '5/30/2025', 'quis orci');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (128, 'CX', 'Cathay Pacific', 'Singapore', '7/22/2025', '9/8/2025', 'nunc');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (129, 'UA', 'United Airlines', 'USA', '1/19/2025', '1/21/2025', 'sem mauris');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (130, 'AA', 'American Airlines', 'USA', '2/23/2025', '10/18/2024', 'nulla integer');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (131, 'SA', 'South African Airways', 'France', '9/12/2025', '6/22/2025', 'id');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (132, 'AA', 'American Airlines', 'USA', '9/20/2025', '10/9/2024', 'nibh');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (133, 'UA', 'United Airlines', 'USA', '11/21/2024', '9/20/2025', 'nisl');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (134, 'SA', 'South African Airways', 'Ethiopia', '3/27/2025', '9/24/2024', 'eget tincidunt');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (135, 'IB', 'Iberia', 'France', '8/24/2025', '6/27/2025', 'sit');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (136, 'IB', 'Iberia', 'France', '6/16/2025', '11/27/2024', 'dapibus dolor');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (137, 'AM', 'Aeroméxico', 'USA', '10/25/2024', '4/12/2025', 'porta');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (138, 'SK', 'SAS Scandinavian', 'France', '10/18/2024', '10/14/2024', 'malesuada');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (139, 'AF', 'Air France', 'Germany', '1/8/2025', '9/16/2025', 'in');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (140, 'AA', 'American Airlines', 'USA', '6/22/2025', '3/26/2025', 'dis');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (141, 'KE', 'Korean Air', 'China', '3/4/2025', '4/17/2025', 'cubilia');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (142, 'AM', 'Aeroméxico', 'USA', '7/5/2025', '8/23/2025', 'venenatis');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (143, 'QF', 'Qantas', 'Australia', '11/29/2024', '4/6/2025', 'in');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (144, 'UA', 'United Airlines', 'USA', '4/28/2025', '11/11/2024', 'dui luctus');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (145, 'NH', 'All Nippon Airways', 'South Korea', '1/16/2025', '2/9/2025', 'natoque');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (146, 'LH', 'Lufthansa', 'France', '9/16/2025', '11/30/2024', 'eu');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (147, 'QR', 'Qatar Airways', 'Ethiopia', '12/27/2024', '6/1/2025', 'at');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (148, 'IB', 'Iberia', 'France', '3/24/2025', '3/23/2025', 'auctor gravida');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (149, 'LH', 'Lufthansa', 'Italy', '9/18/2025', '1/10/2025', 'mauris');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (150, 'SA', 'South African Airways', 'France', '2/3/2025', '10/24/2024', 'cras pellentesque');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (151, 'CX', 'Cathay Pacific', 'Singapore', '6/12/2025', '11/14/2024', 'praesent');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (152, 'AI', 'Air India', 'India', '11/22/2024', '8/6/2025', 'molestie');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (153, 'SA', 'South African Airways', 'India', '2/20/2025', '4/16/2025', 'ipsum');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (154, 'NH', 'All Nippon Airways', 'South Korea', '8/31/2025', '2/14/2025', 'ac diam');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (155, 'AM', 'Aeroméxico', 'Argentina', '10/7/2024', '4/12/2025', 'mauris non');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (156, 'EK', 'Emirates', 'Qatar', '8/9/2025', '12/9/2024', 'ut');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (157, 'UA', 'United Airlines', 'USA', '7/29/2025', '10/10/2024', 'mi');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (158, 'AF', 'Air France', 'Germany', '10/21/2024', '11/15/2024', 'nascetur');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (159, 'SK', 'SAS Scandinavian', 'France', '12/12/2024', '10/8/2024', 'at');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (160, 'UA', 'United Airlines', 'USA', '11/22/2024', '7/13/2025', 'in');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (161, 'SQ', 'Singapore Airlines', 'China', '6/1/2025', '6/5/2025', 'id mauris');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (162, 'KL', 'KLM Royal Dutch Airlines', 'France', '7/4/2025', '2/22/2025', 'in');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (163, 'AM', 'Aeroméxico', 'Colombia', '9/24/2024', '1/7/2025', 'amet');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (164, 'SQ', 'Singapore Airlines', 'South Korea', '10/17/2024', '9/14/2025', 'nec dui');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (165, 'ET', 'Ethiopian Airlines', 'Qatar', '7/27/2025', '10/8/2024', 'mi integer');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (166, 'SA', 'South African Airways', 'France', '6/26/2025', '7/10/2025', 'proin leo');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (167, 'KE', 'Korean Air', 'Japan', '7/18/2025', '1/16/2025', 'mauris sit');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (168, 'AA', 'American Airlines', 'USA', '11/24/2024', '8/19/2025', 'volutpat');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (169, 'BA', 'British Airways', 'Brazil', '9/14/2025', '6/27/2025', 'justo');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (170, 'TG', 'Thai Airways', 'Singapore', '6/12/2025', '5/8/2025', 'fusce consequat');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (171, 'BA', 'British Airways', 'France', '8/8/2025', '2/14/2025', 'augue vestibulum');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (172, 'IB', 'Iberia', 'France', '1/19/2025', '12/2/2024', 'consectetuer adipiscing');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (173, 'AZ', 'Alitalia', 'France', '1/25/2025', '4/13/2025', 'nulla sed');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (174, 'AM', 'Aeroméxico', 'USA', '10/1/2024', '9/3/2025', 'id pretium');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (175, 'WN', 'Southwest Airlines', 'USA', '12/18/2024', '7/13/2025', 'nec');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (176, 'LH', 'Lufthansa', 'Netherlands', '7/18/2025', '6/13/2025', 'suscipit a');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (177, 'KE', 'Korean Air', 'Japan', '3/15/2025', '8/23/2025', 'amet justo');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (178, 'DL', 'Delta Air Lines', 'USA', '1/23/2025', '5/25/2025', 'ut');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (179, 'UA', 'United Airlines', 'USA', '4/10/2025', '12/23/2024', 'sollicitudin');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (180, 'KL', 'KLM Royal Dutch Airlines', 'France', '4/2/2025', '12/24/2024', 'convallis');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (181, 'AM', 'Aeroméxico', 'USA', '11/7/2024', '5/4/2025', 'morbi quis');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (182, 'AC', 'Air Canada', 'Qatar', '11/29/2024', '3/27/2025', 'penatibus');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (183, 'LH', 'Lufthansa', 'France', '4/2/2025', '8/10/2025', 'felis');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (184, 'AZ', 'Alitalia', 'France', '5/7/2025', '9/18/2025', 'nec');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (185, 'AM', 'Aeroméxico', 'USA', '11/27/2024', '7/1/2025', 'semper');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (186, 'QR', 'Qatar Airways', 'Spain', '8/4/2025', '9/14/2025', 'consectetuer');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (187, 'AI', 'Air India', 'India', '10/16/2024', '8/22/2025', 'donec vitae');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (188, 'IB', 'Iberia', 'France', '8/13/2025', '5/9/2025', 'penatibus et');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (189, 'AZ', 'Alitalia', 'France', '2/18/2025', '5/30/2025', 'facilisi cras');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (190, 'AZ', 'Alitalia', 'South Africa', '11/14/2024', '11/24/2024', 'tristique tortor');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (191, 'SA', 'South African Airways', 'France', '6/12/2025', '3/2/2025', 'quisque id');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (192, 'KL', 'KLM Royal Dutch Airlines', 'France', '5/16/2025', '6/16/2025', 'integer pede');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (193, 'QR', 'Qatar Airways', 'Ethiopia', '4/18/2025', '1/12/2025', 'vel');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (194, 'AM', 'Aeroméxico', 'USA', '8/1/2025', '5/7/2025', 'amet');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (195, 'AF', 'Air France', 'Germany', '2/2/2025', '7/21/2025', 'nam ultrices');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (196, 'AV', 'Avianca', 'USA', '4/23/2025', '8/1/2025', 'pulvinar sed');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (197, 'ET', 'Ethiopian Airlines', 'Qatar', '8/8/2025', '7/2/2025', 'tincidunt');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (198, 'KE', 'Korean Air', 'Japan', '2/13/2025', '9/15/2025', 'suscipit');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (199, 'LH', 'Lufthansa', 'France', '8/24/2025', '1/10/2025', 'duis');
insert into airline_info (airline_id, airline_code, airline_name, airline_country, created_at, updated_at , info) values (200, 'QF', 'Qantas', 'Australia', '5/21/2025', '6/21/2025', 'vel dapibus');


ALTER TABLE airport
ALTER COLUMN airport_name TYPE VARCHAR(150),
ALTER COLUMN country TYPE VARCHAR(150),
ALTER COLUMN state TYPE VARCHAR(150),
ALTER COLUMN city TYPE VARCHAR(150);



DROP TABLE IF EXISTS booking CASCADE;
CREATE TABLE booking (
    booking_id INT PRIMARY KEY NOT NULL,
    flight_id INT NOT NULL,
    passenger_id INT NOT NULL,
    booking_platform VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    status VARCHAR(50) NOT NULL,
    price DECIMAL(7,2) NOT NULL
);
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (1, 'Sarzana-Luni Air Base', 'China', 'IL', 'Xianbao', '9/18/2025', '12/2/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (2, 'Tumeremo Airport', 'Malaysia', 'FL', 'Raub', '11/15/2024', '4/19/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (3, 'Wollogorang Airport', 'Portugal', 'MN', 'Santa Maria Oliveira', '8/19/2025', '11/10/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (4, 'Yorkton Municipal Airport', 'Poland', 'LA', 'Smołdzino', '4/9/2025', '6/30/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (5, 'Kenosha Regional Airport', 'Canada', 'KS', 'Saint-Bruno-de-Guigues', '3/21/2025', '1/12/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (6, 'Senadora Eunice Micheles Airport', 'China', 'MA', 'Shuanghe', '5/19/2025', '8/28/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (7, 'Riverside Airport', 'Indonesia', 'MI', 'Sukarama', '3/21/2025', '5/5/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (8, 'Lalmonirhat Airport', 'Russia', 'AL', 'Pikalëvo', '9/30/2024', '9/5/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (9, 'Puerto Leda Airport', 'Brazil', 'MT', 'Santa Quitéria do Maranhão', '10/21/2024', '7/18/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (10, 'Bembridge Airport', 'Morocco', 'TX', 'Moulay Yacoub', '12/30/2024', '2/4/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (11, 'Keokuk Municipal Airport', 'Peru', 'CO', 'Chincha Baja', '7/6/2025', '9/2/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (12, 'Kosipe Airport', 'China', 'IL', 'Yiyang', '4/26/2025', '6/9/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (13, 'Maxson Airfield', 'Dominican Republic', 'PA', 'Ensanche Luperón', '8/24/2025', '6/17/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (14, 'Dongola Airport', 'Poland', 'IL', 'Józefów', '10/5/2024', '10/22/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (15, 'Golfo de Morrosquillo Airport', 'Russia', 'CA', 'Peredovaya', '3/2/2025', '3/15/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (16, 'Zabreh Ostrava Airport', 'Indonesia', 'DE', 'Dukuhpicung', '3/5/2025', '5/31/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (17, 'Cap Manuel Niño International Airport', 'Sweden', 'IL', 'Klippan', '6/4/2025', '4/15/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (18, 'Aasiaat Airport', 'Nigeria', 'IA', 'Kujama', '2/15/2025', '11/3/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (19, 'Myeik Airport', 'Brazil', 'OH', 'Vilhena', '3/3/2025', '12/22/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (20, 'Shanshan Airport', 'Czech Republic', 'PA', 'Brloh', '12/11/2024', '6/25/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (21, 'Toccoa Airport - R.G. Letourneau Field', 'Russia', 'FL', 'Orekhovo-Zuyevo', '9/21/2025', '6/5/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (22, 'Nouakchott–Oumtounsy International Airport', 'Colombia', 'MS', 'Granada', '12/15/2024', '8/21/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (23, 'Moba Airport', 'Indonesia', 'MI', 'Penambangan', '6/26/2025', '12/30/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (24, 'Cape Town International Airport', 'Indonesia', 'MN', 'Ciusul', '8/10/2025', '10/26/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (25, 'Palma Airport', 'Norway', 'FL', 'Bergen', '10/12/2024', '9/28/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (26, 'Enrique Adolfo Jimenez Airport', 'Philippines', 'CA', 'Mabilog', '3/19/2025', '12/18/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (27, 'Los Garzones Airport', 'China', 'VA', 'Xinglong', '1/5/2025', '8/14/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (28, 'Southwest Washington Regional Airport', 'South Africa', 'CA', 'Koffiefontein', '3/3/2025', '9/18/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (29, 'Capitán Av. Juan Cochamanidis S. Airport', 'China', 'VA', 'Guojia', '11/22/2024', '9/30/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (30, 'Makabana Airport', 'Norway', 'IL', 'Skien', '2/27/2025', '1/11/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (31, 'Edinburgh Airport', 'Japan', 'TX', 'Ojiya', '10/17/2024', '11/14/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (32, 'Mc Clellan-Palomar Airport', 'Denmark', 'WI', 'København', '11/25/2024', '8/8/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (33, 'Ulithi Airport', 'Brazil', 'NJ', 'Floresta', '11/19/2024', '4/12/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (34, 'Yeosu Airport', 'Monaco', 'FL', 'Fontvieille', '8/21/2025', '2/6/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (35, 'Canouan Airport', 'China', 'MS', 'Dachong', '12/3/2024', '12/30/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (36, 'McCall Municipal Airport', 'China', 'CA', 'Xuanzhou', '4/2/2025', '3/24/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (37, 'Leshukonskoye Airport', 'Indonesia', 'DE', 'Sindangsuka', '10/30/2024', '6/9/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (38, 'Nunukan Airport', 'Ecuador', 'KS', 'Machala', '5/17/2025', '11/23/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (39, 'Nusatupe Airport', 'China', 'WA', 'Neiguan', '5/4/2025', '3/27/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (40, 'Sauren Airport', 'Portugal', 'MS', 'Avelinha', '11/16/2024', '11/7/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (41, 'Brewster Field', 'Portugal', 'RI', 'Parchal', '11/11/2024', '8/14/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (42, 'Josephstaal Airport', 'Madagascar', 'OR', 'Miandrarivo', '9/16/2025', '9/20/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (43, 'Wilkes Barre Scranton International Airport', 'Comoros', 'SC', 'Chironkamba', '1/31/2025', '2/20/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (44, 'Comodoro Pedro Zanni Airport', 'China', 'PA', 'Gaoshi', '12/20/2024', '1/8/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (45, 'Cruzeiro do Sul Airport', 'Brazil', 'PA', 'Aguaí', '3/7/2025', '9/15/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (46, 'Coventry Airport', 'Greece', 'WV', 'Mólos', '12/18/2024', '1/25/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (47, 'Plato Airport', 'Senegal', 'IL', 'Ouro Sogui', '2/28/2025', '6/16/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (48, 'Bear Creek 3 Airport', 'Colombia', 'WA', 'Palocabildo', '3/4/2025', '9/12/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (49, 'Culion Airport', 'China', 'LA', 'Kokagax', '12/4/2024', '5/3/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (50, 'Cyril E. King Airport', 'Nicaragua', 'AL', 'Moyogalpa', '9/15/2025', '3/16/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (51, 'London Stansted Airport', 'China', 'PA', 'Yaozhanzi', '3/10/2025', '6/6/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (52, 'Kirkwall Airport', 'Jamaica', 'PA', 'Richmond', '6/5/2025', '2/16/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (53, 'Miyakejima Airport', 'Mexico', 'KY', 'Emiliano Zapata', '9/3/2025', '6/24/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (54, 'Khatanga Airport', 'Russia', 'TX', 'Kurovskoye', '7/13/2025', '2/27/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (55, 'Teruel Airport', 'China', 'NY', 'Dawu Chengguanzhen', '3/3/2025', '2/24/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (56, 'Karimui Airport', 'Indonesia', 'MS', 'Padangcermin', '9/10/2025', '10/8/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (57, 'Anfa Airport', 'Poland', 'KY', 'Lubień Kujawski', '3/14/2025', '7/15/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (58, 'Matari Airport', 'Philippines', 'IN', 'Lumatil', '3/3/2025', '8/7/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (59, 'Sochi International Airport', 'Russia', 'IL', 'Taksimo', '1/28/2025', '7/11/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (60, 'Turkmenabat Airport', 'Nicaragua', 'MI', 'Larreynaga', '2/24/2025', '11/11/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (61, 'Mönchengladbach Airport', 'Sweden', 'TX', 'Övertorneå', '9/24/2024', '2/16/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (62, 'Northwest Florida Beaches International Airport', 'Poland', 'AR', 'Tuchola', '9/22/2025', '2/25/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (63, 'Mukah Airport', 'France', 'IL', 'Laval', '8/4/2025', '3/5/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (64, 'El Porvenir Airport', 'Colombia', 'CA', 'Girón', '12/21/2024', '6/1/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (65, 'Miley Memorial Field', 'United States', 'ND', 'Nashville', '10/29/2024', '7/1/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (66, 'Figari Sud-Corse Airport', 'Indonesia', 'FL', 'Tegalheras', '9/13/2025', '2/22/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (67, 'Billy Mitchell Airport', 'Pakistan', 'PA', 'Faruka', '5/31/2025', '6/19/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (68, 'Margaret River Airport', 'Gabon', 'TX', 'Mayumba', '5/1/2025', '2/4/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (69, 'Pimenta Bueno Airport', 'New Zealand', 'OH', 'Kawakawa', '7/14/2025', '8/20/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (70, 'Am Timan Airport', 'Philippines', 'CO', 'San Vicente', '7/26/2025', '10/16/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (71, 'Fort Lauderdale Hollywood International Airport', 'Brazil', 'TX', 'Congonhas', '1/20/2025', '1/22/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (72, 'Jyvaskyla Airport', 'Indonesia', 'MI', 'Cililitan', '1/23/2025', '10/10/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (73, 'Saenz Peña Airport', 'Indonesia', 'TN', 'Palangan', '7/1/2025', '10/5/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (74, 'Lille-Lesquin Airport', 'China', 'FL', 'Ganjiachang', '2/20/2025', '12/3/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (75, 'Snap Lake Airport', 'Peru', 'VA', 'Caspisapa', '4/19/2025', '8/17/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (76, 'Quthing Airport', 'Poland', 'CA', 'Lututów', '11/21/2024', '12/8/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (77, 'Southwest Bay Airport', 'Estonia', 'IL', 'Põltsamaa', '11/23/2024', '2/8/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (78, 'Helena Regional Airport', 'United States', 'IL', 'Austin', '11/24/2024', '5/22/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (79, 'Kelsey Airport', 'Brazil', 'CA', 'Itápolis', '9/12/2025', '6/9/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (80, 'Phrae Airport', 'Mexico', 'NE', 'San Antonio', '1/20/2025', '8/20/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (81, 'Louisville Winston County Airport', 'France', 'OH', 'Noisy-le-Grand', '8/11/2025', '11/29/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (82, 'Ndolo Airport', 'Indonesia', 'NE', 'Labuhan Deli', '9/29/2024', '10/29/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (83, 'Waterloo Airport', 'Russia', 'FL', 'Klimovsk', '12/18/2024', '5/1/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (84, 'Wilcannia Airport', 'Philippines', 'OH', 'Anulid', '2/14/2025', '3/9/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (85, 'NASA Crows Landing Airport', 'Colombia', 'PA', 'Orito', '4/8/2025', '8/6/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (86, 'Wau Airport', 'Thailand', 'MS', 'Sapphaya', '8/24/2025', '10/16/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (87, 'Shimojishima Airport', 'Mauritania', 'TX', 'Néma', '7/2/2025', '2/5/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (88, 'Gwalior Airport', 'Philippines', 'OR', 'Kiamba', '5/29/2025', '2/24/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (89, 'St. Mary''s County Regional Airport', 'China', 'MS', 'Wenchang', '8/21/2025', '3/6/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (90, 'Chacarita Airport', 'Russia', 'NM', 'Kodinsk', '11/17/2024', '6/26/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (91, 'Kaben Airport', 'Thailand', 'MS', 'Udon Thani', '4/30/2025', '9/7/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (92, 'Kleinsee Airport', 'Brazil', 'CA', 'Belo Horizonte', '1/15/2025', '6/16/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (93, 'Cessna Aircraft Field', 'South Sudan', 'GA', 'Yambio', '2/26/2025', '7/19/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (94, 'Santa Ana Airport', 'Philippines', 'WA', 'Bobonan', '9/7/2025', '7/30/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (95, 'Ramon Airport', 'Indonesia', 'VA', 'Basiong', '1/26/2025', '7/28/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (96, 'Lamar Municipal Airport', 'Sweden', 'MN', 'Köping', '3/17/2025', '10/2/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (97, 'Frieda River Airport', 'Tunisia', 'MN', 'Ghār al Milḩ', '5/20/2025', '7/16/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (98, 'Belaya Gora Airport', 'China', 'NY', 'Xiejiaya', '7/12/2025', '1/26/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (99, 'Marigot Seaplane Base', 'Mexico', 'ME', 'Buenavista', '9/13/2025', '4/24/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (100, 'Xilinhot Airport', 'United States', 'CO', 'Pittsburgh', '6/9/2025', '5/14/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (101, 'Wyk auf Föhr Airport', 'Japan', 'IA', 'Ueki', '11/4/2024', '1/7/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (102, 'Long Island Mac Arthur Airport', 'United States', 'NC', 'Memphis', '7/1/2025', '7/23/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (103, 'Thomas C Russell Field', 'Portugal', 'NY', 'Moses', '3/30/2025', '8/23/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (104, 'Sibulan Airport', 'Iran', 'KS', 'Qal‘eh-ye Khvājeh', '5/12/2025', '3/10/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (105, 'Cairns AAF (Fort Rucker) Air Field', 'Togo', 'WA', 'Sotouboua', '5/2/2025', '2/10/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (106, 'Francisco Bangoy International Airport', 'Nepal', 'FL', 'Besisahar', '5/6/2025', '9/22/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (107, 'Meghauli Airport', 'Brazil', 'IL', 'Palhoça', '2/22/2025', '7/20/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (108, 'Corpus Christi International Airport', 'Indonesia', 'MT', 'Cipesing', '8/30/2025', '12/2/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (109, 'Tan Tan Airport', 'Mongolia', 'NY', 'Baruunsuu', '12/5/2024', '10/15/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (110, 'Astoria Regional Airport', 'Philippines', 'OH', 'Salcedo', '6/15/2025', '9/16/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (111, 'Kannur International Airport', 'China', 'MO', 'Heyin', '7/25/2025', '3/27/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (112, 'Wipim Airport', 'Ireland', 'OK', 'Drumcondra', '7/19/2025', '3/9/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (113, 'Zhongwei Shapotou Airport', 'Brazil', 'LA', 'Ribeirão das Neves', '3/30/2025', '10/21/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (114, 'Jacqueline Cochran Regional Airport', 'Greece', 'PA', 'Sosándra', '3/24/2025', '2/21/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (115, 'Owensboro Daviess County Airport', 'Marshall Islands', 'OH', 'Enewetak', '10/24/2024', '5/8/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (116, 'Palungtar Airport', 'France', 'CA', 'Paris 03', '5/6/2025', '7/15/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (117, 'Moses Kilangin Airport', 'China', 'CA', 'Pubu', '2/20/2025', '1/15/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (118, 'Kirkenes Airport (Høybuktmoen)', 'Malaysia', 'NE', 'Kuantan', '5/4/2025', '12/6/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (119, 'Surgut Airport', 'Poland', 'WY', 'Marianowo', '8/15/2025', '1/24/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (120, 'Hollister Municipal Airport', 'Cameroon', 'IN', 'Guider', '7/6/2025', '8/23/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (121, 'Lilongwe International Airport', 'Dominican Republic', 'MN', 'Sabana Grande de Boyá', '3/17/2025', '1/10/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (122, 'Bol Airport', 'Czech Republic', 'TX', 'Údlice', '8/14/2025', '6/27/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (123, 'Comodoro D.R. Salomón Airport', 'Sweden', 'CT', 'Järfälla', '7/8/2025', '10/11/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (124, 'Goroka Airport', 'Czech Republic', 'MO', 'Vrbno pod Pradědem', '6/21/2025', '10/21/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (125, 'Space Coast Regional Airport', 'Costa Rica', 'MT', 'La Suiza', '8/4/2025', '1/22/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (126, 'Da Nang International Airport', 'United States', 'PA', 'Montgomery', '1/26/2025', '1/8/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (127, 'Inyati Airport', 'Malaysia', 'MO', 'Kuala Pilah', '4/2/2025', '5/1/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (128, 'Tri-County Regional Airport', 'Egypt', 'VA', 'Hihyā', '8/7/2025', '11/20/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (129, 'Telida Airport', 'China', 'MS', 'Zhongbao', '2/16/2025', '5/22/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (130, 'Venice Marco Polo Airport', 'Cuba', 'SC', 'Diez de Octubre', '10/25/2024', '1/13/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (131, 'Grand Central Airport', 'France', 'NY', 'Limoges', '12/25/2024', '10/22/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (132, 'Ceres Airport', 'China', 'IN', 'Zhongshan Donglu', '7/16/2025', '1/3/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (133, 'São Pedro Airport', 'French Polynesia', 'TX', 'Papeete', '4/10/2025', '7/20/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (134, 'São Jorge Airport', 'Brazil', 'NY', 'São Sebastião', '3/15/2025', '4/26/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (135, 'Santa Rosa Airport', 'China', 'OH', 'Hule', '10/9/2024', '8/7/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (136, 'London Luton Airport', 'Russia', 'CO', 'Privodino', '4/15/2025', '11/13/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (137, 'Nanuque Airport', 'Canada', 'OH', 'Kingsey Falls', '2/28/2025', '4/12/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (138, 'Kikori Airport', 'Swaziland', 'KS', 'Tshaneni', '11/14/2024', '4/16/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (139, 'Leron Plains Airport', 'France', 'FL', 'Montpellier', '11/7/2024', '4/16/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (140, 'Draughon Miller Central Texas Regional Airport', 'United Kingdom', 'MO', 'West End', '12/7/2024', '9/12/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (141, 'Courtenay Airpark', 'Brazil', 'NY', 'Jandira', '6/10/2025', '5/30/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (142, 'Maturín Airport', 'Brazil', 'IL', 'Pontalina', '6/19/2025', '5/2/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (143, 'Woja Airport', 'Ethiopia', 'IL', 'Bako', '4/27/2025', '9/4/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (144, 'Oombulgurri Airport', 'Portugal', 'TN', 'Pedro Miguel', '2/2/2025', '11/4/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (145, 'Merluna Airport', 'Russia', 'FL', 'Belogorsk', '11/3/2024', '6/26/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (146, 'Jacksonville Executive at Craig Airport', 'Philippines', 'AL', 'Amucao', '5/2/2025', '11/30/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (147, 'Annobón Airport', 'Sweden', 'KS', 'Hörby', '8/16/2025', '12/2/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (148, 'Malden Regional Airport', 'Yemen', 'ND', 'Ad Dīs ash Sharqīyah', '7/16/2025', '9/18/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (149, 'Rubem Berta Airport', 'Colombia', 'SC', 'Córdoba', '12/6/2024', '8/26/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (150, 'Shanghai Pudong International Airport', 'Mexico', 'FL', 'Los Pinos', '5/1/2025', '4/23/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (151, 'St. Lewis (Fox Harbour) Airport', 'El Salvador', 'OK', 'La Unión', '12/31/2024', '1/24/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (152, 'Annette Island Airport', 'Indonesia', 'CO', 'Madura', '8/11/2025', '5/1/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (153, 'Hope Bay Aerodrome', 'Indonesia', 'OH', 'Rancagadog', '12/29/2024', '9/30/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (154, 'Fergus Falls Municipal Airport - Einar Mickelson Field', 'China', 'FL', 'Huolianpo', '8/8/2025', '11/2/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (155, 'Svolvær Helle Airport', 'Indonesia', 'GA', 'Patemon', '1/13/2025', '1/4/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (156, 'Paris-Orly Airport', 'Brazil', 'ND', 'Ouro Preto do Oeste', '6/28/2025', '7/8/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (157, 'Kamphaeng Saen Airport', 'Russia', 'OH', 'Saskylakh', '8/28/2025', '11/26/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (158, 'Yeelirrie Airport', 'Philippines', 'IA', 'Dueñas', '1/25/2025', '1/12/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (159, 'Gordil Airport', 'Mexico', 'CA', 'Francisco Villa', '4/7/2025', '12/16/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (160, 'Mc Carthy Airport', 'Egypt', 'VA', 'Juhaynah', '11/2/2024', '11/30/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (161, 'Hokitika Airfield', 'Russia', 'CO', 'Batagay-Alyta', '11/12/2024', '6/15/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (162, 'Henderson Executive Airport', 'Mexico', 'NY', 'Manlio Fabio Altamirano', '6/14/2025', '1/6/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (163, 'Bao''anying Airport', 'Portugal', 'NC', 'Estribeiro', '4/29/2025', '11/16/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (164, 'Tauta Airport', 'China', 'MN', 'Pu’an', '12/26/2024', '10/15/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (165, 'Rutland Plains Airport', 'Russia', 'VA', 'Spitsevka', '10/27/2024', '12/4/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (166, 'Christmas Island Airport', 'Japan', 'LA', 'Ōfunato', '3/15/2025', '9/3/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (167, 'Monterrey Airport', 'Indonesia', 'TN', 'Koatas Lao', '5/6/2025', '7/14/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (168, 'Mungeranie Airport', 'Brazil', 'NY', 'Tobias Barreto', '10/27/2024', '9/23/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (169, 'Chippewa County International Airport', 'Thailand', 'RI', 'Kut Chap', '6/26/2025', '7/16/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (170, 'Maripasoula Airport', 'China', 'PA', 'Gengqing', '7/25/2025', '8/4/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (171, 'Mogador Airport', 'Mexico', 'VA', 'Independencia', '9/9/2025', '5/29/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (172, 'Dix-Sept Rosado Airport', 'Philippines', 'IL', 'Napuro', '6/7/2025', '4/8/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (173, 'La Tontouta International Airport', 'China', 'PA', 'Xiangride', '2/28/2025', '11/17/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (174, 'Telida Airport', 'China', 'NY', 'Jinping', '11/23/2024', '12/12/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (175, 'Grayling Airport', 'Guatemala', 'MN', 'Santa Clara La Laguna', '7/19/2025', '6/14/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (176, 'Cocos (Keeling) Islands Airport', 'Sweden', 'PA', 'Kiruna', '11/22/2024', '5/4/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (177, 'Reko Diq Airport', 'Japan', 'NY', 'Iwanuma', '8/25/2025', '8/16/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (178, 'Phoenix Goodyear Airport', 'Pakistan', 'VA', 'Chīchāwatni', '7/3/2025', '5/17/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (179, 'Fort Mackay / Firebag', 'China', 'CO', 'Jicun', '2/15/2025', '11/18/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (180, 'EuroAirport Basel-Mulhouse-Freiburg Airport', 'Sweden', 'KY', 'Vallentuna', '11/17/2024', '5/14/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (181, 'Kish International Airport', 'Czech Republic', 'AL', 'Čerčany', '7/29/2025', '1/31/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (182, 'Dorado Beach Airport', 'China', 'IL', 'Dalang', '6/23/2025', '12/3/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (183, 'Kiman Airport', 'Indonesia', 'KY', 'Atap', '2/10/2025', '3/3/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (184, 'Campo do Meio Airport', 'Venezuela', 'PA', 'Rubio', '11/8/2024', '6/9/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (185, 'King Abdulaziz Air Base', 'China', 'MI', 'Xindu', '2/7/2025', '2/27/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (186, 'Francisco B. Reyes Airport', 'Indonesia', 'MN', 'Kalapagenep', '7/12/2025', '12/12/2024');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (187, 'Omak Airport', 'Russia', 'DE', 'Nadvoitsy', '8/24/2025', '4/27/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (188, 'Pangsuma Airport', 'France', 'PA', 'Bobigny', '8/5/2025', '7/31/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (189, 'Milingimbi Airport', 'Peru', 'MN', 'Ccuntuma', '6/15/2025', '2/23/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (190, 'Marion Downs Airport', 'South Africa', 'CA', 'Klerksdorp', '5/19/2025', '6/1/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (191, 'Topeka Regional Airport - Forbes Field', 'China', 'FL', 'Shezhu', '8/8/2025', '2/22/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (192, 'Ramón Villeda Morales International Airport', 'China', 'FL', 'Wukou', '2/13/2025', '4/22/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (193, 'Menongue Airport', 'Philippines', 'PA', 'Lalig', '2/7/2025', '3/25/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (194, 'Imonda Airport', 'China', 'VA', 'Huaicheng', '12/24/2024', '8/7/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (195, 'Pemba Airport', 'Ukraine', 'NC', 'Lyubeshiv', '4/27/2025', '5/29/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (196, 'Boone Municipal Airport', 'Canada', 'MN', 'Princeville', '6/6/2025', '2/27/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (197, 'Sehonghong Airport', 'China', 'CA', 'Changsheng', '1/22/2025', '1/2/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (198, 'Roebourne Airport', 'Iraq', 'IL', '‘Anat al Qadīmah', '10/26/2024', '2/18/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (199, 'Moises R. Espinosa Airport', 'Indonesia', 'MO', 'Trasak', '6/25/2025', '6/12/2025');
insert into airport (airport_id, airport_name, country, state , city, created_at, updated_at) values (200, 'Quinhagak Airport', 'Finland', 'PA', 'Lappi', '4/14/2025', '2/17/2025');


insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (1, 'Jess', 'Strongman', '2/14/2025', 'Female', 'Slovenia', 'Ireland', '064202682', '7/17/2025', '1/29/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (2, 'Edgardo', 'Hawyes', '10/8/2024', 'Male', 'France', 'Indonesia', '101107080', '3/17/2025', '2/10/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (3, 'Hester', 'Wooler', '10/14/2024', 'Genderqueer', 'Indonesia', 'Portugal', '072413036', '2/19/2025', '12/30/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (4, 'Jayson', 'Mogg', '5/23/2025', 'Male', 'Indonesia', 'China', '113007835', '4/17/2025', '9/9/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (5, 'Xylina', 'Blewis', '9/26/2024', 'Bigender', 'Portugal', 'Burkina Faso', '221172610', '9/17/2025', '4/5/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (6, 'Ches', 'Moreside', '9/10/2025', 'Male', 'Russia', 'China', '101000077', '3/16/2025', '10/27/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (7, 'Ruby', 'Maddick', '2/19/2025', 'Male', 'Poland', 'Philippines', '082902757', '11/11/2024', '7/12/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (8, 'Donella', 'Cribbott', '1/22/2025', 'Female', 'Mexico', 'Mongolia', '103103642', '6/16/2025', '8/10/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (9, 'Lennie', 'Filisov', '6/18/2025', 'Male', 'Malaysia', 'China', '026011507', '1/17/2025', '10/12/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (10, 'Ginelle', 'Yanyushkin', '2/2/2025', 'Female', 'China', 'Czech Republic', '082000073', '3/18/2025', '3/20/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (11, 'Tammara', 'Featonby', '5/29/2025', 'Female', 'Thailand', 'Philippines', '053201885', '3/31/2025', '8/16/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (12, 'Linc', 'Tudhope', '1/19/2025', 'Male', 'United States', 'Indonesia', '122000658', '3/29/2025', '5/5/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (13, 'Breanne', 'Nigh', '1/12/2025', 'Female', 'Finland', 'Syria', '022000868', '6/3/2025', '4/26/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (14, 'Kasper', 'Rops', '1/11/2025', 'Male', 'Poland', 'China', '101101785', '7/12/2025', '4/15/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (15, 'Cornelius', 'Manton', '3/21/2025', 'Genderqueer', 'Argentina', 'Nigeria', '063013597', '1/19/2025', '7/30/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (16, 'Vanna', 'Berthon', '1/13/2025', 'Genderqueer', 'China', 'Japan', '321170538', '2/5/2025', '10/4/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (17, 'Lynea', 'Fido', '10/6/2024', 'Female', 'Indonesia', 'Iraq', '231372387', '12/28/2024', '5/25/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (18, 'Taddeusz', 'Reinhardt', '5/10/2025', 'Male', 'Chile', 'Philippines', '071002134', '6/28/2025', '6/25/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (19, 'Zebulen', 'Madgwick', '4/17/2025', 'Male', 'Poland', 'China', '091409597', '11/30/2024', '6/30/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (20, 'Winfield', 'Lytell', '11/25/2024', 'Male', 'Uganda', 'Palestinian Territory', '322270356', '5/11/2025', '6/10/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (21, 'Jud', 'Braizier', '10/26/2024', 'Male', 'China', 'Serbia', '091903844', '9/26/2024', '11/13/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (22, 'Ardella', 'Oughtright', '9/30/2024', 'Female', 'Indonesia', 'Portugal', '071921532', '2/11/2025', '4/2/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (23, 'Thorny', 'Sterman', '12/6/2024', 'Male', 'Greece', 'China', '073922885', '10/25/2024', '4/23/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (24, 'Grover', 'Ortega', '1/5/2025', 'Male', 'China', 'Pakistan', '043303447', '8/2/2025', '6/8/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (25, 'Carmine', 'Zaniolo', '1/26/2025', 'Female', 'Poland', 'Russia', '051402071', '9/22/2025', '6/3/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (26, 'Frieda', 'Cumming', '6/26/2025', 'Female', 'Philippines', 'Gambia', '031100908', '12/11/2024', '7/23/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (27, 'Derron', 'Rackam', '8/11/2025', 'Male', 'Mongolia', 'Iran', '031202084', '1/17/2025', '9/29/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (28, 'Mercedes', 'Bickley', '5/15/2025', 'Female', 'Philippines', 'Portugal', '091408297', '4/12/2025', '6/4/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (29, 'Kean', 'Dainter', '6/4/2025', 'Male', 'Albania', 'Latvia', '125008547', '7/24/2025', '12/28/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (30, 'Iorgos', 'Chippindall', '12/14/2024', 'Male', 'Poland', 'Thailand', '111903575', '11/26/2024', '8/24/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (31, 'Gabbey', 'Rawls', '4/23/2025', 'Bigender', 'France', 'Poland', '083901773', '11/16/2024', '3/31/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (32, 'Chloe', 'Corteney', '7/23/2025', 'Female', 'Mali', 'Ireland', '011201306', '9/2/2025', '1/16/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (33, 'Addie', 'Goter', '7/21/2025', 'Female', 'Russia', 'Russia', '042202264', '8/10/2025', '3/1/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (34, 'Rogers', 'Runge', '12/15/2024', 'Male', 'China', 'Yemen', '101108380', '2/15/2025', '1/8/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (35, 'Leroi', 'Mutter', '2/2/2025', 'Male', 'Portugal', 'Uruguay', '113102138', '4/25/2025', '5/26/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (36, 'Deena', 'Chichgar', '11/14/2024', 'Female', 'Colombia', 'France', '041202922', '5/15/2025', '10/8/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (37, 'Clarita', 'Kenworthey', '10/6/2024', 'Female', 'Brazil', 'Brazil', '253173661', '3/24/2025', '3/19/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (38, 'Roosevelt', 'Reihm', '2/24/2025', 'Male', 'Angola', 'France', '067006238', '6/9/2025', '10/5/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (39, 'Orion', 'Forty', '11/26/2024', 'Male', 'Indonesia', 'Mexico', '244172095', '4/9/2025', '7/16/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (40, 'Claudia', 'Pickavant', '11/11/2024', 'Female', 'Belarus', 'Indonesia', '073920874', '6/7/2025', '11/21/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (41, 'Lyn', 'Robbings', '11/23/2024', 'Female', 'China', 'Japan', '071901882', '9/12/2025', '6/6/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (42, 'Koenraad', 'Schwand', '3/12/2025', 'Male', 'Indonesia', 'Honduras', '123171955', '6/6/2025', '7/4/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (43, 'Kelsey', 'Ivanchenkov', '1/10/2025', 'Female', 'Armenia', 'Peru', '067014822', '9/30/2024', '8/30/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (44, 'Boothe', 'Teodori', '12/3/2024', 'Male', 'China', 'China', '221272332', '12/28/2024', '11/22/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (45, 'Averil', 'Parnall', '11/30/2024', 'Male', 'France', 'Portugal', '021301869', '11/8/2024', '11/3/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (46, 'Moses', 'Labden', '7/18/2025', 'Male', 'United Kingdom', 'South Korea', '221471094', '1/23/2025', '5/24/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (47, 'Berri', 'Chater', '11/18/2024', 'Female', 'France', 'Ukraine', '102102576', '9/23/2024', '1/28/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (48, 'Rhys', 'Joiner', '7/18/2025', 'Male', 'Zambia', 'France', '103101589', '5/2/2025', '7/24/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (49, 'Lulita', 'Margrett', '5/24/2025', 'Polygender', 'China', 'Niger', '107004695', '6/4/2025', '4/3/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (50, 'Vivi', 'Worral', '2/7/2025', 'Female', 'China', 'Indonesia', '253173661', '2/16/2025', '8/8/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (51, 'Daloris', 'Jaimez', '2/20/2025', 'Female', 'China', 'Colombia', '091409681', '1/31/2025', '11/18/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (52, 'Celle', 'Maffia', '3/24/2025', 'Female', 'Portugal', 'Philippines', '091310929', '12/2/2024', '12/18/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (53, 'Hedy', 'Kembry', '7/8/2025', 'Female', 'China', 'Finland', '041201936', '7/9/2025', '1/30/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (54, 'Katy', 'Vannuchi', '1/7/2025', 'Female', 'Canada', 'Russia', '071004378', '6/22/2025', '5/15/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (55, 'Lynn', 'Cardnell', '2/10/2025', 'Genderqueer', 'Egypt', 'Indonesia', '113009464', '12/12/2024', '2/24/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (56, 'Brose', 'Goodliff', '9/24/2024', 'Male', 'China', 'Colombia', '322281439', '9/3/2025', '3/12/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (57, 'Rosaleen', 'Le Breton De La Vieuville', '8/30/2025', 'Female', 'Nicaragua', 'Belarus', '075909903', '4/7/2025', '4/9/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (58, 'Levin', 'Rown', '3/3/2025', 'Male', 'Tanzania', 'China', '211170363', '5/5/2025', '6/7/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (59, 'Cass', 'Bretherick', '3/21/2025', 'Female', 'Costa Rica', 'Sweden', '226070364', '8/5/2025', '8/24/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (60, 'Gwen', 'Sayton', '6/12/2025', 'Female', 'Greece', 'Maldives', '104900349', '3/15/2025', '6/4/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (61, 'Izak', 'Dytham', '11/22/2024', 'Polygender', 'Cuba', 'Ukraine', '067092022', '11/10/2024', '1/18/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (62, 'Deedee', 'Western', '8/28/2025', 'Polygender', 'Brazil', 'United States', '107006651', '12/24/2024', '3/5/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (63, 'Rina', 'Kenwell', '9/16/2025', 'Female', 'Portugal', 'Georgia', '255072935', '1/12/2025', '11/24/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (64, 'Jacinda', 'Greschik', '2/8/2025', 'Female', 'Sweden', 'Greece', '114910565', '5/24/2025', '8/16/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (65, 'Iolande', 'St. Queintain', '1/5/2025', 'Female', 'Tanzania', 'Poland', '074900356', '10/12/2024', '3/11/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (66, 'Camellia', 'McWhorter', '1/18/2025', 'Female', 'Russia', 'Ethiopia', '102089644', '12/20/2024', '2/11/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (67, 'Panchito', 'Callam', '9/22/2025', 'Male', 'Nigeria', 'Japan', '081000032', '1/23/2025', '10/30/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (68, 'Delila', 'Worts', '8/1/2025', 'Female', 'China', 'Brazil', '065405381', '11/11/2024', '2/17/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (69, 'Dore', 'Ferrand', '8/24/2025', 'Female', 'Sweden', 'Russia', '113010547', '3/10/2025', '3/8/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (70, 'Hildegarde', 'Cyseley', '1/8/2025', 'Female', 'Togo', 'United States', '091304634', '7/27/2025', '9/8/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (71, 'Johnny', 'Kite', '11/17/2024', 'Male', 'Ukraine', 'Russia', '321181271', '8/9/2025', '8/2/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (72, 'Ray', 'Lintin', '8/22/2025', 'Female', 'Indonesia', 'Argentina', '081518469', '10/23/2024', '7/2/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (73, 'Mendy', 'Kittel', '5/19/2025', 'Male', 'France', 'France', '051000101', '8/19/2025', '5/10/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (74, 'Clementia', 'Vicar', '5/30/2025', 'Female', 'Ukraine', 'China', '111310841', '1/20/2025', '4/11/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (75, 'Caron', 'Ghelardoni', '7/16/2025', 'Female', 'Ukraine', 'China', '031317636', '5/3/2025', '9/3/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (76, 'Antons', 'Addey', '4/5/2025', 'Male', 'Kazakhstan', 'Cyprus', '072404841', '7/19/2025', '4/14/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (77, 'Fulton', 'Seeger', '5/7/2025', 'Polygender', 'Canada', 'Indonesia', '104902062', '11/17/2024', '3/16/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (78, 'Brad', 'Simester', '8/3/2025', 'Male', 'Morocco', 'Philippines', '081914775', '4/8/2025', '4/3/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (79, 'Gisela', 'Athridge', '10/15/2024', 'Female', 'Venezuela', 'Thailand', '211870977', '12/28/2024', '8/28/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (80, 'Teodoor', 'Hewes', '4/13/2025', 'Male', 'Greece', 'Japan', '091203942', '3/27/2025', '12/9/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (81, 'Davon', 'Fisher', '8/2/2025', 'Male', 'Poland', 'Mexico', '071002134', '2/22/2025', '9/9/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (82, 'Marian', 'Glendenning', '3/16/2025', 'Female', 'China', 'Netherlands', '051502434', '2/6/2025', '6/23/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (83, 'Madeline', 'Hamber', '7/24/2025', 'Female', 'Nigeria', 'Nigeria', '102302761', '8/10/2025', '6/7/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (84, 'Bendix', 'Dartan', '7/11/2025', 'Male', 'Peru', 'Uganda', '121142148', '6/14/2025', '11/15/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (85, 'Nadiya', 'Ubsdall', '2/6/2025', 'Female', 'Ecuador', 'Argentina', '107006651', '10/28/2024', '7/8/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (86, 'Horatio', 'Labes', '1/1/2025', 'Male', 'Philippines', 'Portugal', '071911652', '7/20/2025', '12/14/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (87, 'Arly', 'Wharin', '10/14/2024', 'Female', 'China', 'Japan', '104900459', '2/9/2025', '2/8/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (88, 'Kimball', 'Callacher', '2/27/2025', 'Male', 'Honduras', 'France', '113105452', '12/23/2024', '10/2/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (89, 'Babb', 'Lippett', '7/11/2025', 'Female', 'Brazil', 'Indonesia', '063206663', '1/21/2025', '3/20/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (90, 'Durante', 'Jurisic', '7/22/2025', 'Male', 'Belarus', 'Portugal', '051404260', '5/12/2025', '8/26/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (91, 'Emalia', 'Petworth', '4/9/2025', 'Female', 'Brazil', 'Portugal', '101001283', '12/23/2024', '9/10/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (92, 'Arlen', 'Hutsby', '5/31/2025', 'Female', 'Indonesia', 'France', '071103473', '11/25/2024', '4/2/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (93, 'Levi', 'Blakeston', '10/10/2024', 'Male', 'Portugal', 'Czech Republic', '113124637', '1/4/2025', '2/28/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (94, 'Walker', 'Vint', '7/14/2025', 'Agender', 'Russia', 'Pakistan', '053112631', '6/1/2025', '12/22/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (95, 'Tawsha', 'Hubatsch', '8/22/2025', 'Female', 'Colombia', 'China', '091915133', '11/7/2024', '8/21/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (96, 'Arel', 'Minkin', '1/8/2025', 'Male', 'Philippines', 'China', '263184996', '10/14/2024', '8/4/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (97, 'Emilee', 'Milsted', '9/6/2025', 'Female', 'France', 'Poland', '323270300', '6/19/2025', '11/22/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (98, 'Rina', 'Lace', '4/15/2025', 'Female', 'Guinea', 'Afghanistan', '064206031', '10/23/2024', '1/29/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (99, 'Demetri', 'Wharfe', '10/21/2024', 'Male', 'Indonesia', 'France', '083900680', '11/2/2024', '1/20/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (100, 'Arvy', 'Quinell', '6/10/2025', 'Male', 'Philippines', 'Indonesia', '114017714', '9/27/2024', '6/12/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (101, 'Ahmed', 'Claiden', '8/1/2025', 'Male', 'China', 'Indonesia', '125200057', '7/2/2025', '8/30/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (102, 'Forest', 'Prise', '4/22/2025', 'Male', 'Japan', 'China', '067003671', '6/4/2025', '9/23/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (103, 'Ari', 'Gundry', '7/21/2025', 'Male', 'Finland', 'Gambia', '123203878', '10/15/2024', '9/11/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (104, 'Ranice', 'Philp', '7/5/2025', 'Female', 'Sweden', 'Croatia', '064109264', '4/24/2025', '5/12/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (105, 'Junia', 'Stoeckle', '9/4/2025', 'Female', 'France', 'Guatemala', '122037841', '2/25/2025', '11/10/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (106, 'Bar', 'Conkling', '7/20/2025', 'Male', 'France', 'Morocco', '031301998', '5/15/2025', '11/26/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (107, 'Heloise', 'Seeborne', '7/10/2025', 'Female', 'Dominican Republic', 'Mongolia', '111924392', '11/27/2024', '3/1/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (108, 'Caryl', 'Cundey', '2/13/2025', 'Female', 'Czech Republic', 'Poland', '052000618', '11/17/2024', '12/30/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (109, 'Aimee', 'Scutter', '11/12/2024', 'Female', 'Portugal', 'France', '091305044', '12/9/2024', '5/11/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (110, 'Brennen', 'Teligin', '4/3/2025', 'Male', 'China', 'Indonesia', '071200538', '3/19/2025', '6/1/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (111, 'Buck', 'Rockey', '8/25/2025', 'Male', 'China', 'Armenia', '101115111', '5/11/2025', '3/10/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (112, 'Abrahan', 'Newbury', '10/1/2024', 'Male', 'Malta', 'Kazakhstan', '121000248', '7/30/2025', '6/8/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (113, 'Gabbi', 'Casson', '2/20/2025', 'Non-binary', 'China', 'United States', '011601074', '8/30/2025', '9/5/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (114, 'Katie', 'Buttwell', '11/16/2024', 'Bigender', 'China', 'Portugal', '063113772', '4/26/2025', '7/18/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (115, 'Dani', 'Dumbrall', '11/3/2024', 'Male', 'Philippines', 'Poland', '111304404', '10/9/2024', '4/4/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (116, 'Hakim', 'Benini', '3/13/2025', 'Male', 'Russia', 'Brazil', '031000024', '12/24/2024', '10/24/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (117, 'Leann', 'Carass', '7/23/2025', 'Genderfluid', 'Sweden', 'Vietnam', '114017714', '6/26/2025', '4/30/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (118, 'Carolyn', 'Harring', '3/23/2025', 'Bigender', 'Nigeria', 'Slovenia', '262285184', '6/4/2025', '4/1/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (119, 'Jamie', 'Croley', '8/13/2025', 'Polygender', 'Nepal', 'Poland', '221971293', '8/26/2025', '11/21/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (120, 'Vic', 'Crane', '7/1/2025', 'Male', 'Indonesia', 'China', '081005794', '8/31/2025', '5/1/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (121, 'Tyler', 'Hember', '10/21/2024', 'Male', 'Russia', 'Czech Republic', '101102182', '5/30/2025', '11/12/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (122, 'Conny', 'Kear', '10/3/2024', 'Female', 'Brazil', 'Tanzania', '053274139', '7/19/2025', '11/9/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (123, 'Ursuline', 'Bretelle', '7/25/2025', 'Female', 'Portugal', 'Indonesia', '067012921', '9/20/2025', '3/20/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (124, 'Margie', 'MacFayden', '5/23/2025', 'Female', 'China', 'Kosovo', '074912849', '12/12/2024', '12/20/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (125, 'Sheffield', 'Balston', '6/4/2025', 'Male', 'Germany', 'Panama', '123171955', '2/18/2025', '12/28/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (126, 'Kinny', 'Cotelard', '3/3/2025', 'Male', 'Japan', 'China', '122106219', '8/6/2025', '2/16/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (127, 'Rubie', 'Northcott', '4/21/2025', 'Female', 'China', 'Brazil', '111316887', '12/30/2024', '1/21/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (128, 'Arlina', 'Trayhorn', '12/18/2024', 'Non-binary', 'France', 'Poland', '061308770', '12/15/2024', '12/1/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (129, 'Danielle', 'Teresia', '6/28/2025', 'Polygender', 'United States', 'Indonesia', '267090691', '11/21/2024', '8/22/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (130, 'Olag', 'Orris', '2/22/2025', 'Non-binary', 'Serbia', 'Portugal', '051403915', '1/31/2025', '4/18/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (131, 'Eustacia', 'Arthars', '10/20/2024', 'Female', 'Cameroon', 'Russia', '011304517', '3/21/2025', '4/27/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (132, 'Kaspar', 'Nabbs', '6/16/2025', 'Male', 'Greece', 'France', '071925130', '5/4/2025', '2/6/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (133, 'Reinaldos', 'Bewley', '9/27/2024', 'Agender', 'Brazil', 'Czech Republic', '061208126', '10/8/2024', '5/19/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (134, 'Kingston', 'Olman', '10/4/2024', 'Male', 'Japan', 'Indonesia', '026007508', '3/17/2025', '4/22/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (135, 'Lyn', 'Ainscow', '4/12/2025', 'Male', 'Poland', 'Philippines', '125107532', '11/22/2024', '7/16/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (136, 'Anna-maria', 'Housecroft', '10/19/2024', 'Female', 'South Korea', 'Argentina', '041207150', '3/26/2025', '7/22/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (137, 'Bendicty', 'Cassy', '1/15/2025', 'Male', 'Russia', 'Serbia', '211371201', '9/6/2025', '10/23/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (138, 'Domeniga', 'Benny', '1/29/2025', 'Female', 'Philippines', 'Nigeria', '271989756', '7/28/2025', '5/9/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (139, 'Davy', 'Panyer', '2/23/2025', 'Male', 'Russia', 'Philippines', '111918230', '7/20/2025', '10/26/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (140, 'Kenton', 'Andrejevic', '11/5/2024', 'Bigender', 'Thailand', 'Uganda', '091000019', '11/11/2024', '9/10/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (141, 'Rustie', 'Semple', '4/3/2025', 'Male', 'Brazil', 'Egypt', '053111836', '2/13/2025', '9/13/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (142, 'Wylma', 'Boulton', '8/17/2025', 'Female', 'Tunisia', 'Indonesia', '063104215', '7/1/2025', '11/8/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (143, 'Reg', 'Barniss', '6/18/2025', 'Male', 'Ireland', 'Philippines', '071905985', '8/15/2025', '1/31/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (144, 'Livvie', 'David', '3/2/2025', 'Female', 'China', 'Sweden', '083901100', '9/12/2025', '7/22/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (145, 'Darrell', 'Jewise', '6/7/2025', 'Male', 'Vietnam', 'Portugal', '091406833', '7/14/2025', '4/16/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (146, 'Trula', 'Lyte', '7/27/2025', 'Female', 'Portugal', 'Russia', '122243457', '10/17/2024', '1/11/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (147, 'Georgette', 'Maldin', '2/6/2025', 'Female', 'Central African Republic', 'France', '072413133', '11/25/2024', '12/19/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (148, 'Elliott', 'Basili', '3/9/2025', 'Male', 'Cuba', 'Brazil', '291270636', '1/31/2025', '12/13/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (149, 'Alayne', 'Levee', '11/7/2024', 'Female', 'Vietnam', 'Portugal', '122240340', '7/16/2025', '4/26/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (150, 'Deborah', 'Simner', '4/5/2025', 'Female', 'Indonesia', 'Azerbaijan', '107003612', '1/16/2025', '12/23/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (151, 'Pammy', 'Woolforde', '2/22/2025', 'Female', 'China', 'Indonesia', '043304239', '9/30/2024', '11/25/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (152, 'Tedie', 'Borsi', '5/14/2025', 'Male', 'China', 'Tunisia', '091108746', '6/3/2025', '3/3/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (153, 'Bobina', 'Pudner', '8/24/2025', 'Genderfluid', 'Philippines', 'Indonesia', '065303920', '2/13/2025', '7/11/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (154, 'Marcie', 'Arnold', '11/29/2024', 'Female', 'Bosnia and Herzegovina', 'Indonesia', '072408708', '6/8/2025', '3/6/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (155, 'Jobye', 'Zottoli', '3/3/2025', 'Female', 'Sweden', 'Tunisia', '031100047', '10/22/2024', '2/12/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (156, 'Kenyon', 'Halliwell', '3/7/2025', 'Male', 'Sweden', 'Russia', '075902573', '9/30/2024', '11/22/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (157, 'Kalvin', 'Ledrun', '9/20/2025', 'Male', 'Russia', 'Poland', '082907464', '10/28/2024', '1/6/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (158, 'Creigh', 'Guiton', '5/23/2025', 'Male', 'Indonesia', 'Sweden', '307074098', '8/22/2025', '5/22/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (159, 'Olympie', 'Cund', '11/8/2024', 'Female', 'Venezuela', 'Armenia', '075906142', '10/1/2024', '6/27/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (160, 'Clea', 'Wormell', '5/27/2025', 'Polygender', 'China', 'France', '301271790', '2/13/2025', '7/19/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (161, 'Anna-maria', 'Hussell', '9/1/2025', 'Female', 'China', 'Russia', '091501204', '7/1/2025', '3/20/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (162, 'Rebekah', 'Pointon', '2/7/2025', 'Non-binary', 'Costa Rica', 'Thailand', '241070459', '5/6/2025', '5/18/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (163, 'Johan', 'Lowres', '11/14/2024', 'Male', 'Iran', 'China', '064209177', '3/14/2025', '2/11/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (164, 'Juli', 'Huckerbe', '5/30/2025', 'Female', 'China', 'South Korea', '122244731', '8/11/2025', '4/23/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (165, 'Michel', 'Keam', '9/29/2024', 'Male', 'Indonesia', 'Slovenia', '044115760', '8/17/2025', '12/22/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (166, 'Clevey', 'Colnett', '9/22/2025', 'Male', 'Slovenia', 'China', '062203298', '3/9/2025', '5/21/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (167, 'Emmanuel', 'Kleinsinger', '12/21/2024', 'Bigender', 'Germany', 'Brazil', '067092035', '5/11/2025', '6/14/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (168, 'Jarrad', 'Kitteman', '3/14/2025', 'Male', 'Japan', 'Belarus', '065301540', '3/23/2025', '9/23/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (169, 'Gael', 'Castilljo', '3/3/2025', 'Male', 'Indonesia', 'South Africa', '065002289', '5/24/2025', '11/22/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (170, 'Nevile', 'Dimic', '9/13/2025', 'Male', 'Brunei', 'China', '051403041', '7/17/2025', '7/30/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (171, 'Stephani', 'Fantin', '1/2/2025', 'Female', 'Saudi Arabia', 'France', '071004420', '10/18/2024', '8/29/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (172, 'Ulysses', 'Babe', '1/10/2025', 'Male', 'United Kingdom', 'China', '107006305', '1/22/2025', '6/11/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (173, 'Mozes', 'Belly', '7/30/2025', 'Male', 'Poland', 'Dominican Republic', '111907827', '7/16/2025', '7/21/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (174, 'Neils', 'Sturge', '5/1/2025', 'Male', 'Afghanistan', 'Poland', '111322570', '10/20/2024', '11/13/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (175, 'Tull', 'Derrick', '6/5/2025', 'Genderqueer', 'Greece', 'China', '071101174', '12/23/2024', '4/1/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (176, 'Lil', 'Petrushanko', '10/16/2024', 'Female', 'Russia', 'Russia', '064207771', '10/12/2024', '11/6/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (177, 'Philippine', 'Olliar', '7/2/2025', 'Female', 'Ireland', 'Myanmar', '082907888', '9/20/2025', '5/23/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (178, 'Natal', 'Milmo', '5/12/2025', 'Male', 'Poland', 'China', '065403626', '1/15/2025', '12/1/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (179, 'Glenna', 'enzley', '11/5/2024', 'Female', 'Indonesia', 'Japan', '323271493', '7/3/2025', '8/2/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (180, 'Jewel', 'McElrath', '11/9/2024', 'Female', 'China', 'France', '061104518', '5/6/2025', '3/20/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (181, 'Maureene', 'Gohier', '8/9/2025', 'Female', 'Poland', 'France', '082906494', '2/15/2025', '6/30/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (182, 'Dougy', 'Coomber', '9/5/2025', 'Male', 'China', 'Serbia', '072413858', '12/8/2024', '12/8/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (183, 'Jasmine', 'Skeggs', '11/18/2024', 'Female', 'France', 'Jamaica', '301271787', '5/21/2025', '1/24/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (184, 'Kacie', 'Bremond', '12/31/2024', 'Female', 'China', 'Colombia', '261170740', '1/4/2025', '3/23/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (185, 'Alvy', 'Plank', '6/19/2025', 'Genderfluid', 'Guam', 'Albania', '062005690', '10/19/2024', '4/14/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (186, 'Jayne', 'Bratcher', '2/13/2025', 'Female', 'Russia', 'Indonesia', '121142834', '5/11/2025', '4/1/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (187, 'Floris', 'Gives', '1/18/2025', 'Female', 'Jordan', 'China', '074907126', '7/23/2025', '7/24/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (188, 'Tiphanie', 'Simmen', '5/7/2025', 'Female', 'Indonesia', 'Nicaragua', '083902316', '8/27/2025', '9/20/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (189, 'Jamima', 'Beaten', '6/6/2025', 'Female', 'Indonesia', 'Egypt', '053003931', '8/17/2025', '1/17/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (190, 'Nikolos', 'Gile', '7/23/2025', 'Male', 'China', 'Brazil', '071925156', '8/17/2025', '1/24/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (191, 'Malva', 'Sydney', '11/14/2024', 'Female', 'Indonesia', 'Portugal', '021000322', '6/2/2025', '12/20/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (192, 'Augustine', 'Esplin', '12/4/2024', 'Female', 'Greece', 'Philippines', '063108732', '4/6/2025', '7/12/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (193, 'Emelia', 'Bolstridge', '6/16/2025', 'Female', 'Indonesia', 'Portugal', '021004823', '4/27/2025', '9/8/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (194, 'Rochell', 'Cridlan', '2/22/2025', 'Female', 'Indonesia', 'China', '073921132', '3/26/2025', '3/8/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (195, 'Gerri', 'Butters', '3/6/2025', 'Male', 'Russia', 'Honduras', '111315794', '1/31/2025', '12/18/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (196, 'Cynthie', 'Sent', '10/13/2024', 'Bigender', 'United States', 'China', '064102601', '8/20/2025', '12/22/2024');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (197, 'Dido', 'Pittway', '9/4/2025', 'Female', 'France', 'Palestinian Territory', '322070019', '2/11/2025', '4/8/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (198, 'Reynard', 'Harbin', '10/5/2024', 'Male', 'Canada', 'Brazil', '065204760', '2/16/2025', '5/10/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (199, 'Milena', 'Seyfart', '5/22/2025', 'Female', 'China', 'Philippines', '043400036', '5/4/2025', '8/26/2025');
insert into passengers (passenger_id, first_name, last_name, date_of_birth, gender, country_of_citizenship, country_of_residence, passport_number, created_at, updated_at) values (200, 'Lari', 'Duncombe', '12/3/2024', 'Female', 'Peru', 'China', '121140742', '5/2/2025', '8/29/2025');

ALTER TABLE security_check
ALTER COLUMN check_result TYPE VARCHAR(150);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (1, 'eros', '4/22/2025', '9/30/2024', 1);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (2, 'proin at', '12/23/2024', '8/12/2025', 2);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (3, 'at turpis', '6/16/2025', '12/21/2024', 3);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (4, 'id', '6/21/2025', '8/18/2025', 4);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (5, 'potenti', '10/3/2024', '1/18/2025', 5);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (6, 'sapien', '5/31/2025', '10/1/2024', 6);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (7, 'quisque erat', '1/27/2025', '5/31/2025', 7);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (8, 'rutrum', '9/30/2024', '2/6/2025', 8);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (9, 'suscipit', '3/6/2025', '9/24/2024', 9);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (10, 'id', '3/22/2025', '11/11/2024', 10);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (11, 'dui nec', '10/14/2024', '12/13/2024', 11);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (12, 'tellus in', '8/19/2025', '10/26/2024', 12);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (13, 'aenean', '8/14/2025', '9/22/2025', 13);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (14, 'velit nec', '5/19/2025', '11/15/2024', 14);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (15, 'ipsum', '6/13/2025', '6/14/2025', 15);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (16, 'quisque erat', '7/31/2025', '11/3/2024', 16);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (17, 'consectetuer', '4/19/2025', '5/24/2025', 17);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (18, 'nisi', '7/15/2025', '1/22/2025', 18);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (19, 'nulla suscipit', '3/29/2025', '5/25/2025', 19);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (20, 'tortor quis', '12/17/2024', '8/28/2025', 20);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (21, 'urna ut', '3/7/2025', '9/16/2025', 21);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (22, 'magna vulputate', '2/10/2025', '4/13/2025', 22);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (23, 'orci mauris', '6/23/2025', '11/30/2024', 23);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (24, 'dictumst etiam', '2/16/2025', '6/10/2025', 24);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (25, 'aenean', '4/30/2025', '3/21/2025', 25);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (26, 'laoreet ut', '5/26/2025', '3/16/2025', 26);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (27, 'vestibulum ac', '1/13/2025', '2/21/2025', 27);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (28, 'ipsum dolor', '8/27/2025', '3/19/2025', 28);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (29, 'sem', '12/8/2024', '6/12/2025', 29);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (30, 'aliquam', '8/19/2025', '12/1/2024', 30);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (31, 'tortor sollicitudin', '7/14/2025', '12/28/2024', 31);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (32, 'convallis nulla', '1/23/2025', '4/11/2025', 32);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (33, 'molestie hendrerit', '2/27/2025', '6/3/2025', 33);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (34, 'ullamcorper augue', '5/28/2025', '1/11/2025', 34);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (35, 'donec odio', '7/19/2025', '12/12/2024', 35);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (36, 'hac habitasse', '4/24/2025', '6/21/2025', 36);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (37, 'lobortis', '5/27/2025', '12/9/2024', 37);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (38, 'in tempor', '9/23/2024', '6/7/2025', 38);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (39, 'nunc', '5/17/2025', '11/11/2024', 39);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (40, 'risus', '1/12/2025', '6/17/2025', 40);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (41, 'venenatis', '12/3/2024', '11/13/2024', 41);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (42, 'diam in', '7/10/2025', '2/10/2025', 42);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (43, 'curae', '9/18/2025', '7/13/2025', 43);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (44, 'erat eros', '2/7/2025', '12/8/2024', 44);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (45, 'lacus morbi', '3/15/2025', '6/15/2025', 45);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (46, 'dictumst', '9/30/2024', '7/31/2025', 46);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (47, 'dui', '4/22/2025', '9/22/2025', 47);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (48, 'ligula nec', '12/11/2024', '7/1/2025', 48);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (49, 'pede', '8/29/2025', '6/22/2025', 49);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (50, 'vulputate ut', '7/7/2025', '12/15/2024', 50);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (51, 'eget tincidunt', '6/27/2025', '10/26/2024', 51);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (52, 'tortor sollicitudin', '1/2/2025', '5/15/2025', 52);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (53, 'ipsum dolor', '10/21/2024', '2/5/2025', 53);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (54, 'sit amet', '2/21/2025', '1/17/2025', 54);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (55, 'turpis', '1/31/2025', '1/19/2025', 55);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (56, 'nulla', '2/21/2025', '10/27/2024', 56);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (57, 'nisl', '2/25/2025', '1/9/2025', 57);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (58, 'egestas', '3/14/2025', '10/28/2024', 58);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (59, 'purus phasellus', '11/5/2024', '11/5/2024', 59);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (60, 'ac nibh', '2/27/2025', '11/13/2024', 60);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (61, 'pretium nisl', '11/28/2024', '9/28/2024', 61);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (62, 'amet justo', '3/28/2025', '7/18/2025', 62);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (63, 'sit', '10/24/2024', '4/23/2025', 63);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (64, 'interdum venenatis', '1/21/2025', '12/19/2024', 64);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (65, 'nascetur', '6/25/2025', '8/5/2025', 65);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (66, 'pellentesque viverra', '8/9/2025', '8/17/2025', 66);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (67, 'leo', '2/20/2025', '2/2/2025', 67);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (68, 'consequat', '7/14/2025', '6/14/2025', 68);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (69, 'ornare imperdiet', '9/4/2025', '10/24/2024', 69);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (70, 'donec vitae', '6/6/2025', '11/4/2024', 70);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (71, 'sapien', '2/1/2025', '7/31/2025', 71);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (72, 'turpis donec', '11/30/2024', '12/24/2024', 72);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (73, 'neque', '6/11/2025', '12/12/2024', 73);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (74, 'et magnis', '12/18/2024', '10/17/2024', 74);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (75, 'hac habitasse', '3/24/2025', '4/30/2025', 75);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (76, 'velit id', '8/15/2025', '10/28/2024', 76);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (77, 'fermentum', '8/9/2025', '6/27/2025', 77);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (78, 'eget', '7/16/2025', '1/27/2025', 78);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (79, 'semper est', '3/31/2025', '3/18/2025', 79);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (80, 'erat', '3/18/2025', '2/15/2025', 80);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (81, 'odio', '8/1/2025', '7/27/2025', 81);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (82, 'rhoncus aliquet', '6/23/2025', '3/12/2025', 82);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (83, 'sollicitudin', '9/30/2024', '2/23/2025', 83);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (84, 'quis', '11/1/2024', '10/30/2024', 84);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (85, 'diam', '3/27/2025', '8/14/2025', 85);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (86, 'euismod', '4/21/2025', '9/5/2025', 86);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (87, 'pede malesuada', '12/21/2024', '3/1/2025', 87);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (88, 'etiam pretium', '8/23/2025', '3/6/2025', 88);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (89, 'luctus', '12/9/2024', '10/22/2024', 89);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (90, 'sem', '4/9/2025', '3/23/2025', 90);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (91, 'ut erat', '6/26/2025', '9/20/2025', 91);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (92, 'habitasse platea', '1/24/2025', '10/28/2024', 92);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (93, 'sapien', '5/24/2025', '7/5/2025', 93);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (94, 'donec posuere', '12/2/2024', '3/19/2025', 94);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (95, 'luctus ultricies', '12/2/2024', '2/1/2025', 95);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (96, 'pede', '8/25/2025', '6/9/2025', 96);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (97, 'sit', '4/27/2025', '4/4/2025', 97);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (98, 'donec posuere', '5/13/2025', '10/20/2024', 98);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (99, 'cras', '6/14/2025', '7/5/2025', 99);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (100, 'magnis dis', '3/16/2025', '5/1/2025', 100);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (101, 'ac lobortis', '12/27/2024', '12/17/2024', 101);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (102, 'ac nibh', '12/24/2024', '10/1/2024', 102);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (103, 'tempor', '8/13/2025', '2/17/2025', 103);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (104, 'hac', '6/28/2025', '8/24/2025', 104);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (105, 'pellentesque ultrices', '4/14/2025', '11/2/2024', 105);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (106, 'dolor morbi', '9/7/2025', '7/25/2025', 106);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (107, 'libero rutrum', '4/29/2025', '10/24/2024', 107);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (108, 'eget rutrum', '3/9/2025', '6/7/2025', 108);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (109, 'venenatis', '5/16/2025', '1/1/2025', 109);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (110, 'vulputate', '3/16/2025', '3/18/2025', 110);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (111, 'enim blandit', '7/7/2025', '12/14/2024', 111);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (112, 'quisque arcu', '8/25/2025', '11/21/2024', 112);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (113, 'elementum ligula', '2/18/2025', '1/26/2025', 113);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (114, 'porta volutpat', '9/1/2025', '6/6/2025', 114);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (115, 'nullam', '9/15/2025', '4/19/2025', 115);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (116, 'amet diam', '12/12/2024', '7/24/2025', 116);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (117, 'ac', '2/24/2025', '4/12/2025', 117);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (118, 'mi pede', '1/12/2025', '5/9/2025', 118);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (119, 'sit', '1/8/2025', '10/22/2024', 119);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (120, 'sit amet', '2/8/2025', '9/20/2025', 120);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (121, 'auctor gravida', '4/5/2025', '5/28/2025', 121);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (122, 'posuere', '4/17/2025', '4/14/2025', 122);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (123, 'non', '4/12/2025', '8/10/2025', 123);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (124, 'sapien', '4/3/2025', '2/13/2025', 124);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (125, 'ultrices', '11/2/2024', '2/12/2025', 125);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (126, 'justo', '10/16/2024', '1/27/2025', 126);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (127, 'in', '11/19/2024', '10/10/2024', 127);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (128, 'cursus', '4/3/2025', '10/30/2024', 128);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (129, 'nullam', '1/10/2025', '10/2/2024', 129);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (130, 'ac', '11/2/2024', '9/12/2025', 130);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (131, 'et', '5/28/2025', '12/28/2024', 131);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (132, 'tincidunt', '7/23/2025', '1/28/2025', 132);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (133, 'auctor gravida', '1/20/2025', '8/7/2025', 133);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (134, 'vulputate', '9/4/2025', '3/26/2025', 134);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (135, 'pellentesque', '8/7/2025', '7/31/2025', 135);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (136, 'quis', '10/28/2024', '9/18/2025', 136);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (137, 'viverra', '8/8/2025', '7/10/2025', 137);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (138, 'a odio', '9/30/2024', '1/20/2025', 138);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (139, 'pede ullamcorper', '12/20/2024', '9/8/2025', 139);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (140, 'proin eu', '2/14/2025', '8/21/2025', 140);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (141, 'sit', '5/7/2025', '4/7/2025', 141);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (142, 'mus', '2/2/2025', '4/11/2025', 142);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (143, 'sapien', '11/25/2024', '4/14/2025', 143);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (144, 'praesent', '10/1/2024', '1/3/2025', 144);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (145, 'ultricies eu', '3/3/2025', '10/30/2024', 145);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (146, 'ante vestibulum', '3/1/2025', '2/20/2025', 146);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (147, 'porttitor id', '10/10/2024', '10/12/2024', 147);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (148, 'iaculis diam', '8/31/2025', '1/8/2025', 148);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (149, 'enim blandit', '6/20/2025', '11/23/2024', 149);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (150, 'ut nunc', '11/2/2024', '9/30/2024', 150);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (151, 'a', '1/11/2025', '1/6/2025', 151);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (152, 'quisque ut', '8/10/2025', '6/8/2025', 152);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (153, 'mauris eget', '2/27/2025', '1/21/2025', 153);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (154, 'sapien', '2/2/2025', '1/26/2025', 154);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (155, 'sem', '4/21/2025', '7/22/2025', 155);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (156, 'in imperdiet', '6/30/2025', '1/11/2025', 156);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (157, 'enim', '10/14/2024', '12/13/2024', 157);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (158, 'imperdiet', '2/28/2025', '8/10/2025', 158);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (159, 'potenti', '3/22/2025', '1/22/2025', 159);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (160, 'cum', '10/12/2024', '11/3/2024', 160);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (161, 'proin', '7/22/2025', '11/16/2024', 161);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (162, 'accumsan', '8/29/2025', '3/30/2025', 162);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (163, 'posuere', '10/30/2024', '7/15/2025', 163);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (164, 'mauris', '10/27/2024', '1/3/2025', 164);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (165, 'aliquam', '8/26/2025', '3/15/2025', 165);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (166, 'cursus urna', '10/25/2024', '1/24/2025', 166);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (167, 'donec', '2/7/2025', '8/26/2025', 167);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (168, 'tincidunt lacus', '10/6/2024', '7/27/2025', 168);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (169, 'posuere', '9/15/2025', '2/12/2025', 169);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (170, 'vestibulum ante', '10/11/2024', '1/10/2025', 170);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (171, 'nec', '3/4/2025', '11/16/2024', 171);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (172, 'ultrices', '7/24/2025', '4/13/2025', 172);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (173, 'eros', '7/17/2025', '10/5/2024', 173);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (174, 'magnis', '7/26/2025', '1/6/2025', 174);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (175, 'neque aenean', '8/1/2025', '9/27/2024', 175);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (176, 'vel enim', '3/11/2025', '5/8/2025', 176);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (177, 'curae donec', '9/29/2024', '2/14/2025', 177);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (178, 'ante', '12/21/2024', '2/26/2025', 178);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (179, 'nam tristique', '5/16/2025', '10/30/2024', 179);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (180, 'posuere', '8/7/2025', '1/8/2025', 180);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (181, 'lorem', '2/24/2025', '11/15/2024', 181);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (182, 'quisque ut', '11/14/2024', '11/14/2024', 182);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (183, 'posuere', '6/12/2025', '7/16/2025', 183);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (184, 'ut blandit', '10/4/2024', '1/12/2025', 184);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (185, 'eget', '10/24/2024', '9/12/2025', 185);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (186, 'luctus', '5/5/2025', '9/9/2025', 186);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (187, 'turpis integer', '4/17/2025', '11/4/2024', 187);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (188, 'praesent blandit', '2/22/2025', '11/6/2024', 188);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (189, 'dapibus nulla', '8/29/2025', '12/22/2024', 189);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (190, 'magna vestibulum', '1/23/2025', '11/22/2024', 190);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (191, 'congue', '12/14/2024', '10/5/2024', 191);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (192, 'vel augue', '5/7/2025', '3/29/2025', 192);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (193, 'tempus', '4/18/2025', '6/3/2025', 193);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (194, 'tortor', '5/7/2025', '1/15/2025', 194);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (195, 'in', '12/2/2024', '7/24/2025', 195);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (196, 'maecenas leo', '10/7/2024', '12/20/2024', 196);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (197, 'leo rhoncus', '10/10/2024', '6/19/2025', 197);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (198, 'pellentesque', '4/3/2025', '12/1/2024', 198);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (199, 'montes', '7/21/2025', '12/25/2024', 199);
insert into security_check (security_check_id, check_result, created_at, updated_at, passenger_id) values (200, 'vel augue', '2/4/2025', '1/17/2025', 200);



ALTER TABLE booking
ADD COLUMN price DECIMAL(5,2);



insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (1, 1, 1, 'id ligula', '6/1/2025', '8/8/2025', 'volutpat', 6.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (2, 2, 2, 'dignissim vestibulum', '12/5/2024', '5/1/2025', 'risus praesent', 39.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (3, 3, 3, 'purus phasellus', '3/31/2025', '10/1/2024', 'elementum nullam', 3.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (4, 4, 4, 'curabitur', '4/18/2025', '1/8/2025', 'nulla nisl', 3.19);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (5, 5, 5, 'nullam', '5/28/2025', '10/21/2024', 'blandit ultrices', 19.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (6, 6, 6, 'aliquam', '12/23/2024', '5/7/2025', 'viverra', 89.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (7, 7, 7, 'nulla', '11/21/2024', '5/24/2025', 'pellentesque', 2.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (8, 8, 8, 'blandit non', '7/2/2025', '12/29/2024', 'pellentesque quisque', 34.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (9, 9, 9, 'tempus', '3/26/2025', '8/19/2025', 'metus', 5.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (10, 10, 10, 'lobortis vel', '6/7/2025', '5/23/2025', 'at', 12.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (11, 11, 11, 'elit', '5/17/2025', '9/11/2025', 'eu magna', 3.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (12, 12, 12, 'cubilia', '2/6/2025', '2/24/2025', 'sociis natoque', 3.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (13, 13, 13, 'pretium', '9/24/2024', '3/19/2025', 'pretium iaculis', 22.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (14, 14, 14, 'suspendisse', '1/24/2025', '6/12/2025', 'ac', 2.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (15, 15, 15, 'purus', '7/17/2025', '8/9/2025', 'duis at', 49.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (16, 16, 16, 'massa', '6/8/2025', '10/6/2024', 'augue aliquam', 4.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (17, 17, 17, 'interdum mauris', '7/1/2025', '1/24/2025', 'nulla neque', 3.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (18, 18, 18, 'pede', '7/13/2025', '4/14/2025', 'quam', 4.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (19, 19, 19, 'nunc nisl', '10/2/2024', '6/22/2025', 'justo', 29.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (20, 20, 20, 'feugiat et', '2/9/2025', '5/20/2025', 'adipiscing', 199.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (21, 21, 21, 'ligula', '6/6/2025', '11/4/2024', 'mauris non', 22);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (22, 22, 22, 'rhoncus', '6/18/2025', '5/19/2025', 'vitae', 1.29);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (23, 23, 23, 'pharetra magna', '9/3/2025', '4/6/2025', 'nulla ultrices', 3.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (24, 24, 24, 'fusce congue', '12/13/2024', '2/9/2025', 'dolor vel', 3.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (25, 25, 25, 'rutrum ac', '9/30/2024', '4/1/2025', 'sagittis dui', 39.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (26, 26, 26, 'pede lobortis', '5/26/2025', '10/21/2024', 'dolor sit', 6.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (27, 27, 27, 'rutrum', '4/21/2025', '2/11/2025', 'vulputate', 28.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (28, 28, 28, 'massa id', '2/3/2025', '3/27/2025', 'in blandit', 3.69);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (29, 29, 29, 'ullamcorper purus', '2/12/2025', '2/15/2025', 'pretium', 3.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (30, 30, 30, 'eleifend', '7/16/2025', '12/19/2024', 'fusce posuere', 49.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (31, 31, 31, 'nibh', '10/5/2024', '9/4/2025', 'mauris', 79.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (32, 32, 32, 'volutpat', '12/23/2024', '3/26/2025', 'proin eu', 39.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (33, 33, 33, 'erat quisque', '6/15/2025', '4/11/2025', 'mi', 3.29);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (34, 34, 34, 'amet sapien', '2/15/2025', '9/19/2025', 'pretium', 3.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (35, 35, 35, 'penatibus', '4/4/2025', '6/23/2025', 'et', 39.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (36, 36, 36, 'mauris', '7/31/2025', '8/24/2025', 'ipsum', 4.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (37, 37, 37, 'eu sapien', '4/16/2025', '10/5/2024', 'habitasse platea', 5.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (38, 38, 38, 'blandit', '8/27/2025', '10/22/2024', 'quis', 39.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (39, 39, 39, 'cubilia curae', '9/4/2025', '10/19/2024', 'justo maecenas', 22.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (40, 40, 40, 'augue vel', '2/7/2025', '3/18/2025', 'sit amet', 18.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (41, 41, 41, 'consequat', '8/6/2025', '9/15/2025', 'at nibh', 5.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (42, 42, 42, 'non', '5/4/2025', '8/12/2025', 'a feugiat', 2.79);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (43, 43, 43, 'fermentum donec', '5/18/2025', '7/31/2025', 'duis', 3.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (44, 44, 44, 'blandit ultrices', '3/15/2025', '7/29/2025', 'quis', 5.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (45, 45, 45, 'id nulla', '11/9/2024', '12/1/2024', 'donec', 2.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (46, 46, 46, 'quisque id', '3/1/2025', '7/21/2025', 'morbi a', 4.29);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (47, 47, 47, 'erat eros', '8/20/2025', '5/13/2025', 'nullam sit', 1.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (48, 48, 48, 'vivamus tortor', '5/31/2025', '1/31/2025', 'morbi porttitor', 19.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (49, 49, 49, 'at', '10/14/2024', '12/11/2024', 'pretium quis', 19.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (50, 50, 50, 'tempus', '2/9/2025', '5/13/2025', 'aliquam', 14.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (51, 51, 51, 'luctus et', '12/12/2024', '1/15/2025', 'consequat nulla', 4.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (52, 52, 52, 'id', '5/4/2025', '4/18/2025', 'mauris laoreet', 39.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (53, 53, 53, 'lacinia aenean', '3/15/2025', '3/14/2025', 'morbi', 2.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (54, 54, 54, 'sit', '8/5/2025', '4/16/2025', 'vestibulum', 24.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (55, 55, 55, 'turpis sed', '11/17/2024', '2/12/2025', 'lacus curabitur', 2.79);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (56, 56, 56, 'pellentesque', '5/29/2025', '11/1/2024', 'ac diam', 29.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (57, 57, 57, 'cursus vestibulum', '12/31/2024', '10/18/2024', 'rutrum rutrum', 14.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (58, 58, 58, 'nonummy maecenas', '12/21/2024', '12/10/2024', 'nam dui', 19.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (59, 59, 59, 'pretium iaculis', '12/25/2024', '4/14/2025', 'adipiscing', 5.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (60, 60, 60, 'mauris', '1/13/2025', '2/2/2025', 'luctus et', 3.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (61, 61, 61, 'volutpat', '9/28/2024', '5/10/2025', 'accumsan', 39.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (62, 62, 62, 'nisi', '10/8/2024', '4/17/2025', 'iaculis', 4.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (63, 63, 63, 'egestas metus', '5/8/2025', '12/16/2024', 'ipsum', 2.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (64, 64, 64, 'ipsum', '11/21/2024', '6/30/2025', 'faucibus', 4.29);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (65, 65, 65, 'nam', '4/12/2025', '10/25/2024', 'risus praesent', 34.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (66, 66, 66, 'vestibulum', '1/8/2025', '8/29/2025', 'nisi', 6.29);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (67, 67, 67, 'metus vitae', '11/12/2024', '4/9/2025', 'ac', 3.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (68, 68, 68, 'nulla', '9/25/2024', '3/30/2025', 'convallis nulla', 39.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (69, 69, 69, 'quis', '2/24/2025', '3/27/2025', 'ut', 59.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (70, 70, 70, 'praesent blandit', '6/16/2025', '6/15/2025', 'blandit non', 6.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (71, 71, 71, 'fusce', '5/10/2025', '11/23/2024', 'ullamcorper', 3.69);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (72, 72, 72, 'elit ac', '9/29/2024', '12/6/2024', 'nulla', 25.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (73, 73, 73, 'primis', '6/6/2025', '10/16/2024', 'eu', 4.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (74, 74, 74, 'tellus in', '11/19/2024', '9/1/2025', 'et', 3.29);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (75, 75, 75, 'hendrerit', '6/14/2025', '11/9/2024', 'odio', 3.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (76, 76, 76, 'eu', '6/21/2025', '8/5/2025', 'vel', 22.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (77, 77, 77, 'nibh fusce', '11/21/2024', '6/21/2025', 'bibendum morbi', 3.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (78, 78, 78, 'quam', '7/11/2025', '6/5/2025', 'pellentesque', 5.59);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (79, 79, 79, 'at', '3/30/2025', '4/16/2025', 'nisi', 89.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (80, 80, 80, 'nulla', '1/8/2025', '9/6/2025', 'ac', 19.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (81, 81, 81, 'sapien non', '6/13/2025', '6/21/2025', 'risus dapibus', 3.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (82, 82, 82, 'fringilla rhoncus', '12/30/2024', '4/8/2025', 'nulla dapibus', 19.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (83, 83, 83, 'aliquet', '6/9/2025', '3/25/2025', 'orci luctus', 5.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (84, 84, 84, 'imperdiet sapien', '2/27/2025', '5/23/2025', 'dis parturient', 3.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (85, 85, 85, 'amet consectetuer', '7/16/2025', '2/22/2025', 'turpis', 12.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (86, 86, 86, 'posuere cubilia', '12/25/2024', '9/29/2024', 'quam nec', 19.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (87, 87, 87, 'at', '5/22/2025', '6/10/2025', 'nibh in', 79.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (88, 88, 88, 'vel', '3/4/2025', '7/20/2025', 'tempus vel', 3.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (89, 89, 89, 'vel', '2/21/2025', '4/30/2025', 'tellus', 3.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (90, 90, 90, 'purus aliquet', '6/23/2025', '4/17/2025', 'augue a', 3.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (91, 91, 91, 'nec molestie', '6/19/2025', '3/20/2025', 'lobortis est', 39.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (92, 92, 92, 'amet sem', '11/14/2024', '8/28/2025', 'justo', 2.29);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (93, 93, 93, 'mattis odio', '2/10/2025', '1/20/2025', 'elit', 2.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (94, 94, 94, 'integer non', '1/20/2025', '1/12/2025', 'mattis egestas', 4.29);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (95, 95, 95, 'in', '7/5/2025', '9/11/2025', 'enim lorem', 1.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (96, 96, 96, 'elit proin', '12/16/2024', '10/14/2024', 'a odio', 17.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (97, 97, 97, 'id', '2/7/2025', '1/21/2025', 'sapien non', 8.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (98, 98, 98, 'aenean', '4/17/2025', '4/5/2025', 'nec', 5.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (99, 99, 99, 'quam a', '6/5/2025', '5/24/2025', 'dis parturient', 12.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (100, 100, 100, 'convallis', '9/21/2025', '11/30/2024', 'amet erat', 24.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (101, 101, 101, 'convallis', '1/9/2025', '5/23/2025', 'non mauris', 4.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (102, 102, 102, 'vestibulum rutrum', '9/30/2024', '9/18/2025', 'consequat in', 19.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (103, 103, 103, 'nulla sed', '9/11/2025', '2/21/2025', 'velit donec', 39.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (104, 104, 104, 'ipsum', '2/2/2025', '4/24/2025', 'et commodo', 89.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (105, 105, 105, 'ac', '3/6/2025', '10/3/2024', 'morbi', 2.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (106, 106, 106, 'viverra dapibus', '3/13/2025', '3/25/2025', 'ultrices erat', 18.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (107, 107, 107, 'at velit', '2/22/2025', '7/27/2025', 'velit', 2.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (108, 108, 108, 'interdum eu', '5/28/2025', '8/28/2025', 'mauris', 4.29);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (109, 109, 109, 'justo', '5/4/2025', '5/9/2025', 'mauris', 2.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (110, 110, 110, 'porttitor lacus', '1/3/2025', '2/8/2025', 'lectus in', 2.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (111, 111, 111, 'tincidunt', '1/19/2025', '8/5/2025', 'justo', 2.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (112, 112, 112, 'in imperdiet', '12/23/2024', '10/6/2024', 'aliquet', 119.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (113, 113, 113, 'volutpat convallis', '12/9/2024', '8/6/2025', 'consequat', 99.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (114, 114, 114, 'elementum', '12/10/2024', '5/14/2025', 'posuere', 34.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (115, 115, 115, 'quis', '12/8/2024', '12/3/2024', 'pellentesque', 4.19);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (116, 116, 116, 'volutpat sapien', '5/29/2025', '6/13/2025', 'a odio', 22.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (117, 117, 117, 'aliquam quis', '9/5/2025', '11/21/2024', 'fusce lacus', 3.79);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (118, 118, 118, 'mauris', '4/6/2025', '1/21/2025', 'sed', 34.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (119, 119, 119, 'volutpat in', '5/12/2025', '11/10/2024', 'quisque', 39.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (120, 120, 120, 'purus eu', '4/18/2025', '2/7/2025', 'natoque penatibus', 19.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (121, 121, 121, 'id ligula', '4/18/2025', '10/25/2024', 'in purus', 29.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (122, 122, 122, 'massa volutpat', '7/11/2025', '1/30/2025', 'semper interdum', 15.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (123, 123, 123, 'lacinia sapien', '11/7/2024', '9/11/2025', 'fermentum', 29.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (124, 124, 124, 'tristique', '10/17/2024', '9/20/2025', 'nulla', 29.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (125, 125, 125, 'eleifend', '1/23/2025', '3/11/2025', 'in hac', 1.29);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (126, 126, 126, 'ut', '11/20/2024', '6/27/2025', 'vivamus metus', 2.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (127, 127, 127, 'pellentesque volutpat', '8/11/2025', '1/3/2025', 'sed', 4.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (128, 128, 128, 'sed', '3/30/2025', '11/4/2024', 'est', 4.5);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (129, 129, 129, 'pede', '4/26/2025', '2/24/2025', 'lectus', 9.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (130, 130, 130, 'quis', '6/5/2025', '1/26/2025', 'amet sem', 3.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (131, 131, 131, 'in eleifend', '8/17/2025', '9/13/2025', 'dapibus augue', 24.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (132, 132, 132, 'hac habitasse', '9/2/2025', '7/13/2025', 'tristique', 359.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (133, 133, 133, 'sit', '2/5/2025', '11/17/2024', 'id', 2.59);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (134, 134, 134, 'sodales', '7/10/2025', '3/15/2025', 'congue', 2.69);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (135, 135, 135, 'eu magna', '11/20/2024', '2/1/2025', 'est', 3.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (136, 136, 136, 'porttitor', '3/18/2025', '3/1/2025', 'elementum', 14.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (137, 137, 137, 'nisi', '8/7/2025', '2/27/2025', 'mauris enim', 5.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (138, 138, 138, 'et tempus', '3/8/2025', '6/28/2025', 'fusce lacus', 29.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (139, 139, 139, 'viverra', '2/8/2025', '4/27/2025', 'pretium iaculis', 39.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (140, 140, 140, 'urna ut', '5/1/2025', '11/5/2024', 'diam neque', 22);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (141, 141, 141, 'quis', '7/4/2025', '8/9/2025', 'quis libero', 2.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (142, 142, 142, 'id', '1/28/2025', '2/3/2025', 'orci', 4.29);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (143, 143, 143, 'at dolor', '11/17/2024', '4/23/2025', 'ipsum praesent', 5.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (144, 144, 144, 'maecenas leo', '7/19/2025', '7/20/2025', 'auctor', 22.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (145, 145, 145, 'est quam', '7/21/2025', '12/23/2024', 'orci', 5.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (146, 146, 146, 'adipiscing elit', '12/11/2024', '6/1/2025', 'pellentesque quisque', 22.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (147, 147, 147, 'in', '11/20/2024', '3/30/2025', 'tempus', 1.29);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (148, 148, 148, 'dolor sit', '4/22/2025', '9/9/2025', 'justo lacinia', 3.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (149, 149, 149, 'odio', '6/28/2025', '1/29/2025', 'massa', 1.29);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (150, 150, 150, 'bibendum imperdiet', '8/17/2025', '10/11/2024', 'auctor', 1.29);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (151, 151, 151, 'at', '2/8/2025', '6/20/2025', 'convallis duis', 2.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (152, 152, 152, 'sit amet', '4/12/2025', '12/24/2024', 'posuere', 4.29);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (153, 153, 153, 'parturient', '6/27/2025', '11/11/2024', 'commodo', 29.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (154, 154, 154, 'morbi', '1/11/2025', '9/3/2025', 'lectus', 4.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (155, 155, 155, 'habitasse platea', '2/12/2025', '9/4/2025', 'lorem vitae', 39.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (156, 156, 156, 'vel', '4/17/2025', '9/10/2025', 'nulla', 9.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (157, 157, 157, 'aliquam', '9/13/2025', '12/25/2024', 'proin interdum', 3.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (158, 158, 158, 'quam', '10/13/2024', '3/5/2025', 'diam', 5.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (159, 159, 159, 'nec', '11/20/2024', '1/19/2025', 'nullam molestie', 14.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (160, 160, 160, 'vestibulum', '12/17/2024', '11/28/2024', 'tempor turpis', 4.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (161, 161, 161, 'lacinia', '4/12/2025', '12/10/2024', 'urna pretium', 29.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (162, 162, 162, 'volutpat', '9/28/2024', '11/8/2024', 'suspendisse potenti', 5.29);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (163, 163, 163, 'volutpat', '8/13/2025', '1/1/2025', 'quis', 3.29);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (164, 164, 164, 'sit', '9/4/2025', '12/29/2024', 'fusce', 29.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (165, 165, 165, 'pretium', '10/13/2024', '4/1/2025', 'libero nullam', 19.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (166, 166, 166, 'lacinia erat', '6/1/2025', '6/10/2025', 'eleifend', 3.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (167, 167, 167, 'hendrerit at', '10/17/2024', '4/26/2025', 'in', 10.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (168, 168, 168, 'in', '6/6/2025', '5/22/2025', 'in consequat', 5.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (169, 169, 169, 'pellentesque', '12/1/2024', '8/13/2025', 'quam pharetra', 4.29);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (170, 170, 170, 'nunc', '6/21/2025', '7/21/2025', 'lobortis', 2.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (171, 171, 171, 'etiam', '1/7/2025', '1/14/2025', 'amet', 3.19);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (172, 172, 172, 'nunc rhoncus', '3/1/2025', '7/11/2025', 'id', 1.29);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (173, 173, 173, 'sit', '10/21/2024', '7/16/2025', 'donec odio', 64.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (174, 174, 174, 'non', '2/14/2025', '4/21/2025', 'sem', 5.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (175, 175, 175, 'ante', '10/13/2024', '6/5/2025', 'nec nisi', 3.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (176, 176, 176, 'quis', '8/6/2025', '5/20/2025', 'morbi a', 19.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (177, 177, 177, 'in congue', '3/15/2025', '1/16/2025', 'a', 2.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (178, 178, 178, 'mi integer', '4/30/2025', '6/18/2025', 'ante ipsum', 39.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (179, 179, 179, 'elementum eu', '11/11/2024', '10/20/2024', 'dapibus nulla', 44.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (180, 180, 180, 'montes', '2/12/2025', '1/14/2025', 'at dolor', 89.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (181, 181, 181, 'accumsan', '10/12/2024', '5/8/2025', 'eget nunc', 24.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (182, 182, 182, 'posuere', '1/6/2025', '2/16/2025', 'sociis', 4.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (183, 183, 183, 'erat quisque', '9/7/2025', '10/20/2024', 'tincidunt nulla', 0.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (184, 184, 184, 'at lorem', '4/16/2025', '7/3/2025', 'est phasellus', 25.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (185, 185, 185, 'donec', '6/4/2025', '11/6/2024', 'mi in', 49.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (186, 186, 186, 'dapibus', '9/9/2025', '6/10/2025', 'in faucibus', 49.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (187, 187, 187, 'vivamus tortor', '12/30/2024', '1/29/2025', 'posuere metus', 5.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (188, 188, 188, 'cum', '2/8/2025', '3/20/2025', 'congue', 14.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (189, 189, 189, 'nulla integer', '9/7/2025', '5/16/2025', 'interdum', 59.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (190, 190, 190, 'at', '8/10/2025', '8/20/2025', 'lacinia erat', 2.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (191, 191, 191, 'congue elementum', '2/14/2025', '2/2/2025', 'erat vestibulum', 22.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (192, 192, 192, 'amet nulla', '7/14/2025', '2/13/2025', 'praesent', 59.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (193, 193, 193, 'id', '8/4/2025', '7/25/2025', 'vestibulum ante', 1.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (194, 194, 194, 'sit', '11/24/2024', '1/14/2025', 'primis in', 2.29);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (195, 195, 195, 'at nunc', '10/11/2024', '8/3/2025', 'in quam', 9.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (196, 196, 196, 'praesent', '8/19/2025', '1/4/2025', 'id', 79.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (197, 197, 197, 'in sapien', '2/26/2025', '10/29/2024', 'a nibh', 4.19);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (198, 198, 198, 'vivamus tortor', '9/4/2025', '10/24/2024', 'pretium', 6.49);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (199, 199, 199, 'sagittis', '6/1/2025', '3/21/2025', 'laoreet', 11.99);
insert into booking (booking_id, flight_id, passenger_id, booking_platform, created_at, updated_at, status, price) values (200, 200, 200, 'vivamus', '11/26/2024', '11/3/2024', 'sem mauris', 3.49);

insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (1, 1, 1, '11/21/2024', '8/17/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (2, 2, 2, '7/1/2025', '2/20/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (3, 3, 3, '12/27/2024', '6/8/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (4, 4, 4, '9/3/2025', '9/19/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (5, 5, 5, '4/1/2025', '3/21/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (6, 6, 6, '2/28/2025', '3/27/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (7, 7, 7, '9/15/2025', '1/2/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (8, 8, 8, '7/1/2025', '5/14/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (9, 9, 9, '1/15/2025', '11/28/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (10, 10, 10, '10/31/2024', '8/16/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (11, 11, 11, '11/4/2024', '3/10/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (12, 12, 12, '3/10/2025', '8/5/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (13, 13, 13, '12/6/2024', '1/15/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (14, 14, 14, '12/14/2024', '1/24/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (15, 15, 15, '5/29/2025', '9/22/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (16, 16, 16, '2/6/2025', '2/26/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (17, 17, 17, '4/18/2025', '6/12/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (18, 18, 18, '2/1/2025', '2/6/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (19, 19, 19, '9/27/2024', '6/1/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (20, 20, 20, '7/8/2025', '1/21/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (21, 21, 21, '12/27/2024', '10/31/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (22, 22, 22, '12/16/2024', '8/6/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (23, 23, 23, '9/20/2025', '7/10/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (24, 24, 24, '7/25/2025', '6/25/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (25, 25, 25, '11/4/2024', '9/10/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (26, 26, 26, '2/2/2025', '1/20/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (27, 27, 27, '8/29/2025', '6/22/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (28, 28, 28, '12/22/2024', '5/17/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (29, 29, 29, '7/21/2025', '7/7/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (30, 30, 30, '11/29/2024', '10/5/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (31, 31, 31, '9/28/2024', '7/28/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (32, 32, 32, '10/18/2024', '10/14/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (33, 33, 33, '8/17/2025', '10/16/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (34, 34, 34, '12/13/2024', '9/28/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (35, 35, 35, '8/13/2025', '3/3/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (36, 36, 36, '4/18/2025', '1/11/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (37, 37, 37, '12/11/2024', '6/15/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (38, 38, 38, '8/13/2025', '8/28/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (39, 39, 39, '9/10/2025', '10/18/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (40, 40, 40, '3/20/2025', '9/24/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (41, 41, 41, '6/21/2025', '10/30/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (42, 42, 42, '2/4/2025', '10/3/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (43, 43, 43, '4/20/2025', '12/28/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (44, 44, 44, '6/20/2025', '1/10/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (45, 45, 45, '12/21/2024', '4/13/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (46, 46, 46, '11/20/2024', '12/26/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (47, 47, 47, '10/25/2024', '12/4/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (48, 48, 48, '8/21/2025', '7/8/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (49, 49, 49, '7/20/2025', '2/11/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (50, 50, 50, '12/21/2024', '10/19/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (51, 51, 51, '11/23/2024', '9/16/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (52, 52, 52, '4/15/2025', '9/7/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (53, 53, 53, '3/8/2025', '4/25/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (54, 54, 54, '10/21/2024', '6/7/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (55, 55, 55, '5/15/2025', '6/11/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (56, 56, 56, '10/21/2024', '5/27/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (57, 57, 57, '12/13/2024', '8/31/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (58, 58, 58, '9/3/2025', '7/11/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (59, 59, 59, '7/25/2025', '8/10/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (60, 60, 60, '4/10/2025', '1/29/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (61, 61, 61, '5/5/2025', '3/24/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (62, 62, 62, '3/18/2025', '8/3/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (63, 63, 63, '12/19/2024', '7/18/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (64, 64, 64, '1/7/2025', '4/25/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (65, 65, 65, '9/9/2025', '6/15/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (66, 66, 66, '2/2/2025', '9/25/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (67, 67, 67, '2/10/2025', '8/25/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (68, 68, 68, '11/30/2024', '8/24/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (69, 69, 69, '2/24/2025', '1/29/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (70, 70, 70, '11/15/2024', '2/25/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (71, 71, 71, '12/27/2024', '7/18/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (72, 72, 72, '7/1/2025', '5/3/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (73, 73, 73, '8/2/2025', '8/20/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (74, 74, 74, '9/21/2025', '10/8/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (75, 75, 75, '9/8/2025', '5/20/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (76, 76, 76, '1/23/2025', '1/12/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (77, 77, 77, '8/7/2025', '4/6/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (78, 78, 78, '6/30/2025', '9/4/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (79, 79, 79, '12/4/2024', '6/28/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (80, 80, 80, '4/11/2025', '9/10/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (81, 81, 81, '11/22/2024', '11/11/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (82, 82, 82, '12/6/2024', '2/25/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (83, 83, 83, '4/5/2025', '1/9/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (84, 84, 84, '3/3/2025', '6/29/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (85, 85, 85, '1/31/2025', '7/7/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (86, 86, 86, '8/7/2025', '6/11/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (87, 87, 87, '6/7/2025', '4/29/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (88, 88, 88, '7/2/2025', '12/9/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (89, 89, 89, '9/25/2024', '6/9/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (90, 90, 90, '2/1/2025', '3/13/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (91, 91, 91, '10/30/2024', '4/7/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (92, 92, 92, '10/27/2024', '7/6/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (93, 93, 93, '2/19/2025', '5/5/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (94, 94, 94, '7/4/2025', '2/19/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (95, 95, 95, '3/9/2025', '5/19/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (96, 96, 96, '4/15/2025', '10/21/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (97, 97, 97, '2/27/2025', '8/2/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (98, 98, 98, '4/10/2025', '2/20/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (99, 99, 99, '1/16/2025', '7/1/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (100, 100, 100, '4/19/2025', '8/24/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (101, 101, 101, '2/23/2025', '5/24/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (102, 102, 102, '3/10/2025', '11/4/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (103, 103, 103, '1/22/2025', '3/12/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (104, 104, 104, '8/16/2025', '11/30/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (105, 105, 105, '5/19/2025', '10/1/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (106, 106, 106, '5/23/2025', '6/1/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (107, 107, 107, '1/7/2025', '6/26/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (108, 108, 108, '12/29/2024', '11/28/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (109, 109, 109, '8/10/2025', '4/24/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (110, 110, 110, '3/8/2025', '8/11/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (111, 111, 111, '9/26/2024', '8/17/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (112, 112, 112, '9/18/2025', '8/4/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (113, 113, 113, '4/30/2025', '12/7/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (114, 114, 114, '11/8/2024', '8/17/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (115, 115, 115, '2/13/2025', '6/14/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (116, 116, 116, '12/11/2024', '3/17/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (117, 117, 117, '2/22/2025', '6/1/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (118, 118, 118, '1/13/2025', '12/1/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (119, 119, 119, '8/3/2025', '7/7/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (120, 120, 120, '9/8/2025', '10/7/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (121, 121, 121, '11/29/2024', '4/4/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (122, 122, 122, '4/1/2025', '9/1/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (123, 123, 123, '5/15/2025', '4/14/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (124, 124, 124, '7/16/2025', '1/27/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (125, 125, 125, '8/12/2025', '12/5/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (126, 126, 126, '11/15/2024', '2/20/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (127, 127, 127, '3/6/2025', '4/22/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (128, 128, 128, '2/11/2025', '6/19/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (129, 129, 129, '5/27/2025', '5/22/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (130, 130, 130, '10/13/2024', '5/8/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (131, 131, 131, '9/16/2025', '4/11/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (132, 132, 132, '11/12/2024', '6/18/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (133, 133, 133, '2/4/2025', '1/21/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (134, 134, 134, '4/24/2025', '7/15/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (135, 135, 135, '12/20/2024', '2/22/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (136, 136, 136, '5/4/2025', '9/4/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (137, 137, 137, '10/10/2024', '11/2/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (138, 138, 138, '5/27/2025', '7/8/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (139, 139, 139, '4/17/2025', '6/2/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (140, 140, 140, '5/7/2025', '12/24/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (141, 141, 141, '2/11/2025', '4/28/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (142, 142, 142, '6/24/2025', '10/16/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (143, 143, 143, '7/31/2025', '11/21/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (144, 144, 144, '6/30/2025', '2/10/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (145, 145, 145, '4/30/2025', '2/28/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (146, 146, 146, '8/16/2025', '11/4/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (147, 147, 147, '2/21/2025', '6/26/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (148, 148, 148, '3/3/2025', '11/18/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (149, 149, 149, '11/10/2024', '8/25/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (150, 150, 150, '1/26/2025', '8/19/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (151, 151, 151, '10/9/2024', '10/30/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (152, 152, 152, '11/13/2024', '7/28/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (153, 153, 153, '6/2/2025', '7/11/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (154, 154, 154, '2/8/2025', '10/11/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (155, 155, 155, '8/7/2025', '12/1/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (156, 156, 156, '12/20/2024', '1/9/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (157, 157, 157, '8/31/2025', '3/9/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (158, 158, 158, '12/21/2024', '10/31/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (159, 159, 159, '6/11/2025', '3/8/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (160, 160, 160, '9/26/2024', '8/1/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (161, 161, 161, '5/19/2025', '3/10/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (162, 162, 162, '6/14/2025', '11/19/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (163, 163, 163, '10/14/2024', '2/11/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (164, 164, 164, '10/9/2024', '1/17/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (165, 165, 165, '10/23/2024', '8/20/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (166, 166, 166, '12/15/2024', '8/16/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (167, 167, 167, '10/27/2024', '8/21/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (168, 168, 168, '4/7/2025', '5/12/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (169, 169, 169, '1/9/2025', '11/19/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (170, 170, 170, '6/6/2025', '5/17/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (171, 171, 171, '7/21/2025', '1/28/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (172, 172, 172, '11/29/2024', '5/5/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (173, 173, 173, '9/6/2025', '8/22/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (174, 174, 174, '4/4/2025', '10/27/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (175, 175, 175, '1/1/2025', '7/5/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (176, 176, 176, '12/19/2024', '11/15/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (177, 177, 177, '3/6/2025', '8/16/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (178, 178, 178, '4/8/2025', '9/3/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (179, 179, 179, '7/28/2025', '4/20/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (180, 180, 180, '1/1/2025', '8/29/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (181, 181, 181, '4/30/2025', '2/4/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (182, 182, 182, '12/5/2024', '10/31/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (183, 183, 183, '7/8/2025', '6/17/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (184, 184, 184, '12/24/2024', '10/27/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (185, 185, 185, '7/24/2025', '12/26/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (186, 186, 186, '6/20/2025', '9/23/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (187, 187, 187, '10/10/2024', '1/10/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (188, 188, 188, '8/3/2025', '10/9/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (189, 189, 189, '9/25/2024', '12/6/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (190, 190, 190, '2/21/2025', '12/5/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (191, 191, 191, '11/15/2024', '1/14/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (192, 192, 192, '11/22/2024', '4/11/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (193, 193, 193, '12/20/2024', '4/27/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (194, 194, 194, '6/8/2025', '8/25/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (195, 195, 195, '1/29/2025', '3/5/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (196, 196, 196, '5/31/2025', '7/23/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (197, 197, 197, '4/22/2025', '1/14/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (198, 198, 198, '9/24/2024', '5/28/2025');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (199, 199, 199, '11/22/2024', '11/25/2024');
insert into booking_flight (booking_flight_id, booking_id, flight_id, created_at, updated_at) values (200, 200, 200, '2/26/2025', '6/5/2025');

insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (1, 1, '19442', '12/29/2024', '10/26/2024', '3/25/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (2, 2, '38', '3/3/2025', '3/6/2025', '7/24/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (3, 3, '7381', '7/25/2025', '7/9/2025', '3/22/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (4, 4, '5324', '5/18/2025', '6/1/2025', '3/12/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (5, 5, '970', '6/12/2025', '10/17/2024', '3/22/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (6, 6, '382', '11/12/2024', '3/1/2025', '11/24/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (7, 7, '6', '12/4/2024', '8/18/2025', '7/25/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (8, 8, '1', '5/9/2025', '9/12/2025', '4/7/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (9, 9, '76', '6/15/2025', '11/9/2024', '12/23/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (10, 10, '4', '1/31/2025', '6/3/2025', '7/8/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (11, 11, '99', '6/1/2025', '3/9/2025', '6/9/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (12, 12, '67518', '2/23/2025', '5/23/2025', '1/30/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (13, 13, '7', '10/8/2024', '9/25/2024', '3/11/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (14, 14, '80', '3/25/2025', '8/28/2025', '7/28/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (15, 15, '1802', '5/7/2025', '10/18/2024', '9/2/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (16, 16, '4', '5/6/2025', '6/20/2025', '11/1/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (17, 17, '85', '7/17/2025', '6/6/2025', '3/1/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (18, 18, '817', '2/19/2025', '11/24/2024', '2/17/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (19, 19, '02398', '12/3/2024', '4/18/2025', '11/11/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (20, 20, '89919', '1/24/2025', '5/1/2025', '10/29/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (21, 21, '1418', '6/19/2025', '12/10/2024', '3/15/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (22, 22, '1378', '1/12/2025', '2/1/2025', '5/3/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (23, 23, '402', '8/29/2025', '4/9/2025', '10/18/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (24, 24, '2', '4/27/2025', '2/19/2025', '2/7/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (25, 25, '1253', '10/9/2024', '2/26/2025', '11/1/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (26, 26, '95135', '5/20/2025', '8/13/2025', '10/13/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (27, 27, '62702', '10/30/2024', '10/21/2024', '8/15/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (28, 28, '1461', '7/16/2025', '11/13/2024', '9/29/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (29, 29, '922', '12/8/2024', '2/10/2025', '10/11/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (30, 30, '258', '12/23/2024', '12/1/2024', '2/6/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (31, 31, '95430', '8/9/2025', '9/11/2025', '8/5/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (32, 32, '5', '11/17/2024', '1/19/2025', '11/11/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (33, 33, '241', '11/18/2024', '11/16/2024', '5/10/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (34, 34, '46877', '11/7/2024', '12/9/2024', '7/9/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (35, 35, '9', '3/3/2025', '6/12/2025', '7/14/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (36, 36, '21', '10/12/2024', '2/27/2025', '12/19/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (37, 37, '7826', '7/12/2025', '8/1/2025', '3/7/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (38, 38, '99969', '12/5/2024', '6/27/2025', '4/28/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (39, 39, '70', '5/5/2025', '4/20/2025', '8/9/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (40, 40, '5254', '5/17/2025', '3/19/2025', '12/25/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (41, 41, '549', '8/11/2025', '12/31/2024', '3/7/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (42, 42, '88151', '5/22/2025', '6/7/2025', '2/3/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (43, 43, '809', '2/13/2025', '7/29/2025', '8/5/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (44, 44, '912', '1/9/2025', '8/7/2025', '5/30/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (45, 45, '262', '12/24/2024', '2/2/2025', '3/9/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (46, 46, '4', '5/25/2025', '3/30/2025', '8/18/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (47, 47, '51295', '7/13/2025', '9/18/2025', '7/15/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (48, 48, '731', '2/28/2025', '6/20/2025', '8/3/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (49, 49, '41995', '1/17/2025', '9/2/2025', '12/27/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (50, 50, '6375', '9/10/2025', '12/16/2024', '4/20/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (51, 51, '51012', '8/17/2025', '2/1/2025', '6/30/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (52, 52, '9', '5/10/2025', '4/2/2025', '6/28/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (53, 53, '17', '10/11/2024', '6/25/2025', '11/17/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (54, 54, '779', '8/8/2025', '6/19/2025', '12/14/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (55, 55, '370', '1/23/2025', '12/8/2024', '9/28/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (56, 56, '2', '11/7/2024', '5/30/2025', '6/20/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (57, 57, '3', '10/29/2024', '6/11/2025', '12/24/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (58, 58, '5', '4/7/2025', '4/26/2025', '2/22/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (59, 59, '92', '4/10/2025', '3/18/2025', '5/4/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (60, 60, '71', '10/3/2024', '1/24/2025', '6/8/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (61, 61, '5577', '5/25/2025', '12/13/2024', '12/9/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (62, 62, '07', '3/30/2025', '6/8/2025', '10/14/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (63, 63, '0', '12/4/2024', '9/4/2025', '12/23/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (64, 64, '1395', '1/2/2025', '6/25/2025', '11/10/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (65, 65, '591', '2/24/2025', '8/18/2025', '8/31/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (66, 66, '17505', '1/16/2025', '12/12/2024', '10/12/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (67, 67, '0', '2/19/2025', '8/5/2025', '2/11/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (68, 68, '998', '7/20/2025', '8/22/2025', '10/18/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (69, 69, '859', '2/9/2025', '3/5/2025', '9/16/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (70, 70, '5173', '1/3/2025', '3/16/2025', '2/6/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (71, 71, '50', '10/15/2024', '6/13/2025', '5/5/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (72, 72, '9', '8/18/2025', '11/14/2024', '8/8/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (73, 73, '009', '2/18/2025', '3/8/2025', '11/13/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (74, 74, '33380', '12/10/2024', '9/18/2025', '12/31/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (75, 75, '0', '5/25/2025', '4/12/2025', '10/27/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (76, 76, '4', '9/27/2024', '2/13/2025', '9/16/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (77, 77, '86', '3/8/2025', '5/13/2025', '3/23/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (78, 78, '8', '1/21/2025', '6/19/2025', '12/17/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (79, 79, '55996', '6/16/2025', '5/23/2025', '4/30/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (80, 80, '4', '3/20/2025', '7/6/2025', '11/3/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (81, 81, '66', '8/25/2025', '1/21/2025', '9/5/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (82, 82, '59564', '6/20/2025', '11/4/2024', '12/10/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (83, 83, '2', '5/13/2025', '1/4/2025', '3/6/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (84, 84, '9', '4/18/2025', '3/22/2025', '3/5/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (85, 85, '526', '8/10/2025', '4/23/2025', '8/14/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (86, 86, '4174', '11/25/2024', '11/6/2024', '8/26/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (87, 87, '394', '7/4/2025', '10/2/2024', '10/29/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (88, 88, '33', '5/25/2025', '1/22/2025', '2/18/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (89, 89, '033', '10/14/2024', '1/7/2025', '2/25/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (90, 90, '9636', '1/6/2025', '7/6/2025', '1/7/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (91, 91, '69477', '5/17/2025', '3/10/2025', '2/15/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (92, 92, '7466', '11/27/2024', '2/26/2025', '8/4/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (93, 93, '123', '2/7/2025', '11/8/2024', '9/16/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (94, 94, '82356', '11/13/2024', '2/5/2025', '7/31/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (95, 95, '77332', '8/19/2025', '10/31/2024', '12/9/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (96, 96, '5', '2/11/2025', '2/1/2025', '7/28/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (97, 97, '40', '8/9/2025', '1/21/2025', '7/16/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (98, 98, '95', '1/31/2025', '2/27/2025', '11/18/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (99, 99, '30', '3/26/2025', '3/17/2025', '2/14/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (100, 100, '56', '7/3/2025', '3/16/2025', '5/8/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (101, 101, '86071', '8/29/2025', '4/18/2025', '10/3/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (102, 102, '71113', '4/2/2025', '1/13/2025', '4/1/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (103, 103, '03881', '6/9/2025', '4/16/2025', '9/7/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (104, 104, '34949', '11/13/2024', '11/20/2024', '4/1/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (105, 105, '7', '7/1/2025', '7/7/2025', '7/18/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (106, 106, '07839', '10/12/2024', '6/26/2025', '10/5/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (107, 107, '8', '11/20/2024', '1/6/2025', '3/18/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (108, 108, '59476', '2/21/2025', '9/20/2025', '9/28/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (109, 109, '435', '1/3/2025', '3/2/2025', '3/10/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (110, 110, '6', '4/6/2025', '10/12/2024', '7/31/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (111, 111, '09215', '5/19/2025', '3/2/2025', '1/25/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (112, 112, '761', '11/25/2024', '12/17/2024', '6/27/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (113, 113, '29', '11/11/2024', '3/21/2025', '9/12/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (114, 114, '7337', '3/21/2025', '4/25/2025', '11/26/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (115, 115, '04', '8/27/2025', '6/25/2025', '5/11/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (116, 116, '7', '3/20/2025', '2/28/2025', '4/27/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (117, 117, '7', '3/7/2025', '6/25/2025', '1/23/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (118, 118, '1673', '12/31/2024', '3/21/2025', '5/14/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (119, 119, '573', '4/11/2025', '11/5/2024', '1/4/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (120, 120, '2', '1/15/2025', '12/17/2024', '5/22/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (121, 121, '1', '10/3/2024', '2/27/2025', '4/14/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (122, 122, '03394', '12/1/2024', '11/23/2024', '8/22/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (123, 123, '94665', '5/12/2025', '3/22/2025', '7/30/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (124, 124, '0950', '2/11/2025', '7/20/2025', '5/24/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (125, 125, '4305', '4/20/2025', '7/29/2025', '10/25/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (126, 126, '26427', '6/3/2025', '8/6/2025', '5/29/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (127, 127, '2128', '9/23/2024', '9/9/2025', '9/14/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (128, 128, '77', '9/9/2025', '12/8/2024', '2/23/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (129, 129, '355', '6/23/2025', '10/1/2024', '1/30/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (130, 130, '1', '8/9/2025', '1/1/2025', '12/19/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (131, 131, '80', '7/12/2025', '9/25/2024', '10/18/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (132, 132, '68032', '11/7/2024', '3/16/2025', '8/25/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (133, 133, '675', '6/12/2025', '12/24/2024', '9/2/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (134, 134, '74723', '9/23/2024', '2/23/2025', '9/25/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (135, 135, '90237', '12/14/2024', '10/11/2024', '9/23/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (136, 136, '3563', '4/7/2025', '8/20/2025', '12/4/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (137, 137, '3', '10/18/2024', '10/1/2024', '1/27/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (138, 138, '12', '8/12/2025', '11/7/2024', '3/16/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (139, 139, '86', '6/22/2025', '6/6/2025', '4/30/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (140, 140, '9244', '7/11/2025', '8/28/2025', '1/22/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (141, 141, '7820', '10/10/2024', '3/31/2025', '2/25/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (142, 142, '58', '4/23/2025', '10/1/2024', '8/30/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (143, 143, '7', '12/11/2024', '4/1/2025', '4/29/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (144, 144, '8883', '5/10/2025', '9/30/2024', '10/1/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (145, 145, '12258', '9/6/2025', '9/5/2025', '5/8/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (146, 146, '22', '11/4/2024', '6/15/2025', '8/31/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (147, 147, '42893', '12/2/2024', '10/15/2024', '2/28/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (148, 148, '3', '3/30/2025', '12/20/2024', '11/15/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (149, 149, '35150', '12/9/2024', '3/1/2025', '1/22/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (150, 150, '1', '10/14/2024', '10/1/2024', '1/17/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (151, 151, '11590', '6/9/2025', '7/25/2025', '6/13/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (152, 152, '09', '5/14/2025', '8/9/2025', '3/30/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (153, 153, '483', '7/3/2025', '1/25/2025', '3/26/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (154, 154, '92175', '3/14/2025', '2/18/2025', '12/28/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (155, 155, '266', '12/1/2024', '12/2/2024', '3/7/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (156, 156, '058', '1/19/2025', '3/27/2025', '9/19/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (157, 157, '65508', '1/21/2025', '11/30/2024', '3/10/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (158, 158, '925', '6/22/2025', '12/31/2024', '1/5/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (159, 159, '05404', '6/13/2025', '3/17/2025', '1/22/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (160, 160, '97315', '7/27/2025', '3/23/2025', '11/6/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (161, 161, '87305', '2/24/2025', '12/21/2024', '5/29/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (162, 162, '06', '9/17/2025', '4/11/2025', '11/7/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (163, 163, '43', '1/6/2025', '11/17/2024', '9/24/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (164, 164, '952', '2/9/2025', '12/7/2024', '9/3/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (165, 165, '54753', '3/29/2025', '9/10/2025', '10/23/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (166, 166, '476', '1/14/2025', '11/27/2024', '4/30/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (167, 167, '25245', '12/10/2024', '6/29/2025', '12/2/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (168, 168, '7', '11/3/2024', '12/30/2024', '7/18/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (169, 169, '1', '8/25/2025', '5/1/2025', '9/30/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (170, 170, '4', '4/30/2025', '9/7/2025', '9/4/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (171, 171, '98', '12/5/2024', '10/16/2024', '11/10/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (172, 172, '3', '3/9/2025', '11/28/2024', '3/25/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (173, 173, '4', '11/12/2024', '1/4/2025', '4/2/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (174, 174, '7', '1/28/2025', '9/29/2024', '10/19/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (175, 175, '7075', '8/2/2025', '6/28/2025', '3/8/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (176, 176, '3', '5/26/2025', '8/20/2025', '10/26/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (177, 177, '5718', '11/4/2024', '3/16/2025', '7/3/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (178, 178, '177', '9/4/2025', '3/11/2025', '12/4/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (179, 179, '0', '1/28/2025', '5/11/2025', '6/28/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (180, 180, '36', '9/7/2025', '5/26/2025', '5/20/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (181, 181, '46', '5/4/2025', '12/31/2024', '12/6/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (182, 182, '523', '3/18/2025', '12/25/2024', '8/30/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (183, 183, '8311', '12/26/2024', '9/16/2025', '12/20/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (184, 184, '7064', '7/12/2025', '8/26/2025', '5/11/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (185, 185, '5941', '1/19/2025', '9/17/2025', '9/12/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (186, 186, '47200', '2/2/2025', '12/31/2024', '5/13/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (187, 187, '89', '12/21/2024', '4/16/2025', '6/10/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (188, 188, '927', '9/12/2025', '12/14/2024', '12/7/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (189, 189, '6652', '10/1/2024', '4/19/2025', '12/4/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (190, 190, '6', '8/13/2025', '1/2/2025', '9/28/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (191, 191, '28636', '7/1/2025', '11/19/2024', '10/20/2024');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (192, 192, '895', '3/5/2025', '3/20/2025', '9/2/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (193, 193, '640', '11/27/2024', '9/11/2025', '2/9/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (194, 194, '698', '3/31/2025', '2/26/2025', '2/10/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (195, 195, '2153', '4/29/2025', '4/28/2025', '2/19/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (196, 196, '33143', '1/9/2025', '1/14/2025', '8/17/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (197, 197, '6', '11/8/2024', '2/20/2025', '9/17/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (198, 198, '594', '2/17/2025', '7/1/2025', '6/6/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (199, 199, '1430', '1/12/2025', '7/1/2025', '2/9/2025');
insert into boarding_pass (boarding_pass_id, booking_id, seat, boarding_time, created_at, updated_at) values (200, 200, '814', '2/20/2025', '5/1/2025', '2/4/2025');


DROP TABLE IF EXISTS flights CASCADE;
CREATE TABLE flights (
    flight_id INT PRIMARY KEY NOT NULL,
    sch_departure_time TIMESTAMP NOT NULL,
    sch_arrival_time TIMESTAMP NOT NULL,
    departing_airport_id INT NOT NULL,
    arriving_airport_id INT NOT NULL,
    departing_gate VARCHAR(50) NOT NULL,
    arriving_gate VARCHAR(50) NOT NULL,
    airline_id INT NOT NULL,
    act_departure_time TIMESTAMP NOT NULL,
    act_arrival_time TIMESTAMP NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (1, '9/13/2025', '11/8/2024', 1, 1, 'QR9847', 'QR', 1, '7/24/2025', '7/4/2025', '11/28/2024', '8/15/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (2, '7/10/2025', '6/17/2025', 2, 2, 'LA2448', 'LA', 2, '8/7/2025', '9/3/2025', '1/10/2025', '3/10/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (3, '9/21/2025', '9/26/2024', 3, 3, 'NH6128', 'NH', 3, '11/19/2024', '3/13/2025', '9/30/2024', '6/4/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (4, '6/20/2025', '3/8/2025', 4, 4, 'BA7332', 'BA', 4, '4/10/2025', '8/7/2025', '2/25/2025', '11/11/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (5, '8/30/2025', '6/6/2025', 5, 5, 'AA6702', 'AA', 5, '7/21/2025', '3/10/2025', '4/7/2025', '10/28/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (6, '3/20/2025', '5/20/2025', 6, 6, 'NH4005', 'NH', 6, '3/12/2025', '6/22/2025', '10/23/2024', '4/15/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (7, '3/20/2025', '4/12/2025', 7, 7, 'SK4201', 'SK', 7, '7/13/2025', '9/3/2025', '2/3/2025', '6/16/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (8, '10/6/2024', '3/9/2025', 8, 8, 'UA7982', 'UA', 8, '5/9/2025', '5/27/2025', '10/24/2024', '11/23/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (9, '3/9/2025', '7/17/2025', 9, 9, 'SQ8522', 'SQ', 9, '10/24/2024', '12/5/2024', '4/1/2025', '7/31/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (10, '6/4/2025', '7/10/2025', 10, 10, 'SQ9811', 'SQ', 10, '3/16/2025', '6/20/2025', '12/9/2024', '8/8/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (11, '5/27/2025', '7/4/2025', 11, 11, 'KL6990', 'KL', 11, '9/30/2024', '6/14/2025', '3/25/2025', '4/1/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (12, '2/26/2025', '12/18/2024', 12, 12, 'SA2079', 'SA', 12, '6/11/2025', '5/2/2025', '4/29/2025', '7/30/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (13, '12/6/2024', '5/20/2025', 13, 13, 'LH7664', 'LH', 13, '9/9/2025', '2/9/2025', '10/28/2024', '4/10/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (14, '10/31/2024', '6/25/2025', 14, 14, 'ET8018', 'ET', 14, '3/20/2025', '12/25/2024', '8/11/2025', '8/3/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (15, '2/6/2025', '10/10/2024', 15, 15, 'SQ6821', 'SQ', 15, '12/23/2024', '11/10/2024', '6/11/2025', '6/30/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (16, '3/8/2025', '7/7/2025', 16, 16, 'KL3724', 'KL', 16, '8/7/2025', '8/5/2025', '11/23/2024', '5/18/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (17, '3/28/2025', '5/15/2025', 17, 17, 'TG4099', 'TG', 17, '9/19/2025', '11/7/2024', '7/28/2025', '7/3/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (18, '10/30/2024', '3/30/2025', 18, 18, 'QR2435', 'QR', 18, '6/30/2025', '4/26/2025', '2/2/2025', '1/11/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (19, '12/27/2024', '4/22/2025', 19, 19, 'QF6330', 'QF', 19, '5/15/2025', '7/18/2025', '7/12/2025', '6/30/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (20, '5/11/2025', '11/8/2024', 20, 20, 'QR2115', 'QR', 20, '4/9/2025', '7/4/2025', '8/6/2025', '10/14/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (21, '9/8/2025', '4/9/2025', 21, 21, 'AV2802', 'AV', 21, '1/17/2025', '10/20/2024', '12/18/2024', '4/26/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (22, '10/18/2024', '4/6/2025', 22, 22, 'NZ5671', 'NZ', 22, '1/27/2025', '3/13/2025', '5/11/2025', '7/22/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (23, '6/20/2025', '7/8/2025', 23, 23, 'QR1805', 'QR', 23, '7/22/2025', '4/8/2025', '10/29/2024', '7/24/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (24, '4/13/2025', '3/2/2025', 24, 24, 'NZ8723', 'NZ', 24, '2/1/2025', '1/21/2025', '2/6/2025', '12/26/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (25, '10/28/2024', '6/21/2025', 25, 25, 'DL9915', 'DL', 25, '6/5/2025', '11/24/2024', '5/5/2025', '1/15/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (26, '11/9/2024', '12/24/2024', 26, 26, 'KL3301', 'KL', 26, '5/26/2025', '4/20/2025', '10/20/2024', '11/26/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (27, '4/30/2025', '5/17/2025', 27, 27, 'AV3764', 'AV', 27, '9/27/2024', '5/13/2025', '6/4/2025', '9/18/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (28, '1/4/2025', '4/19/2025', 28, 28, 'AC9069', 'AC', 28, '6/28/2025', '6/14/2025', '12/6/2024', '10/11/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (29, '10/4/2024', '3/8/2025', 29, 29, 'ET3606', 'ET', 29, '11/14/2024', '12/22/2024', '3/1/2025', '11/22/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (30, '11/3/2024', '8/6/2025', 30, 30, 'IB3593', 'IB', 30, '9/17/2025', '11/12/2024', '5/9/2025', '7/26/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (31, '7/8/2025', '9/27/2024', 31, 31, 'AM8408', 'AM', 31, '1/30/2025', '10/2/2024', '7/25/2025', '6/25/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (32, '7/3/2025', '1/16/2025', 32, 32, 'AC5771', 'AC', 32, '6/4/2025', '12/19/2024', '12/12/2024', '2/10/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (33, '11/22/2024', '2/14/2025', 33, 33, 'AM3107', 'AM', 33, '4/14/2025', '10/7/2024', '12/17/2024', '9/14/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (34, '2/26/2025', '3/24/2025', 34, 34, 'LH9661', 'LH', 34, '10/29/2024', '11/18/2024', '3/7/2025', '7/13/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (35, '1/23/2025', '3/7/2025', 35, 35, 'AM3012', 'AM', 35, '12/7/2024', '5/8/2025', '5/20/2025', '8/4/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (36, '11/6/2024', '11/21/2024', 36, 36, 'AZ2749', 'AZ', 36, '8/1/2025', '4/27/2025', '9/2/2025', '9/29/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (37, '8/27/2025', '6/4/2025', 37, 37, 'SA2779', 'SA', 37, '1/21/2025', '6/3/2025', '2/22/2025', '10/17/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (38, '8/16/2025', '3/11/2025', 38, 38, 'SK1381', 'SK', 38, '9/17/2025', '7/28/2025', '4/28/2025', '9/20/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (39, '7/18/2025', '5/3/2025', 39, 39, 'AI9592', 'AI', 39, '4/28/2025', '2/28/2025', '12/8/2024', '2/3/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (40, '10/6/2024', '6/20/2025', 40, 40, 'AI2595', 'AI', 40, '5/11/2025', '9/26/2024', '5/15/2025', '12/1/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (41, '6/28/2025', '3/7/2025', 41, 41, 'AV9841', 'AV', 41, '8/2/2025', '2/2/2025', '1/2/2025', '2/27/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (42, '1/30/2025', '10/3/2024', 42, 42, 'BA1466', 'BA', 42, '9/6/2025', '12/22/2024', '1/20/2025', '4/30/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (43, '8/27/2025', '5/13/2025', 43, 43, 'QR5322', 'QR', 43, '6/23/2025', '10/17/2024', '10/16/2024', '2/8/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (44, '10/17/2024', '12/10/2024', 44, 44, 'LA3855', 'LA', 44, '10/14/2024', '7/6/2025', '1/4/2025', '6/10/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (45, '11/25/2024', '11/14/2024', 45, 45, 'LA5423', 'LA', 45, '10/28/2024', '8/5/2025', '6/5/2025', '9/29/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (46, '1/14/2025', '1/4/2025', 46, 46, 'KL7867', 'KL', 46, '7/10/2025', '8/1/2025', '4/22/2025', '11/11/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (47, '9/26/2024', '7/11/2025', 47, 47, 'KL1655', 'KL', 47, '9/20/2025', '12/16/2024', '3/17/2025', '5/3/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (48, '12/8/2024', '11/28/2024', 48, 48, 'ET4205', 'ET', 48, '10/8/2024', '3/18/2025', '10/20/2024', '2/8/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (49, '7/5/2025', '12/9/2024', 49, 49, 'SK5443', 'SK', 49, '6/3/2025', '5/16/2025', '4/17/2025', '2/9/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (50, '7/2/2025', '6/9/2025', 50, 50, 'SQ4766', 'SQ', 50, '1/24/2025', '1/18/2025', '12/27/2024', '12/7/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (51, '9/9/2025', '4/17/2025', 51, 51, 'NZ1348', 'NZ', 51, '12/4/2024', '5/1/2025', '7/19/2025', '10/21/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (52, '10/20/2024', '5/29/2025', 52, 52, 'ET6038', 'ET', 52, '6/16/2025', '10/13/2024', '2/5/2025', '12/9/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (53, '12/20/2024', '9/17/2025', 53, 53, 'SK4478', 'SK', 53, '2/26/2025', '11/4/2024', '11/30/2024', '10/14/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (54, '4/5/2025', '10/8/2024', 54, 54, 'IB5378', 'IB', 54, '4/24/2025', '9/26/2024', '12/8/2024', '11/22/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (55, '11/30/2024', '9/5/2025', 55, 55, 'EK9900', 'EK', 55, '10/12/2024', '7/27/2025', '3/16/2025', '10/28/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (56, '11/20/2024', '8/18/2025', 56, 56, 'AF5854', 'AF', 56, '10/17/2024', '12/5/2024', '3/7/2025', '9/2/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (57, '6/30/2025', '3/4/2025', 57, 57, 'QR5361', 'QR', 57, '2/5/2025', '10/14/2024', '8/21/2025', '1/9/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (58, '8/6/2025', '6/15/2025', 58, 58, 'SQ1881', 'SQ', 58, '10/22/2024', '3/12/2025', '7/19/2025', '7/24/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (59, '2/13/2025', '3/4/2025', 59, 59, 'AZ8989', 'AZ', 59, '3/19/2025', '8/13/2025', '10/27/2024', '8/17/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (60, '10/28/2024', '11/25/2024', 60, 60, 'AC9069', 'AC', 60, '12/14/2024', '8/20/2025', '6/11/2025', '12/14/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (61, '10/2/2024', '6/11/2025', 61, 61, 'BA2476', 'BA', 61, '12/9/2024', '2/12/2025', '6/12/2025', '2/17/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (62, '7/4/2025', '7/29/2025', 62, 62, 'AI2455', 'AI', 62, '12/1/2024', '12/6/2024', '5/24/2025', '4/16/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (63, '12/14/2024', '4/12/2025', 63, 63, 'AZ5740', 'AZ', 63, '8/27/2025', '2/5/2025', '7/30/2025', '10/7/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (64, '9/25/2024', '6/4/2025', 64, 64, 'AI1786', 'AI', 64, '11/28/2024', '8/7/2025', '10/19/2024', '11/19/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (65, '12/14/2024', '1/30/2025', 65, 65, 'SQ5942', 'SQ', 65, '11/28/2024', '7/24/2025', '5/31/2025', '12/1/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (66, '10/26/2024', '9/3/2025', 66, 66, 'WN1644', 'WN', 66, '12/2/2024', '5/2/2025', '5/31/2025', '9/26/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (67, '3/8/2025', '6/11/2025', 67, 67, 'QR2424', 'QR', 67, '5/16/2025', '1/26/2025', '11/19/2024', '5/14/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (68, '6/20/2025', '8/8/2025', 68, 68, 'NZ6489', 'NZ', 68, '11/11/2024', '1/14/2025', '2/14/2025', '3/25/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (69, '1/13/2025', '5/23/2025', 69, 69, 'SK8606', 'SK', 69, '12/6/2024', '4/7/2025', '3/24/2025', '11/3/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (70, '9/25/2024', '8/8/2025', 70, 70, 'AZ5926', 'AZ', 70, '3/15/2025', '3/31/2025', '1/14/2025', '8/20/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (71, '4/3/2025', '8/23/2025', 71, 71, 'AC9922', 'AC', 71, '4/8/2025', '12/24/2024', '8/25/2025', '1/26/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (72, '3/3/2025', '7/18/2025', 72, 72, 'UA4868', 'UA', 72, '11/9/2024', '12/12/2024', '5/9/2025', '7/14/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (73, '11/16/2024', '9/7/2025', 73, 73, 'SQ9432', 'SQ', 73, '2/22/2025', '9/4/2025', '12/6/2024', '6/28/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (74, '3/9/2025', '8/5/2025', 74, 74, 'AC8416', 'AC', 74, '10/20/2024', '3/8/2025', '10/6/2024', '1/31/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (75, '5/20/2025', '4/5/2025', 75, 75, 'NH7338', 'NH', 75, '9/5/2025', '4/30/2025', '4/18/2025', '5/12/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (76, '9/22/2025', '4/27/2025', 76, 76, 'UA8496', 'UA', 76, '12/20/2024', '8/3/2025', '9/30/2024', '6/18/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (77, '5/12/2025', '9/11/2025', 77, 77, 'LH6965', 'LH', 77, '8/30/2025', '8/13/2025', '9/17/2025', '1/5/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (78, '2/8/2025', '12/3/2024', 78, 78, 'UA6894', 'UA', 78, '2/5/2025', '10/30/2024', '3/10/2025', '11/13/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (79, '9/24/2024', '9/10/2025', 79, 79, 'QF1061', 'QF', 79, '7/13/2025', '5/29/2025', '2/27/2025', '11/23/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (80, '2/27/2025', '8/17/2025', 80, 80, 'KL2554', 'KL', 80, '1/16/2025', '1/13/2025', '12/24/2024', '4/16/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (81, '7/2/2025', '9/17/2025', 81, 81, 'QR5078', 'QR', 81, '12/22/2024', '2/28/2025', '3/15/2025', '5/15/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (82, '8/22/2025', '7/20/2025', 82, 82, 'NH1887', 'NH', 82, '3/29/2025', '2/6/2025', '8/5/2025', '11/23/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (83, '4/14/2025', '5/5/2025', 83, 83, 'NZ7915', 'NZ', 83, '6/26/2025', '12/29/2024', '10/6/2024', '8/18/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (84, '7/21/2025', '9/8/2025', 84, 84, 'KL6096', 'KL', 84, '12/2/2024', '2/15/2025', '1/5/2025', '5/18/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (85, '8/27/2025', '3/26/2025', 85, 85, 'EK7699', 'EK', 85, '7/8/2025', '5/3/2025', '9/9/2025', '8/27/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (86, '1/13/2025', '10/29/2024', 86, 86, 'NH6128', 'NH', 86, '11/23/2024', '5/1/2025', '8/15/2025', '12/12/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (87, '5/1/2025', '11/10/2024', 87, 87, 'DL3040', 'DL', 87, '11/23/2024', '8/11/2025', '3/13/2025', '8/28/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (88, '10/1/2024', '7/6/2025', 88, 88, 'WN3122', 'WN', 88, '3/31/2025', '3/12/2025', '4/6/2025', '11/14/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (89, '10/29/2024', '3/20/2025', 89, 89, 'AI7280', 'AI', 89, '10/21/2024', '8/7/2025', '2/16/2025', '1/18/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (90, '2/16/2025', '6/18/2025', 90, 90, 'KE9917', 'KE', 90, '5/6/2025', '7/5/2025', '3/18/2025', '8/20/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (91, '3/18/2025', '6/24/2025', 91, 91, 'AI1534', 'AI', 91, '12/24/2024', '7/20/2025', '11/25/2024', '10/8/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (92, '6/4/2025', '1/27/2025', 92, 92, 'EK9582', 'EK', 92, '6/18/2025', '10/6/2024', '3/5/2025', '5/12/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (93, '9/9/2025', '2/14/2025', 93, 93, 'AM4751', 'AM', 93, '6/1/2025', '12/12/2024', '8/14/2025', '3/16/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (94, '4/12/2025', '12/30/2024', 94, 94, 'AM7831', 'AM', 94, '6/1/2025', '3/17/2025', '7/20/2025', '2/3/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (95, '11/2/2024', '2/23/2025', 95, 95, 'AF1560', 'AF', 95, '3/23/2025', '1/12/2025', '6/28/2025', '7/17/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (96, '10/14/2024', '10/27/2024', 96, 96, 'AF6433', 'AF', 96, '6/27/2025', '5/6/2025', '3/20/2025', '3/3/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (97, '2/4/2025', '10/23/2024', 97, 97, 'KL9667', 'KL', 97, '1/22/2025', '4/8/2025', '4/7/2025', '9/19/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (98, '4/6/2025', '12/16/2024', 98, 98, 'NH5575', 'NH', 98, '1/27/2025', '5/26/2025', '4/24/2025', '11/30/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (99, '8/23/2025', '3/13/2025', 99, 99, 'SQ4965', 'SQ', 99, '3/8/2025', '8/6/2025', '2/2/2025', '10/18/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (100, '4/18/2025', '2/1/2025', 100, 100, 'KL1655', 'KL', 100, '3/6/2025', '4/30/2025', '5/19/2025', '1/15/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (101, '10/14/2024', '1/1/2025', 101, 101, 'CX3889', 'CX', 101, '3/3/2025', '9/30/2024', '8/30/2025', '12/23/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (102, '1/15/2025', '9/3/2025', 102, 102, 'NZ7374', 'NZ', 102, '7/1/2025', '10/17/2024', '9/6/2025', '4/30/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (103, '6/6/2025', '9/17/2025', 103, 103, 'ET9188', 'ET', 103, '3/16/2025', '8/18/2025', '3/31/2025', '4/11/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (104, '11/24/2024', '8/15/2025', 104, 104, 'SK4201', 'SK', 104, '7/3/2025', '7/14/2025', '11/10/2024', '9/9/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (105, '8/26/2025', '4/8/2025', 105, 105, 'SA1026', 'SA', 105, '10/9/2024', '10/9/2024', '12/30/2024', '3/13/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (106, '5/23/2025', '10/31/2024', 106, 106, 'AI1786', 'AI', 106, '2/10/2025', '3/14/2025', '11/7/2024', '11/5/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (107, '5/11/2025', '5/16/2025', 107, 107, 'AC8527', 'AC', 107, '10/29/2024', '12/11/2024', '8/25/2025', '9/5/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (108, '4/30/2025', '11/20/2024', 108, 108, 'BA6869', 'BA', 108, '1/26/2025', '10/20/2024', '2/28/2025', '2/12/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (109, '2/3/2025', '6/1/2025', 109, 109, 'NH9924', 'NH', 109, '12/19/2024', '5/5/2025', '7/5/2025', '9/23/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (110, '5/30/2025', '3/23/2025', 110, 110, 'LH1304', 'LH', 110, '2/6/2025', '12/25/2024', '10/10/2024', '10/16/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (111, '1/5/2025', '9/18/2025', 111, 111, 'AM9465', 'AM', 111, '12/6/2024', '8/15/2025', '4/24/2025', '1/8/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (112, '9/12/2025', '3/28/2025', 112, 112, 'BA9707', 'BA', 112, '11/21/2024', '6/7/2025', '9/20/2025', '8/20/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (113, '12/23/2024', '10/6/2024', 113, 113, 'NZ2252', 'NZ', 113, '6/14/2025', '6/29/2025', '3/5/2025', '10/9/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (114, '4/23/2025', '1/22/2025', 114, 114, 'WN8112', 'WN', 114, '4/28/2025', '11/14/2024', '3/4/2025', '2/26/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (115, '6/21/2025', '1/14/2025', 115, 115, 'KE8751', 'KE', 115, '5/31/2025', '4/5/2025', '9/4/2025', '8/25/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (116, '9/1/2025', '3/3/2025', 116, 116, 'AA2865', 'AA', 116, '3/10/2025', '7/7/2025', '9/12/2025', '11/15/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (117, '12/5/2024', '4/10/2025', 117, 117, 'QR6944', 'QR', 117, '11/1/2024', '1/8/2025', '4/11/2025', '2/5/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (118, '7/27/2025', '12/18/2024', 118, 118, 'DL1701', 'DL', 118, '1/19/2025', '6/11/2025', '6/18/2025', '6/16/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (119, '7/11/2025', '10/22/2024', 119, 119, 'AA5996', 'AA', 119, '4/12/2025', '7/30/2025', '4/22/2025', '1/7/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (120, '7/7/2025', '9/3/2025', 120, 120, 'WN8883', 'WN', 120, '12/4/2024', '8/5/2025', '2/21/2025', '1/10/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (121, '10/14/2024', '5/24/2025', 121, 121, 'AZ1726', 'AZ', 121, '8/14/2025', '9/9/2025', '1/23/2025', '8/22/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (122, '12/30/2024', '3/26/2025', 122, 122, 'NH1430', 'NH', 122, '3/23/2025', '11/23/2024', '3/23/2025', '7/16/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (123, '4/12/2025', '3/24/2025', 123, 123, 'AF6240', 'AF', 123, '7/27/2025', '4/12/2025', '12/22/2024', '1/8/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (124, '10/7/2024', '3/30/2025', 124, 124, 'ET1809', 'ET', 124, '2/5/2025', '8/14/2025', '11/16/2024', '7/16/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (125, '8/10/2025', '4/21/2025', 125, 125, 'KL5381', 'KL', 125, '3/1/2025', '11/13/2024', '8/29/2025', '8/16/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (126, '5/27/2025', '1/4/2025', 126, 126, 'SQ8523', 'SQ', 126, '12/30/2024', '10/2/2024', '12/8/2024', '10/24/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (127, '1/26/2025', '6/10/2025', 127, 127, 'AM2655', 'AM', 127, '12/8/2024', '4/3/2025', '3/30/2025', '6/21/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (128, '5/31/2025', '12/3/2024', 128, 128, 'QF7187', 'QF', 128, '7/1/2025', '9/11/2025', '12/16/2024', '10/26/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (129, '9/21/2025', '5/4/2025', 129, 129, 'AI4444', 'AI', 129, '12/26/2024', '6/30/2025', '2/27/2025', '8/16/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (130, '4/8/2025', '7/23/2025', 130, 130, 'AI5177', 'AI', 130, '1/23/2025', '4/5/2025', '11/6/2024', '1/31/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (131, '7/18/2025', '6/1/2025', 131, 131, 'ET5853', 'ET', 131, '7/21/2025', '8/8/2025', '12/30/2024', '8/28/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (132, '10/6/2024', '12/28/2024', 132, 132, 'AF9744', 'AF', 132, '10/19/2024', '12/29/2024', '8/23/2025', '10/20/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (133, '6/19/2025', '2/16/2025', 133, 133, 'KL3664', 'KL', 133, '5/5/2025', '11/15/2024', '9/14/2025', '6/4/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (134, '7/19/2025', '6/10/2025', 134, 134, 'AA5655', 'AA', 134, '7/7/2025', '7/26/2025', '12/14/2024', '8/9/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (135, '12/4/2024', '1/31/2025', 135, 135, 'NH6679', 'NH', 135, '10/25/2024', '4/13/2025', '12/29/2024', '7/21/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (136, '5/7/2025', '7/30/2025', 136, 136, 'SA8769', 'SA', 136, '4/30/2025', '3/29/2025', '10/20/2024', '1/24/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (137, '3/26/2025', '1/18/2025', 137, 137, 'UA6626', 'UA', 137, '9/21/2025', '3/20/2025', '7/27/2025', '9/18/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (138, '4/2/2025', '5/26/2025', 138, 138, 'LH4128', 'LH', 138, '3/29/2025', '8/11/2025', '12/24/2024', '11/12/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (139, '12/29/2024', '10/13/2024', 139, 139, 'AA9225', 'AA', 139, '8/18/2025', '10/23/2024', '12/14/2024', '11/2/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (140, '12/29/2024', '9/1/2025', 140, 140, 'SQ6592', 'SQ', 140, '5/11/2025', '7/29/2025', '12/2/2024', '10/16/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (141, '5/7/2025', '1/10/2025', 141, 141, 'BA1599', 'BA', 141, '8/1/2025', '2/17/2025', '3/20/2025', '12/17/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (142, '4/15/2025', '1/1/2025', 142, 142, 'NZ2165', 'NZ', 142, '2/20/2025', '12/13/2024', '3/31/2025', '1/20/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (143, '3/4/2025', '9/2/2025', 143, 143, 'IB3042', 'IB', 143, '1/26/2025', '1/18/2025', '12/22/2024', '6/10/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (144, '11/9/2024', '2/11/2025', 144, 144, 'SK3030', 'SK', 144, '8/24/2025', '8/19/2025', '5/29/2025', '11/28/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (145, '7/12/2025', '11/17/2024', 145, 145, 'WN8234', 'WN', 145, '7/12/2025', '9/6/2025', '12/13/2024', '4/28/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (146, '12/2/2024', '6/21/2025', 146, 146, 'NH7849', 'NH', 146, '5/27/2025', '8/12/2025', '5/25/2025', '7/5/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (147, '7/16/2025', '8/19/2025', 147, 147, 'BA7831', 'BA', 147, '1/29/2025', '8/17/2025', '3/9/2025', '11/3/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (148, '6/20/2025', '4/15/2025', 148, 148, 'IB4654', 'IB', 148, '8/18/2025', '12/1/2024', '10/8/2024', '4/17/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (149, '11/26/2024', '6/24/2025', 149, 149, 'KL8508', 'KL', 149, '4/9/2025', '7/4/2025', '9/25/2024', '7/7/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (150, '3/13/2025', '5/6/2025', 150, 150, 'QR1463', 'QR', 150, '12/25/2024', '4/16/2025', '9/17/2025', '11/20/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (151, '1/4/2025', '1/20/2025', 151, 151, 'NZ7915', 'NZ', 151, '7/12/2025', '3/15/2025', '3/7/2025', '2/3/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (152, '2/4/2025', '5/23/2025', 152, 152, 'AC8527', 'AC', 152, '10/21/2024', '3/19/2025', '11/22/2024', '6/2/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (153, '5/11/2025', '1/14/2025', 153, 153, 'TG2389', 'TG', 153, '7/22/2025', '1/27/2025', '8/25/2025', '1/23/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (154, '12/20/2024', '3/20/2025', 154, 154, 'LA8052', 'LA', 154, '9/8/2025', '5/13/2025', '10/21/2024', '10/9/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (155, '10/26/2024', '1/31/2025', 155, 155, 'IB1843', 'IB', 155, '6/24/2025', '1/11/2025', '3/26/2025', '1/11/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (156, '4/25/2025', '9/3/2025', 156, 156, 'WN9242', 'WN', 156, '12/11/2024', '3/3/2025', '11/21/2024', '8/25/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (157, '8/4/2025', '1/24/2025', 157, 157, 'UA1667', 'UA', 157, '7/13/2025', '6/15/2025', '7/17/2025', '4/24/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (158, '12/31/2024', '8/20/2025', 158, 158, 'LA5411', 'LA', 158, '6/25/2025', '3/19/2025', '9/16/2025', '6/12/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (159, '1/14/2025', '2/1/2025', 159, 159, 'SA1147', 'SA', 159, '5/14/2025', '2/12/2025', '9/8/2025', '4/16/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (160, '3/19/2025', '8/25/2025', 160, 160, 'WN2811', 'WN', 160, '1/12/2025', '2/14/2025', '6/26/2025', '9/9/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (161, '12/4/2024', '11/17/2024', 161, 161, 'SQ5942', 'SQ', 161, '7/15/2025', '10/9/2024', '12/21/2024', '6/1/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (162, '3/14/2025', '8/9/2025', 162, 162, 'SK4116', 'SK', 162, '6/13/2025', '8/15/2025', '4/8/2025', '5/29/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (163, '10/22/2024', '10/30/2024', 163, 163, 'AZ2355', 'AZ', 163, '12/28/2024', '10/20/2024', '5/27/2025', '6/20/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (164, '3/6/2025', '11/28/2024', 164, 164, 'AV3743', 'AV', 164, '5/6/2025', '1/19/2025', '5/12/2025', '3/12/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (165, '7/12/2025', '3/25/2025', 165, 165, 'SA1965', 'SA', 165, '2/4/2025', '3/30/2025', '10/30/2024', '5/30/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (166, '7/14/2025', '2/8/2025', 166, 166, 'TG8096', 'TG', 166, '10/4/2024', '4/26/2025', '6/2/2025', '11/14/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (167, '7/19/2025', '10/19/2024', 167, 167, 'AM3761', 'AM', 167, '4/10/2025', '10/29/2024', '9/29/2024', '6/26/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (168, '4/20/2025', '10/23/2024', 168, 168, 'SK5342', 'SK', 168, '5/29/2025', '7/24/2025', '1/2/2025', '5/8/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (169, '8/22/2025', '12/12/2024', 169, 169, 'IB8898', 'IB', 169, '5/7/2025', '9/9/2025', '4/26/2025', '4/7/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (170, '1/22/2025', '6/10/2025', 170, 170, 'DL2404', 'DL', 170, '11/12/2024', '3/4/2025', '8/11/2025', '8/13/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (171, '1/20/2025', '5/31/2025', 171, 171, 'SA8899', 'SA', 171, '2/3/2025', '9/29/2024', '8/2/2025', '7/29/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (172, '2/8/2025', '4/21/2025', 172, 172, 'AA8312', 'AA', 172, '9/26/2024', '10/16/2024', '6/26/2025', '4/12/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (173, '4/16/2025', '1/18/2025', 173, 173, 'AC7816', 'AC', 173, '2/14/2025', '12/26/2024', '6/24/2025', '7/6/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (174, '6/6/2025', '4/15/2025', 174, 174, 'KE2000', 'KE', 174, '11/5/2024', '2/19/2025', '7/26/2025', '12/31/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (175, '11/25/2024', '9/17/2025', 175, 175, 'SQ4035', 'SQ', 175, '7/21/2025', '2/9/2025', '11/15/2024', '3/28/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (176, '5/19/2025', '5/6/2025', 176, 176, 'CX3169', 'CX', 176, '8/1/2025', '2/22/2025', '9/20/2025', '6/21/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (177, '1/25/2025', '5/5/2025', 177, 177, 'KE3851', 'KE', 177, '11/19/2024', '10/24/2024', '11/28/2024', '10/16/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (178, '2/16/2025', '2/1/2025', 178, 178, 'IB9642', 'IB', 178, '5/17/2025', '1/7/2025', '8/23/2025', '7/18/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (179, '7/24/2025', '8/16/2025', 179, 179, 'SA8119', 'SA', 179, '2/22/2025', '5/27/2025', '7/13/2025', '3/22/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (180, '5/16/2025', '9/27/2024', 180, 180, 'QF3265', 'QF', 180, '5/18/2025', '2/17/2025', '11/5/2024', '7/17/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (181, '12/24/2024', '5/12/2025', 181, 181, 'AV9155', 'AV', 181, '1/18/2025', '11/15/2024', '8/13/2025', '5/17/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (182, '10/20/2024', '3/12/2025', 182, 182, 'AC1314', 'AC', 182, '6/15/2025', '8/6/2025', '10/3/2024', '9/2/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (183, '5/21/2025', '11/5/2024', 183, 183, 'LH9661', 'LH', 183, '3/12/2025', '3/4/2025', '10/21/2024', '4/19/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (184, '12/21/2024', '12/15/2024', 184, 184, 'AI3145', 'AI', 184, '9/26/2024', '11/23/2024', '4/13/2025', '7/9/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (185, '5/13/2025', '7/7/2025', 185, 185, 'NH4965', 'NH', 185, '2/9/2025', '2/2/2025', '10/7/2024', '5/10/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (186, '9/7/2025', '4/24/2025', 186, 186, 'IB4379', 'IB', 186, '11/15/2024', '12/21/2024', '3/16/2025', '10/6/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (187, '5/13/2025', '10/22/2024', 187, 187, 'SQ5685', 'SQ', 187, '7/22/2025', '5/18/2025', '1/24/2025', '10/4/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (188, '6/11/2025', '8/9/2025', 188, 188, 'LA1827', 'LA', 188, '1/9/2025', '5/24/2025', '2/1/2025', '3/29/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (189, '8/12/2025', '6/19/2025', 189, 189, 'ET2460', 'ET', 189, '9/26/2024', '9/15/2025', '7/4/2025', '4/22/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (190, '10/2/2024', '8/14/2025', 190, 190, 'SA8401', 'SA', 190, '10/24/2024', '9/18/2025', '4/3/2025', '12/25/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (191, '10/22/2024', '6/26/2025', 191, 191, 'KL4754', 'KL', 191, '4/24/2025', '10/14/2024', '9/11/2025', '9/22/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (192, '2/9/2025', '10/10/2024', 192, 192, 'KL1861', 'KL', 192, '10/22/2024', '10/28/2024', '2/9/2025', '2/16/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (193, '5/7/2025', '12/22/2024', 193, 193, 'KL5959', 'KL', 193, '8/22/2025', '4/30/2025', '11/13/2024', '3/11/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (194, '4/29/2025', '10/11/2024', 194, 194, 'SK4118', 'SK', 194, '12/21/2024', '9/9/2025', '8/20/2025', '12/1/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (195, '9/18/2025', '12/8/2024', 195, 195, 'NZ8857', 'NZ', 195, '5/5/2025', '7/2/2025', '1/2/2025', '9/8/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (196, '12/26/2024', '1/20/2025', 196, 196, 'TG7193', 'TG', 196, '1/20/2025', '8/11/2025', '9/12/2025', '7/20/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (197, '12/5/2024', '10/24/2024', 197, 197, 'UA6565', 'UA', 197, '2/9/2025', '7/18/2025', '11/21/2024', '12/19/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (198, '1/7/2025', '9/17/2025', 198, 198, 'SK9394', 'SK', 198, '9/21/2025', '12/12/2024', '11/29/2024', '11/12/2024');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (199, '7/11/2025', '1/14/2025', 199, 199, 'KL3748', 'KL', 199, '1/14/2025', '5/10/2025', '2/3/2025', '3/30/2025');
insert into flights (flight_id, sch_departure_time, sch_arrival_time, departing_airport_id, arriving_airport_id, departing_gate, arriving_gate, airline_id, act_departure_time, act_arrival_time, created_at, updated_at) values (200, '3/12/2025', '3/28/2025', 200, 200, 'KL7515', 'KL', 200, '12/31/2024', '9/27/2024', '8/26/2025', '10/19/2024');

insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (1, 20, '10/27/2024', '11/28/2024', 1);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (2, 14, '6/1/2025', '3/31/2025', 2);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (3, 12, '10/13/2024', '5/23/2025', 3);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (4, 9, '4/17/2025', '5/30/2025', 4);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (5, 4, '12/29/2024', '12/29/2024', 5);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (6, 3, '5/5/2025', '3/7/2025', 6);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (7, 11, '1/27/2025', '12/28/2024', 7);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (8, 7, '6/19/2025', '10/6/2024', 8);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (9, 5, '10/15/2024', '12/7/2024', 9);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (10, 10, '11/13/2024', '5/9/2025', 10);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (11, 14, '2/27/2025', '5/1/2025', 11);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (12, 6, '7/20/2025', '2/17/2025', 12);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (13, 3, '9/15/2025', '7/5/2025', 13);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (14, 3, '10/25/2024', '12/27/2024', 14);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (15, 10, '5/14/2025', '11/4/2024', 15);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (16, 4, '8/10/2025', '8/17/2025', 16);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (17, 21, '12/6/2024', '4/16/2025', 17);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (18, 19, '9/18/2025', '6/19/2025', 18);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (19, 7, '1/11/2025', '4/18/2025', 19);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (20, 11, '8/28/2025', '4/5/2025', 20);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (21, 14, '6/25/2025', '10/31/2024', 21);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (22, 6, '4/21/2025', '9/3/2025', 22);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (23, 8, '4/18/2025', '11/14/2024', 23);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (24, 16, '1/16/2025', '7/1/2025', 24);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (25, 16, '3/21/2025', '7/23/2025', 25);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (26, 20, '5/26/2025', '3/21/2025', 26);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (27, 10, '8/31/2025', '11/27/2024', 27);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (28, 7, '12/25/2024', '9/12/2025', 28);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (29, 9, '8/18/2025', '2/16/2025', 29);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (30, 1, '11/9/2024', '10/20/2024', 30);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (31, 2, '7/24/2025', '2/6/2025', 31);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (32, 2, '6/12/2025', '5/21/2025', 32);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (33, 18, '6/28/2025', '1/22/2025', 33);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (34, 13, '11/4/2024', '8/12/2025', 34);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (35, 19, '4/1/2025', '12/28/2024', 35);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (36, 16, '12/13/2024', '1/18/2025', 36);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (37, 21, '6/19/2025', '11/23/2024', 37);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (38, 24, '3/21/2025', '3/25/2025', 38);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (39, 7, '9/19/2025', '5/28/2025', 39);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (40, 22, '9/4/2025', '5/18/2025', 40);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (41, 15, '4/29/2025', '10/9/2024', 41);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (42, 10, '11/5/2024', '2/16/2025', 42);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (43, 19, '6/1/2025', '4/17/2025', 43);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (44, 13, '7/9/2025', '7/12/2025', 44);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (45, 16, '11/17/2024', '12/16/2024', 45);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (46, 25, '1/17/2025', '11/16/2024', 46);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (47, 8, '10/10/2024', '2/19/2025', 47);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (48, 13, '5/17/2025', '12/29/2024', 48);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (49, 20, '7/6/2025', '9/16/2025', 49);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (50, 7, '10/21/2024', '7/21/2025', 50);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (51, 16, '6/15/2025', '10/18/2024', 51);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (52, 7, '6/1/2025', '8/20/2025', 52);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (53, 22, '6/25/2025', '3/14/2025', 53);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (54, 23, '9/30/2024', '9/1/2025', 54);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (55, 14, '7/15/2025', '8/15/2025', 55);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (56, 5, '1/5/2025', '7/20/2025', 56);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (57, 6, '9/23/2024', '7/15/2025', 57);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (58, 17, '8/14/2025', '5/6/2025', 58);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (59, 9, '5/26/2025', '2/11/2025', 59);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (60, 14, '6/6/2025', '2/7/2025', 60);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (61, 23, '5/29/2025', '6/21/2025', 61);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (62, 20, '1/17/2025', '2/7/2025', 62);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (63, 16, '5/13/2025', '3/6/2025', 63);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (64, 7, '5/6/2025', '2/8/2025', 64);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (65, 13, '1/2/2025', '10/7/2024', 65);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (66, 24, '12/2/2024', '9/24/2024', 66);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (67, 15, '12/10/2024', '9/13/2025', 67);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (68, 11, '4/18/2025', '10/28/2024', 68);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (69, 5, '3/28/2025', '6/5/2025', 69);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (70, 25, '2/2/2025', '4/7/2025', 70);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (71, 23, '7/22/2025', '12/10/2024', 71);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (72, 14, '4/7/2025', '2/13/2025', 72);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (73, 4, '3/11/2025', '6/18/2025', 73);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (74, 23, '9/5/2025', '5/1/2025', 74);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (75, 6, '6/3/2025', '8/27/2025', 75);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (76, 12, '10/29/2024', '7/6/2025', 76);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (77, 24, '3/15/2025', '2/17/2025', 77);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (78, 3, '4/8/2025', '10/11/2024', 78);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (79, 15, '3/19/2025', '12/19/2024', 79);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (80, 25, '2/16/2025', '9/20/2025', 80);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (81, 24, '3/19/2025', '3/5/2025', 81);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (82, 12, '2/19/2025', '8/10/2025', 82);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (83, 3, '9/26/2024', '11/15/2024', 83);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (84, 21, '4/16/2025', '1/11/2025', 84);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (85, 2, '2/10/2025', '3/21/2025', 85);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (86, 10, '5/2/2025', '12/18/2024', 86);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (87, 22, '11/13/2024', '5/2/2025', 87);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (88, 12, '2/5/2025', '10/20/2024', 88);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (89, 25, '1/8/2025', '11/4/2024', 89);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (90, 17, '1/23/2025', '9/26/2024', 90);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (91, 14, '9/8/2025', '12/26/2024', 91);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (92, 8, '11/28/2024', '3/29/2025', 92);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (93, 11, '5/12/2025', '1/8/2025', 93);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (94, 2, '1/14/2025', '2/22/2025', 94);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (95, 15, '9/30/2024', '8/4/2025', 95);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (96, 18, '12/15/2024', '11/25/2024', 96);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (97, 11, '1/21/2025', '5/13/2025', 97);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (98, 4, '4/2/2025', '5/17/2025', 98);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (99, 1, '8/1/2025', '3/29/2025', 99);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (100, 10, '5/14/2025', '5/7/2025', 100);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (101, 14, '5/24/2025', '7/4/2025', 101);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (102, 9, '6/10/2025', '8/16/2025', 102);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (103, 23, '8/28/2025', '10/6/2024', 103);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (104, 20, '6/8/2025', '10/20/2024', 104);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (105, 3, '8/24/2025', '2/15/2025', 105);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (106, 24, '10/16/2024', '7/7/2025', 106);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (107, 11, '9/16/2025', '3/25/2025', 107);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (108, 11, '3/5/2025', '5/21/2025', 108);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (109, 1, '3/16/2025', '8/11/2025', 109);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (110, 22, '6/10/2025', '12/23/2024', 110);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (111, 15, '8/7/2025', '3/10/2025', 111);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (112, 9, '10/20/2024', '5/27/2025', 112);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (113, 12, '3/13/2025', '4/16/2025', 113);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (114, 19, '8/8/2025', '3/13/2025', 114);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (115, 7, '9/29/2024', '11/27/2024', 115);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (116, 17, '1/16/2025', '1/6/2025', 116);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (117, 13, '2/26/2025', '4/24/2025', 117);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (118, 10, '7/16/2025', '4/23/2025', 118);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (119, 9, '9/30/2024', '1/30/2025', 119);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (120, 8, '5/6/2025', '3/27/2025', 120);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (121, 13, '3/12/2025', '9/27/2024', 121);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (122, 6, '8/25/2025', '9/16/2025', 122);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (123, 20, '3/10/2025', '2/18/2025', 123);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (124, 12, '4/28/2025', '2/1/2025', 124);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (125, 21, '9/1/2025', '5/5/2025', 125);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (126, 7, '1/10/2025', '4/20/2025', 126);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (127, 21, '10/4/2024', '4/27/2025', 127);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (128, 1, '1/23/2025', '11/11/2024', 128);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (129, 4, '1/2/2025', '9/25/2024', 129);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (130, 22, '6/8/2025', '10/10/2024', 130);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (131, 18, '2/4/2025', '1/20/2025', 131);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (132, 21, '8/30/2025', '4/20/2025', 132);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (133, 23, '4/26/2025', '10/20/2024', 133);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (134, 12, '5/16/2025', '8/26/2025', 134);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (135, 17, '9/4/2025', '11/25/2024', 135);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (136, 16, '10/16/2024', '4/15/2025', 136);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (137, 8, '5/12/2025', '3/2/2025', 137);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (138, 19, '8/2/2025', '10/18/2024', 138);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (139, 7, '11/10/2024', '11/30/2024', 139);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (140, 1, '12/17/2024', '3/4/2025', 140);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (141, 13, '3/19/2025', '5/16/2025', 141);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (142, 24, '11/25/2024', '3/1/2025', 142);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (143, 8, '6/27/2025', '2/17/2025', 143);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (144, 13, '8/8/2025', '1/28/2025', 144);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (145, 7, '7/25/2025', '4/12/2025', 145);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (146, 20, '10/7/2024', '7/8/2025', 146);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (147, 22, '7/27/2025', '8/1/2025', 147);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (148, 15, '12/11/2024', '7/3/2025', 148);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (149, 19, '12/13/2024', '7/29/2025', 149);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (150, 17, '3/28/2025', '10/6/2024', 150);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (151, 3, '4/23/2025', '3/16/2025', 151);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (152, 19, '7/29/2025', '5/21/2025', 152);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (153, 24, '5/5/2025', '2/26/2025', 153);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (154, 3, '5/5/2025', '7/2/2025', 154);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (155, 17, '5/1/2025', '11/2/2024', 155);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (156, 15, '6/10/2025', '1/13/2025', 156);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (157, 25, '3/27/2025', '3/1/2025', 157);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (158, 25, '7/30/2025', '8/11/2025', 158);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (159, 12, '1/14/2025', '6/10/2025', 159);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (160, 17, '6/27/2025', '3/23/2025', 160);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (161, 22, '4/12/2025', '11/20/2024', 161);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (162, 15, '1/15/2025', '5/27/2025', 162);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (163, 16, '5/21/2025', '3/10/2025', 163);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (164, 3, '8/25/2025', '2/22/2025', 164);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (165, 22, '3/9/2025', '4/23/2025', 165);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (166, 5, '8/15/2025', '7/8/2025', 166);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (167, 7, '12/27/2024', '5/17/2025', 167);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (168, 13, '3/15/2025', '1/18/2025', 168);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (169, 15, '6/22/2025', '7/18/2025', 169);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (170, 10, '5/25/2025', '9/1/2025', 170);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (171, 17, '8/20/2025', '8/7/2025', 171);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (172, 19, '1/20/2025', '11/11/2024', 172);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (173, 5, '5/7/2025', '6/19/2025', 173);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (174, 3, '11/18/2024', '8/13/2025', 174);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (175, 1, '8/13/2025', '4/11/2025', 175);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (176, 10, '3/19/2025', '3/2/2025', 176);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (177, 3, '10/20/2024', '4/3/2025', 177);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (178, 18, '12/30/2024', '7/7/2025', 178);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (179, 21, '12/2/2024', '2/18/2025', 179);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (180, 25, '3/25/2025', '1/18/2025', 180);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (181, 11, '4/13/2025', '3/7/2025', 181);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (182, 18, '7/4/2025', '8/7/2025', 182);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (183, 8, '5/25/2025', '7/2/2025', 183);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (184, 7, '1/5/2025', '11/7/2024', 184);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (185, 15, '6/1/2025', '3/22/2025', 185);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (186, 11, '2/26/2025', '8/1/2025', 186);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (187, 12, '3/4/2025', '6/5/2025', 187);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (188, 5, '5/26/2025', '9/25/2024', 188);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (189, 4, '1/13/2025', '4/12/2025', 189);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (190, 13, '10/17/2024', '4/9/2025', 190);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (191, 21, '9/6/2025', '2/4/2025', 191);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (192, 9, '7/2/2025', '3/20/2025', 192);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (193, 24, '10/27/2024', '5/7/2025', 193);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (194, 8, '4/18/2025', '4/24/2025', 194);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (195, 25, '3/13/2025', '7/18/2025', 195);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (196, 2, '5/30/2025', '7/3/2025', 196);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (197, 8, '2/24/2025', '11/4/2024', 197);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (198, 19, '11/30/2024', '10/18/2024', 198);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (199, 7, '5/17/2025', '1/9/2025', 199);
insert into baggage (baggage_id, weight_in_kg, created_at, updated_at, booking_id) values (200, 19, '10/12/2024', '7/23/2025', 200);





insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (1, 'Eartha', '7/4/2025', '5/19/2025', '45527', 1);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (2, 'Morna', '10/28/2024', '6/29/2025', '29', 2);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (3, 'Yettie', '3/26/2025', '3/16/2025', '3815', 3);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (4, 'Averyl', '1/9/2025', '9/1/2025', '56', 4);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (5, 'Raimundo', '1/8/2025', '4/15/2025', '779', 5);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (6, 'Martelle', '4/14/2025', '12/6/2024', '4', 6);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (7, 'Melvyn', '8/8/2025', '6/28/2025', '62734', 7);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (8, 'Lissa', '12/16/2024', '11/6/2024', '51761', 8);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (9, 'Jo ann', '7/5/2025', '6/8/2025', '7', 9);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (10, 'Pammie', '12/3/2024', '4/1/2025', '76', 10);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (11, 'Griffin', '10/8/2024', '9/7/2025', '36', 11);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (12, 'Helen-elizabeth', '2/24/2025', '3/7/2025', '7', 12);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (13, 'Andris', '2/24/2025', '11/3/2024', '3', 13);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (14, 'Vivie', '4/24/2025', '8/19/2025', '696', 14);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (15, 'Abbie', '5/19/2025', '6/15/2025', '32', 15);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (16, 'Antony', '11/14/2024', '9/9/2025', '37', 16);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (17, 'Emili', '11/7/2024', '11/29/2024', '596', 17);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (18, 'Gale', '7/13/2025', '11/2/2024', '27', 18);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (19, 'Fredericka', '9/23/2024', '2/18/2025', '04573', 19);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (20, 'Tynan', '4/23/2025', '4/7/2025', '37', 20);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (21, 'Quincey', '8/4/2025', '6/22/2025', '57724', 21);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (22, 'Angus', '3/17/2025', '8/10/2025', '14322', 22);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (23, 'Gordan', '10/21/2024', '4/14/2025', '68900', 23);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (24, 'Dallas', '6/23/2025', '9/8/2025', '60', 24);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (25, 'Mariele', '4/2/2025', '8/10/2025', '3536', 25);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (26, 'Coralie', '6/13/2025', '5/26/2025', '0', 26);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (27, 'Pacorro', '3/2/2025', '11/4/2024', '474', 27);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (28, 'Joletta', '9/18/2025', '2/8/2025', '18893', 28);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (29, 'Kaylyn', '8/9/2025', '11/9/2024', '1899', 29);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (30, 'Cyrille', '3/22/2025', '11/27/2024', '9', 30);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (31, 'Mona', '4/20/2025', '12/23/2024', '85', 31);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (32, 'Taryn', '8/15/2025', '12/30/2024', '1778', 32);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (33, 'Aidan', '3/12/2025', '8/21/2025', '49583', 33);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (34, 'Gustie', '9/13/2025', '4/25/2025', '33', 34);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (35, 'Carry', '1/20/2025', '7/30/2025', '023', 35);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (36, 'Cassey', '8/15/2025', '4/28/2025', '60', 36);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (37, 'Anetta', '3/15/2025', '8/14/2025', '8', 37);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (38, 'Giffard', '5/4/2025', '4/7/2025', '20', 38);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (39, 'Peggi', '3/18/2025', '8/15/2025', '8291', 39);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (40, 'Gaylene', '8/27/2025', '7/9/2025', '9817', 40);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (41, 'Vince', '7/13/2025', '4/30/2025', '6', 41);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (42, 'Gladys', '2/26/2025', '6/11/2025', '7415', 42);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (43, 'Janka', '6/7/2025', '3/15/2025', '95', 43);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (44, 'Chelsy', '10/9/2024', '3/4/2025', '5913', 44);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (45, 'Hurlee', '5/5/2025', '3/31/2025', '4', 45);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (46, 'Gallard', '11/4/2024', '12/1/2024', '269', 46);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (47, 'Idelle', '12/17/2024', '10/14/2024', '595', 47);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (48, 'Ritchie', '12/31/2024', '10/25/2024', '0', 48);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (49, 'Alexandro', '11/11/2024', '7/22/2025', '82', 49);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (50, 'Alla', '6/15/2025', '12/4/2024', '03', 50);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (51, 'Mab', '1/24/2025', '7/7/2025', '39808', 51);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (52, 'Levon', '11/20/2024', '2/12/2025', '097', 52);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (53, 'Briny', '11/16/2024', '12/12/2024', '8', 53);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (54, 'Klarrisa', '8/2/2025', '6/19/2025', '9410', 54);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (55, 'Irene', '10/18/2024', '5/12/2025', '1182', 55);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (56, 'Stacee', '4/22/2025', '11/11/2024', '87895', 56);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (57, 'Saloma', '5/5/2025', '1/23/2025', '47', 57);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (58, 'Ulrick', '2/23/2025', '1/9/2025', '5885', 58);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (59, 'Jenna', '5/28/2025', '2/15/2025', '7256', 59);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (60, 'Cirilo', '5/1/2025', '7/11/2025', '1631', 60);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (61, 'Grier', '7/29/2025', '3/13/2025', '07862', 61);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (62, 'Nita', '3/24/2025', '2/26/2025', '7281', 62);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (63, 'Bryna', '10/14/2024', '8/10/2025', '076', 63);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (64, 'Sterling', '10/24/2024', '1/12/2025', '86', 64);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (65, 'Nichols', '6/16/2025', '12/27/2024', '9159', 65);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (66, 'Dona', '10/4/2024', '3/19/2025', '61008', 66);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (67, 'Stefan', '11/5/2024', '10/16/2024', '31', 67);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (68, 'Dena', '8/2/2025', '1/13/2025', '1386', 68);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (69, 'Sibylle', '10/30/2024', '1/28/2025', '90067', 69);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (70, 'Alanna', '7/24/2025', '11/23/2024', '498', 70);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (71, 'Clemens', '7/17/2025', '11/21/2024', '3802', 71);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (72, 'Frederick', '5/17/2025', '4/22/2025', '6', 72);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (73, 'Shelia', '4/8/2025', '4/5/2025', '83882', 73);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (74, 'Vittoria', '4/7/2025', '10/23/2024', '41', 74);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (75, 'Caz', '6/11/2025', '7/18/2025', '95', 75);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (76, 'Rabbi', '8/9/2025', '11/2/2024', '47125', 76);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (77, 'Britt', '9/2/2025', '1/17/2025', '84', 77);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (78, 'Jacklin', '8/22/2025', '1/14/2025', '61932', 78);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (79, 'Waverley', '6/29/2025', '1/2/2025', '2205', 79);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (80, 'Agnella', '12/17/2024', '4/5/2025', '52247', 80);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (81, 'Durand', '10/31/2024', '12/7/2024', '480', 81);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (82, 'Annis', '9/27/2024', '5/31/2025', '20', 82);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (83, 'Culver', '10/16/2024', '1/7/2025', '30', 83);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (84, 'Belia', '6/12/2025', '11/27/2024', '1490', 84);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (85, 'Flory', '7/28/2025', '11/27/2024', '75', 85);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (86, 'Adolph', '12/3/2024', '8/27/2025', '4', 86);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (87, 'Cody', '6/23/2025', '2/17/2025', '50', 87);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (88, 'Terence', '11/7/2024', '9/27/2024', '3', 88);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (89, 'Jay', '10/30/2024', '3/9/2025', '45171', 89);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (90, 'Allan', '7/10/2025', '5/20/2025', '065', 90);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (91, 'Becca', '1/2/2025', '10/9/2024', '3307', 91);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (92, 'Ingaberg', '10/10/2024', '10/29/2024', '267', 92);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (93, 'Lauri', '4/19/2025', '8/12/2025', '3707', 93);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (94, 'Mina', '1/6/2025', '2/23/2025', '6', 94);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (95, 'Grady', '3/28/2025', '4/23/2025', '10324', 95);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (96, 'Shoshana', '11/2/2024', '11/25/2024', '3', 96);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (97, 'North', '9/17/2025', '9/3/2025', '062', 97);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (98, 'Delmore', '1/6/2025', '5/7/2025', '078', 98);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (99, 'Falito', '5/27/2025', '7/18/2025', '5', 99);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (100, 'Tommie', '12/7/2024', '4/30/2025', '18147', 100);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (101, 'Dal', '8/22/2025', '4/29/2025', '3', 101);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (102, 'Waneta', '5/7/2025', '9/9/2025', '811', 102);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (103, 'Reed', '2/12/2025', '10/29/2024', '487', 103);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (104, 'Cordy', '4/26/2025', '9/19/2025', '474', 104);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (105, 'Lonee', '7/19/2025', '9/26/2024', '51950', 105);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (106, 'Nolly', '3/31/2025', '12/9/2024', '8', 106);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (107, 'Adamo', '12/6/2024', '11/7/2024', '170', 107);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (108, 'Rafferty', '11/18/2024', '4/27/2025', '1859', 108);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (109, 'Mariejeanne', '8/8/2025', '8/24/2025', '8', 109);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (110, 'Adina', '10/19/2024', '10/10/2024', '454', 110);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (111, 'Alexine', '12/2/2024', '6/16/2025', '07', 111);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (112, 'Cort', '7/31/2025', '8/2/2025', '3', 112);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (113, 'Tracee', '8/15/2025', '3/27/2025', '6655', 113);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (114, 'Abby', '1/9/2025', '5/10/2025', '305', 114);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (115, 'Koressa', '11/15/2024', '3/1/2025', '47', 115);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (116, 'Richmound', '11/14/2024', '9/1/2025', '200', 116);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (117, 'Hill', '7/1/2025', '11/22/2024', '63345', 117);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (118, 'Olivie', '12/27/2024', '1/23/2025', '2', 118);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (119, 'Jacinthe', '11/23/2024', '8/9/2025', '21325', 119);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (120, 'Lotte', '4/4/2025', '12/15/2024', '7717', 120);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (121, 'Tudor', '8/12/2025', '1/5/2025', '43', 121);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (122, 'Rosanna', '6/30/2025', '8/18/2025', '31', 122);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (123, 'Queenie', '12/8/2024', '6/22/2025', '61', 123);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (124, 'Tammara', '1/28/2025', '4/29/2025', '6301', 124);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (125, 'Dominica', '6/21/2025', '5/15/2025', '4611', 125);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (126, 'Garner', '5/30/2025', '1/20/2025', '88290', 126);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (127, 'Cecilla', '11/19/2024', '8/12/2025', '18641', 127);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (128, 'Sheffy', '12/22/2024', '11/8/2024', '73963', 128);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (129, 'Marthe', '2/3/2025', '12/16/2024', '8939', 129);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (130, 'Garnette', '4/21/2025', '10/2/2024', '17', 130);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (131, 'Angele', '2/26/2025', '11/18/2024', '60', 131);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (132, 'Jory', '2/24/2025', '2/27/2025', '8', 132);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (133, 'Mylo', '10/5/2024', '12/20/2024', '24', 133);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (134, 'Helene', '8/21/2025', '9/2/2025', '0020', 134);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (135, 'Loren', '3/12/2025', '6/23/2025', '5', 135);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (136, 'Modesty', '12/7/2024', '3/27/2025', '43', 136);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (137, 'Cynthea', '1/25/2025', '3/30/2025', '40756', 137);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (138, 'Helsa', '6/28/2025', '1/29/2025', '5', 138);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (139, 'Annadiane', '10/3/2024', '12/26/2024', '2396', 139);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (140, 'Katya', '6/20/2025', '8/9/2025', '132', 140);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (141, 'Sarah', '5/29/2025', '1/6/2025', '90', 141);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (142, 'Gayle', '6/14/2025', '7/3/2025', '0338', 142);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (143, 'Daffie', '5/11/2025', '7/20/2025', '5', 143);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (144, 'Kerstin', '11/5/2024', '7/11/2025', '335', 144);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (145, 'Cthrine', '6/26/2025', '1/26/2025', '9178', 145);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (146, 'Belva', '1/24/2025', '3/1/2025', '153', 146);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (147, 'Amelie', '10/4/2024', '5/21/2025', '124', 147);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (148, 'Antony', '8/11/2025', '12/1/2024', '2065', 148);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (149, 'Natale', '12/7/2024', '6/25/2025', '3', 149);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (150, 'Wilone', '9/25/2024', '6/21/2025', '6', 150);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (151, 'Trish', '10/7/2024', '9/15/2025', '056', 151);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (152, 'Tillie', '6/19/2025', '6/28/2025', '2937', 152);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (153, 'Joel', '7/30/2025', '12/22/2024', '327', 153);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (154, 'Joye', '10/15/2024', '1/20/2025', '37486', 154);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (155, 'Roselin', '2/10/2025', '6/1/2025', '405', 155);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (156, 'Kerrin', '7/22/2025', '3/3/2025', '24347', 156);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (157, 'Arley', '8/9/2025', '5/2/2025', '519', 157);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (158, 'Justus', '9/8/2025', '4/30/2025', '7', 158);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (159, 'Katalin', '5/11/2025', '6/10/2025', '35', 159);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (160, 'Palmer', '5/13/2025', '3/30/2025', '331', 160);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (161, 'Welbie', '12/9/2024', '6/26/2025', '986', 161);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (162, 'Timmie', '7/31/2025', '3/28/2025', '6528', 162);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (163, 'Devi', '4/2/2025', '7/9/2025', '08161', 163);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (164, 'Patti', '6/15/2025', '5/5/2025', '34', 164);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (165, 'Lorena', '6/16/2025', '12/30/2024', '1', 165);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (166, 'Jacinthe', '7/23/2025', '7/1/2025', '457', 166);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (167, 'Ruthie', '10/11/2024', '5/20/2025', '090', 167);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (168, 'Kipp', '11/3/2024', '6/12/2025', '109', 168);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (169, 'Elfrida', '10/7/2024', '4/14/2025', '860', 169);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (170, 'Toinette', '7/14/2025', '4/17/2025', '0', 170);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (171, 'Alley', '6/3/2025', '10/15/2024', '16', 171);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (172, 'Candra', '11/2/2024', '3/30/2025', '3607', 172);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (173, 'Antoine', '3/28/2025', '12/1/2024', '73', 173);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (174, 'Bridget', '7/4/2025', '12/20/2024', '960', 174);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (175, 'Sunny', '1/21/2025', '4/19/2025', '8', 175);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (176, 'Orbadiah', '3/4/2025', '11/19/2024', '3', 176);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (177, 'Jamaal', '1/27/2025', '2/6/2025', '18118', 177);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (178, 'Faye', '5/30/2025', '1/26/2025', '0448', 178);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (179, 'Brandea', '4/7/2025', '9/1/2025', '34', 179);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (180, 'Layla', '3/14/2025', '4/25/2025', '0297', 180);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (181, 'Kitty', '7/11/2025', '8/22/2025', '62', 181);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (182, 'Alec', '6/3/2025', '3/21/2025', '5535', 182);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (183, 'Taylor', '6/8/2025', '3/24/2025', '2960', 183);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (184, 'Pauletta', '7/18/2025', '11/17/2024', '889', 184);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (185, 'Joete', '1/12/2025', '10/13/2024', '4', 185);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (186, 'West', '5/1/2025', '12/9/2024', '6117', 186);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (187, 'Woody', '10/1/2024', '1/23/2025', '80424', 187);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (188, 'Bess', '11/28/2024', '12/12/2024', '822', 188);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (189, 'Gustave', '11/30/2024', '10/24/2024', '6', 189);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (190, 'Bernetta', '7/5/2025', '2/19/2025', '4', 190);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (191, 'Jaimie', '5/25/2025', '3/9/2025', '1', 191);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (192, 'Logan', '10/3/2024', '5/21/2025', '802', 192);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (193, 'Hatti', '10/18/2024', '10/11/2024', '2', 193);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (194, 'Zara', '9/16/2025', '1/6/2025', '15324', 194);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (195, 'Berke', '6/10/2025', '8/31/2025', '02600', 195);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (196, 'Larissa', '11/15/2024', '8/24/2025', '18', 196);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (197, 'Neely', '10/6/2024', '1/18/2025', '8757', 197);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (198, 'Carl', '10/30/2024', '6/30/2025', '31750', 198);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (199, 'Codie', '12/24/2024', '2/17/2025', '674', 199);
insert into baggage_check (baggage_check_id, check_result, created_at, updated_at, booking_id, passenger_id) values (200, 'Natal', '5/22/2025', '12/26/2024', '0', 200);
