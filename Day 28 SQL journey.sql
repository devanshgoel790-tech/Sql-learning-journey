create database Restaurant_operations;
use restaurant_operations;

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  restaurant_name VARCHAR(50),
  cuisine_type VARCHAR(30),
  location VARCHAR(30),
  dish_name VARCHAR(50),
  price DECIMAL(8,2),
  quantity_ordered INT,
  customer_rating INT,
  order_date DATE,
  chef_name VARCHAR(50)
);

INSERT INTO orders VALUES
(1, 'Spice House', 'Indian', 'Delhi', 'Biryani', 350.00, 2, 5, '2026-09-01', 'Rajesh'),
(2, 'Spice House', 'Indian', 'Delhi', 'Butter Chicken', 280.00, 3, 4, '2026-09-01', 'Rajesh'),
(3, 'Pasta Paradise', 'Italian', 'Mumbai', 'Carbonara', 450.00, 1, 5, '2026-09-02', 'Marco'),
(4, 'Dragon Fire', 'Chinese', 'Delhi', 'Kung Pao Chicken', 320.00, 4, 3, '2026-09-02', 'Wang'),
(5, 'Spice House', 'Indian', 'Delhi', 'Paneer Tikka', 290.00, 2, 5, '2026-09-03', 'Rajesh'),
(6, 'Pizza Zone', 'Italian', 'Bangalore', 'Margherita Pizza', 380.00, 5, 4, '2026-09-01', 'Giovanni'),
(7, 'Dragon Fire', 'Chinese', 'Mumbai', 'Sweet and Sour', 310.00, 3, 4, '2026-09-03', 'Wang'),
(8, 'Taco Fiesta', 'Mexican', 'Delhi', 'Chicken Tacos', 250.00, 6, 5, '2026-09-04', 'Carlos'),
(9, 'Pasta Paradise', 'Italian', 'Delhi', 'Risotto', 420.00, 2, 4, '2026-09-02', 'Marco'),
(10, 'Spice House', 'Indian', 'Mumbai', 'Dosa', 200.00, 4, 5, '2026-09-04', 'Rajesh'),
(11, 'Dragon Fire', 'Chinese', 'Bangalore', 'Fried Rice', 280.00, 5, 3, '2026-09-05', 'Wang'),
(12, 'Pizza Zone', 'Italian', 'Delhi', 'Pepperoni Pizza', 400.00, 3, 5, '2026-09-03', 'Giovanni'),
(13, 'Taco Fiesta', 'Mexican', 'Mumbai', 'Beef Burrito', 320.00, 2, 4, '2026-09-05', 'Carlos'),
(14, 'Spice House', 'Indian', 'Delhi', 'Samosa', 150.00, 8, 5, '2026-09-02', 'Rajesh'),
(15, 'Pasta Paradise', 'Italian', 'Mumbai', 'Lasagna', 480.00, 1, 5, '2026-09-06', 'Marco'),
(16, 'Pizza Zone', 'Italian', 'Mumbai', 'Veggie Pizza', 350.00, 4, 4, '2026-09-04', 'Giovanni'),
(17, 'Dragon Fire', 'Chinese', 'Delhi', 'Noodles', 240.00, 6, 4, '2026-09-06', 'Wang'),
(18, 'Taco Fiesta', 'Mexican', 'Bangalore', 'Fish Tacos', 300.00, 3, 5, '2026-09-01', 'Carlos'),
(19, 'Spice House', 'Indian', 'Bangalore', 'Chole Bhature', 220.00, 5, 4, '2026-09-05', 'Rajesh'),
(20, 'Pasta Paradise', 'Italian', 'Bangalore', 'Penne Arrabbiata', 410.00, 2, 4, '2026-09-06', 'Marco');

SELECT * FROM orders;

select restaurant_name, sum(price * quantity_ordered) as Total_Revenue from orders
group by restaurant_name
order by total_revenue desc;

select cuisine_type , avg(customer_rating) as avg_customer_rating from orders
group by cuisine_type
order by avg(customer_rating) desc
limit 2;

select chef_name, count(dish_name) from orders
group by chef_name
order by count(dish_name) desc;

select restaurant_name ,
					avg(customer_rating) as avg_customer_rating,
					sum(quantity_ordered) as total_quantity_ordered
 from orders
group by restaurant_name
having avg(customer_rating) > 4.5;

select location, sum(price * quantity_ordered) as Highest_Total_Revenue from orders
group by location 
order by Highest_Total_Revenue desc
limit 1;

select  restaurant_name, chef_name, avg(customer_rating) as avg_customer_rating from orders
group by chef_name, restaurant_name
having avg(customer_rating) > 4.5;

select cuisine_type, location, sum(quantity_ordered) as total_ordered, avg(customer_rating) as avg_rating from orders
group by cuisine_type, location
having sum(quantity_ordered) > 3
order by avg_rating desc;

select restaurant_name, count(chef_name), sum(price * quantity_ordered) as Total_Revenue from orders
group by restaurant_name
having sum(price * quantity_ordered) > 3000 and count(chef_name) > 3 ;

select restaurant_name, cuisine_type, 
                            avg(customer_rating) as avg_rating, 
                            sum(quantity_ordered) as total_quantity_ordered from orders
group by restaurant_name, cuisine_type
having  sum(quantity_ordered) >  3
limit 3;

select location, 
               sum(price * quantity_ordered) as Total_Revenue,
               count(cuisine_type) as count_cuisine_type,
               avg(customer_rating) as avg_customer_rating,
               count(chef_name) as chef_count
from orders
group by location 
having  sum(price * quantity_ordered) > 2500
	and avg(customer_rating) > 4
    and  count(cuisine_type)  >= 3
    and count(chef_name) >= 2
order by total_revenue desc;              
               






