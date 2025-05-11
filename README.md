
![Healytics](https://github.com/user-attachments/assets/241c980c-432d-4554-9d91-24ecdbfad560)


## 📘 Project Overview

**Healytics** is a comprehensive **healthcare analytics project** that leverages **data integration** to deliver **actionable insights** for improving **patient care** and **operational efficiency**. 

By consolidating multiple datasets — including **patient demographics**, **doctor information**, **visit data**, **lab results**, and **treatment records** — into dynamic, interactive **Tableau dashboards**, the project provides **healthcare professionals** with a centralized, real-time view of **key metrics**.

These metrics cover **patient visits**, **diagnostic trends**, **doctor performance**, and **treatment outcomes**, empowering **administrators** to:

- Optimize **resource allocation**
- Streamline **hospital operations**
- Make informed decisions that enhance **patient care**.
  

*Dashboards showcasing patient trends, lab results, treatments, and physician impact.*



![Patient](https://github.com/user-attachments/assets/ab372f34-7d56-45a0-ac0d-4cb12b6658af)



![Treatment](https://github.com/user-attachments/assets/504cb614-50b7-4bd7-8a33-d9e73ec0a92e)



![Doctor](https://github.com/user-attachments/assets/bb49137d-9472-404d-8b2b-b3307d779117)


## 📊 View Live Tableau Dashboard

Click the link below to explore the interactive Tableau dashboard:

👉 [**View Live Dashboard**](https://public.tableau.com/app/profile/nisha.r3849/viz/HEALTHCARE11/TreatmentDashboard?publish=yes)


---
## 📑 Table of Contents
1. [Business Problem]()
2. [Dataset Overview]()
3. [Tools and Technologies Used]()
4. [Approach]()
    - [Data Cleaning & Transformation]()
    - [SQL Data Quality Checks]()
    - [Tableau Relationships]()
    - [Tableau Calculated Fields]()
    - [Dashboard Creation]()
    - [Dashboard Navigation]()
    - [Data Validation and Cross-Verification]()
5. [Key Insights]()
6. [Recommendations]()
7. [Conclusion]()

---

## ❓ Business Problem

Hospitals often face significant challenges due to **siloed** and **unstructured data** spread across multiple departments. This lack of **integration** limits **visibility** and hampers efforts to improve **patient care** and **operational efficiency**.

---

## 📁 Dataset Overview

The project utilizes five datasets:
1. **Patient Data**: Includes patient demographics such as age, gender, medical history, and primary conditions.
2. **Doctor Data**: Provides details on doctor specialties, years of experience, and work schedules.
3. **Visit Data**: Tracks patient visits, including reasons for visits, diagnoses, and treatment plans.
4. **Treatment Data**: Contains information about treatment types, treatment outcomes, and associated costs.
5. **Lab Results Data**: Features results from lab tests, highlighting abnormalities and critical results.

---

## Tools and Technologies Used

| Tool/Technology       | Purpose                                                                 |
|-----------------------|-------------------------------------------------------------------------|
| Excel                 | Initial data cleaning, deduplication, and formatting                    |
| Power Query (Power BI) | Column type transformations, custom fields, and data enrichment         |
| MySQL                 | Data validation (consistency, completeness, duplicates, joins)         |
| Tableau         | Dashboard development, relationship modeling, and calculated fields.    |

---

## 📊 Approach

### 1. Data Cleaning & Transformation
- **Excel Preprocessing**: Duplicate and irrelevant columns were removed.
- **Power Query Transformation**:
  - **Data types** validated and corrected.
  - A new **"Patient Name"** column was created by concatenating first and last names.
  - An **"Age Category"** column was created to classify patients into **Adult**, **Adolescent**, and **Senior** categories.
  - **Doctors** were categorized into **Entry Level**, **Mid Level**, **Senior Level**, and **Veteran** based on experience.

---
### 2. SQL Data Quality Checks

Before loading the data into **Tableau**, a series of **SQL checks** were conducted to ensure **data quality** and **integrity**. These checks aimed to ensure that the data was accurate, complete, consistent, and free from duplicates. Below are the checks performed:

- **Data Count Validation**: Ensured all tables had the correct number of records.
```sql
SELECT COUNT(*) FROM patient;
SELECT COUNT(*) FROM doctor;
SELECT COUNT(*) FROM visit;
SELECT COUNT(*) FROM treatments;
SELECT COUNT(*) FROM labresult;
```
- **Data Completeness Check**: Ensured no critical fields like PatientName, DoctorName, VisitType, etc., were missing.
```sql
SELECT * FROM patient WHERE PatientName IS NULL OR Gender IS NULL;
SELECT * FROM doctor WHERE DoctorName IS NULL OR Specialty IS NULL;
SELECT * FROM visit WHERE VisitType IS NULL OR VisitDate IS NULL;
SELECT * FROM treatments WHERE TreatmentName IS NULL OR Status IS NULL;
SELECT * FROM labresult WHERE TestName IS NULL OR Result IS NULL;
```
- **Data Consistency Check**: Ensured there were no orphaned records (e.g., visits without patients or treatments without visits).
```sql
SELECT v.VisitID, v.PatientID FROM Visit v LEFT JOIN Patient p ON v.PatientID = p.PatientID WHERE p.PatientID IS NULL;
SELECT v.VisitID, d.DoctorID FROM Visit v LEFT JOIN Doctor d ON v.DoctorID = d.DoctorID WHERE d.DoctorID IS NULL;
```
- **Duplicate Records Check**: Checked for any duplicate records in core tables like Patient, Doctor, Visit, etc.
```sql
SELECT PatientID, COUNT(*) FROM Patient GROUP BY PatientID HAVING COUNT(*) > 1;
SELECT DoctorID, COUNT(*) FROM doctor GROUP BY DoctorID HAVING COUNT(*) > 1;
SELECT VisitID, COUNT(*) FROM Visit GROUP BY VisitID HAVING COUNT(*) > 1;
SELECT TreatmentID, COUNT(*) FROM treatments GROUP BY TreatmentID HAVING COUNT(*) > 1;
SELECT LabResultID, COUNT(*) FROM labresult GROUP BY LabResultID HAVING COUNT(*) > 1;
```
---
### 3. Tableau Relationships
After **cleaning** and **validating** the data, it was loaded into **Tableau**. **Relationships between tables** were established based on **common fields**.This setup allowed for **seamless integration** of data across multiple tables, enabling **holistic analysis** of **patient demographics**, **treatment details**, and **doctor performance**.

![relation](https://github.com/user-attachments/assets/a6e69c04-be58-464b-a73e-1d98ef2551d8)


---
### 4. Tableau Calculated Fields
**Calculated fields** in Tableau were used to create **key performance indicators (KPIs)** for the dashboards:

 •	**Follow-up Rate**:
```tableau
SUM(IF [Follow-up Required] = "Yes" THEN 1 ELSE 0 END) / COUNT([Follow-up Required])
```
 •	**Average Treatment Cost per Visit**:
```tableau
AVG([Treatment Cost])
```
 •	**Success Rate of Doctors**:
    First, a success flag was created:
```tableau
IF [Outcome] = "Successful" THEN 1 ELSE 0 END
```
Then, the success rate was calculated:
```tableau
AVG([Success Flag]) * 100
```
 •	**Percentage of Abnormal Lab Results**:
```tableau
SUM(IF [Result] = "Abnormal" THEN 1 ELSE 0 END) / COUNT([Result])
```
---
### 5. Dashboard Creation
Three interactive dashboards were created in Tableau to provide comprehensive insights into the healthcare system:
### 1. Patient Demographics & Visit Overview Dashboard:
- **Purpose**: To understand the distribution of patients, visit types, and reasons for hospital visits.
- **KPIs**: 
  - Total Visits
  - Total Patients
  - Average Age of Patient
- **Visuals**:
  - Patient Gender Segmentation (Bar Chart)
  - Patient Distribution by Age Group (Pie Chart)
  - Statewise Patient Breakdown (Map)
  - Patient Visit Distribution by Type & Reason (Column Chart)
  - Patient Visit Status (Donut Chart)

### 2. Testing, Diagnosis, and Treatment Overview Dashboard:
- **Purpose**: To visualize test results, diagnoses, and treatment data along with treatment cost and success.
- **KPIs**:
  - Total Lab Tests
  - Percentage of Abnormal Lab Results
  - Treatment Cost per Visit
  - Follow-up Rate
- **Visuals**:
  - Test Type Distribution (Lollipop Chart)
  - Top 5 Diagnosed Conditions (Column Chart)
  - Treatment Distribution by Category (Pie Chart)
  - Most Prescribed Medication (Bubble Chart)
  - Treatment Status (Donut Chart)

### 3. Doctor Overview Dashboard:
- **Purpose**: To monitor doctor performance, specialization distribution, and patient load for informed staffing and healthcare delivery decisions.
- **KPIs**:
  - Total Doctors
  - Doctor Workload
- **Visuals**:
  - Doctor Specialization Distribution (Tree Map)
  - Experience Level (Donut Chart)
  - Patient Load by Specialization
  - Top 10 Doctors by Success Rate
---
### 6. Dashboard Navigation
**Interactive navigation buttons** were added to ensure users could easily switch between the three dashboards, providing a **seamless experience**. These buttons allowed users to quickly navigate between:
- **Patient Demographics & Visit Overview**
- **Testing, Diagnosis & Treatment Overview**
- **Doctor Overview**

This **navigation feature** unified the dashboards, allowing users to explore all facets of the **healthcare data** within a **single**, **integrated platform**.

---
### 7. Data Validation and Cross-Verification
After building the dashboards, **data values** were **cross-verified with MySQL queries (dashboard aggregation check)** to ensure the **integrity of the visualizations**. For instance:
- **Total number of patients** shown in the dashboard was verified by running:
```sql
SELECT COUNT(*) FROM patient;
```
-	**Treatment Cost Per Visit** was validated by comparing the aggregated treatment cost in Tableau with the SQL result:
```sql
SELECT AVG([Treatment Cost]) FROM treatments AS treatment_cost_per_visit;
```
This **cross-verification process** confirmed that the **data visualizations in Tableau** were **accurate** and **consistent** with the underlying data. The dashboards are **fully validated** and can now be reliably used for **healthcare analysis**.

---

## 🔍 Key Insights

### 👥 **Patient Demographics**
- **Adults** = 64%, **Seniors** = 28% → High need for **chronic/geriatric care**.
- **34%** marked as “**Other**” in gender → Points to **diversity** or **data inconsistencies**.
- Highest patient volumes from **Texas**, **California**, and **Florida**.

### 🏥 **Visit Behavior**
- Top visit reasons: **Flu**, **Chronic Pain**, **Routine Checkups**, **Emergency**.
- Avg ~400 visits/month. Peaks in **August 2023**, dip in **March 2025** (likely due to seasonal or systemic factors).
- ~**33% cancellations** → Need for better **appointment management**.

### 🧪 **Diagnostics & Treatment**
- More than **10,000 lab tests** performed, with **49%** showing **abnormal results** → Effective but potentially overused diagnostics.
- Top diagnoses: **Migraine**, **Hypertension**, **Asthma**, **Diabetes**.
- Treatments split evenly: **Medication**, **Surgery**, **Vaccination**, **Physical Therapy**.
- Outcome data shows 1/3 each: **Successful**, **Failed**, **Ongoing** → Needs better tracking.

### 💰 **Financials**
- Total treatment cost: **$5.2M**, Avg **$524.75/visit**.
- Costs rise with **patient volume**, while the **March 2025 dip** mirrors the decrease in visits.

### 👨‍⚕️ **Doctor Metrics**
- Most specialize in **General Medicine**.
- **65%** are **Senior/Veteran-level**.
- Avg **10 patients/doctor**, with top doctors achieving high **success** and **efficiency**.

---

## ✅ Recommendations

1. **Refine Patient Engagement**
   - Run **age-targeted health campaigns**.
   - Standardize **gender classification** for better demographic analytics.

2. **Reduce Visit Cancellations**
   - Add **reminder systems** (SMS/email).
   - Offer **telehealth/virtual appointments** for flexible care.

3. **Streamline Diagnostics**
   - Audit for **over-testing**, especially imaging.
   - Use **historical trends** to predict and prepare for **regional disease spikes**.

4. **Clarify Treatment Outcomes**
   - Implement clear **success/failure definitions**.
   - Mandate **follow-up data** to eliminate ambiguous outcomes.

5. **Control Costs**
   - Monitor monthly **cost per visit**.
   - Link **cost** to **treatment success** for **value-based decisions**.

6. **Enhance Doctor Effectiveness**
   - Create **mentorship programs** using insights from top performers.
   - Balance **workloads** across departments and specializations.

7. **Expand Services in Key States**
   - Scale up outreach in **TX**, **CA**, **FL**.
   - Align **inventory** and **staffing** to regional health trends.
---
## 🏁 Conclusion

**Healytics** transforms complex healthcare data into clear, actionable intelligence through dynamic, well-structured dashboards. By connecting **patient demographics**, **test results**, **doctor performance**, and **treatment patterns**, it offers a **360° view** of healthcare delivery. This enables stakeholders to detect inefficiencies, monitor **key metrics**, and act swiftly on emerging trends.

The project not only identifies gaps in **patient management** but also empowers providers to enhance the **quality of care** and optimize resources. Interactive **visuals** support informed **decision-making** at every level—from **frontline staff** to **hospital executives**.

Ultimately, **Healytics** lays the groundwork for a **data-driven**, **patient-centric healthcare system** focused on **continuous improvement** and **measurable outcomes**.
