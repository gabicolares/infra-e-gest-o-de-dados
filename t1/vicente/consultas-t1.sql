-- 1- Listar o nome completo (primeiro nome + último nome), a idade e a cidade de todos os passageiros do sexo 
-- feminino (sex='w') com mais de 40 anos, residentes no país 'BRAZIL'.
-- [resposta sugerida = 141 linhas]

SELECT 
    AIR_PASSENGERS.FIRSTNAME || ' ' || AIR_PASSENGERS.LASTNAME AS FULLNAME,
    CAST(MONTHS_BETWEEN(SYSDATE, AIR_PASSENGERS_DETAILS.BIRTHDATE)/12 AS INT) AS AGE,
    AIR_PASSENGERS_DETAILS.CITY AS CITY
FROM
    AIR_PASSENGERS
    INNER JOIN AIR_PASSENGERS_DETAILS 
        ON AIR_PASSENGERS.PASSENGER_ID = AIR_PASSENGERS_DETAILS.PASSENGER_ID
WHERE
    AIR_PASSENGERS_DETAILS.SEX = 'w' 
    AND
    AIR_PASSENGERS_DETAILS.BIRTHDATE <= ADD_MONTHS(SYSDATE, -(40*12)) 
    AND 
    AIR_PASSENGERS_DETAILS.COUNTRY = 'BRAZIL';
    

-- 2- Listar o nome da companhia aerea, o identificador da aeronave, o nome do tipo de aeronave e o numero de 
-- todos os voos operados por essa companhia aerea (independentemente de a aeronave ser de sua propriedade) que 
-- saem E chegam em aeroportos localizados no pais 'BRAZIL'.
-- [resposta sugerida = 8 linhas]

-- usar seguintes comandos no SELECT para visualizar pais de origem e destino
-- ORIGIN_GEO.COUNTRY AS ORIGIN_COUNTRY,
-- DESTINY_GEO.COUNTRY AS DESTINY_COUNTRY

SELECT
    AIR_AIRLINES.AIRLINE_NAME AS AIRLINE,
    AIR_AIRPLANES.AIRPLANE_ID AS AIRPLANE_ID,
    AIR_AIRPLANE_TYPES.NAME AS AIRPLANE,
    AIR_FLIGHTS.FLIGHTNO AS FLIGHT_NO
FROM
    AIR_AIRLINES
    INNER JOIN AIR_FLIGHTS
        ON AIR_AIRLINES.AIRLINE_ID = AIR_FLIGHTS.AIRLINE_ID
    INNER JOIN AIR_AIRPLANES
        ON AIR_FLIGHTS.AIRPLANE_ID = AIR_AIRPLANES.AIRPLANE_ID
    INNER JOIN AIR_AIRPLANE_TYPES
        ON AIR_AIRPLANES.AIRPLANE_TYPE_ID = AIR_AIRPLANE_TYPES.AIRPLANE_TYPE_ID
    INNER JOIN AIR_AIRPORTS_GEO ORIGIN_GEO
        ON AIR_FLIGHTS.FROM_AIRPORT_ID = ORIGIN_GEO.AIRPORT_ID
    INNER JOIN AIR_AIRPORTS_GEO DESTINY_GEO
        ON AIR_FLIGHTS.TO_AIRPORT_ID = DESTINY_GEO.AIRPORT_ID
WHERE
    ORIGIN_GEO.COUNTRY = 'BRAZIL'
    AND
    DESTINY_GEO.COUNTRY = 'BRAZIL'
ORDER BY AIR_AIRLINES.AIRLINE_NAME ASC;
    

-- 3- Listar o número do voo, o nome do aeroporto de saída e o nome do aeroporto de destino, o nome completo 
-- (primeiro e último nome) e o assento de cada passageiro, para todos os voos que partem no dia do seu 
-- aniversário (do seu mesmo, caro aluno, e não o do passageiro) neste ano (caso a consulta não retorne nenhuma 
-- linha, faça para o dia subsequente até encontrar uma data que retorne alguma linha). 
-- [resposta sugerida = 106 linhas para o dia 25/03/2023]

