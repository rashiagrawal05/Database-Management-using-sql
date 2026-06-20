create database Sakila;
use Sakila;

## question 10:

## task1: 
##Identify the top 5 customers based on the total amount they’ve spent.
## Include customer name, email, and total amount spent.

select concat(c.first_name," ",c.last_name) as customer_name,c.email,round(sum(p.amount),2) as total_amount_spent 
from customer c join payment p on c.customer_id = p.customer_id
group by customer_name,c.email
order by total_amount_spent desc 
limit 5;

##task 2 :
## Which 3 movie categories have the highest rental counts?
## Display the category name and number of times movies from that category were rented.
select * from rental;


## task 3:
## Calculate how many films are available at each store and how many of those have never been rented.

select * from customer;

select store_id,active,count(active) from customer
group by store_id, active
order by store_id;


##task 4
## Show the total revenue per month for the year 2023 to analyze business seasonality

select * from payment;
select month(payment_date) as pay_month,round(sum(amount),2) as total_revenue from payment
where year(payment_date)=2005
group by pay_month; 

##task 5 
## Identify customers who have rented more than 10 times in the last 6 months.

select customerId, count(rental_id) as no_of_times_rented 
from rental
group by customerId
order by customerId;