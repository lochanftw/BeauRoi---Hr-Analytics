-- 1. Top Reasons for Attrition
SELECT Reason_for_Leaving, COUNT(*) AS Attrition_Count
FROM finalized_dataset
WHERE Attrition_Status = 'Yes'
GROUP BY Reason_for_Leaving
ORDER BY Attrition_Count DESC;

-- 2. Monthly Attrition Trend
SELECT 
    DATE_FORMAT(Leaving_Date, '%Y-%m') AS Month,
    COUNT(*) AS Attritions
FROM finalized_dataset
WHERE Attrition_Status = 'Yes'
GROUP BY Month
ORDER BY Month;

-- 3. Tenure Segmentation
SELECT
  CASE
    WHEN Tenure_at_Company < 1 THEN '0-1 Year'
    WHEN Tenure_at_Company BETWEEN 1 AND 3 THEN '1-3 Years'
    WHEN Tenure_at_Company BETWEEN 4 AND 6 THEN '4-6 Years'
    ELSE '7+ Years'
  END AS Tenure_Band,
  COUNT(*) AS Employee_Count
FROM finalized_dataset
GROUP BY Tenure_Band;

-- 4. Absenteeism Trend by Department
SELECT Department, AVG(Absenteeism_Days) AS Avg_Absenteeism_Days
FROM finalized_dataset
GROUP BY Department
ORDER BY Avg_Absenteeism_Days DESC;

-- 5. Training Attendance Rate by Department
SELECT 
    Department,
    ROUND(AVG(Attended_Training_Hours * 100 / NULLIF(Total_Training_Hours, 0)), 2) AS Avg_Attendance_Percentage
FROM finalized_dataset
GROUP BY Department;

-- 6. Gender Distribution by Department
SELECT Department, Gender, COUNT(*) AS Gender_Count
FROM finalized_dataset
GROUP BY Department, Gender
ORDER BY Department, Gender;

-- 7. Attrition Rate by Job Role
SELECT 
    Job_Role,
    ROUND(SUM(CASE WHEN Attrition_Status = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS Attrition_Rate
FROM finalized_dataset
GROUP BY Job_Role
ORDER BY Attrition_Rate DESC;

-- 8. Age Bucket Distribution
SELECT
  CASE
    WHEN Age < 25 THEN '<25'
    WHEN Age BETWEEN 25 AND 34 THEN '25-34'
    WHEN Age BETWEEN 35 AND 44 THEN '35-44'
    WHEN Age BETWEEN 45 AND 54 THEN '45-54'
    ELSE '55+'
  END AS Age_Bucket,
  COUNT(*) AS Employee_Count
FROM finalized_dataset
GROUP BY Age_Bucket
ORDER BY Age_Bucket;

-- 9. Hiring Trend Over Time
SELECT 
    YEAR(Joining_Date) AS Year,
    COUNT(*) AS Hires
FROM finalized_dataset
GROUP BY Year
ORDER BY Year;

-- 10. Employees with High Absenteeism
SELECT Employee_ID, Employe_Name, Department, Absenteeism_Days
FROM finalized_dataset
WHERE Absenteeism_Days > 15
ORDER BY Absenteeism_Days DESC;

-- 11. High Performers Who Are at Risk of Burnout
SELECT Employee_ID, Employe_Name, Department, Job_Role, Performance_Rating, Burnout_Risk
FROM finalized_dataset
WHERE Performance_Rating >= 4 AND Burnout_Risk = 'High'
ORDER BY Performance_Rating DESC;

-- 12. Performance Rating Distribution by Department
SELECT Department, Performance_Rating, COUNT(*) AS Count
FROM finalized_dataset
GROUP BY Department, Performance_Rating
ORDER BY Department, Performance_Rating;

-- 13. Top 10 Most Engaged Employees
SELECT Employee_ID, Employe_Name, Department, Engagement_Score
FROM finalized_dataset
ORDER BY Engagement_Score DESC
LIMIT 10;

-- 14. Training Attendance vs Performance
SELECT 
    Department,
    ROUND(AVG(Attended_Training_Hours), 2) AS Avg_Attended_Hours,
    ROUND(AVG(Performance_Rating), 2) AS Avg_Performance_Rating
FROM finalized_dataset
GROUP BY Department;

-- 15. Employees Who Left Within One Year of Joining
SELECT Employee_ID, Employe_Name, DATEDIFF(Leaving_Date, Joining_Date) AS Days_Stayed
FROM finalized_dataset
WHERE Attrition_Status = 'Yes' AND DATEDIFF(Leaving_Date, Joining_Date) < 365
ORDER BY Days_Stayed;