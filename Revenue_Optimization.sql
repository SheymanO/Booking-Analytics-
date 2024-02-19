--What is the overall revenue trend, and are there specific customer segments or countries contributing significantly to revenue?
--Create a table for Revenue_trend and select the variables that are relevant to revenue (optional)
Select * into Revenue_trend from (
    select Booking_ID, Hotel ,Booking_Date,Arrival_Date,Avg_Daily_Rate,Lead_time,Customer_type,Country,Distribution_Channel,Revenue,Revenue_loss,
    YEAR(Booking_Date) AS Booking_Year,
    DATEPART(QUARTER, Booking_Date) AS Booking_Quarter,
    MONTH(Booking_Date) AS Booking_Month,
    YEAR(Arrival_Date) AS Arrival_Year,
    DATEPART(QUARTER, Arrival_Date) AS Arrival_Quarter,
    MONTH(Arrival_Date) AS Arrival_Month
    from SHG_Booking
) as Revenue_trend


--------Top Countries contributing to revenue 
SELECT Top 5
    Country,
    SUM(Revenue) AS TotalRevenue
FROM
    Revenue_trend -- Replace with your actual table name
GROUP BY
    Country
ORDER BY
    TotalRevenue DESC


-------Customer types that generates high revenue .

WITH RankedCustomerTypes AS (
    SELECT
        Country,
        Customer_Type,
        SUM(Revenue) AS TotalRevenue,
        ROW_NUMBER() OVER (PARTITION BY Country ORDER BY SUM(Revenue) DESC) AS Rank
    FROM
        Revenue_trend -- Replace with your actual table name
    GROUP BY
        Country, Customer_Type
)
SELECT
    Country,
    Customer_Type,
    TotalRevenue
FROM
    RankedCustomerTypes
WHERE
    Rank = 1 and TotalRevenue <> 0
order by TotalRevenue DESC ;

-- Can we identify optimal pricing strategies based on the Average Daily Rate (ADR) for different customer types and distribution channels?
-----Average Daily Rate for different Distribution channel and Customer Type
SELECT
    Customer_Type,
    Distribution_Channel,
    AVG(Avg_Daily_Rate) AS AverageADR,
    COUNT(*) AS BookingCount
FROM
    Revenue_trend 
WHERE
    Avg_Daily_Rate IS NOT NULL
    AND Customer_Type IS NOT NULL
    AND Distribution_Channel IS NOT NULL
GROUP BY
    Customer_Type, Distribution_Channel
ORDER BY
    Customer_Type, Distribution_Channel;

----AVerage Daily rate by Distribution channel 
SELECT
    
    Distribution_Channel,
    AVG(Avg_Daily_Rate) AS AverageADR,
    COUNT(*) AS BookingCount
FROM
    Revenue_trend 
WHERE
    Avg_Daily_Rate IS NOT NULL
    AND Distribution_Channel IS NOT NULL
GROUP BY
     Distribution_Channel
ORDER BY
    AverageADR DESC
  
--------Average Daily rate by Customer type
SELECT
    
    Customer_Type,
    AVG(Avg_Daily_Rate) AS AverageADR,
    COUNT(*) AS BookingCount
FROM
    Revenue_trend 
WHERE
    Avg_Daily_Rate IS NOT NULL
    AND Customer_Type IS NOT NULL
    AND  Distribution_Channel = 'Corporate'

GROUP BY
     Customer_Type
ORDER BY
    AverageADR DESC
---
