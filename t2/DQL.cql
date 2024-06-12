---Q1---

SELECT * 
FROM Q1Q2.Flights
WHERE departure >= '2023-01-14 00:00:00'
AND departure < '2023-01-15 00:00:00'
ALLOW FILTERING;


---Q2---

SELECT *
FROM q1q2.Bookings
WHERE flight_id = 386821
AND price < 250.00
ALLOW FILTERING;

---Q3---

SELECT * 
FROM q3q4.Airplanes
WHERE capacity = 380
ALLOW FILTERING;

---Q4---

SELECT * 
FROM q3q4.AirplaneType_By_Airplane
WHERE airplaneId = 4290
ALLOW FILTERING;
