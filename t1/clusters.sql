-- passengers-passengers_details
CREATE CLUSTER clr_passengers(passenger_id numeric(12)) INDEX
    storage (
        INITIAL 8K
    );
    
CREATE INDEX idx_clr_passengers ON CLUSTER clr_passengers;

DROP TABLE AIR_PASSENGERS_DETAILS CASCADE CONSTRAINTS;
DROP TABLE AIR_PASSENGERS CASCADE CONSTRAINTS;

CREATE TABLE AIR_PASSENGERS CLUSTER clr_passengers(passenger_id) AS SELECT * FROM arruda.AIR_PASSENGERS;
CREATE TABLE AIR_PASSENGERS_DETAILS CLUSTER clr_passengers(passenger_id) AS SELECT * FROM arruda.AIR_PASSENGERS_DETAILS;


-- flights-bookings
CREATE CLUSTER clr_flights_bookings(flight_id numeric(10)) INDEX
    storage (
        INITIAL 8K
    );

CREATE INDEX idx_clr_flights ON CLUSTER clr_flights_bookings;

DROP TABLE AIR_BOOKINGS CASCADE CONSTRAINTS;
DROP TABLE AIR_FLIGHTS CASCADE CONSTRAINTS;

CREATE TABLE AIR_FLIGHTS CLUSTER clr_flights_bookings(flight_id) AS SELECT * FROM arruda.AIR_FLIGHTS;
CREATE TABLE AIR_BOOKINGS CLUSTER clr_flights_bookings(flight_id) AS SELECT * FROM arruda.AIR_BOOKINGS;
 
-- airports-passenger_details
CREATE CLUSTER clr_airports(airport_id numeric(5)) HASHKEYS 128
    storage (
        INITIAL 1024K
    );
    
DROP TABLE AIR_AIRPORTS_GEO CASCADE CONSTRAINTS;
DROP TABLE AIR_AIRPORTS CASCADE CONSTRAINTS;

CREATE TABLE AIR_AIRPORTS CLUSTER clr_airports(airport_id) AS SELECT * FROM arruda.AIR_AIRPORTS;
CREATE TABLE AIR_AIRPORTS_GEO CLUSTER clr_airports(airport_id) AS SELECT * FROM arruda.AIR_AIRPORTS_GEO;