CREATE DATABASE consulting_performance;
USE consulting_performance;

CREATE TABLE consulting_performance (
  consultant_id INT PRIMARY KEY,
  consultant_name VARCHAR(50),
  firm VARCHAR(30),
  project_name VARCHAR(50),
  project_revenue DECIMAL(12,2),
  project_cost DECIMAL(10,2),
  hours_billed INT,
  billable_hours INT,
  client_segment VARCHAR(30),
  region VARCHAR(20),
  project_revenue  INT,
  client_satisfaction INT,
  project_status VARCHAR(20)
);

INSERT INTO consulting_performance VALUES
(1001, 'Rajesh Kumar', 'McKinsey', 'Digital Transformation', 850000, 340000, 480, 420, 'Technology', 'North', 60, 95, 'Completed'),
(1002, 'Priya Singh', 'BCG', 'Supply Chain Optimization', 920000, 368000, 520, 480, 'Manufacturing', 'South', 60, 98, 'Completed'),
(1003, 'Amit Patel', 'Bain', 'Market Entry Strategy', 650000, 260000, 360, 300, 'Financial Services', 'East', 60, 88, 'Completed'),
(1004, 'Neha Gupta', 'McKinsey', 'Operational Excellence', 780000, 312000, 440, 380, 'Retail', 'North', 60, 92, 'Completed'),
(1005, 'Vikram Das', 'BCG', 'Revenue Growth Program', 1050000, 420000, 600, 540, 'Technology', 'West', 60, 96, 'Completed'),
(1006, 'Deepak Roy', 'Bain', 'Cost Reduction Initiative', 720000, 360000, 400, 320, 'Manufacturing', 'South', 50, 85, 'Completed'),
(1007, 'Anjali Verma', 'McKinsey', 'Customer Analytics', 890000, 356000, 500, 450, 'Retail', 'East', 60, 94, 'Completed'),
(1008, 'Sanjay Gupta', 'BCG', 'Pricing Strategy', 950000, 380000, 540, 500, 'Financial Services', 'North', 60, 97, 'Completed'),
(1009, 'Kavya Nair', 'Bain', 'Digital Commerce', 1100000, 440000, 620, 580, 'Technology', 'West', 60, 99, 'Completed'),
(1010, 'Rohit Jain', 'McKinsey', 'Post-Merger Integration', 800000, 400000, 450, 360, 'Retail', 'South', 50, 82, 'Completed'),
(1011, 'Sneha Iyer', 'BCG', 'Sustainability Program', 760000, 304000, 420, 380, 'Manufacturing', 'East', 60, 91, 'Completed'),
(1012, 'Arjun Reddy', 'Bain', 'Analytics Platform', 980000, 392000, 560, 520, 'Technology', 'North', 60, 93, 'Completed'),
(1013, 'Divya Malhotra', 'McKinsey', 'Organizational Design', 680000, 340000, 380, 300, 'Financial Services', 'West', 50, 86, 'Completed'),
(1014, 'Varun Singh', 'BCG', 'Market Transformation', 1025000, 410000, 580, 530, 'Retail', 'East', 60, 95, 'Completed'),
(1015, 'Pooja Agarwal', 'Bain', 'Technology Integration', 890000, 445000, 500, 400, 'Manufacturing', 'North', 50, 84, 'Completed');

select * from consulting_performance;

select  consultant_name,
						sum(billable_hours) as total_billable_hours,
                        (sum( billable_hours) / sum(hours_billed)) * 100 as Billable_utilization_rate,
                        avg( profit_margin_percent)as avg_project_profit_margin,
                        count(project_name)as total_project,
                        sum(project_revenue)as total_revenue
                        
from consulting_performance
group by consultant_name
having total_billable_hours > 400
   and Billable_utilization_rate > 85
   and avg_project_profit_margin > 58
order by  total_revenue desc;


SELECT firm,
            SUM(project_revenue) as total_revenue,
            SUM(project_cost) as total_cost,
			(SUM(project_revenue) - SUM(project_cost)) as total_profit,
            ((SUM(project_revenue) - SUM(project_cost)) / SUM(project_revenue)) * 100 as profit_margin_percent,
            AVG(client_satisfaction) as avg_client_satisfaction,
            SUM(billable_hours) as total_billable_hours,
			COUNT(*) as project_count
FROM consulting_performance
GROUP BY firm
HAVING SUM(project_revenue) > 3000000
  AND ((SUM(project_revenue) - SUM(project_cost)) / SUM(project_revenue)) * 100 > 57
ORDER BY (SUM(project_revenue) - SUM(project_cost)) DESC;
                       
SELECt region , client_segment,
                              SUM(project_revenue ) AS total_revenue,
							  SUM(project_cost) AS total_cost,
                              SUM(project_revenue - project_cost) AS gross_profit,
                              AVG(profit_margin_percent) AS avg_profit_margin,
                              COUNT(DISTINCT consultant_id) AS consultant_count,
							 (SUM(billable_hours) / SUM(hours_billed) * 100) AS avg_billable_utilization,
                             AVG(client_satisfaction) AS avg_client_satisfaction,
							COUNT(*) AS project_count
FROM consulting_performance
GROUP BY region, client_segment
HAVING SUM(project_revenue )> 1500000
    AND AVG(profit_margin_percent) >= 55
    AND AVG(client_satisfaction) > 88
    AND COUNT(DISTINCT consultant_id) >= 2
order by  gross_profit desc;

select consultant_name, firm,
							SUM(project_revenue ) AS project_revenue,
                            sum(project_revenue - project_cost) as total_profit,
                            AVG(profit_margin_percent) AS avg_profit_margin,
                             (SUM(billable_hours) / SUM(hours_billed) * 100) AS avg_billable_utilization,
							AVG(client_satisfaction) AS avg_client_satisfaction,
						   count(project_status) as project_count,
						  avg((billable_hours) / (hours_billed) *profit_margin_percent / 100) as efficiency_score
FROM consulting_performance
group by consultant_name, firm
having project_revenue > 850000
  and avg_profit_margin > 55
  and avg_billable_utilization > 80
  and avg_client_satisfaction >= 88
order by total_profit desc;

select firm, client_segment,
							SUM(project_revenue ) AS total_revenue,
							SUM(project_cost) AS total_cost,
							SUM(project_revenue - project_cost) AS gross_profit,
							avg(profit_margin_percent) AS profit_margin_percentage,
							sum( billable_hours/hours_billed * 100) as Billable_utilization_rate,
							AVG(client_satisfaction) AS avg_client_satisfaction,
							COUNT(DISTINCT consultant_id) AS consultant_count,
                            count( project_name)as project_count,
                            (sum(project_revenue) / count(distinct consultant_id))as revenue_per_consultant
from consulting_performance
group by firm, client_segment
having SUM(project_revenue ) > 1800000
  and avg(profit_margin_percent) >=55
  and sum( billable_hours/hours_billed * 100) > 80
  and AVG(client_satisfaction) >90
  and COUNT(DISTINCT consultant_id) >=1
order by gross_profit desc
limit 5;
                            
                            
