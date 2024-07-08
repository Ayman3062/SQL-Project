WITH best_selling AS (
    SELECT artist.artist_id AS a_id, 
           artist.name AS a_name, 
           SUM(invoice_line.unit_price * invoice_line.quantity) AS total_sell
    FROM invoice_line
    JOIN track ON track.track_id = invoice_line.track_id 
    JOIN album ON album.album_id = track.album_id 
    JOIN artist ON artist.artist_id = album.artist_id 
    GROUP BY artist.artist_id, artist.name
)

select customer.first_name , customer.last_name , best_selling.a_name , 
sum(invoice_line.unit_price * invoice_line.quantity) as amount_spent
from invoice
join customer on customer.customer_id = invoice.customer_id
join invoice_line on invoice_line.invoice_id = invoice.invoice_id
join track on track.track_id = invoice_line.track_id
join album on album.album_id = track.album_id
join best_selling on best_selling.a_id = album.artist_id

group by 1,2,3
order by amount_spent desc