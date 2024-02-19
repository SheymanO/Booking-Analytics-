# Booking Analytics using sql
# Introduction
Step into the convergence of data and hospitality, where every reservation ,each arrival and every interaction intricately knit a canvas of undiscovered insights. In this report we explore the booking data of splendor Hotel Group .

As we unravel the layers of this analysis ,we traverse through the patterns ,outliers, nuances that shape the dynamic ebb and flow of  SHG’s booking landscape .From lead times to customer types ,distribution channels to  cancellation rates ,our exploration seeks to not only understand the past but to illuminate the pathways toward informed decision-making for the future.

Together let’s uncover the stories that lies beneath the surface ,transforming data into a compass that guides strategic choices for Splendor Hotel Groups .

# Objective 

In this report we will explore diverse facets of hotel booking dynamics, customer behaviour, and operational efficiency. Key inquiries delve into booking trends, customer demographics, cancellation drivers, revenue optimization, geographical patterns, deposit impact, corporate bookings, time-to-event dynamics, and distinctions between online and offline travel agents. The analysis aims to reveal actionable insights, enhance revenue strategies, and inform operational decisions for Splendor Hotel Groups.

# Data Source 

The primary dataset used in this analysis is a dummy dataset from splendor a X user , the dummy data captures a comprehensive record of reservations ,guest interactions and related detail.
The data is in a csv format ,with multiple variables that captures various aspects of the booking process ,number of guests ,distribution channel, this variable make it easy to derive actionable insights .
The dataset spans from 2013 – 2017 ,providing a comprehensive view of booking patterns, customer behaviours and operational dynamics throughout the year. 
Add the link to the data source and project brief .

