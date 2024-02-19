----Create a new table named Booking_patterns(optional)
Select * into Booking_Patterns  from (
    select Booking_ID, Hotel ,Booking_Date,Lead_time,Customer_type,Country,Distribution_Channel,
    YEAR(Booking_Date) AS Year,
    DATEPART(QUARTER, Booking_Date) AS Quarter,
    MONTH(Booking_Date) AS Month
    from SHG_Booking
) as Booking_Patterns

Select * from Booking_Patterns 


---Year with most bookings 
Select Year,Count(*) as No_of_Bookings
from Booking_patterns 
Group by Year 

-----Month with most bookings  for each year 
WITH RankedMonths AS (
    SELECT 
        Year, 
        Month, 
        COUNT(*) AS No_of_Bookings,
        ROW_NUMBER() OVER(PARTITION BY Year ORDER BY COUNT(*) DESC) AS MonthRank
    FROM Booking_patterns 
    GROUP BY Year, Month
)
SELECT Year, Month, No_of_Bookings
FROM RankedMonths
WHERE MonthRank = 1
ORDER BY Year;

----Quarter with most bookings for each year 
WITH RankedQuarter AS (
    SELECT 
        Year, 
        Quarter, 
        COUNT(*) AS No_of_Bookings,
        ROW_NUMBER() OVER(PARTITION BY Year ORDER BY COUNT(*) DESC) AS QuarterRank
    FROM Booking_patterns 
    GROUP BY Year, Quarter
)
SELECT Year, Quarter, No_of_Bookings
FROM RankedQuarter
WHERE QuarterRank = 1
ORDER BY Year;

--How does lead time vary across different booking channels, and is there a correlation between lead time and customer type?
-----Lead time vs Booking channels
Select Avg(Lead_time) as Average_lead_time ,
       Max(Lead_time) as MaximumLead_time,
       Min(Lead_time) as MinimumLead_time,
       Distribution_channel as Booking_channels,
       count(*) as No_of_Bookings
from Booking_patterns 
Group by Distribution_channel

------Lead time vs Customer type
Select Avg(Lead_time) as Average_lead_time ,
       Max(Lead_time) as MaximumLead_time,
       Min(Lead_time) as MinimumLead_time,
       Customer_Type as Customer_Type,
       count(*) as No_of_Bookings
from Booking_patterns 
Group by Customer_Type
