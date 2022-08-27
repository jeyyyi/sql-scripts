show databases;

use newsugartitasph;
show tables;

select * from customer;
select * from order_line;
select * from orders;
select * from product;
select * from delete_history;

# get revenue
select ol.product_id, p.product_name, sum(quantity * price) as revenue
from order_line as ol inner join product as p
on ol.product_id = p.product_id
group by p.product_id;