CREATE DATABASE market_expansion;
USE market_expansion;

CREATE TABLE market_expansion (
  transaction_id INT PRIMARY KEY,
  company_name VARCHAR(40),
  market_segment VARCHAR(30),
  region VARCHAR(20),
  product_line VARCHAR(30),
  customer_acquisition_cost DECIMAL(8,2),
  customer_lifetime_value DECIMAL(10,2),
  revenue_generated DECIMAL(11,2),
  marketing_spend DECIMAL(10,2),
  operational_cost DECIMAL(10,2),
  market_share_percent DECIMAL(5,2),
  customer_retention_rate INT,
  months_in_market INT,
  competitive_position VARCHAR(20),
  profitability_index DECIMAL(5,2)
);

INSERT INTO market_expansion VALUES
(1, 'TechCorp', 'Enterprise', 'North', 'Software', 5000, 85000, 450000, 45000, 120000, 15.5, 85, 24, 'Leader', 2.1),
(2, 'TechCorp', 'SMB', 'South', 'Cloud', 2000, 35000, 220000, 35000, 55000, 8.2, 72, 18, 'Challenger', 1.8),
(3, 'FinServe', 'Enterprise', 'East', 'Analytics', 8000, 125000, 580000, 65000, 180000, 18.5, 92, 30, 'Leader', 1.9),
(4, 'TechCorp', 'Enterprise', 'West', 'AI Platform', 6500, 95000, 520000, 55000, 140000, 16.2, 88, 20, 'Challenger', 2.3),
(5, 'FinServe', 'SMB', 'North', 'Mobile Banking', 3000, 45000, 280000, 42000, 70000, 9.8, 78, 15, 'Challenger', 1.7),
(6, 'TechCorp', 'SMB', 'East', 'Automation', 2500, 40000, 260000, 38000, 65000, 10.2, 75, 16, 'Challenger', 1.9),
(7, 'FinServe', 'Enterprise', 'North', 'Advisory', 7000, 110000, 650000, 60000, 200000, 19.8, 94, 32, 'Leader', 2.0),
(8, 'RetailCo', 'SMB', 'South', 'E-commerce', 1500, 28000, 180000, 28000, 45000, 6.5, 68, 12, 'Entrant', 1.5),
(9, 'TechCorp', 'Enterprise', 'South', 'Data Platform', 5500, 90000, 480000, 50000, 130000, 17.8, 86, 22, 'Leader', 2.2),
(10, 'FinServe', 'SMB', 'East', 'Payments', 2800, 42000, 290000, 40000, 72000, 11.2, 80, 14, 'Challenger', 1.8),
(11, 'RetailCo', 'Enterprise', 'North', 'Supply Chain', 4000, 65000, 350000, 45000, 95000, 12.5, 82, 18, 'Challenger', 1.9),
(12, 'TechCorp', 'SMB', 'North', 'Cybersecurity', 3500, 55000, 310000, 42000, 80000, 9.5, 81, 17, 'Challenger', 2.0),
(13, 'FinServe', 'Enterprise', 'West', 'Risk Management', 6800, 100000, 540000, 58000, 160000, 16.8, 90, 28, 'Leader', 2.1),
(14, 'RetailCo', 'SMB', 'West', 'Inventory', 1800, 32000, 210000, 32000, 52000, 7.2, 70, 13, 'Entrant', 1.6),
(15, 'TechCorp', 'Enterprise', 'East', 'IoT Solutions', 7200, 105000, 520000, 62000, 150000, 15.2, 87, 25, 'Challenger', 2.4),
(16, 'FinServe', 'SMB', 'South', 'Credit Scoring', 3200, 48000, 320000, 45000, 80000, 10.8, 79, 16, 'Challenger', 1.9),
(17, 'RetailCo', 'Enterprise', 'South', 'Logistics', 3500, 58000, 380000, 48000, 110000, 13.8, 84, 20, 'Challenger', 1.8),
(18, 'TechCorp', 'SMB', 'South', 'API Platform', 2200, 38000, 240000, 36000, 60000, 8.8, 76, 14, 'Challenger', 1.8),
(19, 'FinServe', 'Enterprise', 'South', 'Wealth Tech', 8500, 130000, 620000, 70000, 190000, 20.2, 96, 34, 'Leader', 2.2),
(20, 'RetailCo', 'SMB', 'East', 'Customer Analytics', 2100, 36000, 225000, 33000, 58000, 8.2, 72, 11, 'Entrant', 1.7);


select * from market_expansion;

select company_name,
                  sum(revenue_generated)as total_revenue,
                  sum(customer_acquisition_cost)as total_cac,
                  sum(customer_lifetime_value)as total_clc,
                  sum(customer_acquisition_cost/customer_lifetime_value)as cac_payback_efficiency,
                  sum( marketing_spend)as total_marketing_spend,
                  sum(revenue_generated - marketing_spend/ marketing_spend)as marketing_ROI,
                  avg(customer_retention_rate)as avg_retention_rate,
                  count(market_segment)as count_markets
from market_expansion
group by company_name
having total_revenue > 2500000
  and  avg_retention_rate >80
  and count_markets >=3
