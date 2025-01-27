-- This is retrives all data from the bank_loan_data table 
select * from bank_loan_data

-- Open the Problem Statement start solving it 

-- Summary Report 
-- KPI's
-- 1) Total Loan Applications: We need to calculate the total number of loan applications received during a specified period. 
-- Additionally, it is essential to monitor the Month-to-Date (MTD) Loan Applications and track changes Month-over-Month (MoM).

SELECT count(id) AS Total_loan_Application from bank_loan_data

-- Total column Application is 38576 

SELECT count(id) AS MTD_Total_loan_Application from bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR (issue_date) = 2021

-- Month to Date Total_loan_Application is 4314 

SELECT count(id) AS PMTD_Total_loan_Application 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 

-- Previous Month to Date Total_Loan_Application is 4035 

-- 2) Total Funded Amount: Understanding the total amount of funds disbursed as loans is crucial. 
-- We also want to keep an eye on the MTD Total Funded Amount and analyse the Month-over-Month (MoM) changes in this metric.

SELECT SUM(loan_amount) AS Total_funded_Amount FROM bank_loan_data

-- Total Funded amount is 435757075

SELECT SUM(loan_amount) AS MTD_Total_funded_Amount FROM bank_loan_data
where month(issue_date) = 12 AND YEAR(issue_date) = 2021 

-- Month to Date Total_funded_Amount is 53981425

SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date)=2021

-- The Previous Month to Date Total Funded Amount is 47754825



-- 3	Total Amount Received: Tracking the total amount received from borrowers is essential for assessing the bank's cash flow and loan repayment
--We should analyse the Month-to-Date (MTD) Total Amount Received and observe the Month-over-Month (MoM) changes.


SELECT SUM(total_payment) As Total_Amount_received FROM bank_loan_data

-- The total Amount received is 473070933

SELECT SUM(total_Payment) AS MTD_Total_Amount_Received 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) =2021

-- Month to Date Total Amount Received is 58074380

SELECT SUM(total_payment) AS PMTD_Total_Amount_Received
FROM bank_loan_data
WHERE Month(issue_date) = 11 AND YEAR(issue_date) = 2021

-- The Previous Month To Date Total Amount Received is 50132030

--4)Average Interest Rate: Calculating the average interest rate across all loans, MTD, and monitoring the Month-over-Month 
-- variations in interest rates will provide insights into our lending portfolio's overall cost.

SELECT AVG(int_rate) * 100 AS Avg_Interest_Rate FROM bank_loan_data

-- The Avg Interest Rate is 12.048

SELECT ROUND(AVG(int_rate), 4) * 100 AS MTD_Avg_Interest_Rate 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 

-- Month to Date Avg Interest Rate is 12.36 

SELECT ROUND(AVG(int_rate), 4) * 100 AS PMTD_Avg_Interest_Rate 
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- The Previous Month to Date Avg Interest Rate is 11.94

--  Average Debt-to-Income Ratio (DTI): Evaluating the average DTI for our borrowers helps us gauge their financial health-- 
-- We need to compute the average DTI for all loans, MTD, and track Month-over-Month (MoM) fluctuations

SELECT ROUND(AVG(dti) , 4) * 100 AS Avg_DTI FROM bank_loan_data

-- The Avg Month DTI is 13.33 

SELECT ROUND(AVG(dti) , 4) * 100 AS MTD_Avg_DTI
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date)  = 2021 

-- The Month to Date DTI ratio is 13.67

SELECT ROUND(AVG(dti) , 4) * 100 AS MTD_Avg_DTI
FROM bank_loan_data
WHERE MONTH(issue_date) = 11AND YEAR(issue_date)  = 2021 

-- The Previous Month DTI Ratio is 13.3

-- GOOD LOAN AND BAD LOAN
SELECT 
	(COUNT(CASE WHEN loan_status ='Fully Paid ' or loan_status ='Current' THEN id END ) * 100 )
	/ 
	COUNT(id) AS Good_loan_percentage 
FROM bank_loan_data

-- The Good Loan Application Percentage is 86

SELECT count(id)AS Good_loan_Application FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR Loan_status = 'Current'

-- The God loan Application is 33243

SELECT SUM(loan_amount) AS Good_loan_Funded_Amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status ='Current'

-- The Good Loan Funded Amount is 370224850

SELECT SUM(total_payment) AS Good_Loan_Received_Amount FROM bank_loan_data
WHERE loan_status ='Fully Paid' OR loan_status = 'Current'

-- The Good Loan Received Amount is 435786170

--BAD LOAN 

SELECT
	(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END ) * 100.0) / COUNT(id) AS Bad_Loan_Percentage 
	FROM bank_loan_data

-- The Bad Loan Percentage is 13.82


SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Charged Off'

-- The Bank Bad Loan Application is 5333

SELECT SUM(loan_amount) AS Bad_Loan_Amount FROM bank_loan_data WHERE loan_status = 'Charged Off'

-- The Total Bad Loan Amount is 65532225

SELECT sum(total_payment) AS Bad_Loan_Amount_Received FROM bank_loan_data
WHERE loan_status = 'Charged Off'

-- The Total Bad Loan Amount Received is 37284763

SELECT
	loan_status,
	COUNT(id) AS Total_loan_Applications,
	SUM(total_payment) AS Total_Amount_Received,
	SUM(loan_amount) AS Total_Funded_Amount,
	AVG(int_rate * 100) AS Interest_Rate,
	AVG(dti * 100) AS DTI
FROM bank_loan_data
GROUP BY loan_status 


-- Check all in tables 

SELECT 
	loan_status,
	SUM(total_payment) AS MTD_Total_Amount_Received,
	SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status


