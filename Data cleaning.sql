# Data cleaning,Transformation and Validation 
  
--Alter the Avg_Daily_Rate data type  to money
  --The initial data type was a string 
  
ALTER TABLE SHG_Booking
ALTER COLUMN Avg_Daily_Rate  money;

--Update the column by converting the string to money and removing the dollar sign to enable data aggregation.

UPDATE SHG_Booking
SET Avg_Daily_Rate = TRY_CAST(REPLACE(Avg_Daily_Rate, '$', '') AS money);

-- Alter the Revenue data type  to money

ALTER TABLE SHG_Booking
ALTER COLUMN Revenue  money;

-- Update the column by converting the string to money

UPDATE SHG_Booking
SET Revenue = TRY_CAST(REPLACE(Revenue, '$', '') AS money);

-- Alter the Revenue_Loss data type  to money

ALTER TABLE SHG_Booking
ALTER COLUMN Revenue_Loss  money;

-- Update the column by converting the string to money

UPDATE SHG_Booking
SET Revenue_Loss = TRY_CAST(REPLACE(Revenue_Loss, '$', '') AS money);

------Change canceled to cancelled in status

UPDATE SHG_Booking
SET [Status] = 'Cancelled'
where [Status] = 'Canceled';

-----Validate lead time 
----There is a lead time variable in the data set ,Number of days between the booking date and arrival date.
----To validate all lead time in the dataset is valid 

Select Hotel , Booking_date ,Arrival_Date, Lead_Time,DATEDIFF(DAY,Booking_date ,Arrival_Date) as lead
from SHG_Booking
where Lead_time <> DATEDIFF(DAY,Booking_date ,Arrival_Date) 

---Check for duplicates 
----The sql command below will return no observations if there are no duplicates
  
SELECT  [Booking_ID]
      ,[Hotel],[Booking_Date],[Arrival_Date],[Lead_Time],[Nights],[Guests]
      ,[Distribution_Channel],[Customer_Type],[Country],[Deposit_Type] ,[Avg_Daily_Rate],[Status]
      ,[Status_Update],[Cancelled_0_1],[Revenue],[Revenue_Loss], count(*) as duplicates

From SHG_Booking
Group by Booking_ID]
      ,[Hotel],[Booking_Date],[Arrival_Date],[Lead_Time],[Nights],[Guests]
      ,[Distribution_Channel],[Customer_Type],[Country],[Deposit_Type] ,[Avg_Daily_Rate],[Status]
      ,[Status_Update],[Cancelled_0_1],[Revenue],[Revenue_Loss]
Having count(*) >1 
