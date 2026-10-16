use trade_db;

select c.client_name, s.stock_name, t.quantity 
from trades t 
INNER JOIN clients c 
ON t.client_id = c.client_id 
INNER JOIN stocks s 
ON t.stock_id = s.stock_id
where quantity > 10 
order by  t.quantity  desc,
         c.client_name desc ;

select t.trade_id, c.client_name, s.stock_name
from trades t 
INNER JOIN clients c
ON t.client_id = c.client_id 
INNER JOIN stocks s 
ON t.stock_id = s.stock_id 
where sector = 'IT'
ORDER BY t.trade_id;

select c.client_name, c.city, t.trade_id 
from clients c
LEFT JOIN trades t 
ON c.client_id = t.client_id 
WHERE city IN ('Mumbai','Delhi')
Group BY  c.client_name, c.city, t.trade_id 
order by  client_name,
		  trade_id ;

select c.client_name, count(t.trade_id) as number_of_trades 
from clients c
LEFT JOIN trades t 
ON c.client_id = t.client_id 
WHERE t.trade_id IS NOT NULL
GROUP BY  c.client_name
ORDER BY  count(t.trade_id) DESC,  c.client_name ;

select c.client_name, count(t.trade_id) as number_of_trades 
from clients c
LEFT JOIN trades t 
ON c.client_id = t.client_id 
GROUP BY  c.client_id
ORDER BY  count(t.trade_id) DESC,  c.client_name ;

select c.client_name, sum(t.quantity * t.price) as total_traded_value 
from clients c
Left join trades t 
ON t.client_id = c.client_id
WHERE t.trade_id IS NOT NULL
group by c.client_name
order by  sum(t.quantity * t.price) desc ;

select s.stock_name,  sum(t.quantity)as total_quantity_traded 
from stocks s 
INNER JOIN trades t 
ON s.stock_id = t.stock_id 
GROUP BY s.stock_name 
HAVING sum(t.quantity) > 30 
order by sum(t.quantity) DESC;

select b.broker_id ,b.broker_name, sum(t.quantity * t.price) as total_traded_value 
from trades t 
INNER JOIN clients c 
on t.client_id = c.client_id 
INNER JOIN brokers b 
ON c.broker_id = b.broker_id 
GROUP BY b.broker_id ,b.broker_name
ORDER BY total_traded_value  desc ;

SELECT b.broker_name, count(c.client_id)as number_of_clients  
from clients c 
RIGHT JOIN brokers b 
ON c.broker_id = b.broker_id 
GROUP BY b.broker_name
ORDER BY number_of_clients DESC ;

select s.sector, sum(t.quantity * t.price) as total_traded_value 
from stocks s 
Left JOIN trades t 
ON s.stock_id = t.stock_id 
GROUP BY  s.sector
HAVING sum(t.quantity * t.price)> 50000
ORDER BY sum(t.quantity * t.price) DESC 
LIMIT 2;


select * from brokers;
select * from clients;
select * from stocks;
select * from trades;