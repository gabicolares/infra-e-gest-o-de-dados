SELECT 
    'create table ' || table_name || ' as select * from arruda.' || table_name || ';'
FROM
    all_tables
WHERE
    owner = 'ARRUDA'
    AND table_name LIKE 'AIR_%';

create table AIR_AIRLINES as select * from arruda.AIR_AIRLINES;
create table AIR_AIRPLANES as select * from arruda.AIR_AIRPLANES;
create table AIR_AIRPLANE_TYPES as select * from arruda.AIR_AIRPLANE_TYPES;
create table AIR_AIRPORTS as select * from arruda.AIR_AIRPORTS;
create table AIR_AIRPORTS_GEO as select * from arruda.AIR_AIRPORTS_GEO;
create table AIR_BOOKINGS as select * from arruda.AIR_BOOKINGS;
create table AIR_FLIGHTS as select * from arruda.AIR_FLIGHTS;
create table AIR_FLIGHTS_SCHEDULES as select * from arruda.AIR_FLIGHTS_SCHEDULES;
create table AIR_PASSENGERS as select * from arruda.AIR_PASSENGERS;
create table AIR_PASSENGERS_DETAILS as select * from arruda.AIR_PASSENGERS_DETAILS;