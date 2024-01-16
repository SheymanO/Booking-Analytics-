---Which distribution channels contribute the most to bookings, and how does the average daily rate (ADR) differ across these channels?
Select Distribution_channel ,Avg(Avg_Daily_Rate) as Average_of_Avg_Daily_Rate,count(*) as No_of_Bookings
From SHG_Booking
Group by Distribution_channel 
order by No_of_Bookings DESC

--Distribution of guest based on country of Origin, and its impact on Revenue 
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


