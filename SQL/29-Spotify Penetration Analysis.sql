# Question
  Market penetration is an important metric for understanding Spotifys performance and growth potential in different regions.
You are part of the analytics team at Spotify and are tasked with calculating the active user penetration rate in specific countries.
For this task, 'active_users' are defined based on the  following criterias:
last_active_date: The user must have interacted with Spotify within the last 30 days.
•    sessions: The user must have engaged with Spotify for at least 5 sessions.
•    listening_hours: The user must have spent at least 10 hours listening on Spotify.
Based on the condition above, calculate the active 'user_penetration_rate' by using the following formula.
•    Active User Penetration Rate = (Number of Active Spotify Users in the Country / Total users in the Country)
Total Population of the country is based on both active and non-active users.
The output should contain 'country' and 'active_user_penetration_rate' rounded to 2 decimals.
Lets assume the current_day is 2024-01-31.

# Link  
  https://platform.stratascratch.com/coding/10369-spotify-penetration-analysis?code_type=1

# Answer
with total as (
select country , count(user_id) t 
from penetration_analysis
group by 1
),
active as (select country , count(user_id) a 
from penetration_analysis
where sessions >= 5
and  listening_hours >= 10
and last_active_date >= cast('2024-01-01' as DATE)
group by 1 )
select country ,a*100/t AS Active_User_Penetration_Rate
from total 
join active  
using(country)
