
SELECT * 
FROM year_to_price;

SELECT *
FROM price_paid;


DESCRIBE price_paid;
USE london_housing;

SELECT *
FROM price_paid
LIMIT 50;

UPDATE price_paid
SET deed_date = STR_TO_DATE(deed_date, '%d/%m/%Y');

# Annual avg prices(2015-2025)

SELECT 
YEAR(deed_date) AS year,
round(avg(price_paid),0) as average_price
from PRICE_PAID
where county ='greater london'
and year(deed_date) between 2015 and 2025
group by year (deed_date)
order by year;

SELECT DISTINCT YEAR(deed_date) AS Year
FROM price_paid
ORDER BY Year;

#borough level affordability

SELECT 
district,
YEAR(deed_date) AS Year,
ROUND(AVG(price_paid),0) AS avg_price
FROM price_paid
WHERE YEAR(deed_date) BETWEEN 2015 and 2025
group by district,Year(deed_date)
order by district, year asc;

#property type trends
 
SELECT 
    YEAR(deed_date) AS year,
    property_type,
    ROUND(AVG(price_paid), 0) AS avg_price
FROM price_paid
WHERE YEAR(deed_date) BETWEEN 2015 AND 2025
GROUP BY YEAR(deed_date), property_type
ORDER BY year, property_type;



ALTER TABLE salary_data
ADD date_val DATE;

UPDATE salary_data
SET date_val= STR_TO_DATE(CONCAT('01-',period), '%d-%b-%y');

#query by time period

SELECT YEAR(date_val) AS year,AVG(regular_pay) as median_regular_pay,AVG(total_pay) as median_total_pay
FRom salary_data
group by year(date_val);

#filtering by month across years

SELECT MONTH(date_val) as month,AVG(regular_pay) as median_pay
from salary_data
group by month(date_val)
order by month asc;

#moving averages

SELECT date_val, regular_pay,
       AVG(regular_pay) OVER (ORDER BY date_val ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS rolling_12m
FROM salary_data;



#Affordability index

CREATE OR REPLACE VIEW affordability_index AS
SELECT 
    b.year,
    b.district,
    b.avg_price,
    s.median_regular_pay,
    ROUND(b.avg_price / NULLIF(s.median_regular_pay, 0), 2) AS affordability_index
FROM borough_avg_price b
JOIN year_to_price s
  ON b.year = s.year;








SELECT
    district,
    avg_price,
    median_regular_pay,
    affordability_index
FROM affordability_index
WHERE year = 2025
ORDER BY affordability_index DESC;



