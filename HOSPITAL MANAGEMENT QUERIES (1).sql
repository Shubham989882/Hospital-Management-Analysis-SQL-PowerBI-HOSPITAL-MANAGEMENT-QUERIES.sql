USE Hospital_Management_Analysis_Project;
SELECT * FROM appointments;
SELECT * FROM billing;
SELECT * FROM doctors;
SELECT * FROM patients;
SELECT * FROM treatments;

-- Total Patients
SELECT COUNT(*) AS total_patients
FROM patients;

-- Total Doctors
SELECT COUNT(*) AS total_doctors
FROM doctors;

-- Appointment Status Count
SELECT 
    status,
    COUNT(*) AS total
FROM appointments
GROUP BY status;

-- Top 5 Highest Billing Patients
SELECT 
    CONCAT(p.first_name, ' ', p.last_name) AS full_name,
    ROUND(SUM(b.amount), 2) AS total_bill
FROM billing b
JOIN patients p
ON b.patient_id = p.patient_id
GROUP BY p.patient_id, p.first_name, p.last_name
ORDER BY total_bill DESC
LIMIT 5;

-- Revenue by Treatment Type
SELECT 
    treatment_type,
    SUM(cost) AS revenue
FROM treatments
GROUP BY treatment_type
ORDER BY revenue DESC;

-- Most Busy Doctors
SELECT 
    CONCAT(d.first_name, ' ',
    d.last_name) AS full_name,
    COUNT(a.appointment_id) AS total_appointments
FROM appointments a
JOIN doctors d
ON a.doctor_id = d.doctor_id
GROUP BY d.doctor_id,  d.first_name, d.last_name
ORDER BY total_appointments DESC;

-- Monthly Revenue Trend
SELECT 
    MONTH(bill_date) AS month_no,
    SUM(amount) AS monthly_revenue
FROM billing
GROUP BY MONTH(bill_date)
ORDER BY month_no;

-- Running Revenue Total
SELECT 
    bill_date,
    amount,
    SUM(amount) OVER(ORDER BY bill_date) AS running_total
FROM billing;

-- Payment Failure Analysis
SELECT 
    payment_status,
    COUNT(*) AS total
FROM billing
GROUP BY payment_status;
