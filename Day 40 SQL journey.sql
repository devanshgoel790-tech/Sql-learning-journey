DROP DATABASE IF EXISTS consulting_performance;
CREATE DATABASE consulting_performance;
USE consulting_performance;

CREATE TABLE consultants (
  consultant_id INT PRIMARY KEY,
  name VARCHAR(50),
  firm VARCHAR(30),
  specialization VARCHAR(40),
  years_experience INT,
  billable_rate DECIMAL(8,2),
  utilization_target INT
);

CREATE TABLE projects (
  project_id INT PRIMARY KEY,
  project_name VARCHAR(50),
  client VARCHAR(40),
  industry VARCHAR(30),
  firm VARCHAR(30),
  start_date DATE,
  end_date DATE,
  total_budget DECIMAL(12,2),
  actual_revenue DECIMAL(12,2),
  status VARCHAR(20),
  profitability_percent DECIMAL(5,2)
);

CREATE TABLE billable_hours (
  billing_id INT PRIMARY KEY,
  consultant_id INT,
  project_id INT,
  month_year VARCHAR(10),
  billable_hours INT,
  total_hours INT,
  hourly_rate DECIMAL(8,2),
  revenue_generated DECIMAL(10,2),
  FOREIGN KEY (consultant_id) REFERENCES consultants(consultant_id),
  FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

INSERT INTO consultants VALUES
(101, 'Rahul Singh', 'BCG', 'Financial Strategy', 8, 2500, 85),
(102, 'Priya Sharma', 'McKinsey', 'Operations', 6, 2300, 82),
(103, 'Amit Kumar', 'Bain', 'Digital Transformation', 7, 2400, 80),
(104, 'Neha Patel', 'BCG', 'Mergers & Acquisitions', 9, 2600, 88),
(105, 'Vikram Desai', 'McKinsey', 'Financial Strategy', 5, 2200, 78),
(106, 'Deepak Gupta', 'Bain', 'Operations', 6, 2350, 81),
(107, 'Anjali Verma', 'BCG', 'Digital Transformation', 4, 2100, 75),
(108, 'Sanjay Iyer', 'McKinsey', 'Mergers & Acquisitions', 7, 2400, 84),
(109, 'Meera Nair', 'Bain', 'Financial Strategy', 8, 2500, 86),
(110, 'Arun Menon', 'BCG', 'Operations', 5, 2200, 79),
(111, 'Kavya Reddy', 'McKinsey', 'Digital Transformation', 6, 2350, 83),
(112, 'Harish Rao', 'Bain', 'Financial Strategy', 7, 2450, 85),
(113, 'Sneha Gupta', 'BCG', 'Operations', 4, 2100, 76),
(114, 'Pooja Das', 'McKinsey', 'Mergers & Acquisitions', 5, 2250, 80),
(115, 'Varun Singh', 'Bain', 'Digital Transformation', 6, 2350, 82);

INSERT INTO projects VALUES
(1001, 'Digital Banking Transformation', 'HDFC Bank', 'Financial Services', 'BCG', '2024-01-15', '2024-06-30', 4500000, 5200000, 'Completed', 15.6),
(1002, 'Supply Chain Optimization', 'Reliance Industries', 'Retail & Oil', 'McKinsey', '2024-02-01', '2024-08-31', 3800000, 4100000, 'Completed', 7.9),
(1003, 'Cloud Migration Strategy', 'TCS', 'IT Services', 'Bain', '2024-03-10', '2024-09-30', 2800000, 3200000, 'In Progress', 14.3),
(1004, 'Merger Integration - Bank Consolidation', 'Axis Bank + Yes Bank', 'Financial Services', 'BCG', '2024-04-01', '2024-12-31', 6200000, 7100000, 'In Progress', 14.5),
(1005, 'AI & Analytics Roadmap', 'Infosys', 'IT Services', 'McKinsey', '2024-05-15', '2024-11-30', 3200000, 3600000, 'In Progress', 12.5),
(1006, 'Cost Reduction Program', 'Indian Railways', 'Government', 'Bain', '2024-02-20', '2024-10-31', 5000000, 5800000, 'Completed', 16.0),
(1007, 'Market Entry Strategy - Southeast Asia', 'Bharti Airtel', 'Telecom', 'BCG', '2024-06-01', '2024-12-31', 2500000, 2900000, 'In Progress', 16.0),
(1008, 'Organizational Restructuring', 'ICICI Bank', 'Financial Services', 'McKinsey', '2024-03-20', '2024-09-30', 3100000, 3450000, 'Completed', 11.3),
(1009, 'Pricing Optimization - E-commerce', 'Flipkart', 'Retail', 'Bain', '2024-04-15', '2024-10-15', 2200000, 2600000, 'In Progress', 18.2),
(1010, 'Digital Transformation - 5-Year Roadmap', 'State Bank of India', 'Financial Services', 'BCG', '2024-07-01', '2025-06-30', 8500000,
 9200000, 'In Progress', 8.2);

INSERT INTO billable_hours VALUES
(501, 101, 1001, '2024-01', 160, 175, 2500, 400000),
(502, 104, 1004, '2024-04', 155, 170, 2600, 403000),
(503, 110, 1001, '2024-05', 150, 165, 2200, 330000),
(504, 102, 1002, '2024-02', 165, 180, 2300, 379500),
(505, 105, 1005, '2024-05', 140, 175, 2200, 308000),
(506, 108, 1004, '2024-06', 158, 172, 2400, 379200),
(507, 103, 1003, '2024-03', 145, 168, 2400, 348000),
(508, 106, 1006, '2024-02', 168, 180, 2350, 394800),
(509, 109, 1006, '2024-04', 162, 175, 2500, 405000),
(510, 111, 1005, '2024-06', 152, 168, 2350, 357200),
(511, 107, 1007, '2024-06', 138, 165, 2100, 289800),
(512, 112, 1009, '2024-04', 155, 170, 2450, 379750),
(513, 113, 1001, '2024-02', 142, 180, 2100, 298200),
(514, 114, 1008, '2024-03', 148, 170, 2250, 333000),
(515, 115, 1003, '2024-05', 160, 175, 2350, 376000);

select * from billable_hours;
select * from consultants;
select * from projects;

SELECT 
c.name,
    c.firm,
    c.specialization,
    COUNT(DISTINCT bh.project_id) as projects_assigned,
    SUM(bh.billable_hours) as total_billable_hours,
    SUM(bh.total_hours) as total_hours_worked,
    ROUND((SUM(bh.billable_hours) / SUM(bh.total_hours)) * 100, 1) as utilization_percent,
    SUM(bh.revenue_generated) as total_revenue_generated,
    ROUND(AVG(bh.hourly_rate), 0) as avg_hourly_rate,
    ROUND((SUM(bh.revenue_generated) - (SUM(bh.total_hours) * 800)) / (SUM(bh.total_hours) * 800) * 100, 1) as profitability_margin_percent
FROM consultants c
LEFT JOIN billable_hours bh ON c.consultant_id = bh.consultant_id
GROUP BY c.consultant_id, c.name, c.firm, c.specialization
HAVING (SUM(bh.billable_hours) / SUM(bh.total_hours)) * 100 >= 80
  AND SUM(bh.total_hours) >= 150
ORDER BY utilization_percent DESC, total_revenue_generated DESC;


SELECT 
    p.project_name,
    p.client,
    p.firm,
    p.industry,
    p.status,
    p.total_budget,
    p.actual_revenue,
    (p.actual_revenue - p.total_budget) as profit,
    ROUND(((p.actual_revenue - p.total_budget) / p.total_budget) * 100, 2) as roi_percent,
    COUNT(DISTINCT bh.consultant_id) as consultant_count,
    SUM(bh.billable_hours) as total_billable_hours,
    ROUND(SUM(bh.revenue_generated), 0) as total_generated,
    ROUND(SUM(bh.revenue_generated) / p.actual_revenue * 100, 1) as revenue_from_billable_percent
FROM projects p
LEFT JOIN billable_hours bh ON p.project_id = bh.project_id
GROUP BY p.project_id, p.project_name, p.client, p.firm, p.industry, p.status, p.total_budget, p.actual_revenue
HAVING ((p.actual_revenue - p.total_budget) / p.total_budget) * 100 > 8
  AND COUNT(DISTINCT bh.consultant_id) >= 2
ORDER BY roi_percent DESC, profit DESC;

SELECT 
    p.firm,
    COUNT(DISTINCT p.project_id) as total_projects,
    SUM(p.total_budget) as total_budget_managed,
    SUM(p.actual_revenue) as total_revenue,
    (SUM(p.actual_revenue) - SUM(p.total_budget)) as total_profit,
    ROUND((SUM(p.actual_revenue) - SUM(p.total_budget)) / SUM(p.total_budget) * 100, 2) as portfolio_roi_percent,
    COUNT(DISTINCT c.consultant_id) as consultant_count,
    ROUND(AVG(c.years_experience), 1) as avg_experience_years,
    SUM(bh.total_hours) as total_hours_worked,
    ROUND(SUM(bh.billable_hours) / SUM(bh.total_hours) * 100, 1) as firm_utilization_percent,
    SUM(bh.revenue_generated) as revenue_from_consulting
FROM projects p
LEFT JOIN consultants c ON p.firm = c.firm
LEFT JOIN billable_hours bh ON c.consultant_id = bh.consultant_id
GROUP BY p.firm
HAVING COUNT(DISTINCT p.project_id) >= 2
  AND SUM(p.actual_revenue) > 15000000
ORDER BY total_profit DESC, portfolio_roi_percent DESC;

SELECT 
    c.specialization,
    p.industry,
    COUNT(DISTINCT p.project_id) as projects,
    COUNT(DISTINCT c.consultant_id) as consultant_count,
    SUM(p.total_budget) as budget,
    SUM(p.actual_revenue) as revenue,
    (SUM(p.actual_revenue) - SUM(p.total_budget)) as profit,
    ROUND(((SUM(p.actual_revenue) - SUM(p.total_budget)) / SUM(p.total_budget)) * 100, 2) as roi_percent,
    ROUND(AVG(c.years_experience), 1) as avg_years_exp,
    ROUND(SUM(bh.billable_hours) / SUM(bh.total_hours) * 100, 1) as utilization_percent,
    COUNT(CASE WHEN c.years_experience >= 6 THEN 1 END) as senior_consultants
FROM consultants c
LEFT JOIN projects p ON c.firm = p.firm
LEFT JOIN billable_hours bh ON c.consultant_id = bh.consultant_id
GROUP BY c.specialization, p.industry
HAVING COUNT(DISTINCT p.project_id) >= 1
  AND SUM(p.actual_revenue) > 2500000
ORDER BY roi_percent DESC, profit DESC;

SELECT 
    p.firm,
    c.specialization,
    COUNT(DISTINCT p.project_id) as active_projects,
    SUM(CASE WHEN p.status = 'Completed' THEN 1 ELSE 0 END) as completed_projects,
    SUM(CASE WHEN p.status = 'In Progress' THEN 1 ELSE 0 END) as ongoing_projects,
    SUM(p.total_budget) as total_contract_value,
    SUM(p.actual_revenue) as actual_revenue,
    ROUND((SUM(p.actual_revenue) - SUM(p.total_budget)) / SUM(p.total_budget) * 100, 2) as profitability_percent,
    COUNT(DISTINCT c.consultant_id) as team_size,
    ROUND(AVG(c.years_experience), 1) as team_avg_experience,
    ROUND(SUM(bh.billable_hours) / SUM(bh.total_hours) * 100, 1) as team_utilization,
    ROUND(AVG(p.profitability_percent), 2) as avg_project_margin,
    COUNT(CASE WHEN p.profitability_percent >= 14 THEN 1 END) as highly_profitable_projects
FROM projects p
INNER JOIN consultants c ON p.firm = c.firm
LEFT JOIN billable_hours bh ON c.consultant_id = bh.consultant_id
GROUP BY p.firm, c.specialization
HAVING COUNT(DISTINCT p.project_id) >= 2
  AND (SUM(p.actual_revenue) - SUM(p.total_budget)) > 1000000
  AND ROUND(SUM(bh.billable_hours) / SUM(bh.total_hours) * 100, 1) >= 78
ORDER BY profitability_percent DESC, team_utilization DESC;