-- passengers-passengers_details
CREATE CLUSTER cl_passengers(passenger_id numeric(12)) HASHKEYS 128
    storage (
        INITIAL 8K
    );
    
CREATE INDEX idx_cl_passengers ON CLUSTER cl_passengers;

DROP TABLE AIR_PASSENGERS_DETAILS CASCADE CONSTRAINTS;
DROP TABLE AIR_PASSENGERS CASCADE CONSTRAINTS;

CREATE TABLE AIR_PASSENGERS CLUSTER cl_passengers(passenger_id) AS SELECT * FROM arruda.AIR_PASSENGERS;
CREATE TABLE AIR_PASSENGERS_DETAILS CLUSTER cl_passengers(passenger_id) AS SELECT * FROM arruda.AIR_PASSENGERS_DETAILS;


-- flights-bookings
CREATE CLUSTER cl_flights_bookings(flight_id numeric(10)) HASHKEYS 128
    storage (
        INITIAL 8K
    );
CREATE INDEX idx_cl_flights ON CLUSTER cl_flights_bookings;

DROP TABLE AIR_BOOKINGS CASCADE CONSTRAINTS;
DROP TABLE AIR_FLIGHTS CASCADE CONSTRAINTS;

CREATE TABLE AIR_FLIGHTS CLUSTER cl_flights_bookings(flight_id) AS SELECT * FROM arruda.AIR_FLIGHTS;
CREATE TABLE AIR_BOOKINGS CLUSTER cl_flights_bookings(flight_id) AS SELECT * FROM arruda.AIR_BOOKINGS;
 
-- airports-passenger_details
CREATE CLUSTER cl_airports(airport_id numeric(5)) HASHKEYS 128
    storage (
        INITIAL 1024K
    );
    
CREATE INDEX idx_cl_airports ON CLUSTER cl_airports;

DROP TABLE AIR_PASSENGERS_DETAILS CASCADE CONSTRAINTS;
DROP TABLE AIR_AIRPORTS CASCADE CONSTRAINTS;

CREATE TABLE AIR_AIRPORTS CLUSTER cl_airports(airport_id) AS SELECT * FROM arruda.AIR_AIRPORTS;
CREATE TABLE AIR_PASSENGERS_DETAILS CLUSTER cl_airports(airport_id) AS SELECT * FROM arruda.AIR_PASSENGERS_DETAILS;