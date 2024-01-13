select count(*)
from inventory
where film_id =(select film_id 
				from film
                where title = 'Hunchback Impossible');
select title, length
from film 
where length > (select avg(length) from film);
select first_name, last_name, fa.actor_id from film_actor fa
join actor using(actor_id)
where film_id =(select film_id from film 
				where title ='Alone Trip');
select title as movies
from film
join film_category using(film_id)
where category_id = (select category_id from category where name = 'Family');
select first_name, last_name, email
from customer 
where address_id in (select address_id
	from address
    where city_id in (select city_id
					from city
                    where country_id =(select country_id
                    from country
                    where country = 'Canada')));
select first_name, last_name, email
from customer
join address using(address_id)
join city using(city_id)
join country using(country_id)
where country = 'Canada';
select film_id
from film_actor 
where actor_id = (select actor_id from (select actor_id, count(film_id)
from film_actor
group by actor_id
order by count(film_id) desc
limit 1) sub1);
select title
from film
join inventory using(film_id)
where inventory_id in (select inventory_id 													
					  from rental
					  where customer_id = (select customer_id from (select customer_id, sum(amount)
														from payment
														group by customer_id
														order by sum(amount) desc
														limit 1) sub1));
 select customer_id as client_id, sum(amount) as total_amount_spent
 from payment
 group by customer_id
 having sum(amount) > 
 (select sum(amount)/count(*) as average_payment from payment)
 ;