Below is the variable description of the dataset.

  **Booking ID**: Unique identifier for each booking.  
     **Hotel**: Type or name of the hotel within the Splendor Hotel Group.  
      **Booking Date**: Date when the booking was made.  
      **Arrival Date**: Date when the guests are scheduled to arrive.  
      **Lead Time**: Number of days between the booking date and arrival date.  
      **Nights**: Number of nights the guests are booked to stay.  
      **Guests**: Number of guests included in the booking.  
      **Distribution Channel**: The channel through which the booking was made (e.g.,           Direct, Online Travel Agent, Offline Travel Agent).  
      **Customer Type**: Type of customer making the booking (e.g., Transient, Corporate).  
      **Country**: Country of origin of the guests.  
      **Deposit Type**: Whether a deposit was made for the booking (e.g., No Deposit, Deposit).  
      **Avg Daily Rate**: Average daily rate for the booking.  
      **Status**: Status of the booking (e.g., Check-Out, Canceled).  
      **Status Update**: Date of the last status update for the booking.  
      **Canceled (0/1)**: Binary indicator of whether the booking was canceled (1 if canceled, 0 if not canceled).  
      **Revenue**: Revenue generated from the booking.   
      **Revenue Loss**: Loss in revenue if the booking was cancelled (negative value if the booking wasn't canceled).  

# Data Exploration 

During this phase, our focus is on acquainting ourselves with the dataset. Let's ascertain the overall number of bookings for Splendor Group.

In our dataset we have the hotel variable , which comprises of the type of hotel in the splendor group ,we have the resort and city hotels ,we have a total of 40,060 bookings for hotel and 79,330 bookings for City.

For the distribution channel ,74,072 bookings were made through online travel agent ,23,991 through offline travel agent ,6,677 through corporate ,14,645 through direct bookings and 5 bookings through undefined  channels. SHG had different customer types making reservations for their hotels , we have the group ,contract ,transient and transient-party customer type .

For the Deposit type variable, different guests had different options for deposit , some No-deposit , some refundable and some non-refundable ,what effect could this have on our analysis ? Stay with me as we continue to explore our dataset.

In our data set not all guest that made reservations showed up ,we have a status variable to indicate if our guest checked in or cancelled their bookings . 

The booking date ,supposed arrival date and lead time, and number of night stay  for all bookings were also indicated in the dataset , the average daily rate for each booking , SHG had bookings from 175 different countries .


# Data Cleaning and Transformation 

"In our dataset, a data point in the 'Status' variable was misspelled. To rectify this, the SQL UPDATE statement was employed. 

The 'Average Daily Rate,' 'Revenue,' and 'Revenue Loss' variables were initially stored in string format with a dollar sign. To enable aggregation functions on these variables, it was necessary to convert them to a format compatible with aggregation functions. In this instance, the conversion was performed by altering the column format to 'money' in SQL Server. This involved using the ALTER COLUMN statement along with an UPDATE statement to transform the string format, replacing the dollar sign. 

**Checking for Duplicate**
When checking for duplicates in SQL, you need to select each column from the dataset, count the occurrences of observations, group by each column, and utilize the HAVING clause. The HAVING clause is employed to filter and return instances where the count of observations in each group is greater than one.

**Data Validation**  
In our dataset, we utilize the 'Lead Time' variable, representing the duration between the booking date and arrival date. To validate the accuracy of the lead time data, the DATEDIFF function in SQL is employed. This function calculates the difference in days between the booking date and arrival date. By applying a WHERE clause, we selectively display cases where the lead time differs from the calculated difference. All lead time are valid.
All sql query used can be found in [Sql Query ](Data_cleaning.sql)

# Data Analysis

In this phase, the main aim is to conduct our data analysis to answer the business questions as stated in the objectives .

**Booking Patterns**   
Analyzing the trend in booking patterns, we can be able to derive a lot of information from this , the peak seasons  and years for bookings .
The first thing we can do is to create a new table , and select the relevant variables useful for the booking pattern analysis , and perform our analysis on this table . 
Year 2016 recorded the highest number of bookings ,a total of 58,453 bookings were recorded ,there was a decline in the number of bookings in the year 2017 ,total of 26,565 bookings.

**Month with most booking for each year**   

This can be achieved by utilizing a Common Table Expression, calculate the count of bookings for each month, and assign a row number based on the count in descending order , and filter to include only the top ranked month for each year .A final select statement is used to extract the year, month and the corresponding number of bookings for the top-ranked months, ordered by year .  

In the year 2016 and 2017 ,the  month of January the highest number of bookings were recorded a total of 7,654 and 7,869 bookings respectively .

**Quarter with most bookings for each year**   

In the year 2016 and 2017, in first quarter  the highest number of bookings were recorded a total of 19,980 and 17,250 bookings respectively and in 2014 and 2015 in  fourth quarter the highest number of bookings were recorded .

Sql query used can be found in [Sql Query ](Booking_pattern_Analysis.sql) 
 
**Customer Behavior Analysis**

Which distribution channels contribute the most to bookings, and how does the average daily rate (ADR) differ across these channels?

online travel agent contributed the most to the no of bookings, which is way higher compared to other distribution channels, having X% more than the next distribution channel.
Considering the average daily rate, the direct distribution channel and online travel agent had average daily rate close to 110$ ,while other channels had average daily rate below 100$ .

Let’s see which country contributes to the number of bookings 
Portugal has the highest contribution to number of bookings and Portugal generates the highest revenue
Sql query used can be found in [Sql Query ](Customer_Behaviour.sql) 

**Cancellation Analysis** 

What factors are most strongly correlated with cancellations, and can we predict potential cancellations based on certain variables?

Let us see the relationship distribution channel and customer type as with rate of cancellations.

We can see in majority of the customer types, online travel agents have the highest no of cancellations this can be due to change in plans of travellers or the travellers were able to secure other accomodations, we can say the probability of any booking made by online travel agent to be cancelled is high.
Sql query used can be found in [Sql Query ](Cancellation_Analysis.sql) 

**Revenue Optimization**   
Portugal contributes a total of $9million to the revenue ,a very large percentage of guest bookings came from Portugal 
It will be of great help to determine the customer type that contributes more to the revenue ,out of the 175 different countries from which our guests bookings  originated from ,9 of the countries generated zero revenue  and for countries that generated revenue, 88% of the customer type that contributed more to the revenue per country were the Transient customer type .
Sql query used can be found in [Sql Query ](Revenue_Optimization.sql)  

**Geographical Analysis**   

Guest Distribution across different countries 
To analyze the distribution of guests across various countries, we examined the booking data for Splendor Hotel Groups (SHG).  The data revealed that the majority of guests originated from diverse countries, with notable concentrations from key regions. Portugal and United kingdom contribute significantly to the guest count, suggesting a potential focus for marketing efforts.

Correlation with cancellations 
Portugal had cancellation rate of 55%, Spain had a cancellation rate of 25%, and the United Kingdom had a cancellation rate of 19.8%, Only Portugal has a slightly higher cancellation rate compared to others.  
Sql query used can be found in [Sql Query ](Geographical_Analysis.sql) 

**Operational Efficiency**   

The objective of this analysis is to determine the average length of stay for guests, identify variations based on booking channels or customer types, and explore patterns in check-out dates for informed staffing and resource allocation strategies.

Variations based on Distribution channels.   

•	Online Travel Agents (OTA): 3 days  
•	Offline Travel Agents: 4 days  
•	Direct Bookings: 3 days  
•	Corporate Bookings: 2 days  
•	Undefined Channel: 5 days  

The guest booking through. Offline Travel Agents tend to have longer stays compared to other channels.  

Variations based on Customer Type.   

•	Contract 6 days  
•	Transient :3 days  
•	Transient-party: 3 days  
•	Group: 2 days  

Contract guests appear to have the longest average stays, while Group guests have a slightly shorter duration.  

Analyzing patterns in check-out dates is crucial for effective staffing and resource allocation. We observed the following trends:  

•	Peak Check-Out Days: Thursdays and Sundays  
•	Off-Peak Check-Out Days: Tuesdays and Wednesdays  

These patterns suggest staffing levels can be adjusted to accommodate higher check-out volumes on Thursdays and Sundays.  

Sql query used can be found in [Sql Query ](Operational_Efficiency.sql)  

# Data Visualization
An interactive dashboard for the SHG booking analysis was created in tableau ,follow this link to the [dashboard](https://public.tableau.com/views/Book1_17050766597460/Dashboard1?:language=en-GB&:sid=&:display_count=n&:origin=viz_share_link)


# Recommendation

**Marketing Focus**: Marketing efforts towards countries with high guest counts, such as Portugal and United Kingdom should be considered.  

**Cancellation Mitigation**: Strategies to mitigate cancellations, especially for guests from countries with higher cancellation rates should be implemented. 

**Extended Stay Promotions**: Promotions targeting countries with longer average stays to encourage extended visits should be developed.  

**Marketing Strategies**: Marketing strategies to promote longer stays, especially for channels with shorter average durations should be considered.  

**Resource Allocation**: Adjust staffing levels to accommodate peak check-out days, ensuring a smooth guest departure experience.  

**Special Promotions**: Introducing special promotions for customer types with shorter stays to encourage extended bookings.  










