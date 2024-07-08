select count(invoice_line.quantity) as purchase,customer.country , genre.name,
row_number() over(partition by customer.country order by count(invoice_line.quantity))
from invoice_line
join invoice on invoice.invoice_id = invoice_line.invoice_id
join customer on customer.customer_id=invoice.customer_id
join track on track.track_id = invoice_line.track_id
join genre on genre.genre_id = track.genre_id 
group by 2,3
order by 2 asc, 1 desc

with recursive customer_as as (select  sum(total) as total_spend, customer.country , customer.first_name,customer.last_name,billing_country
from invoice
join customer on customer.customer_id = invoice.customer_id
group by 2,3,4,5
order by 1 desc),
bill_boy as (select billing_country , max(total_spend) as max_spend
from customer_as
group by 1)
select customer_as.billing_country, customer_as.first_name,customer_as.last_name , customer_as.total_spend
from customer_as
join bill_boy on bill_boy.billing_country = customer_as.billing_country
where customer_as.total_spend= bill_boy.max_spend
order by 1

