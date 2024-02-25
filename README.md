# City Cycling Bike-Share Analysis: Understanding Casual Riders and Optimizing Conversions for City Cycling
## Introduction
City Cycling's bike-share program has seen tremendous success, growing to over 5,000 bicycles across 692 stations. While casual riders contribute significantly, maximizing annual memberships remains crucial for long-term sustainability. This report analyzes rider data from 2023 to uncover insights into casual rider behavior and recommend data-driven marketing strategies for conversion.

City Cycling's marketing strategy has so far focused on building general awareness and appealing to broad consumer segments. The company offers flexible pricing plans that cater to the diverse needs of users including single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are City Cycling members

The company's marketing director believes that the company’s future success depends on maximizing the number of annual memberships. The Marketing Director has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. This analysis uses historical bike trip data from January to December  2023 to uncover insights into casual riders’ behavior and recommend data-driven marketing strategies for conversion to annual memberships

## Business Task
Design marketing strategies to convert casual riders to members by analyzing their differences, why casual riders would buy a membership, and how digital media could affect marketing decisions..

### Key questions to guide the analysis.
How do annual members and casual riders differ in their usage patterns?
What factors influence casual riders to convert to annual memberships?
How can City Cycling leverage digital media to reach and convert casual riders?

## Data Source
The data would cover rider information spanning one year from January 2023 to December 2023. The data has been made available by Motivate International Inc. with a [license](https://ride.divvybikes.com/data-license-agreement) and is originally stored in separate CSV files organized by the different months of the year [here](https://divvy-tripdata.s3.amazonaws.com/index.html).

The dataset consists of 13 variables such as

* ride_id	- Unique ID assigned to each ride
* rideable_type	- classic, docked, or electric
* started_at - Date and time at the start of trip
* ended_at - Date and time at the end of trip
* start_station_name - Name of the station where the riders’ journey started from
* start_station_id - ID of the station where the riders’ journey started from
* end_station_name - Name of the station where the ride trip ended at
* end_station_id -  ID of the station where the ride trip ended at
* start_lat - Latitude of starting station
* start_lng - Longitude of starting station
* end_lat - Latitude of ending station
* end_lng - Longitude of ending station
* ride_plan - Type of membership of each rider

## Methodology
Data from 13 variables spanning 1 year was analyzed using PostgreSQL and visualized in Tableau.
### Data Processing & Cleaning
To prepare the data for analysis, I followed these steps:
Data Import and Merging: All CSV files containing rider data from January to December 2023 were imported into a PostgreSQL database and merged into a single table named "cycling_data". This table consisted of 13 variables and initially contained 5,667,717 rows.
Duplicate Removal: The data was checked for duplicate entries (there were no duplicates)
Null Value Handling: Columns containing missing values (NULLs) were identified, and a total of 1,388,159 rows with NULL data were removed to ensure cleaner analysis.

### Feature Engineering: 
This involves creating some new columns for deeper understanding..
> 1. Created a new column named ride_length to give insight into the amount of time each ride is for 
> 2. Created a new column named date_month that contains the extracted months of the year for every ride. This will help determine which month of the year has the most rides.
> 3. Created a new column named day_of_week to give insight into which days of the week riders ride the most
> 4. Created a new column named time_of_day that contains the extracted hours of the day with the most rides This will help answer the question of what time of the day riders ride mostly.

During data exploration, I identified inconsistencies in ride durations, where some rides had negative durations (ending time before starting time). These were clearly errors and were removed (76 rows in total). Additionally, trips lasting less than a minute were excluded, as they likely represent false starts or users briefly docking the bike for security.
The cleaned dataset contains 4,331,138 rows

## Exploratory Data Analysis (EDA): 
To understand how members and casual riders differ in their usage, I conducted a detailed analysis focusing on several key aspects:

* Ride Volume and Duration: I compared the total number of rides taken by each group, revealing the overall usage distribution. Average ride duration (in minutes) was calculated for both groups, providing insights into their typical trip lengths.
* Daily and Time-Based Usage: The number of rides per day and average ride duration per day were examined for both groups, uncovering potential daily usage patterns. Time-of-day analysis involved calculating the number of rides per hour, offering insights into peak usage periods and potential trip purposes for each group.
* Monthly Trends: The number of rides per month was analyzed for both groups, revealing any seasonal variations in their usage patterns.
* Station Usage: To identify the most frequented start and end stations for each group, I calculated the number of rides per station. This provided valuable information about their preferred locations.

This comprehensive analysis, covering various aspects of usage, shed light on the distinct preferences and behaviors of members and casual riders, laying the groundwork for informed marketing strategies.


## Data Visualization
My final CSV file was exported to Tableau to create the visualizations and dashboard  to further communicate my findings.

![Dashboard 1](https://github.com/alayelawson/City-Cycling-Analysis/assets/134657438/fe5b36de-635e-44bc-8782-6b2e2b404d55)

[Tableau Dasboard](https://public.tableau.com/views/CityCylingBike-ShareAnalysis/Dashboard1?:language=en-US&publish=yes&:sid=&:display_count=n&:origin=viz_share_link)


## Results:
Key Differences between Member and Casual Riders:
> 1. Ride length: Casual riders average significantly longer rides (23 hours) compared to members (12 hours), suggesting interest of casual riders in extended trips.
> 2. Time of day: Both groups peak at 5 PM, with members having secondary peak time at 8 AM ang high usage between Tuesday and Friday, indicating potential commuting usage. However, casual riders also show higher activity in evenings and weekends, suggesting recreational purposes.   
> 3. Station usage: While both groups utilize diverse stations, casual riders favor Streeter Dr & Grand Ave, potentially indicating attraction to specific locations or longer trips. Members prefer Clinton St & Washington Blvd, possibly closer to their work commutes.

## Understanding Casual Riders' Motivations for Membership:
Longer ride lengths and weekend/evening activity suggest casual riders might be interested in memberships if they are offered:
1. Cost savings: Analyze how much frequent casual riders spend on single rides compared to annual membership cost to quantify potential savings. Highlight annual membership benefits like cost savings for frequent users.
2. Convenience: Explore offering multi-day passes or discounted rates for longer trips.
3. Flexibility: Showcase membership benefits like unlimited rides, bike type upgrades, or priority access to popular stations.
4. Additional Features: Investigate member-exclusive features (e.g., e-bikes, reserved parking) and showcase them in marketing campaigns.

## Recommendations:
1. Dynamic Pricing: Implementing dynamic pricing based on demand and station availability. This can incentivize casual riders to subscribe for guaranteed access during peak hours or at popular stations.
2. Loyalty Programs: Implement a loyalty program rewarding frequent riders with points redeemable for discounts or exclusive benefits, encouraging them towards membership.
Leveraging Digital Media for Conversion:
3. Targeted ads: Based on station usage and ride patterns, target ads on specific platforms popular with casual riders in popular areas and during peak times.
4. Content Marketing: Create engaging content showcasing membership benefits, user testimonials, and bike usage tips across various digital channels.
5. Personalized content: Develop content showcasing longer scenic routes, weekend getaways, or discounts for multi-day trips to address casual rider interests.
6. Interactive tools: Create an online trip planner suggesting routes and station availability based on user preferences, potentially enticing casual riders to explore membership benefits. Use rider app push notifications and targeted in-app promotions for further engagement.

## Limitations:
### Data: 
> 1. Cost of plans: No information on individual plan costs hinders comparing actual savings for casual riders.members
> 2. Limited timeframe: Analyzing data from only one year might not capture seasonal variations in rider behavior or long-term trends.
> 3. Lack of demographic information: Understanding demographics like age, income, and location could provide deeper insights into motivations and preferences.
> 4. Limited ride details: Only start and end stations are available, missing information on intermediate stops and routes, which could be valuable for understanding trip purposes and station usage patterns.
> 5. No information on conversion attempts: The data doesn't reveal past marketing efforts or their impact on conversion rates, making it harder to assess the effectiveness of proposed strategies.
### Analysis:
> 1. Self-reported data limitations: The analysis assumes ride data accurately reflects actual usage, but factors like missing rides or inaccurate GPS data could exist.
### General:
> 1. External factors: The analysis doesn't consider external factors like weather, gas prices, traffic situation or public transportation changes that might influence rider behavior.
> 2. Competitor analysis: Understanding competitor offerings and marketing strategies could provide valuable insights for City Cycling.

## Conclusion:
By understanding casual rider behavior, motivations, and digital media preferences, City Cycling can develop targeted marketing strategies to incentivize membership conversion. The recommended actions, supported by data-driven insights, provide a roadmap for achieving this goal and contributing to City Cycling's continued success.


