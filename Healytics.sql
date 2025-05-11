CREATE DATABASE healthcare;
USE healthcare;

-- Data Count Validation
SELECT COUNT(*) FROM patient;
SELECT COUNT(*) FROM doctor;
SELECT COUNT(*) FROM visit;
SELECT COUNT(*) FROM treatments;
SELECT COUNT(*) FROM labresult;

-- Data Completeness Check
SELECT * FROM patient WHERE PatientName IS NULL OR Gender IS NULL;
SELECT * FROM doctor WHERE DoctorName IS NULL OR Specialty IS NULL;
SELECT * FROM visit WHERE VisitType IS NULL OR VisitDate IS NULL;
SELECT * FROM treatments WHERE TreatmentName IS NULL OR Status IS NULL;
SELECT * FROM labresult WHERE TestName IS NULL OR Result IS NULL;

-- Data Consistency Check
SELECT v.VisitID, v.PatientID, p.PatientID
FROM Visit v
LEFT JOIN Patient p ON v.PatientID = p.PatientID
WHERE p.PatientID IS NULL; 
SELECT v.VisitID, d.DoctorID, d.DoctorID
FROM Visit v
LEFT JOIN Doctor d ON v.DoctorID = d.DoctorID
WHERE d.DoctorID IS NULL; 
SELECT t.TreatmentID, t.VisitID, v.VisitID
FROM Treatments t
LEFT JOIN Visit v ON t.VisitID = v.VisitID
WHERE v.VisitID IS NULL;
SELECT l.LabResultID, l.VisitID, v.VisitID
FROM labresult l
LEFT JOIN Visit v ON l.VisitID = v.VisitID
WHERE v.VisitID IS NULL;

-- Duplicate Records Check
SELECT PatientID, COUNT(*)
FROM Patient
GROUP BY PatientID
HAVING COUNT(*) > 1;
SELECT DoctorID, COUNT(*)
FROM doctor
GROUP BY DoctorID
HAVING COUNT(*) > 1;
SELECT VisitID, COUNT(*)
FROM Visit
GROUP BY VisitID
HAVING COUNT(*) > 1;
SELECT TreatmentID, COUNT(*)
FROM treatments
GROUP BY TreatmentID
HAVING COUNT(*) > 1;
SELECT LabResultID, COUNT(*)
FROM labresult
GROUP BY LabResultID
HAVING COUNT(*) > 1;

-- Dashboard Aggregation Check
-- Total Patients
SELECT COUNT(PatientID) AS Total_Patients FROM patient;
-- Average Age of Patient
SELECT ROUND(AVG(Age),0) as Average_Age_Of_Patient FROM Patient;
-- Patient Gender Segmentation
SELECT Gender, COUNT(PatientID) AS Total_Patients FROM Patient GROUP BY Gender ORDER BY Total_Patients DESC;
-- Total Doctors
SELECT COUNT(DoctorID) AS Total_Doctors FROM doctor;
-- Distribution by Specializtion
SELECT Specialty, COUNT(DoctorID) AS TOTAL_Doctors FROM doctor GROUP BY Specialty ORDER BY Total_Doctors DESC;
-- Doctor Workload
SELECT ROUND((COUNT(VisitID)/COUNT(DISTINCT(DoctorID))),0) AS Doctor_Workload FROM Visit;
-- Total Visits
SELECT COUNT(VisitID) AS Total_Visit FROM visit;
-- Reason For Visit
SELECT ReasonForVisit, COUNT(VisitID) AS Total_Patients FROM visit GROUP BY ReasonForVisit ORDER BY Total_Patients DESC;
-- Top 5 Diagnosed Conditions
SELECT Diagnosis, COUNT(VisitID) AS Total FROM Visit GROUP BY Diagnosis ORDER BY COUNT(VisitID) DESC;
-- Total Lab Tests Conducted
SELECT COUNT(LabResultID) AS Total_Lab_Tests_Conducted FROM labresult;
-- Test Type Distribution
SELECT TestName, COUNT(LabResultID) AS Total_Tests FROM labresult GROUP BY TestName ORDER BY Total_Tests DESC;
-- Percentage of Abnormal Lab Results
SELECT 
    Concat(ROUND(SUM(result = 'abnormal') / COUNT(*) * 100, 2),"%") AS abnormal_result_percentage
FROM 
    labresult;
-- Treatment Cost Per Visit
SELECT CONCAT("$",ROUND(AVG(TreatmentCost),2)) as Treatment_Cost_Per_Visit FROM treatments;
-- Treatment Distribution by Category
SELECT TreatmentType, COUNT(VisitID) AS Total_Treatment FROM treatments GROUP BY TreatmentType ORDER BY Total_Treatment DESC;
-- Follow Up Rate
SELECT 
    CONCAT(ROUND(SUM(followuprequired = 'Yes') / COUNT(*) * 100, 2),"%") AS follow_up_rate
FROM 
visit;













