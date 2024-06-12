---Q1---

SELECT * 
FROM q1q2.Flights
WHERE departure = ''
allow filtering;

---Q2---

SELECT *
FROM q1q2.Bookings
WHERE flight_id = ''
AND price < 250.00
allow filtering;

---Q3---

SELECT * 
FROM q3q4.Airplanes
WHERE capacity = 
allow filtering;

---Q4---

SELECT * 
FROM q3q4.AirplaneType_By_Airplane
WHERE airplaneId = 
allow filtering;
