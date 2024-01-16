
--●	How does the distribution of guests vary across different countries, and are there specific countries that should be targeted for marketing efforts?
--Distribution of guests across different countries
SELECT
    country,
    COUNT(*) AS NumberOfGuests,
    SUM(Revenue) AS TotalRevenue
FROM
    SHG_Booking 
GROUP BY
    country
ORDER BY
    NumberOfGuests DESC;

-----Country Vs Likelihood of cancellations 
SELECT
    Country,
    COUNT(*) AS TotalBookings,
    SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) AS CanceledBookings , 
    AVG(CASE WHEN Status = 'Cancelled' THEN 1.0 ELSE 0.0 END) AS CancellationRate  
FROM
    SHG_Booking 
GROUP BY
    Country
ORDER BY
    CancellationRate DESC;

