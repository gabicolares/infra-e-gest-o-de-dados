-- 1- Listar o nome completo (primeiro nome + último nome), a idade e a cidade de todos os passageiros do sexo 
-- feminino (sex='w') com mais de 40 anos, residentes no país 'BRAZIL'.
-- [resposta sugerida = 141 linhas]

SELECT 
    ap.firstname || ' ' || ap.lastname AS nome,
    TRUNC(MONTHS_BETWEEN(SYSDATE, apd.birthdate) / 12) AS idade,
    apd.city AS cidade
FROM air_passengers ap
    INNER JOIN air_passengers_details apd ON ap.passenger_id = apd.passenger_id
WHERE
    apd.sex = 'w' 
    AND apd.birthdate < ADD_MONTHS(SYSDATE,-40*12)
    AND apd.country = 'BRAZIL';

-- 2- Listar o nome da companhia aerea, o identificador da aeronave, o nome do tipo de aeronave e o numero de 
-- todos os voos operados por essa companhia aerea (independentemente de a aeronave ser de sua propriedade) que 
-- saem E chegam em aeroportos localizados no pais 'BRAZIL'.
-- [resposta sugerida = 8 linhas]

-- usar seguintes comandos no SELECT para visualizar pais de origem e destino
-- ORIGIN_GEO.COUNTRY AS ORIGIN_COUNTRY,
-- DESTINY_GEO.COUNTRY AS DESTINY_COUNTRY

SELECT
    aal.airline_name AS companhia,
    aal.airline_id AS companhia_id,
    af.flightno AS numero_voo,
    aapt.name AS aviao
FROM
    air_airlines aal
    INNER JOIN air_flights af ON aal.airline_id = af.airline_id
    INNER JOIN air_airplanes aap ON af.airplane_id = aap.airplane_id
    INNER JOIN air_airplane_types aapt ON aap.airplane_type_id = aapt.airplane_type_id
    INNER JOIN air_airports_geo origem ON af.from_airport_id = origem.airport_id
    INNER JOIN air_airports_geo destino ON af.to_airport_id = destino.airport_id
WHERE
    origem.country = 'BRAZIL'
    AND
    destino.country = 'BRAZIL'

-- 3- Listar o número do voo, o nome do aeroporto de saída e o nome do aeroporto de destino, o nome completo (primeiro e último nome) e o assento de cada passageiro, 
-- para todos os voos que partem no dia do seu aniversário (do seu mesmo, caro aluno, e não o do passageiro) neste ano (caso a consulta não retorne nenhuma linha, 
-- faça para o dia subsequente até encontrar uma data que retorne alguma linha). [resposta sugerida = 106 linhas para o dia 25/03/2024]

SELECT 
    af.flightno AS num_voo, 
    aap_origem.name AS aeroporto_origem, 
    aap_destino.name AS aeroporto_destino, 
    ap.firstname || ' ' || ap.lastname AS nome, 
    ab.seat AS assento
FROM air_flights af
    INNER JOIN air_airports aap_origem ON af.from_airport_id = aap_origem.airport_id
    INNER JOIN air_airports aap_destino ON af.to_airport_id = aap_destino.airport_id
    INNER JOIN air_bookings ab ON af.flight_id = ab.flight_id
    INNER JOIN air_passengers ap ON ab.passenger_id = ap.passenger_id
WHERE TRUNC(af.departure) = TRUNC(TO_DATE('14/01/2024', 'dd/mm/yyyy'));

-- 4- Listar o nome da companhia aérea bem como a data e a hora de saída de todos os voos que chegam para a cidade de 'NEW YORK' que partem às terças, 
-- quartas ou quintas-feiras, no mês do seu aniversário  (caso a consulta não retorne nenhuma linha, faça para o mês subsequente até encontrar um mês que retorne alguma linha). 
-- [resposta sugerida = 1 linha para o mês de março de 2024]
SELECT 
    aal.airline_name AS companhia, 
    TO_CHAR(af.departure, 'dd/mm/yyyy hh24:mi') AS data_hora_saida
FROM air_airlines aal
    INNER JOIN air_flights af ON aal.airline_id = af.airline_id
    INNER JOIN air_flights_schedules afs ON af.flightno = afs.flightno
    INNER JOIN air_airports aap ON af.to_airport_id = aap.airport_id
    INNER JOIN air_airports_geo cidade_destino ON aap.airport_id = cidade_destino.airport_id
WHERE cidade_destino.city = 'NEW YORK' AND (afs.tuesday = 1 OR afs.wednesday = 1 or afs.thursday = 1) AND EXTRACT(MONTH from af.departure) = 1;

-- 5- Crie uma consulta que seja resolvida adequadamente com um acesso hash em um cluster com pelo menos duas tabelas. 
-- A consulta deve utilizar todas as tabelas do cluster e pelo menos outra tabela fora dele.
SELECT 
    aal.airline_name AS companhia,
    af.flightno AS numero_voo,
    COUNT(DISTINCT ap.passenger_id) AS total_passageiros
FROM air_airlines aal
    INNER JOIN air_flights af ON aal.airline_id = af.airline_id
    INNER JOIN air_bookings ab ON af.flight_id = ab.flight_id
    INNER JOIN air_passengers ap ON ab.passenger_id = ap.passenger_id
    INNER JOIN air_passengers_details apd ON ap.passenger_id = apd.passenger_id
WHERE
    apd.country = 'BRAZIL'
    AND ab.flight_date BETWEEN TO_DATE('01/01/2024', 'dd/mm/yyyy') AND TO_DATE('31/12/2024', 'dd/mm/yyyy');