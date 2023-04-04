/*
3. 
Given is the table schema

- users
    - id
    - name
    - city
    - email
    - password
    - isActive
    - createdAt
    - updatedAt
    - deletedAt
- cabs
    - id
    - userId
    - regNumber
    - isActive
    - createdAt
    - updatedAt
    - deletedAt
- drivers
    - id
    - name
    - licenceNumber
- trips
    - id
    - cabId
    - driverId
    - from
    - to
    - distance
    - fromLat
    - fromLng
    - toLat
    - toLng
    - fare
    - amount
    - tax

Question 1

Write a single query in mysql that fetches summary for all users that includes following data for a given date.

- User name
- Revenue
- Distance travelled
- Number of cabs that generated revenue, (there could be some cabs that didn’t run at that day, do not include them)
- Total trips done
- Most active cab (Get the detail of the most active cab)

Question 2

On which columns would you create indexes to make your query run faster?
*/





/*
 Ans 1- 
In this query, we join the users, cabs, and trips tables together to get the required data for a 
given date (specified in the WHERE clause). We use the SUM() function to 
calculate the total revenue and distance travelled by each user. We use COUNT(DISTINCT t.cabId) to 
count the number of unique cabs that generated revenue, and COUNT(*) to count the total number of trips done by each user.
Finally, we use a subquery to get the details of the most active cab, which is the cab with the highest number of trips
for the given date.
*/
SELECT u.name AS `User Name`,
       SUM(t.amount) AS `Revenue`,
       SUM(t.distance) AS `Distance Travelled`,
       COUNT(DISTINCT t.cabId) AS `Number of Cabs that Generated Revenue`,
       COUNT(*) AS `Total Trips Done`,
       (SELECT CONCAT_WS(', ', c.regNumber, c.isActive, c.createdAt) FROM cabs c JOIN trips t2 ON t2.cabId = c.id WHERE t2.createdAt >= '2023-04-04' GROUP BY c.id ORDER BY COUNT(*) DESC LIMIT 1) AS `Most Active Cab`
FROM users u
JOIN cabs c ON u.id = c.userId
JOIN trips t ON c.id = t.cabId
WHERE t.createdAt >= '2023-04-04'
GROUP BY u.id

/**
 * Aws- 2:

To make the query run faster, we can create indexes on the columns used in the JOIN and WHERE clauses. 
Specifically, we can create the following indexes:

cabs(userId): This index will help to speed up the join between the users and cabs tables by creating 
a quick lookup for the userId column in the cabs table.
trips(cabId): This index will help to speed up the join between the cabs and trips tables by creating a
quick lookup for the cabId column in the trips table.
trips(createdAt): This index will help to speed up the WHERE clause by creating a quick lookup for the 
createdAt column in the trips table.


 */