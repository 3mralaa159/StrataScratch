# Question
Meta/Facebook is developing a search algorithm that will allow users to search through their post history. You have been assigned to evaluate the performance of this algorithm.

We have a table with the user''s search term, search result positions, and whether or not the user clicked on the search result.

Write a query that assigns ratings to the searches in the following way:
•	If the search was not clicked for any term, assign the search with rating=1
•	If the search was clicked but the top position of clicked terms was outside the top 3 positions, assign the search a rating=2
•	If the search was clicked and the top position of a clicked term was in the top 3 positions, assign the search a rating=3

As a search ID can contain more than one search term, select the highest rating for that search ID. Output the search ID and its highest rating.
Example: The search_id 1 was clicked (clicked = 1) and its position is outside of the top 3 positions (search_results_position = 5), therefore its rating is 2.

# Link
https://platform.stratascratch.com/coding/10350-algorithm-performance?code_type=1

# Answer
/* for each row */
select search_id , case
when clicked = 0 then 1
when clicked = 1 and search_results_position > 3 then 2
else 3
end as rating
from fb_search_events;

# Answer
/* max ratings */
WITH search_ratings AS (
    SELECT
        search_id,
        CASE 
            WHEN MAX(clicked) = 0 THEN 1  -- No clicks for the search
            WHEN MIN(CASE WHEN clicked = 1 THEN search_results_position END) > 3 THEN 2  -- Clicked but top clicked position > 3
            WHEN MIN(CASE WHEN clicked = 1 THEN search_results_position END) <= 3 THEN 3  -- Clicked and top clicked position <= 3
        END AS rating
    FROM fb_search_events
    GROUP BY search_id
)
SELECT search_id, MAX(rating) AS highest_rating
FROM search_ratings
GROUP BY search_id;
