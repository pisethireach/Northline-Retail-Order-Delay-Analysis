-- Q1. What is the overall late delivery rate across all orders?
SELECT
    CAST(SUM(ReachedOnTime) AS FLOAT) * 100 / COUNT(*) AS late_rate_percent
FROM Orders;

-- Q2. Are certain warehouses or shipping methods underperforming and driving delays?
SELECT
    w.BlockName,
    s.ModeName,
    CAST(SUM(o.ReachedOnTime) AS FLOAT) * 100 / COUNT(*) AS late_rate_percent
FROM Orders o
INNER JOIN Warehouse w on o.WarehouseBlockID = w.BlockID
INNER JOIN ShipmentMode s on o.ShipmentModeID = s.ModeID
GROUP BY w.BlockName, s.ModeName;

-- Q3. Are discounted orders putting delivery performance at risk?
SELECT
    DiscountOffered,
    COUNT(*) AS total_orders,
    CAST(SUM(ReachedOnTime) AS FLOAT) * 100 / COUNT(*) AS late_rate_percent
FROM Orders
GROUP BY DiscountOffered
ORDER BY DiscountOffered;

-- Q4. Is order weight a factor operations should account for when planning fulfilment?
SELECT
    ReachedOnTime,
    MIN(WeightInGrams) AS min_weight,
    AVG(WeightInGrams) AS avg_weight,
    MAX(WeightInGrams) AS max_weight
FROM Orders
GROUP BY ReachedOnTime;

-- Q5. What proportion of all late orders had a discount above 10%?
SELECT
    CASE
        WHEN DiscountOffered > 10 THEN 'above_10'
        ELSE 'below_10'
    END AS discount_group,
    CAST(SUM(ReachedOnTime) AS FLOAT) * 100 / (SELECT SUM(ReachedOnTime) FROM Orders) AS proportion_percent
FROM Orders
GROUP BY discount_group;

-- Q6. Is the discount-related delay pattern the same across every warehouse?
SELECT
    w.BlockName,
    COUNT(*) AS total_orders,
    CAST(SUM(o.ReachedOnTime) AS FLOAT) * 100 / COUNT(*) AS late_rate_percent
FROM Orders o
INNER JOIN Warehouse w ON o.WarehouseBlockID = w.BlockID
WHERE o.DiscountOffered > 10
GROUP BY w.BlockName;