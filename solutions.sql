-- Add you solution queries below:

1. Write a query to display for each store its store ID, city, and country.

select s.store_id, c.city, cc.country
from store as s
join address as a on s.address_id = a.address_id
join city as c on a.city_id = c.city_id
join country as cc on c.country_id = cc.country_id


2. Write a query to display how much business, in dollars, each store brought in.

select s.store_id as store, SUM(p.amount) as total_sales
from store as s
join inventory as i on s.store_id = i.store_id
join rental as r on i.inventory_id = r.inventory_id
join payment as p on p.rental_id = r.rental_id
group by s.store_id;


3. What is the average running time of films by category?

select c.name as category, avg(f.length) as running_time
from film as f
join film_category as fc on f.film_id = fc.film_id
join category as c on fc.category_id = c.category_id
group by c.name


4. Which film categories are longest?

select c.name as category, avg(f.length) as running_time
from film as f
join film_category as fc on f.film_id = fc.film_id
join category as c on fc.category_id = c.category_id
group by c.name
order by running_time DESC LIMIT 1;


5. Display the most frequently rented movies in descending order.

SELECT f.title, count(r.rental_id) as number_of_rental
FROM film as f
Join Inventory as i on f.film_id = i.film_id
Join rental as r on i.inventory_id = r.inventory_id
group by f.title
order by number_of_rental DESC limit 1;


6. List the top five genres in gross revenue in descending order.

SELECT c.name as category, sum(p.amount) as total_sales
from film as f
join film_category as fc on f.film_id = fc.film_id
join category as c on fc.category_id = c.category_id
join inventory as i on f.film_id = i.film_id
join rental as r on i.inventory_id = r.inventory_id
join payment as p on r.rental_id = p.rental_id
group by category
order by total_sales DESC LIMIT 5;

7. Is "Academy Dinosaur" available for rent from Store 1?

SELECT 
 CASE 
 WHEN EXISTS (
 SELECT 1 
 FROM inventory AS i
 JOIN film AS f ON i.film_id = f.film_id
 WHERE f.title = 'Academy Dinosaur'
 AND i.store_id = 1
 AND i.inventory_id NOT IN (
 SELECT inventory_id FROM rental WHERE return_date IS NULL
 )
 ) THEN 'Yes'
 ELSE 'No'
 END AS is_available;

