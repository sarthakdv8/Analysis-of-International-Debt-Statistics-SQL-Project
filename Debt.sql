ALTER TABLE debt_analysis RENAME TO debts_analysis;

SELECT * FROM debts_analysis;
-- Data Cleaning
WITH duplicates AS (
SELECT *,
ROW_NUMBER() OVER(PARTITION BY country_name, country_code, indicator_name, indicator_code, debt) AS row_num
FROM debts_analysis
)
SELECT * FROM duplicates
WHERE row_num>1;
		-- No Duplicates.
SELECT * 
	FROM debts_analysis
    WHERE country_name IS NULL OR country_code IS NULL 
    OR indicator_name IS NULL OR indicator_code IS NULL
    OR debt IS NULL;
    
-- Finding the number of distinct countries

SELECT COUNT(DISTINCT country_name) AS dis_countries
FROM debts_analysis;

-- Finding out the distinct debt indicators

SELECT DISTINCT (indicator_code) AS dis_code FROM debts_analysis
ORDER BY dis_code;

-- Totaling the amount of debt owed by the countries and round it upto 2 decimal places.

SELECT round(SUM(debt),2) AS total_debt FROM debts_analysis
;

-- Country with the highest debt.binlog

SELECT country_name,SUM(debt) AS total_sum FROM debts_analysis
GROUP BY 1
ORDER BY 2 LIMIT 1;

-- Average amount of debt across indicators,round it upto 2 decimal places.

SELECT indicator_code,indicator_name,ROUND(AVG(debt),2) AS avg_debt FROM debts_analysis
GROUP BY 1,2
ORDER BY 3 ;

-- The most common debt indicator

SELECT indicator_code,COUNT(indicator_code) as ct_indi FROM debts_analysis
GROUP BY 1
ORDER BY 2 DESC;

-- Other viable debt issues and conclusion

SELECT country_name,MAX(debt) FROM debts_analysis
GROUP BY 1
ORDER BY 2 DESC;

