-- primary keys

ALTER TABLE air_airlines ADD CONSTRAINT pk_air_airlines PRIMARY KEY (airline_id);

ALTER TABLE air_airplanes ADD CONSTRAINT pk_air_airplane PRIMARY KEY (airplane_id); 

ALTER TABLE air_airplane_types ADD CONSTRAINT pk_air_airplane_types PRIMARY KEY (airplane_type_id);

ALTER TABLE air_airports ADD CONSTRAINT pk_air_airports PRIMARY KEY (airport_id);

ALTER TABLE air_airports_geo ADD CONSTRAINT pk_air_airports_geo PRIMARY KEY (airport_id);

ALTER TABLE air_flights ADD CONSTRAINT pk_air_flights PRIMARY KEY (flight_id);

ALTER TABLE air_flights_schedules ADD CONSTRAINT pk_air_flights_schedules PRIMARY KEY (flightno);

ALTER TABLE air_bookings ADD CONSTRAINT pk_air_bookings PRIMARY KEY (booking_id);

ALTER TABLE air_passengers ADD CONSTRAINT pk_air_passengers PRIMARY KEY (passenger_id);

ALTER TABLE air_passengers_details ADD CONSTRAINT pk_air_passengers_details PRIMARY KEY (passenger_id);

-- foreign keys

ALTER TABLE air_airlines ADD CONSTRAINT fk_airline_airports FOREIGN KEY (base_airport_id) REFERENCES air_airports (airport_id);

ALTER TABLE air_airplanes ADD CONSTRAINT fk_airplane_airlines FOREIGN KEY (airline_id) REFERENCES air_airlines (airline_id);
ALTER TABLE air_airplanes ADD CONSTRAINT fk_airplane_plane_types FOREIGN KEY (airplane_type_id) REFERENCES air_airplane_types (airplane_type_id);

ALTER TABLE air_flights ADD CONSTRAINT fk_flights_schedules FOREIGN KEY (flightno) REFERENCES air_flights_schedules (flightno);
ALTER TABLE air_flights ADD CONSTRAINT fk_flights_airlines FOREIGN KEY (airline_id) REFERENCES air_airlines (airline_id);
ALTER TABLE air_flights ADD CONSTRAINT fk_flights_from_airports FOREIGN KEY (from_airport_id) REFERENCES air_airports (airport_id);
ALTER TABLE air_flights ADD CONSTRAINT fk_flights_to_airports FOREIGN KEY (to_airport_id) REFERENCES air_airports (airport_id);
ALTER TABLE air_flights ADD CONSTRAINT fk_flights_airplanes FOREIGN KEY (airplane_id) REFERENCES air_airplanes (airplane_id);

ALTER TABLE air_flights_schedules ADD CONSTRAINT fk_schedules_airlines FOREIGN KEY (airline_id) REFERENCES air_airlines (airline_id);
ALTER TABLE air_flights_schedules ADD CONSTRAINT fk_schedules_from_airports FOREIGN KEY (from_airport_id) REFERENCES air_airports (airport_id);
ALTER TABLE air_flights_schedules ADD CONSTRAINT fk_schedules_to_airports FOREIGN KEY (to_airport_id) REFERENCES air_airports (airport_id);

ALTER TABLE air_airports_geo ADD CONSTRAINT fk_geo_airports FOREIGN KEY (airport_id) REFERENCES air_airports (airport_id);

ALTER TABLE air_bookings ADD CONSTRAINT fk_bookings_passengers FOREIGN KEY (passenger_id) REFERENCES air_passengers (passenger_id);
ALTER TABLE air_bookings ADD CONSTRAINT fk_bookings_flights FOREIGN KEY (flight_id) REFERENCES air_flights (flight_id);

ALTER TABLE air_passengers_details ADD CONSTRAINT fk_details_passengers FOREIGN KEY (passenger_id) REFERENCES air_passengers (passenger_id);

-- unique keys

ALTER TABLE air_airlines ADD CONSTRAINT ak_iata UNIQUE (iata);

ALTER TABLE air_airports ADD CONSTRAINT ak_icao UNIQUE (icao);

CREATE UNIQUE INDEX ak_air_bookings_flightidseat ON air_bookings (
    CASE
        WHEN seat IS NOT NULL THEN flight_id
        ELSE NULL
    END,
    CASE
        WHEN seat IS NOT NULL THEN seat
        ELSE NULL
    END
);

ALTER TABLE air_passengers ADD CONSTRAINT ak_passportno UNIQUE (passportno);

-- indexes

CREATE INDEX idx_aal_base_airport ON air_airlines(base_airport_id);

CREATE INDEX idx_aap_airline_id ON air_airplanes(airline_id);
CREATE INDEX idx_aap_airplane_typa ON air_airplanes(airplane_type_id);

CREATE INDEX idx_af_flightno ON air_flights(flightno);
CREATE INDEX idx_af_airline_id ON air_flights(airline_id);
CREATE INDEX idx_af_from_airport_id ON air_flights(from_airport_id);
CREATE INDEX idx_af_to_airport_id ON air_flights(to_airport_id);
CREATE INDEX idx_af_airplane_id ON air_flights(airplane_id);
CREATE INDEX idx_af_departure ON air_flights(departure);

CREATE INDEX idx_afs_airline_id ON air_flights_schedules(airline_id);
CREATE INDEX idx_afs_from_airport_id ON air_flights_schedules(from_airport_id);
CREATE INDEX idx_afs_to_airport_id ON air_flights_schedules(to_airport_id);

CREATE INDEX idx_aapg_country ON air_airports_geo(country);
CREATE INDEX idx_aapg_city ON air_airports_geo(city);

CREATE INDEX idx_ab_passenger_id ON air_bookings(passenger_id);
CREATE INDEX idx_ab_flight_id ON air_bookings(flight_id);

CREATE INDEX idx_apd_country ON air_passengers_details(country);
CREATE INDEX idx_apd_birthdate ON air_passengers_details(birthdate);
CREATE INDEX idx_apd_sex ON air_passengers_details(sex);