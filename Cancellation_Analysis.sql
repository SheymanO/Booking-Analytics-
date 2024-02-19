-- What factors are most strongly correlated with cancellations, and can we predict potential cancellations based on certain variables?

Select Distribution_channel,Customer_type,count(*) as No_of_cancellations from 
SHG_Booking
where status ='Cancelled'
Group by Distribution_channel,Customer_type

----Revenue loss from cancellations 
SELECT
    Distribution_channel,
    Customer_Type,
    COUNT(*) AS No_of_cancellations ,
    SUM(Revenue_Loss) AS TotalRevenue
FROM
    SHG_Booking 
where Status ='Cancelled'
GROUP BY
    Distribution_channel,Customer_Type
ORDER BY
    TotalRevenue  DESC;
