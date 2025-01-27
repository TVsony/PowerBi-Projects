-- Report - 2 
-- Overview 

-- Check the Table 
SELECT * FROM bank_loan_data

-- 1.	Monthly Trends by Issue Date (Line Chart):  To identify seasonality and long-term trends in lending activities

SELECT 
	MONTH(issue_date) AS Month_Number,
	DATENAME(MONTH,issue_date) AS Month_Name,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH , issue_date)
ORDER BY MONTH(issue_date)


-- 2.	Regional Analysis by State (Filled Map): To identify regions with significant lending activity and assess regional disparities

SELECT address_state,
	   Count(id) AS Total_Loan_Applications,
	   SUM(loan_amount) AS Total_Funded_Amount,
	   SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY address_state
ORDER BY count(id) DESC

-- 3.	Loan Term Analysis (Donut Chart): To allow the client to understand the distribution of loans across various term lengths.

SELECT term,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY term
ORDER BY term

--  Employee Length Analysis (Bar Chart):  How lending metrics are distributed among borrowers with different employment lengths, helping us assess the impact of employment history on loan applications.

SELECT emp_length,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length 

--  5)	Loan Purpose Breakdown (Bar Chart): Will provide a visual breakdown of loan metrics based on the stated purposes of 
-- loans, aiding in the understanding of the primary reasons borrowers seek financing.

SELECT purpose,
	COUNT(id) AS Total_loan_Applications,
	SUM(loan_amount) AS Total_Funded_Ammount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY purpose
ORDER BY count(id) DESC


--	Home Ownership Analysis (Tree Map): For a hierarchical view of how home ownership impacts loan applications and disbursements.

SELECT home_ownership,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC 

--  