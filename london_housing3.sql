SELECT
    year,
    ROUND(AVG(avg_price)) AS london_median_price,
    AVG(median_regular_pay) AS london_salary,
    ROUND(AVG(affordability_index), 2) AS avg_affordability_index
FROM affordability_index
GROUP BY year
ORDER BY year;

