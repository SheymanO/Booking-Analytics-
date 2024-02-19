--What is the average length of stay for guests, and how does it differ based on booking channels or customer types?

With Stays as (
             Select Booking_ID,Arrival_Date,Nights,Distribution_channel,Status_update,Status
             ,DATEDIFF(DAY,Arrival_Date,Status_Update) as Stay

              from SHG_Booking
              where Status = 'Check-out'
              
)
Select Distribution_channel,Avg(Nights) as Average_stay
from Stays
Group by Distribution_channel

  ---For Customer types
With Stays as (
             Select Booking_ID,Arrival_Date,Nights,Customer_type,Status_update,Status
             ,DATEDIFF(DAY,Arrival_Date,Status_Update) as Stay

              from SHG_Booking
              where Status = 'Check-out'
              
)
Select Customer_type,Avg(Nights) as Average_stay
from Stays
Group by Customer_type 

---we might have cases where some guests didnt stay for the booked period and some guest checked out the same day they arrived (Extended stay /Under stay)
With Stays as (
             Select Booking_ID,Arrival_Date,Nights,Status_update,Status
             ,DATEDIFF(DAY,Arrival_Date,Status_Update) as Stay

              from SHG_Booking
              where Status = 'Check-out'
              
)
Select *
from Stays
where  Nights<> Stay 
  
-----Impact of Deposit types.
Select Count(*) as Total_Bookings,
       Deposit_Type,
       sum(Revenue) as Revenue_generated,
       AVG(CASE WHEN Status = 'Cancelled' THEN 1.0 ELSE 0.0 END) AS CancellationRate  
from SHG_Booking
Group by Deposit_Type

-----Can we identify any patterns in the use of deposit types across different customer segments?
Select 
       Customer_type,
       Deposit_Type,
       Count(*) as Total_Bookings
from SHG_Booking
Group by Customer_type,Deposit_Type

----Analysis of corporate Bookings 
SELECT
    Distribution_Channel,
    Customer_Type,
    COUNT(*) AS BookingCount,
    AVG(Avg_Daily_Rate) AS AverageADR
FROM
    SHG_Booking 
WHERE
    Distribution_Channel  IN ('Corporate','Online Travel Agent','Offline Travel Agent','Direct','Undefined')
GROUP BY
    Distribution_Channel,Customer_Type;

------Corporate Booking distribution over time 
SELECT
    DATEPART(MONTH, Arrival_Date) AS Month,
    COUNT(*) AS BookingCount
FROM
    SHG_Booking
WHERE
    Distribution_Channel = 'Corporate'
GROUP BY
    DATEPART(MONTH, Arrival_Date);

------Cancellation Rate for corporate bookings 
SELECT
    Distribution_Channel,
    COUNT(*) AS TotalBookings,
    AVG(CASE WHEN Status = 'Cancelled' THEN 1.0 ELSE 0.0 END) AS CancellationRate
FROM
    SHG_Booking
GROUP BY
    Distribution_Channel;

---ADR Trends over time 
SELECT
    DATEPART(Month, Arrival_Date) AS Month,
    AVG(Avg_Daily_Rate) AS AverageADR
FROM
    SHG_Booking
WHERE
    Distribution_Channel = 'Corporate'
GROUP BY
    DATEPART(MONTH, Arrival_Date);

----Revenue trends over time 
SELECT
    DATEPART(MONTH, Arrival_Date) AS Month,
    SUM(Revenue) AS TotalRevenue
FROM
    SHG_Booking
WHERE
    Distribution_Channel = 'Corporate'
GROUP BY
    DATEPART(MONTH, Arrival_Date);

----Compariison of Online and Offline Travel Agents 
Select 
     Distribution_channel,
     Sum(Revenue) as Revenue,
     Sum(Revenue_Loss) as Revenue_Loss,
     Count(*) as No_of_Bookings,
     SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) AS CanceledBookings,
     AVG(CASE WHEN Status = 'Cancelled' THEN 1.0 ELSE 0.0 END) AS CancellationRate
 From SHG_Booking
 where Distribution_Channel in ('Online Travel Agent' ,'Offline Travel Agent')
 Group By Distribution_Channel
