@@ -22,13 +22,12 @@ GROUP BY status;

-- Top 5 Highest Billing Patients
SELECT 
    p.first_name,
    p.last_name,
    SUM(b.amount) AS total_bill
    CONCAT(p.first_name, ' ', p.last_name) AS full_name,
    ROUND(SUM(b.amount), 2) AS total_bill
FROM billing b
JOIN patients p
ON b.patient_id = p.patient_id
GROUP BY p.patient_id
GROUP BY p.patient_id, p.first_name, p.last_name
ORDER BY total_bill DESC
LIMIT 5;

@@ -42,13 +41,13 @@ ORDER BY revenue DESC;

-- Most Busy Doctors
SELECT 
    d.first_name,
    d.last_name,
    CONCAT(d.first_name, ' ',
    d.last_name) AS full_name,
    COUNT(a.appointment_id) AS total_appointments
FROM appointments a
JOIN doctors d
ON a.doctor_id = d.doctor_id
GROUP BY d.doctor_id
GROUP BY d.doctor_id,  d.first_name, d.last_name
ORDER BY total_appointments DESC;

-- Monthly Revenue Trend
@@ -71,4 +70,4 @@ SELECT
    payment_status,
    COUNT(*) AS total
FROM billing
GROUP BY payment_status;
GROUP BY payment_status;
