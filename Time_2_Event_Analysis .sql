--	How does the time between booking and arrival date (lead time) affect revenue and the likelihood of cancellations?
--The lead time variable is a continous data , categorizing it make it discrete and  easier for analysis .
--This can be achieved using Sql Case statement
SELECT
    CASE
        WHEN Lead_Time < 200 THEN 'Short Lead Time'
        WHEN Lead_Time >= 200 AND Lead_Time < 450 THEN 'Medium Lead Time'
        ELSE 'Long Lead Time'
    END AS LeadTimeCategory,
    COUNT(*) AS No_of_Bookings,
    AVG(Revenue) AS AverageRevenue,
    Sum(Revenue) AS Total_Revenue,
    AVG(CASE WHEN Status = 'Cancelled' THEN 1.0 ELSE 0.0 END) AS CancellationRate
FROM
    SHG_Booking
GROUP BY
     CASE
        WHEN Lead_Time < 200 THEN 'Short Lead Time'
        WHEN Lead_Time >= 200 AND Lead_Time < 450 THEN 'Medium Lead Time'
        ELSE 'Long Lead Time'
    END
ORDER BY
    LeadTimeCategory;

