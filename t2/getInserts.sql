SELECT DISTINCT
    'insert into q1q2.Flights(departure,flight_id,arrival) values(' ||
    '''' || TO_CHAR(f.departure,'yyyy-mm-dd hh24:mi:ss') || ''',' ||
    TRIM(f.flight_id) || ',' ||
    '''' || TO_CHAR(f.arrival,'yyyy-mm-dd hh24:mi:ss') || ''');'
FROM
    air_flights f
;

SELECT DISTINCT
    'insert into q1q2.Bookings(flight_id,booking_id,price,seat,passenger_id) values(' ||
    TRIM(f.flight_id) || ',' ||
    b.booking_id || ',' ||
    TRIM(TO_CHAR(b.price, '9999999999D99', 'NLS_NUMERIC_CHARACTERS = ''.,''')) || ',' ||
    '''' || TRIM(b.seat) || ''',' ||
    p.passenger_id || ');'
FROM
    air_flights f
    inner join air_bookings b ON b.flight_id = f.flight_id
    inner join air_passengers p ON p.passenger_id = b.passenger_id
    FETCH FIRST 20000 ROWS ONLY
;

--------------------------------------------------------------------------------------------------

SELECT DISTINCT
    'insert into q3q4.Airplanes(capacity, airplaneId) values(' ||
    p.capacity || ',' ||
    TRIM(p.airplane_id) || ');'
FROM
    air_airplanes p
;

SELECT DISTINCT
    'insert into q3q4.AirplaneType_By_Airplane(airplaneId, airplaneTypeId, name) values(' ||
    TRIM(p.airplane_id) || ',' ||
    TRIM(pt.airplane_type_id) || ',' ||
    '''' || TRIM(pt.name) || ''');'

FROM
    air_airplanes p
    inner join air_airplane_types pt on p.airplane_type_id = pt.airplane_type_id
;