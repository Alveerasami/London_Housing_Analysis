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


SELECT *
FROM affordability_index
WHERE 'year' = 2020;

select *
FROM year_to_price;