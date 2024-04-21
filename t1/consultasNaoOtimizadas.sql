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
    AND TRUNC(MONTHS_BETWEEN(SYSDATE, apd.birthdate) / 12) > 40 
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
WHERE TRUNC(af.departure) = TRUNC(TO_DATE('14/01/2024', 'DD/MM/YYYY'));