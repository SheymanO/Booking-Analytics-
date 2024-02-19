# Data Exploration 
#This selects the all variables in the SHG Dataset ,running this query can inform us how the dataset looks like .
Select * 
from SHG_Booking 

#How many observations do we have in the dataset 
Select count(*) 
from SHG_Booking 

# Types of Hotels within the SGH
Select Hotel 
from SHG_Booking
Group by Hotel

# Type of Distribution channels 
Select Distribution_Channel 
from SHG_Booking
Group by Distribution_Channel

# Type of Customer
Select Customer_Type 
from SHG_Booking
Group by Customer_Type

# Type of Deposit 
Select Deposit_Type 
from SHG_Booking
Group by Deposit_Type

# Booking Status
Select [Status] 
from SHG_Booking
Group by [Status]

With above sql commands we would have been able to uderstand what our data look like  