SELECT
    AIR_FLIGHTS.FLIGHTNO AS FLIGHT_NO,
    ORIGIN_AIRPORTS.NAME AS ORIGIN_AIRPORT,
    DESTINY_AIRPORTS.NAME AS DESTINY_AIRPORT,
    AIR_PASSENGERS.FIRSTNAME || ' ' || AIR_PASSENGERS.LASTNAME AS PASSENGER_NAME,
    AIR_BOOKINGS.SEAT AS SEAT,
    AIR_FLIGHTS.DEPARTURE AS DEPARTURE
FROM
    AIR_FLIGHTS
    INNER JOIN AIR_AIRPORTS ORIGIN_AIRPORTS
        ON AIR_FLIGHTS.FROM_AIRPORT_ID = ORIGIN_AIRPORTS.AIRPORT_ID
    INNER JOIN AIR_AIRPORTS DESTINY_AIRPORTS
        ON AIR_FLIGHTS.TO_AIRPORT_ID = DESTINY_AIRPORTS.AIRPORT_ID
    INNER JOIN AIR_BOOKINGS
        ON AIR_FLIGHTS.FLIGHT_ID = AIR_BOOKINGS.FLIGHT_ID
    INNER JOIN AIR_PASSENGERS
        ON AIR_BOOKINGS.PASSENGER_ID = AIR_PASSENGERS.PASSENGER_ID
WHERE
    TRUNC(AIR_FLIGHTS.DEPARTURE) = TRUNC(TO_DATE('14/05/2024', 'DD/MM/YYYY'))
ORDER BY
    AIR_FLIGHTS.FLIGHTNO ASC;


-- 4- Listar o nome da companhia aérea bem como a data e a hora de saída de todos os voos que chegam para a 
-- cidade de 'NEW YORK' que partem às terças, quartas ou quintas-feiras, no mês do seu aniversário 
-- (caso a consulta não retorne nenhuma linha, faça para o mês subsequente até encontrar um mês que retorne 
-- alguma linha).
-- [resposta sugerida = 1 linha para o mês de março de 2024]

SELECT
    AIR_AIRLINES.AIRLINE_NAME AS AIRLINE,
    TO_CHAR(AIR_FLIGHTS.DEPARTURE, 'dd/mm/yyyy hh24:mi') as DEPARTURE_DATE_AND_TIME
FROM
    AIR_FLIGHTS
    INNER JOIN AIR_AIRLINES
        ON AIR_FLIGHTS.AIRLINE_ID = AIR_AIRLINES.AIRLINE_ID
    INNER JOIN AIR_FLIGHTS_SCHEDULES
        ON AIR_FLIGHTS.FLIGHTNO = AIR_FLIGHTS_SCHEDULES.FLIGHTNO
    INNER JOIN AIR_AIRPORTS_GEO
        ON AIR_FLIGHTS.TO_AIRPORT_ID = AIR_AIRPORTS_GEO.AIRPORT_ID
WHERE
    (
        AIR_FLIGHTS_SCHEDULES.TUESDAY = 1
        OR
        AIR_FLIGHTS_SCHEDULES.WEDNESDAY = 1
        OR
        AIR_FLIGHTS_SCHEDULES.THURSDAY = 1
    )
    AND
    AIR_AIRPORTS_GEO.CITY = 'NEW YORK'
    AND
    EXTRACT(MONTH FROM (AIR_FLIGHTS.DEPARTURE)) = 03
    AND
    EXTRACT(YEAR FROM (AIR_FLIGHTS.DEPARTURE)) = 2024;


-- 5- Crie uma consulta que seja resolvida adequadamente com um acesso hash em um cluster com pelo menos duas 
-- tabelas. A consulta deve utilizar todas as tabelas do cluster e pelo menos outra tabela fora dele.