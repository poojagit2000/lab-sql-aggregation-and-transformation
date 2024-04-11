/* Challenge 1
You need to use SQL built-in functions to gain insights relating to the duration of movies: */
USE sakila;

#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select MIN(length) as min_duration,MAX(length) as max_duration from sakila.film;
/*1.2. Express the average movie duration in hours and minutes. Don't use decimals.
Hint: Look for floor and round functions.
You need to gain insights related to rental dates:*/
select * from film;
select concat(
FLOOR(AVG(length) / 60),
'hours',
ROUND(AVG(length) % 60),
'minutes'
) as average_duration
from film;

/*2.1 Calculate the number of days that the company has been operating.
Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.*/
select * from rental;
select DATEDIFF(MAX(rental_date),Min(rental_date)) as num_operating_days from rental;
#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select *,date_format(convert(rental_date,DATE) ,'%Y-%m-%d') as formatted_date,
MONTH(rental_date) as rental_month,
DAYNAME(rental_date) as rental_weekday 
from rental 
limit 20;

/*2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
Hint: use a conditional expression.*/
select * from rental;
select *, 
CASE
when DAYNAME(rental_date) in ('Saturday','Sunday') THEN 'weekend' 
ELSE 'workday' 
END AS DAY_TYPE 
FROM rental ;

/*3. need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
Hint: Look for the IFNULL() function.*/
 
#Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.
SELECT CONCAT(first_name, ' ', last_name) AS FULL_NAME,
LEFT(email, 3) AS email_prefix
FROM customer
ORDER BY last_name ASC;
/*Challenge 2
Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
1.1 The total number of films that have been released.*/
select COUNT(*) as num_of_films from film;

#1.2 The number of films for each rating.
select rating,count(*) as count_rating from film group by rating;
#1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
select rating,count(*) as count_rating from film group by rating order by count_rating DESC;
#2.Using the film table, determine:
#2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
select rating,ROUND(AVG(length),2) as mean_duration from film group by rating order by mean_duration DESC;
#2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select rating from film group by rating having  ROUND(AVG(length),2) > 2 ;
#Bonus: determine which last names are not repeated in the table actor.
select last_name from actor group by last_name having count(*) =1;