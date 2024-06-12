CREATE KEYSPACE IF NOT EXISTS Q1Q2 WITH replication = {'class':'SimpleStrategy', 'replication_factor' : 3};

USE Q1Q2;

CREATE TABLE IF NOT EXISTS Flights (
    departure TIMESTAMP,
    flight_id INT,
    arrival TIMESTAMP,
    PRIMARY KEY (departure, flight_id)
)
WITH CLUSTERING ORDER BY (flight_id asc);

CREATE TABLE IF NOT EXISTS Bookings (
    flight_id INT,
    booking_id INT,
    price double,
    seat TEXT,
    passenger_id INT,
    PRIMARY KEY (flight_id, booking_id, price)
)
WITH CLUSTERING ORDER BY (booking_id asc, price asc);

----------------------------------------------------------------------------------------------------------------------

CREATE KEYSPACE IF NOT EXISTS Q3Q4 WITH replication = {'class':'SimpleStrategy', 'replication_factor' : 3};

USE Q3Q4;

CREATE TABLE IF NOT EXISTS Airplanes (
    capacity INT,
    airplaneId INT,
    PRIMARY KEY (capacity, airplaneId)
)
WITH CLUSTERING ORDER BY (airplaneId asc);

CREATE TABLE IF NOT EXISTS AirplaneType_By_Airplane (
    airplaneId INT,
    airplaneTypeId INT,
    name TEXT,
    PRIMARY KEY (airplaneId)
)
WITH CLUSTERING ORDER BY (airplaneTypeId asc);