order by cac_payback_efficiency desc;

select region,
        market_segment,
                      sum(revenue_generated)as total_revenue,
                      sum(customer_acquisition_cost+ operational_cost+ marketing_spend)as total_cost,
                      (sum(revenue_generated) - sum(customer_acquisition_cost+ operational_cost+ marketing_spend)) as gross_profit,
					  (sum(revenue_generated) - sum(customer_acquisition_cost+ operational_cost+ marketing_spend) /  sum(revenue_generated) )* 100 as profit_margin_percentage,
                      avg( customer_lifetime_value )as avg_customer_lifetime_value,
                      avg( market_share_percent)as avg_market_share,
                      avg(case
		                       when LOWER(competitive_position) LIKE 'leader' then 3
                                when LOWER(competitive_position) LIKE 'challengers' then 2
                                 when LOWER(competitive_position) LIKE 'entrant' then 1
                                 ELSE 0
                              END) AS avg_competitive_position,   
                      count(company_name)as company_count,
				      count(product_line)as product_line
from market_expansion
group by region, market_segment
having total_revenue > 1200000
  and profit_margin_percentage >55
  and  avg_market_share >10
  and  company_count >= 2
  order by gross_profit desc;
  
  
  
  select company_name,
		region,
		market_segment,
                      sum(revenue_generated)as total_revenue,
                      sum(revenue_generated) - sum(customer_acquisition_cost)+ SUM(operational_cost)+ SUM(marketing_spend) as total_profit,
					(( sum(revenue_generated) - sum(customer_acquisition_cost)+ sum(operational_cost)+ sum(marketing_spend)) /sum(revenue_generated)) * 100 as profit_margin_percentage,
                     avg(market_share_percent)as avg_market_share,
                    sum( CASE WHEN COMPETITIVE_POSITION = 'LEADER' THEN 1 ELSE 0 END)as avg_competitive_position,
                     sum(customer_lifetime_value)as total_customer_lifetime_value, 
                     avg( customer_retention_rate)as avg_retention_rate,
                     avg(profitability_index)as avg_profitability_index,
                     AVG( months_in_market)as months_market
from market_expansion
group by company_name ,region, market_segment
having  sum(revenue_generated) > 540000
  and  (( sum(revenue_generated) - sum(customer_acquisition_cost)+ sum(operational_cost)+ sum(marketing_spend)) /sum(revenue_generated)) * 100  > 52
  and    avg(profitability_index) > 1.8
  and  avg( customer_retention_rate)> 78
order by total_profit desc;

select region,
        market_segment,
        company_name,
                       sum(revenue_generated)as total_revenue,
                       sum(revenue_generated) - sum(customer_acquisition_cost)+ SUM(operational_cost)+ SUM(marketing_spend)as total_profit,
                      (( sum(revenue_generated) - sum(customer_acquisition_cost)+ sum(operational_cost)+ sum(marketing_spend)) /sum(revenue_generated))
                      * 100 as profit_margin_percentage,
                        avg(customer_acquisition_cost)as total_cac,
                        avg(customer_lifetime_value)as avg_clc,
                        sum(customer_acquisition_cost)/ sum(customer_lifetime_value)clv_cac_ratio,
                        avg( market_share_percent)as avg_market_share,
                        avg(customer_retention_rate)as avg_retention,
                        avg(profitability_index)as avg_profitability_index,
                        count(product_line)as product_count,
                          AVG(months_in_market)as months_market
from market_expansion
where company_name = 'techcorp'
group by region, market_segment
having total_revenue > 450000
  and profit_margin_percentage > 55
  and avg_profitability_index > 1.9
  and avg_retention >80
order by total_profit desc;

select company_name,
	    region,
	  market_segment,
					sum(revenue_generated)as total_revenue,
					sum(customer_acquisition_cost+ operational_cost+ marketing_spend)as total_cost, 
                     (sum(revenue_generated) - sum(customer_acquisition_cost+ operational_cost+ marketing_spend)) as gross_profit,
					  (sum(revenue_generated) - sum(customer_acquisition_cost+ operational_cost+ marketing_spend) /  sum(revenue_generated) )* 100
                      as profit_margin_percentage,
                   sum(customer_lifetime_value/customer_acquisition_cost)as clv_cac_efficiency,
                   sum(revenue_generated/months_in_market) as revenue_per_month,
				  avg(profitability_index)as avg_profitability_index,
                  avg(market_share_percent)as avg_market_share,
                  avg(customer_retention_rate)as avg_retention_rate,
                  sum( months_in_market)as months_in_market,
                  sum( market_share_percent+customer_retention_rate/ 2)as leadership_score
from market_expansion
group by company_name,region,market_segment
having total_revenue > 560000
  and  profit_margin_percentage > 54
  and clv_cac_efficiency > 12
  and avg_market_share > 11
  and avg_retention_rate > 79
  and months_in_market >=15
order by leadership_score desc, gross_profit desc
limit 5;

                  
                        
                       
      
                     
                      
                        



                  
                  
                  
			
                  